unit uFrmMonitorSat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, Menus, ExtCtrls, StdCtrls, ComCtrls;

// Variável para controle de TryIcon do sistema
const WM_TrayIcon = WM_User + 1;

type
  TFrmMonitorSAT = class(TForm)
    PopupMenu1: TPopupMenu;
    Visualizarmonitoramento1: TMenuItem;
    EncerrarAplicao1: TMenuItem;
    N1: TMenuItem;
    Minimizaraplicao1: TMenuItem;
    MemoProcessados: TMemo;
    PnInforma: TPanel;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure EncerrarAplicao1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Visualizarmonitoramento1Click(Sender: TObject);
    procedure Minimizaraplicao1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FPodeFechar : boolean;
    sIDPedido : Integer;
    procedure WMSysCommand(var Msg: TWMSysCommand); Message WM_SysCommand;
    procedure WMTrayIcon(var Msg: TMessage); Message WM_TRAYICON;
    procedure DestroyIcone;
    procedure CriaIcone;
    procedure ImprimirDAV;
  public
    { Public declarations }
  end;

var
  FrmMonitorSAT: TFrmMonitorSAT;

implementation

uses uLibrary, uDmWorkCom, uDmAcBr, DB, uDmProdutos;

{$R *.dfm}

{ TFrmPrincipal }

procedure TFrmMonitorSAT.CriaIcone;
var NotifyIconData: TNotifyIconData;
begin
  with NotifyIconData do
  begin
//    cbSize:= SizeOf(TNotifyIconData);
    cbSize:= SizeOf;
    Wnd:= Self.Handle;
    uID:= 0;
    uCallbackMessage:= WM_TRAYICON;
    uFlags:= NIF_ICON or NIF_TIP or NIF_MESSAGE;
    hIcon:= Application.Icon.Handle;
    szTip:= 'Monitor SAT';
  end;
  Shell_NotifyIcon(NIM_ADD, @NotifyIconData);
  FrmMonitorSAT.Hide;

end;

procedure TFrmMonitorSAT.DestroyIcone;
var NotifyIconData: TNotifyIconData;
begin
  NotifyIconData.cbSize:= SizeOf(TNotifyIconData);
  NotifyIconData.Wnd:= Self.Handle;
  NotifyIconData.uID:= 0;
  NotifyIconData.uFlags:= 0;
  Shell_NotifyIcon(NIM_DELETE, @NotifyIconData);

end;

procedure TFrmMonitorSAT.WMSysCommand(var Msg: TWMSysCommand);
begin
  case (Msg.CmdType) of
    SC_MINIMIZE:
    begin
      Self.Visible:= False;
      CriaIcone;
    end;
    SC_MAXIMIZE:
    begin
      Self.Visible:= True;
    end
    else
      Inherited
  end;

end;

procedure TFrmMonitorSAT.WMTrayIcon(var Msg: TMessage);
var Pt: TPoint;
begin
  if (Msg.LParam = WM_RBUTTONDOWN) then
  begin
    GetCursorPos(Pt);
    PopupMenu.Popup(Pt.X, Pt.Y);
    PopupMenu.AutoPopup:= False;
  end
  else
    if (Msg.LParam = WM_LBUTTONDBLCLK) then
    begin
      Self.Visible:= True;
      DestroyIcone;
    end;

end;

procedure TFrmMonitorSAT.FormCreate(Sender: TObject);
begin
  FPodeFechar := false;

end;

procedure TFrmMonitorSAT.EncerrarAplicao1Click(Sender: TObject);
begin
  if Confirmacao('Confirma o encerramento do aplicativo?') then
  begin
    FPodeFechar := true;
    Close;
  end;

end;

procedure TFrmMonitorSAT.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := FPodeFechar;
  if not FPodeFechar then
     CriaIcone;

end;

procedure TFrmMonitorSAT.Visualizarmonitoramento1Click(Sender: TObject);
begin
  FrmMonitorSAT.Show;

end;

procedure TFrmMonitorSAT.Minimizaraplicao1Click(Sender: TObject);
begin
   CriaIcone;

end;

procedure TFrmMonitorSAT.Timer1Timer(Sender: TObject);
var NomeArq : String;
    F: TSearchRec;
    Ret: Integer;
begin
  inherited;
  Timer1.Enabled := false;
  PnInforma.Caption := 'Verificando...';
  Application.ProcessMessages;
  sIDPedido := 0;
  DmWorkCom.Dados_Pedido(0);
  DmWorkCom.Dados_PedidoItens(0);
  DmWorkCom.Dados_PedidoFP(0);
  // abre lista de arquivos txt
  Ret := FindFirst(ExtractFilePath(Application.ExeName)+'\txt\*.txt', faAnyFile, F);
  while Ret = 0 do
  begin
    if F.Attr and faDirectory <> faDirectory then
    begin
      NomeArq := ExtractFilePath(Application.ExeName)+'txt\'+F.Name;
//      if UpperCase(Copy(ExtractFileName(NomeArq),1,4)) = 'SAT_' then
      begin
        // manda emitir o DAV do arquivo
        if DmWorkCom.CarregaDadosClientDataSet(NomeArq) then
        begin
          sIDPedido := DmWorkCom.CdsPedidos.FieldByname('ID').AsInteger;
          MemoProcessados.Lines.Add('Processado o arquivo: '+NomeArq);
          Break;
        end;
      end;  
    end;
    Ret := FindNext(F);
  end;
  // se tiver carregado o pedido manda processar
  if sIDPedido > 0 then
  begin
    ImprimirDAV;
  end
  else
  begin
    PnInforma.Caption := 'Aguardando...';
    Application.ProcessMessages;
    Timer1.Enabled := true;
  end;

end;

procedure TFrmMonitorSAT.ImprimirDAV;
begin
  inherited;
  if sIDPedido > 0 then
  begin
    PnInforma.Caption := 'Processando...';
    Application.ProcessMessages;
    DmWorkCom.Dados_Pedido(sIDPedido);
    DmWorkCom.Dados_PedidoItens(sIDPedido);
    DmWorkCom.Dados_PedidoFP(sIDPedido);
    if DmWorkCom.CdsPedidos.RecordCount > 0 then
    begin
      if DmWorkCom.GerarSAT(DmWorkCom.CdsPedidos.FieldByname('ID').AsInteger) then
      begin
        MemoProcessados.Lines.Add('Gerado SAT do pedido: '+IntToStr(sIDPedido));
        DmAcBr.ACBrSAT1.CFe.GerarXML;
        DmAcBr.ACBrSAT1.EnviarDadosVenda;
        if DmAcBr.ACBrSAT1.Resposta.codigoDeRetorno = 6000 then
        begin
          MemoProcessados.Lines.Add('Enviado SAT do pedido: '+IntToStr(sIDPedido));
          DmAcBr.ACBrSAT1.CFe.GerarXML;
          // grava os dados na tabela pedido
          DmWorkCom.Grava_DadosSAT(DmWorkCom.CdsPedidos.FieldByname('ID').AsInteger,
                                   DmAcBr.ACBrSAT1.CFe.infCFe.ID,
                                   DmAcBr.ACBrSAT1.Resposta.codigoSEFAZ,
                                   DmAcBr.ACBrSAT1.Resposta.numeroSessao);
          // grava o XML na tabela
          DmWorkCom.GravaArquivoXML(DmAcBr.ACBrSAT1.CFe.infCFe.ID,
                                    DmAcBr.ACBrSAT1.Resposta.RetornoStr);
          //
          try
            DmAcBr.ACBrSAT1.ImprimirExtratoResumido;
          except
            on E:Exception do ShowMessage(E.Message);
          end;
        end
        else
        begin
          MemoProcessados.Lines.Add('Erro ao enviar SAT do pedido: '+IntToStr(sIDPedido));
          MemoProcessados.Lines.Add('Messagem do retorno: '+DmAcBr.ACBrSAT1.Resposta.mensagemRetorno);
          MemoProcessados.Lines.Add('Mensagem da seFaz: '+DmAcBr.ACBrSAT1.Resposta.mensagemSEFAZ);
        end;
        // Grava Arquivo de retorno
        DmWorkCom.GravaArquivoRetornoSAT(IntToStr(DmAcBr.ACBrSAT1.Resposta.codigoDeRetorno),
                                         DmAcBr.ACBrSAT1.Resposta.mensagemRetorno);

      end;
    end;
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoItens(0);
    DmWorkCom.Dados_PedidoFP(0);
    PnInforma.Caption := 'Aguardando...';
    Application.ProcessMessages;
    Timer1.Enabled := true;
  end
  else
  begin
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoItens(0);
    DmWorkCom.Dados_PedidoFP(0);
  end;

end;

procedure TFrmMonitorSAT.FormShow(Sender: TObject);
begin
  DmProdutos.Dados_Produto(0);
  DmWorkCom.Dados_Pedido(0);
  DmWorkCom.Dados_PedidoItens(0);
  DmWorkCom.Dados_PedidoFP(0);
  DmWorkCom.Dados_FormaPagto;
  DmProdutos.Dados_NCM;
  DmWorkCom.Dados_Empresa;
  sIDEmpresa := DmWorkCom.CdsEmpresaID.AsInteger;
  DmWorkCom.Dados_Config(sIDEmpresa);
  DmWorkCom.CarregaDadosEmpresa;
  //
  StatusBar1.Panels.Items[0].Text := 'Empresa: '+DmWorkCom.CdsEmpresaID.AsString+' - '+
                                                 DmWorkCom.CdsEmpresaRAZAO_SOCIAL.AsString;
  //
  DmWorkCom.AjustaACBrSAT;
  DmWorkCom.ConfiguraRedeSAT;
  DmWorkCom.PrepararImpressao;
  //
  DmAcBr.ACBrSAT1.Inicializado := not DmAcBr.ACBrSAT1.Inicializado;

  if DmAcBr.ACBrSAT1.Inicializado then
     StatusBar1.Panels.Items[1].Text := 'SAT Inicializado'
  else
     StatusBar1.Panels.Items[1].Text := 'SAT não Inicializado';

end;

end.
