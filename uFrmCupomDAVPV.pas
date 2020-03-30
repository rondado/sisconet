unit uFrmCupomDAVPV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, StdCtrls, DB, ActnList, Buttons, Grids,
  DBGrids, FMTBcd, DBClient, Provider, SqlExpr;

type
  TFrmCupomDAVPV = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ActionList1: TActionList;
    ActImprimir: TAction;
    ActCancelar: TAction;
    ActEncerrar: TAction;
    DataDavPV: TDataSource;
    BitBtn4: TBitBtn;
    ActAtualizar: TAction;
    ActionList2: TActionList;
    ActMenuFiscal: TAction;
    ActImportarTXT: TAction;
    OpenDialog1: TOpenDialog;
    BtnImpTXTDav: TBitBtn;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActImprimirExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActAtualizarExecute(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure ActImportarTXTExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure HabiilitaTimerAutomatico;
  public
    { Public declarations }
    sIDPedido : Integer;
    sCancelado : Boolean;
  end;

var
  FrmCupomDAVPV: TFrmCupomDAVPV;

implementation

uses uDmWorkCom, uLibrary, uFrmMenuFiscal;

{$R *.dfm}

procedure TFrmCupomDAVPV.FormShow(Sender: TObject);
begin
  inherited;
  DataDavPV.DataSet := DmWorkCom.CdsDavPV;
  DmWorkCom.Dados_DavPrevendaAbertos(0);

end;

procedure TFrmCupomDAVPV.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;
  Close;
  
end;

procedure TFrmCupomDAVPV.FormCreate(Sender: TObject);
begin
  inherited;
  sIDPedido := 0;
  sCancelado := false;
  BtnImpTXTDav.Visible := false;
  if DmWorkCom.PAFECF.gArqTXTDav then
     BtnImpTXTDav.Visible := true;
  HabiilitaTimerAutomatico;

end;

procedure TFrmCupomDAVPV.ActImprimirExecute(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;
  if DataDavPV.DataSet.RecordCount > 0 then
  begin
    if Confirmacao('Confirma a emissão do cupom deste registro?') then
    begin
      sCancelado := false;
      sIDPedido := DataDavPV.DataSet.FieldByname('ID').AsInteger;
      Close;
    end
    else HabiilitaTimerAutomatico;
  end
  else HabiilitaTimerAutomatico;

end;

procedure TFrmCupomDAVPV.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;
  if DataDavPV.DataSet.RecordCount > 0 then
  begin
    if DataDavPV.DataSet.FieldByName('NumPV').AsString <> '' then
    begin
      if Confirmacao('Confirma o cancelamento desta Pré-Venda?') then
      begin
        sCancelado := true;
        sIDPedido := DataDavPV.DataSet.FieldByname('ID').AsInteger;
        Close;
      end
      else HabiilitaTimerAutomatico;
    end
    else
    begin
      MessageDlg('O registro selecionado não é uma Pré-venda!!!', mtWarning, [mbOK], 0);
      HabiilitaTimerAutomatico;
    end;
  end
  else HabiilitaTimerAutomatico;

end;

procedure TFrmCupomDAVPV.ActAtualizarExecute(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;
  DmWorkCom.Dados_DavPrevendaAbertos(0);
  HabiilitaTimerAutomatico;
  
end;

procedure TFrmCupomDAVPV.ActMenuFiscalExecute(Sender: TObject);
var aMensagem : String;
begin
  inherited;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
  begin
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  end
  else
  begin
    if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
    begin
      ShowMessage(aMensagem);
      DmWorkCom.PAFECF.sControleECFAtivo := 2;
    end;
  end;  
   Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
   Try
      FrmMenuFiscal.ShowModal;
   Finally
      FrmMenuFiscal.Destroy;
   End;

end;

procedure TFrmCupomDAVPV.ActImportarTXTExecute(Sender: TObject);
var aNomeArq : String;
begin
  inherited;
  Timer1.Enabled := false;
  aNomeArq := '';
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+'\txt\') then
     CreateDir(ExtractFilePath(Application.ExeName)+'\txt\');
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName)+'\txt\';
  //
  OpenDialog1.Execute;
  aNomeArq := OpenDialog1.FileName;
  if FileExists(aNomeArq) then
  begin
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoItens(0);
    DmWorkCom.Dados_PedidoFP(0);
    //
    if DmWorkCom.CarregaDadosClientDataSet(aNomeArq) then
    begin
      sCancelado := false;
      sIDPedido := DataDavPV.DataSet.FieldByname('ID').AsInteger;
      Close;
    end
    else HabiilitaTimerAutomatico;
  end
  else HabiilitaTimerAutomatico;

end;

procedure TFrmCupomDAVPV.Timer1Timer(Sender: TObject);
var NomeArq : String;
    F: TSearchRec;
    Ret: Integer;
begin
  inherited;
  Timer1.Enabled := false;
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
      // manda emitir o DAV do arquivo
      if DmWorkCom.CarregaDadosClientDataSet(NomeArq) then
      begin
        sIDPedido := DmWorkCom.CdsPedidos.FieldByname('ID').AsInteger;
        Break;
      end;
    end;
    Ret := FindNext(F);
  end;
  // se tiver carregado o pedido manda processar
  if sIDPedido > 0 then
  begin
    sCancelado := false;
    Close;
  end
  else Timer1.Enabled := true;
end;

procedure TFrmCupomDAVPV.HabiilitaTimerAutomatico;
begin
  Timer1.Enabled := false;
  if (DmWorkCom.PAFECF.gArqTXTDav) and (DmWorkCom.PAFECF.gTXTAutomatico) then
     Timer1.Enabled := true;


end;

end.
