unit uFrmPrincipalSAT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Menus, Buttons, ActnList, ExtCtrls, StdCtrls,
  ACBrDevice, ImgList, XPMan, jpeg, uMensagem, System.ImageList, System.Actions;

type
  TFrmPrincipalSat = class(TForm)
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    ActCupomFiscal: TAction;
    ActEncerrar: TAction;
    ActSangria: TAction;
    ActSuprimento: TAction;
    ActSintegra: TAction;
    Timer1: TTimer;
    ImageList1: TImageList;
    XPManifest1: TXPManifest;
    LbArqMD5: TLabel;
    ActAbreCaixa: TAction;
    ActFechaCaixa: TAction;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    MenuPAFECF1: TMenuItem;
    AbrirCaixa1: TMenuItem;
    FecharCaixa1: TMenuItem;
    LanarSuprimento1: TMenuItem;
    EfetuarSangria1: TMenuItem;
    PDV1: TMenuItem;
    SobreoAplicativo1: TMenuItem;
    Encerrar2: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    ImgLogoMarca: TImage;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CarregarConfiguracao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelarDocumentoNoFiscal1Click(Sender: TObject);
    procedure CadastrarAliquotanoECF1Click(Sender: TObject);
    procedure CadastrarFormadePagamentonaImpressora1Click(Sender: TObject);
    procedure EmitirReduoZPendente1Click(Sender: TObject);
    procedure btVendasClick(Sender: TObject);
    procedure btSangriaClick(Sender: TObject);
    procedure btSuprimentoClick(Sender: TObject);
    procedure ActCupomFiscalExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure ActSangriaExecute(Sender: TObject);
    procedure ActSuprimentoExecute(Sender: TObject);
    procedure dxBarLargeButton4Click(Sender: TObject);
    procedure dxBarLargeButton6Click(Sender: TObject);
    procedure BtnEmitirClick(Sender: TObject);
    procedure ActAbreCaixaExecute(Sender: TObject);
    procedure ActFechaCaixaExecute(Sender: TObject);
    procedure dxBarLargeButton1Click(Sender: TObject);
    procedure dxBarLargeButton8Click(Sender: TObject);
    procedure dxBarLargeButton20Click(Sender: TObject);
    procedure dxBarLargeButton21Click(Sender: TObject);
    procedure AbrirCaixa1Click(Sender: TObject);
    procedure FecharCaixa1Click(Sender: TObject);
    procedure LanarSuprimento1Click(Sender: TObject);
    procedure EfetuarSangria1Click(Sender: TObject);
    procedure PDV1Click(Sender: TObject);
    procedure SobreoAplicativo1Click(Sender: TObject);
    procedure Encerrar2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowHint(Sender: TObject);
  end;

var
  FrmPrincipalSat: TFrmPrincipalSat;

implementation

uses uLibrary, uFrmEmiCupom, uDmWorkCom, uFrmLoginUsuario, uFrmConfiguracoes,
  uDmAcBr, DB, uFrmAbreCaixa, uFrmImforma, uFrmMensageemProd, uFrmLiberacao,
  uFrmFechaCaixa, uFuncoesPAFECF, uDMClientes, uDmProdutos;

{$R *.dfm}

procedure TFrmPrincipalSat.FormCreate(Sender: TObject);
begin       
   Application.OnHint := ShowHint;
   sIDEmpresa := 1;
   CarregarConfiguracao;
   // verifica arquivo INI
   if not FileExists(ExtractFilePath(Application.ExeName)+'ArqVerifica.ini') then
   begin
     if DmWorkCom.PAFECF.gPortaECF = '' then
        DmWorkCom.PAFECF.gPortaECF := '003';
     if DmWorkCom.PAFECF.gCaixa = '' then
        DmWorkCom.PAFECF.gCaixa := '001';
     if DmWorkCom.PAFECF.gPathArqMenu = '' then
        DmWorkCom.PAFECF.gPathArqMenu := ExtractFilePath(Application.ExeName)+'Menu Fiscal\';
     DmWorkCom.PAFECF.GravaArqINI('0','0,00','',2);
     // TESTE PAF ECF
   end;
   DmWorkCom.PAFECF.LeArquivoINI;
   FrmPrincipalSat.WindowState := wsMaximized;
   sPAFNFCe := 2;
   SpeedButton3.Caption := 'Registrar'+#13+'suprimento';
   SpeedButton4.Caption := 'Registrar'+#13+'Sangria';
   SpeedButton5.Caption := 'Emitir Doc.'+#13+'Fiscal';

end;

procedure TFrmPrincipalSat.FormShow(Sender: TObject);
var aTef : Boolean;
begin
  // Pportellaa.
//  DmWorkCom.PAFECF.LeArquivoINI;  Ler duas vezes? no onCreate e no onShow ??
  DmWorkCom.PAFECF.ArqTemp := ExtractFilePath(Application.ExeName)+'INTPOS.001';
  StatusBar1.Panels.Items[0].Text := DateToStr(SVData);
  StatusBar1.Panels.Items[1].Text := 'IP: '+RetornaIP;
  StatusBar1.Panels.Items[4].Text := 'Aplicativo para Emissão de Documento Fiscal - Versão: 1.0.0.0';
  
end;

procedure TFrmPrincipalSat.LanarSuprimento1Click(Sender: TObject);
begin
  ActSuprimentoExecute(Sender);

end;

procedure TFrmPrincipalSat.PDV1Click(Sender: TObject);
begin
  ActCupomFiscalExecute(Sender);

end;

procedure TFrmPrincipalSat.Timer1Timer(Sender: TObject);
var formMensagem: TFormMensagem;
    aMensagem : String;
    aIDPedido : Integer;
    aDataMov, aDataAtual : TDateTime;
begin
  try
    formMensagem := TFormMensagem.Create('Aguarde... enquanto o sistema é inicializado!',550,150,clWhite,clSilver);
    formMensagem.mostrar;
    Refresh;
    // DESATIVA
    Timer1.Enabled := false;
    // captura a empresa vinculada ao caixa
    sIDEmpresa := DmWorkCom.PAFECF.RetornaIDEmpresaCaixa;
    if DmWorkCom.Dados_Empresa(sIDEmpresa) then
       DmWorkCom.CarregaDadosEmpresa;
    // Captura numero do ultimo pedido
    aIDPedido := RetornaUltimoPedidoCaixa(DmWorkCom.PAFECF.gCaixa);
    // captura as formas de pagamento
    DmWorkCom.Dados_PedidoFP(aIDPedido,true);
    // Verifica transações TEF pendente
    DmWorkCom.PAFECF.VerificaResolvePendenciaTEF(DmWorkCom.CdsPedidoFP,false,true);
    // captura o ID da Empresa vinculada a ECF
    sIDEmpresa := 1;
    DmWorkCom.PAFECF.sControleECFAtivo := 0;
    // captura o MD5
    DmWorkCom.PAFECF.gMD5 := DmWorkCom.PAFECF.GeraMD5PAFECF;
    // carrega os dados tecnicos
    if DmWorkCom.Dados_DadosTecnicos then
    begin
      DmWorkCom.PAFECF.gNOME_EXECUTAVEL := DmWorkCom.CdsDadosTecnicosPAFECF.AsString;
      DmWorkCom.PAFECF.gNOME_APLICACAO  := DmWorkCom.CdsDadosTecnicosDENOMINACAO.AsString;
      DmWorkCom.PAFECF.gVERSAO          := DmWorkCom.CdsDadosTecnicosVERSAO.AsString;
      DmWorkCom.PAFECF.gRazao_social    := DmWorkCom.CdsDadosTecnicosEMPRESA.AsString;
    end;
    FrmPrincipalSat.Caption := 'Emissor de Documento Fiscal - versão '+DmWorkCom.PAFECF.gVERSAO;
    // Verifica se tem arquivo inválido
    DmWorkCom.PAFECF.Verifica_Campo9;
  finally
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
  end;
  // login do usuario
  Application.CreateForm(TFrmLoginUsuario,FrmLoginUsuario);
  try
    FrmLoginUsuario.sOK := false;
    FrmLoginUsuario.sSelEmpresa := true;
    FrmLoginUsuario.ShowModal;
    if FrmLoginUsuario.sOK then
    begin
      StatusBar1.Panels.Items[2].Text := DmClientes.CdsUsuariosNOME_USUAIO.AsString;
      DmWorkCom.PAFECF.gIDOperador    := DmClientes.CdsUsuariosID.AsInteger;
      DmWorkCom.PAFECF.gOperador      := DmClientes.CdsUsuariosUSUARIO.AsString;
      DmWorkCom.PAFECF.gNomeOperador  := DmClientes.CdsUsuariosNOME_USUAIO.AsString;
      // verifica dados da empresa
      if DmWorkCom.Dados_Empresa(sIDEmpresa) then
      begin
        StatusBar1.Panels.Items[3].Text := DmWorkCom.CdsEmpresaRAZAO_SOCIAL.AsString;
        DmWorkCom.CarregaDadosEmpresa;
      end
      else
      begin
        MessageDlg('Não foi encontrado dados da configuração da empresa!', mtWarning, [mbOK], 0);
        Application.Terminate;
      end;
      // verifica tabela NCM
      if not DmProdutos.Dados_NCM then
      begin
        try
          formMensagem := TFormMensagem.Create('Aguarde... Importando registro da tabela NCM!',550,150,clWhite,clSilver);
          formMensagem.mostrar;
          Refresh;
          DmProdutos.ImportaDadosTabelaNCM;
        finally
          FormMensagem.destruir;
          FreeAndNil(FormMensagem);
        end;
      end;
      // abre a tela de venda
      btVendasClick(Sender);
    end
    else Application.Terminate;
  finally
    FrmLoginUsuario.Destroy
  end;

end;

procedure TFrmPrincipalSat.CarregarConfiguracao;
begin
  // tela principal
  if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg') then
  begin
    ImgLogoMarca.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg');
    ImgLogoMarca.Visible  := true;
  end;
  
end;

procedure TFrmPrincipalSat.dxBarLargeButton4Click(Sender: TObject);
begin
  btSuprimentoClick(Sender);
end;

procedure TFrmPrincipalSat.BtnEmitirClick(Sender: TObject);
begin
  btVendasClick(Sender);
end;

procedure TFrmPrincipalSat.dxBarLargeButton6Click(Sender: TObject);
begin
  btSangriaClick(Sender);
end;

procedure TFrmPrincipalSat.ShowHint(Sender: TObject);
begin
  statusbar1.Panels.Items[4].Text := Application.hint;

end;

procedure TFrmPrincipalSat.SobreoAplicativo1Click(Sender: TObject);
begin
  AbreForm(TFrmImforma,FrmImforma);

end;

procedure TFrmPrincipalSat.SpeedButton10Click(Sender: TObject);
begin
  ActEncerrarExecute(Sender);

end;

procedure TFrmPrincipalSat.SpeedButton1Click(Sender: TObject);
begin
  ActAbreCaixaExecute(Sender);

end;

procedure TFrmPrincipalSat.SpeedButton2Click(Sender: TObject);
begin
  ActFechaCaixaExecute(Sender);

end;

procedure TFrmPrincipalSat.SpeedButton3Click(Sender: TObject);
begin
  ActSuprimentoExecute(Sender);

end;

procedure TFrmPrincipalSat.SpeedButton4Click(Sender: TObject);
begin
  ActSangriaExecute(Sender);

end;

procedure TFrmPrincipalSat.SpeedButton5Click(Sender: TObject);
begin
  ActCupomFiscalExecute(Sender);

end;

procedure TFrmPrincipalSat.SpeedButton9Click(Sender: TObject);
begin
  AbreForm(TFrmImforma,FrmImforma);

end;

procedure TFrmPrincipalSat.FecharCaixa1Click(Sender: TObject);
begin
  ActFechaCaixaExecute(Sender);

end;

procedure TFrmPrincipalSat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmWorkCom.PAFECF.FechaPortaSerial;

end;

procedure TFrmPrincipalSat.CancelarDocumentoNoFiscal1Click(
  Sender: TObject);
begin
  DmWorkCom.PAFECF.CancelarCupomNaoFiscal;
end;

procedure TFrmPrincipalSat.CadastrarAliquotanoECF1Click(Sender: TObject);
var aAliq : String;
    aux : Double;
begin
  aAliq := '';
  if InputQuery('Cadastrar aliquota','Aliquota',aAliq) then
  begin
    try
      aux   := StrToFloat(aAliq);
      aAliq := FormatFloat('0.00',aux);
      aAliq := FiltraNumero(aAliq);
      DmWorkCom.PAFECF.AdicionarAliquotaECF(aAliq,0);
    except
      MessageDlg('Erro ao cadastrar aliquota!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
end;

procedure TFrmPrincipalSat.CadastrarFormadePagamentonaImpressora1Click(Sender: TObject);
var aFormaPag : String;
begin
  aFormaPag := '';
  if InputQuery('Cadastrar Forma de Pagamento','Descricao',aFormaPag) then
  begin
    try
      DmWorkCom.PAFECF.AdicionarFormaPagtoECF(aFormaPag);
    except
      MessageDlg('Erro ao cadastrar forma de pagamento!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

end;

procedure TFrmPrincipalSat.EfetuarSangria1Click(Sender: TObject);
begin
  ActSangriaExecute(Sender);

end;

procedure TFrmPrincipalSat.EmitirReduoZPendente1Click(Sender: TObject);
begin
  DmWorkCom.PAFECF.EmiteReducaoZ;
  
end;

procedure TFrmPrincipalSat.Encerrar2Click(Sender: TObject);
begin
  ActEncerrarExecute(Sender);

end;

procedure TFrmPrincipalSat.btVendasClick(Sender: TObject);
var NomeOperador : String;
    DataCaixa : TDateTime;
begin
  // Abre Jornada Fiscal
  if not DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    MessageDlg('Não há caixa aberto para realização do procedimento!', mtInformation, [mbOK], 0);
    Abort;
  end
  else
  begin
    if Trim(NomeOperador) <> Trim(DmWorkCom.PAFECF.gOperador) then
    begin
      MessageDlg('Operador atual difere do operador do caixa aberto!', mtWarning, [mbOK], 0);
      Abort;
    end;
    // verifica data do caixa
    if DataCaixa < SVData then
    begin
      MessageDlg('A Data do caixa aberto não conhecide com a data atual do sistema. Verfique!', mtWarning, [mbOK], 0);
      Abort;
    end;
    // localiza o caixa
    if DmWorkCom.Dados_Caixa(DataCaixa) then
    begin
       if DmWorkCom.PAFECF.sControleECFAtivo <> 0 then
       begin
         MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
         Exit;
       end;
       // verifica valor de sangria
       if DmWorkCom.PAFECF.RetornaSaldoCaixa(DmWorkCom.PAFECF.gCaixa,DataCaixa) > DmWorkCom.PAFECF.gValorSangria then
       begin
          Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
          try
            FrmMensageemProd.PnMensagem.Caption := 'É necessário a realização de sangria no caixa!';
            FrmMensageemProd.ShowModal;
          finally
            FreeAndNil(FrmMensageemProd);
          end;
       end;
       AbreForm(TFrmEmiCupom,FrmEmiCupom);
    end;
  end;

end;

procedure TFrmPrincipalSat.btSangriaClick(Sender: TObject);
var aValor, NomeOperador : String;
    aValorAux : Double;
    DataCaixa : TDateTime;
begin
  // Abre Jornada Fiscal
  if not DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    MessageDlg('Não há caixa aberto para realização do procedimento!', mtInformation, [mbOK], 0);
    Abort;
  end
  else
  begin
    if Trim(NomeOperador) <> Trim(DmWorkCom.PAFECF.gOperador) then
    begin
      MessageDlg('Operador atual difere do operador do caixa aberto!', mtWarning, [mbOK], 0);
      Abort;
    end;
    // localiza o caixa
    if DmWorkCom.Dados_Caixa(DataCaixa,true) then
    begin
      if sPAFNFCe = 0 then // paf-ecf
      begin
        if DmWorkCom.PAFECF.sControleECFAtivo <> 0 then
        begin
          MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
          Exit;
        end;
        // Abre Jornada Fiscal
        if not DmWorkCom.PAFECF.VerificaJornadaFiscal then
        begin
          MessageDlg('É necessário abrir a jornada fiscal!!!', mtWarning, [mbOK], 0);
          Abort;
        end;
      end;
      //
      aValor := '0';
      if InputQuery('Sangria no ECF','Valor',aValor) then
      begin
        try
           aValorAux := StrToFloat(aValor);
           aValor    := FormatFloat('0.00',aValorAux);
        except
           ShowMessage('O Valor informado é inválido!');
           Abort;
        end;
        if sPAFNFCe = 0 then // paf-ecf
        begin
          DmWorkCom.PAFECF.EfetuaSangria(aValor);
          DmWorkCom.PAFECF.EmiteGerencialSangria(DmWorkCom.PAFECF.gCaixa,
                                                 DmWorkCom.PAFECF.gOperador,
                                                 now,aValorAux);
          DmWorkCom.PAFECF.AtualizaINI(false);
        end
        else
        begin
          DmWorkCom.PAFECF.EmiteGerencialSangriaNFCe(DmWorkCom.PAFECF.gCaixa,
                                                     DmWorkCom.PAFECF.gOperador,
                                                     now,aValorAux,
                                                     '');
        end;
        // grava registro de movimento
        if DmWorkCom.Dados_Caixa(SVData,true) then
        begin
          DmWorkCom.Dados_CaixaMov(0);
          DmWorkCom.CdsCaixaMov.Append;
          DmWorkCom.CdsCaixaMov.FieldByName('HISTORICO').AsString := 'SANGRIA DE CAIXA';
          DmWorkCom.CdsCaixaMov.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
          DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString        := 'D';
          DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := StrToFloat(aValor);
          Grava_Dados(DmWorkCom.CdsCaixaMov);
        end;
      end;  
    end;
  end;
end;

procedure TFrmPrincipalSat.btSuprimentoClick(Sender: TObject);
var aValor, NomeOperador : String;
    aValorAux : Double;
    DataCaixa : TDateTime;
begin
  // Abre Jornada Fiscal
  if not DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    MessageDlg('Não há caixa aberto para realização do procedimento!', mtInformation, [mbOK], 0);
    Abort;
  end
  else
  begin
    if Trim(NomeOperador) <> Trim(DmWorkCom.PAFECF.gOperador) then
    begin
      MessageDlg('Operador atual difere do operador do caixa aberto!', mtWarning, [mbOK], 0);
      Abort;
    end;
     // localiza o caixa
    if DmWorkCom.Dados_Caixa(DataCaixa,true) then
    begin
      if sPAFNFCe = 0 then // paf-ecf
      begin
        if DmWorkCom.PAFECF.sControleECFAtivo <> 0 then
        begin
         MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
         Exit;
        end;
        // Abre Jornada Fiscal
        if not DmWorkCom.PAFECF.VerificaJornadaFiscal then
        begin
          MessageDlg('É necessário abrir a jornada fiscal!!!', mtWarning, [mbOK], 0);
          exit;
        end;
      end;  
      //
      aValor := '0';
      if InputQuery('Suprimento no ECF','Valor',aValor) then
      begin
        try
          aValorAux := StrToFloat(aValor);
          aValor    := FormatFloat('0.00',aValorAux);
        except
          ShowMessage('O Valor informado é inválido!');
          Abort;
        end;
        if sPAFNFCe = 0 then // paf-ecf
        begin
          DmWorkCom.PAFECF.EfetuaSuprimento(aValor);
          DmWorkCom.PAFECF.AtualizaINI(false);
        end
        else
        begin
          DmWorkCom.PAFECF.EmiteGerencialSSuprimentoNFCe(DmWorkCom.PAFECF.gCaixa,
                                                         DmWorkCom.PAFECF.gOperador,
                                                         now,aValorAux);
        end;
        // grava registro de movimento
        if DmWorkCom.Dados_Caixa(SVData,True) then
        begin
          DmWorkCom.Dados_CaixaMov(0);
          DmWorkCom.CdsCaixaMov.Append;
          DmWorkCom.CdsCaixaMov.FieldByName('HISTORICO').AsString := 'SUPRIMENTO DE CAIXA';
          DmWorkCom.CdsCaixaMov.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
          DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString        := 'C';
          DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := StrToFloat(aValor);
          Grava_Dados(DmWorkCom.CdsCaixaMov);
        end;
      end;
    end;
  end;
end;

procedure TFrmPrincipalSat.ActCupomFiscalExecute(Sender: TObject);
begin
  btVendasClick(Sender);

end;

procedure TFrmPrincipalSat.ActEncerrarExecute(Sender: TObject);
begin
  Application.Terminate;

end;

procedure TFrmPrincipalSat.ActSangriaExecute(Sender: TObject);
begin
  btSangriaClick(Sender);

end;

procedure TFrmPrincipalSat.ActSuprimentoExecute(Sender: TObject);
begin
  btSuprimentoClick(Sender);

end;

procedure TFrmPrincipalSat.AbrirCaixa1Click(Sender: TObject);
begin
  ActAbreCaixaExecute(Sender);

end;

procedure TFrmPrincipalSat.ActAbreCaixaExecute(Sender: TObject);
var NomeOperador : String;
    DataCaixa : TDateTime;
begin
   if sPAFNFCe = 0 then // paf-ecf
   begin
     // Verifica se a jornada esta fechada
     if not DmWorkCom.PAFECF.VerificaJornadaFiscal then
     begin
       MessageDlg('A jornada fiscal esta fechada no ECF. Favor abrir caixa pela opção!', mtInformation, [mbOK], 0);
       Abort;
     end;
   end;
   // Abre Jornada Fiscal
   if DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
   begin
     MessageDlg('O caixa esta aberto para '+NomeOperador+' na data '+DateToStr(DataCaixa)+'. Proceda o fechamento!', mtInformation, [mbOK], 0);
     Abort;
   end;
   // Abre a jornada fiscal
   Application.CreateForm(TFrmAbrecaixa,FrmAbrecaixa);
   try
     DmClientes.Dados_Funcionario;
     DmWorkCom.Dados_Caixa(SVData,true);
     FrmAbreCaixa.ShowModal;
     if FrmAbreCaixa.sValor > 0 then
     begin
       if sPAFNFCe = 0 then // paf-ecf
          DmWorkCom.PAFECF.EfetuaSuprimento(FloatToStr(FrmAbreCaixa.sValor));
       // grava registro de movimento
       if DmWorkCom.Dados_Caixa(SVData,true) then
       begin
         DmWorkCom.Dados_CaixaMov(0);
         DmWorkCom.CdsCaixaMov.Append;
         DmWorkCom.CdsCaixaMov.FieldByName('HISTORICO').AsString := 'SUPRIMENTO DE CAIXA';
         DmWorkCom.CdsCaixaMov.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
         DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString        := 'C';
         DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := FrmAbreCaixa.sValor;
         Grava_Dados(DmWorkCom.CdsCaixaMov);
       end;
       DmWorkCom.PAFECF.AtualizaINI(false);
     end;
   finally
     FreeAndNil(FrmAbreCaixa);
   end;

end;

procedure TFrmPrincipalSat.ActFechaCaixaExecute(Sender: TObject);
var NomeOperador : String;
    DataCaixa : TDateTime;
    aValorTotal, aValDinheiro, aValCartao, aValCheque, aValOutros : Double;
begin
  // Abre Jornada Fiscal
  if not DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    MessageDlg('Não há caixa aberto para o fechamento!', mtInformation, [mbOK], 0);
    Exit;
  end
  else
  begin
    if Trim(NomeOperador) <> Trim(DmWorkCom.PAFECF.gOperador) then
    begin
      if not Confirmacao('Operador atual difere do operador do caixa aberto. Prosseguir mesmo assim?') then
         Abort;
    end;
    // localiza o caixa
    if DmWorkCom.Dados_Caixa(DataCaixa,true) then
    begin
      // verifica permissão de usuário
      Application.CreateForm(TFrmLiberacao,FrmLiberacao);
      try
        FrmLiberacao.ShowModal;
        if FrmLiberacao.sOk then
        begin
          aValorTotal := 0;
          try
            Application.CreateForm(TFrmFechaCaixa,FrmFechaCaixa);
            FrmFechaCaixa.ShowModal;
            aValDinheiro := FrmFechaCaixa.sDinheiro;
            aValCartao   := FrmFechaCaixa.sCartao;
            aValCheque   := FrmFechaCaixa.sCheque;
            aValOutros   := FrmFechaCaixa.sOutros;
          finally
            FreeAndNil(FrmFechaCaixa);
          end;
          //
          aValorTotal := aValDinheiro + aValCartao + aValCheque + aValOutros;
          if aValorTotal > 0 then
          begin
            //
            if Confirmacao('Confirma o fechamento do caixa aberto para '+NomeOperador) then
            begin
              // efetua a sangria do valor informado
              if sPAFNFCe = 0 then // paf-ecf
              begin
                DmWorkCom.PAFECF.EfetuaSangria(FormatFloat('0.00',aValorTotal));
                // Imprimir gerencial de fechamento
                if DmWorkCom.PAFECF.gGerFechaCaixa then
                begin
                  DmWorkCom.PAFECF.ImprimirFechamentoCaixa(DmWorkCom.PAFECF.gOperador,
                                                           NomeOperador,
                                                           aValorTotal);
                end;
              end;
              // grava registro de movimento
              DmWorkCom.Dados_CaixaMov(0);
              DmWorkCom.CdsCaixaMov.Append;
              DmWorkCom.CdsCaixaMov.FieldByName('HISTORICO').AsString := 'SANGRIA DE CAIXA';
              DmWorkCom.CdsCaixaMov.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
              DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString        := 'D';
              DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := aValorTotal;
              Grava_Dados(DmWorkCom.CdsCaixaMov);
              // grava caixa como fechado
              DmWorkCom.GravaFechamentoCaixaDiario(DataCaixa,aValDinheiro,aValCartao,aValCheque,aValOutros);
              // emite leitura X
              if sPAFNFCe = 0 then // paf-ecf
              begin
                if DmWorkCom.PAFECF.gLXFechaCaixa then
                begin
                  DmWorkCom.PAFECF.LeituraX;
                end;
              end;
            end;
          end;
        end
      finally
        FreeAndNil(FrmLiberacao);
      end;
    end;
  end;  

end;

procedure TFrmPrincipalSat.dxBarLargeButton1Click(Sender: TObject);
begin
  ActAbreCaixaExecute(Sender);
end;

procedure TFrmPrincipalSat.dxBarLargeButton8Click(Sender: TObject);
begin
  ActFechaCaixaExecute(Sender);
end;

procedure TFrmPrincipalSat.dxBarLargeButton20Click(Sender: TObject);
begin
  AbreForm(TFrmImforma,FrmImforma);

end;

procedure TFrmPrincipalSat.dxBarLargeButton21Click(Sender: TObject);
begin
  ActEncerrarExecute(Sender);

end;

end.
