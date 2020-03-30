unit uFrmPrincipalECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Menus, Buttons, ActnList, ExtCtrls, StdCtrls,
  ACBrDevice, ImgList, XPMan, jpeg, System.ImageList, System.Actions;

type
  TFrmPrincipalECF = class(TForm)
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    ActCupomFiscal: TAction;
    ActMenuFiscal: TAction;
    ActEncerrar: TAction;
    ActSangria: TAction;
    ActSuprimento: TAction;
    ActAbrirJornada: TAction;
    ActFecharJornada: TAction;
    ActSintegra: TAction;
    ActConfig: TAction;
    Timer1: TTimer;
    ImageList1: TImageList;
    XPManifest1: TXPManifest;
    LbArqMD5: TLabel;
    ActAbreCaixa: TAction;
    ActFechaCaixa: TAction;
    OpenDialog1: TOpenDialog;
    ActVendaNFCe: TAction;
    MainMenu1: TMainMenu;
    MenuPAFECF1: TMenuItem;
    MovimentaodeCaixa1: TMenuItem;
    AbrirJornada1: TMenuItem;
    FecharJornada1: TMenuItem;
    AbrirCaixa1: TMenuItem;
    FecharCaixa1: TMenuItem;
    Emitirorelatoriodefechamentodecaixa1: TMenuItem;
    OpesdoECF1: TMenuItem;
    LanarSuprimento1: TMenuItem;
    EfetuarSangria1: TMenuItem;
    PDV1: TMenuItem;
    MenuFiscal1: TMenuItem;
    rocadePlacasBomba1: TMenuItem;
    OpesdoSistema1: TMenuItem;
    SobreoAplicativo1: TMenuItem;
    Encerrar1: TMenuItem;
    Utilitrios1: TMenuItem;
    CancelarCupomPendente1: TMenuItem;
    CadastrarAliquotasnoECF1: TMenuItem;
    FormasdePagamentonoECF1: TMenuItem;
    LerreduoArqSPED1: TMenuItem;
    EmitirZPendente1: TMenuItem;
    CadastrarIndiceGerencial1: TMenuItem;
    Encerrar2: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    ImgLogoMarca: TImage;
    Registrodenotamanual1: TMenuItem;
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
    procedure btMenuFiscalClick(Sender: TObject);
    procedure btSangriaClick(Sender: TObject);
    procedure btSuprimentoClick(Sender: TObject);
    procedure btJornadaClick(Sender: TObject);
    procedure btFimDiaClick(Sender: TObject);
    procedure ActCupomFiscalExecute(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure ActSangriaExecute(Sender: TObject);
    procedure ActSuprimentoExecute(Sender: TObject);
    procedure ActAbrirJornadaExecute(Sender: TObject);
    procedure ActFecharJornadaExecute(Sender: TObject);
    procedure BtnAbreJornadaClick(Sender: TObject);
    procedure BtnFechaJornadaClick(Sender: TObject);
    procedure BtnEmitirClick(Sender: TObject);
    procedure BtnMenuFiscalClick(Sender: TObject);
    procedure ActAbreCaixaExecute(Sender: TObject);
    procedure ActFechaCaixaExecute(Sender: TObject);
    procedure BtnPlacasClick(Sender: TObject);
    procedure ActVendaNFCeExecute(Sender: TObject);
    procedure BtnContingenciaClick(Sender: TObject);
    procedure AbrirCaixa1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FecharCaixa1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure AbrirJornada1Click(Sender: TObject);
    procedure FecharJornada1Click(Sender: TObject);
    procedure Emitirorelatoriodefechamentodecaixa1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure LanarSuprimento1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure EfetuarSangria1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure PDV1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure MenuFiscal1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure rocadePlacasBomba1Click(Sender: TObject);
    procedure SobreoAplicativo1Click(Sender: TObject);
    procedure Encerrar1Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure CancelarCupomPendente1Click(Sender: TObject);
    procedure CadastrarAliquotasnoECF1Click(Sender: TObject);
    procedure FormasdePagamentonoECF1Click(Sender: TObject);
    procedure LerreduoArqSPED1Click(Sender: TObject);
    procedure EmitirZPendente1Click(Sender: TObject);
    procedure CadastrarIndiceGerencial1Click(Sender: TObject);
    procedure Encerrar2Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Registrodenotamanual1Click(Sender: TObject);
  private
//    procedure TrataErros(Sender: TObject; E: Exception);
    procedure FechaCaixaAutomaticoZPendente;
    procedure AbreCaixaAutomaticoZPendente;
    { Private declarations }
  public
    { Public declarations }
    procedure ShowHint(Sender: TObject);
  end;

var
  FrmPrincipalECF: TFrmPrincipalECF;

implementation

uses uLibrary, uFrmEmiCupom, uDmWorkCom, uFrmMenuFiscal, uFrmLoginUsuario,
  uFrmConfiguracoes, uDmAcBr, DB, uFrmAbreCaixa, uFrmImforma,
  uFrmCadPlacasAbastec, uFrmMensageemProd, uFrmLiberacao, uFrmFechaCaixa,
  uFrmValSupSangria, uFrmEstoqueFisico, uDmPosto, uFrmCadReg61, uMensagem,
  uDmProdutos, uDMClientes;

{$R *.dfm}

procedure TFrmPrincipalECF.FormCreate(Sender: TObject);
begin
   Application.OnHint := ShowHint;
//   Application.OnException := TrataErros;
   sIDEmpresa := 1;
   CarregarConfiguracao;
   // verifica arquivo INI
   DmWorkCom.PAFECF.LeArquivoINI;
   FrmPrincipalECF.WindowState := wsMaximized;
   sPAFNFCe := 0;
   SpeedButton3.Caption := 'Registrar'+#13+'suprimento';
   SpeedButton4.Caption := 'Registrar'+#13+'Sangria';
   SpeedButton5.Caption := 'Emitir Doc.'+#13+'Fiscal';

end;

procedure TFrmPrincipalECF.FormShow(Sender: TObject);
var aTef : Boolean;
begin
  // Pportellaa.
//  DmWorkCom.PAFECF.LeArquivoINI;  Ler duas vezes? no onCreate e no onShow ??
//  DmAcBr.sMensagem := StatusBar2;
  DmWorkCom.PAFECF.ArqTemp := ExtractFilePath(Application.ExeName)+'INTPOS.001';
  StatusBar1.Panels.Items[0].Text := DateToStr(SVData);
  StatusBar1.Panels.Items[1].Text := 'IP: '+RetornaIP;
  StatusBar1.Panels.Items[4].Text := 'Aplicativo para Emissão de Documento Fiscal - Versão: 1.0.0.0';

end;

procedure TFrmPrincipalECF.LanarSuprimento1Click(Sender: TObject);
begin
  ActSuprimentoExecute(Sender);
end;

procedure TFrmPrincipalECF.LerreduoArqSPED1Click(Sender: TObject);
var formMensagem: TFormMensagem;
    Resultado : Boolean;
begin
  OpenDialog1.Execute;
  if Trim(OpenDialog1.FileName) <> '' then
  begin
    MessageDlg('Este procedimento irá importar apenas as reduções da ECF vinculada ao caixa!',mtInformation,[mbOK],0);
    try
      formMensagem := TFormMensagem.Create('Aguarde... enquanto e realizado o processo de importação!',650,150,clBlack,clSilver);
      formMensagem.mostrar;
      Refresh;
      //
      Resultado := DmWorkCom.GravaDadosReducaoArqSPED(OpenDialog1.FileName);
    finally
      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
    end;
    // exibe mensagem de retorno do procedimento
    if not Resultado then
    begin
      MessageDlg('Erro ao processar os dados do arquivo!',mtWarning,[mbOK],0);
      Exit;
    end
    else
      MessageDlg('Procedimento concluído com sucesso!',mtInformation,[mbOK],0);
  end;

end;

procedure TFrmPrincipalECF.MenuFiscal1Click(Sender: TObject);
begin
  ActMenuFiscalExecute(Sender);
end;

procedure TFrmPrincipalECF.PDV1Click(Sender: TObject);
begin
  ActCupomFiscalExecute(Sender);
end;

procedure TFrmPrincipalECF.Registrodenotamanual1Click(Sender: TObject);
begin
  BtnContingenciaClick(Sender);
end;

procedure TFrmPrincipalECF.rocadePlacasBomba1Click(Sender: TObject);
begin
  AbreForm(TFrmCadPlacasAbastec,FrmCadPlacasAbastec);

end;

procedure TFrmPrincipalECF.Timer1Timer(Sender: TObject);
var formMensagem: TFormMensagem;
    aMensagem, aux, aArquivo, NomeArquivo : String;
    aIDPedido : Integer;
    aDataMov, aDataAtual, aDataMes : TDateTime;
    aRedZPendente, aGerouEstFisico : Boolean;
begin
  try
    // Desativa timer
    Timer1.Enabled := false;
    // exibe a mensagem
    formMensagem := TFormMensagem.Create('Aguarde... enquanto o sistema é inicializado!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    // cadastra itens do aplicativo
    if not DmClientes.Dados_UsuariosItens(sNomeApp) then
    begin
      DmClientes.Grava_ItemsMenu(MainMenu1);
    end;
    // verifica perfil
    if not DmClientes.Dados_Perfil then
    begin
      DmClientes.Adiciona_PerfilPadrao;
    end
    else sIDPerfil := DmClientes.CdsUsuariosPerfilID.AsInteger;
    // verifica permissões
    if not DmClientes.Dados_Permissoes(sIDPerfil,sNomeApp) then
    begin
      // adciona permissoes
      DmClientes.Insere_PermissoesPerfil(sIDPerfil);
    end;
    // verifica usuários
    if not DmClientes.Dados_Usuarios then
    begin
      DmClientes.Adciona_UsuarioPadrao;
    end;

    aRedZPendente := false;
    // captura a empresa vinculada ao caixa
    sIDEmpresa := DmWorkCom.PAFECF.RetornaIDEmpresaCaixa;
    if DmWorkCom.Dados_Empresa(sIDEmpresa) then
       DmWorkCom.CarregaDadosEmpresa
    else
       sPAFNFCe := 0;
    // Captura numero do ultimo pedido
    aIDPedido := RetornaUltimoPedidoCaixa(DmWorkCom.PAFECF.gCaixa);
    // captura as formas de pagamento
    DmWorkCom.Dados_PedidoFP(aIDPedido,true);
    // Verifica transações TEF pendente
    DmWorkCom.PAFECF.VerificaResolvePendenciaTEF(DmWorkCom.CdsPedidoFP,false,true);
    // verifica tipo de funcionamento e paf-ecf
    if sPAFNFCe = 0 then
    begin
      // abre comunicação com impressora
      DmWorkCom.PAFECF.sControleECFAtivo := 0;
      if DmWorkCom.PAFECF.AbrePortaSerial then
      begin
        // captura o ID da Empresa vinculada a ECF
        sIDEmpresa := DmWorkCom.PAFECF.RetornaIDEmpresa;
      end
      else
         DmWorkCom.PAFECF.sControleECFAtivo := 1;
      //
      if sIDEmpresa = 0 then
      begin
        MessageDlg('É necessário vincular o caixa a empresa. Entre em contato com o suporte técnico!', mtError, [mbOK], 0);
        Application.Terminate;
      end;
      // carrega os dados tecnicos
      if DmWorkCom.Dados_DadosTecnicos then
      begin
        DmWorkCom.PAFECF.gNOME_EXECUTAVEL := DmWorkCom.CdsDadosTecnicosPAFECF.AsString;
        DmWorkCom.PAFECF.gNOME_APLICACAO  := DmWorkCom.CdsDadosTecnicosDENOMINACAO.AsString;
        DmWorkCom.PAFECF.gVERSAO          := DmWorkCom.CdsDadosTecnicosVERSAO.AsString;
        DmWorkCom.PAFECF.gRazao_social    := DmWorkCom.CdsDadosTecnicosEMPRESA.AsString;
      end;
      FrmPrincipalECF.Caption := 'Emissor de Cupom Fiscal - versão '+DmWorkCom.PAFECF.gVERSAO;
      // Verifica se tem arquivo inválido
      DmWorkCom.PAFECF.Verifica_Campo9;
      // verifica se a ECF esta ativa
      if DmWorkCom.PAFECF.sControleECFAtivo = 0 then
      begin
        DmWorkCom.PAFECF.CapturaDadosECF;
        if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
        begin
          ShowMessage(aMensagem);
          DmWorkCom.PAFECF.sControleECFAtivo := 2;
        end
        else
        begin
          // atualiza o arquivo MD5
          DmWorkCom.PAFECF.AtualizaINI;
        end;
      end;
      LbArqMD5.Caption := 'Arquivo MD5 gerado em '+DmWorkCom.PAFECF.ArqTextoMD5;
      // grava a identificação na ECF
      DmAcBr.ACBrECF1.IdentificaPAF(DmWorkCom.CdsDadosTecnicosDENOMINACAO.AsString,
                                    DmWorkCom.PAFECF.gMD5);
      // verifica se a ECF esta ativa
      if DmWorkCom.PAFECF.sControleECFAtivo = 0 then
      begin
        if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
        begin
          ShowMessage(aMensagem);
          DmWorkCom.PAFECF.sControleECFAtivo := 2;
        end;
      end;
    end
    else
    begin
      DmWorkCom.PAFECF.sControleECFAtivo := 0;
      // carrega os dados tecnicos
      if DmWorkCom.Dados_DadosTecnicos then
      begin
        DmWorkCom.PAFECF.gNOME_EXECUTAVEL := DmWorkCom.CdsDadosTecnicosPAFECF.AsString;
        DmWorkCom.PAFECF.gNOME_APLICACAO  := DmWorkCom.CdsDadosTecnicosDENOMINACAO.AsString;
        DmWorkCom.PAFECF.gVERSAO          := DmWorkCom.CdsDadosTecnicosVERSAO.AsString;
        DmWorkCom.PAFECF.gRazao_social    := DmWorkCom.CdsDadosTecnicosEMPRESA.AsString;
      end;
      FrmPrincipalECF.Caption := 'Emissor de Cupom Fiscal - versão '+DmWorkCom.PAFECF.gVERSAO;
      // Verifica se tem arquivo inválido
      DmWorkCom.PAFECF.Verifica_Campo9;
    end;
  finally
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
  end;
  // login do usuario
  Application.CreateForm(TFrmLoginUsuario,FrmLoginUsuario);
  try
    FrmLoginUsuario.sOK := false;
    FrmLoginUsuario.sSelEmpresa := false;
    FrmLoginUsuario.ShowModal;
    if FrmLoginUsuario.sOK then
    begin
      StatusBar1.Panels.Items[2].Text := DmClientes.CdsUsuariosNOME_USUAIO.AsString;
      DmWorkCom.PAFECF.gIDOperador    := DmClientes.CdsUsuariosID.AsInteger;
      DmWorkCom.PAFECF.gOperador      := DmClientes.CdsUsuariosUSUARIO.AsString;
      DmWorkCom.PAFECF.gNomeOperador  := DmClientes.CdsUsuariosNOME_USUAIO.AsString;
      // verifica permissões
      if not DmClientes.Dados_Permissoes(sIDPerfil,sNomeApp) then
      begin
        // adciona permissoes
        DmClientes.Insere_PermissoesPerfil(sIDPerfil);
      end;
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
          formMensagem := TFormMensagem.Create('Aguarde... Importando registro da tabela NCM!',550,150,clBlack,clSilver);
          formMensagem.mostrar;
          Refresh;
          DmProdutos.ImportaDadosTabelaNCM;
        finally
          FormMensagem.destruir;
          FreeAndNil(FormMensagem);
        end;
      end;
      //
      if sPAFNFCe = 0 then // paf-ecf
      begin
        try
          formMensagem := TFormMensagem.Create('Aguarde... verificando pendencias!',550,150,clBlack,clSilver);
          formMensagem.mostrar;
          Refresh;
          // verifica se a ECF esta ativa
          if DmWorkCom.PAFECF.sControleECFAtivo = 0 then
          begin
            aGerouEstFisico := false;
            // verifica redução pendente
            aDataMov := StrToDate(FormatDateTime('dd/mm/yyyy',DmAcBr.ACBrECF1.DataMovimento));
            aDataAtual := StrToDate(FormatDateTime('dd/mm/yyyy',SVData));
            if aDataMov < aDataAtual then
            begin
              if DmAcBr.ACBrECF1.Estado = estRequerZ then
              begin
                aRedZPendente := true;
                MessageDlg('Há redução Z pendente e será Emitida agora!',mtWarning,[mbOK],0);
                // EMITE RELATORIO DE ESTOQUE FISICO
                aDataMes := StrToDate(FormatDateTime('dd/mm/yyyy',UltimoDia(aDataMov)));
                if aDataMov = aDataMes then
                begin
                  // limpa informações anteriores
                  DmPosto.LimpaEstoqueFisicoAnterior;
                  // abre a tela para o cadastro
                  AbreForm(TFrmEstoqueFisico,FrmEstoqueFisico);
                  aGerouEstFisico := true;
                  try
                    formMensagem := TFormMensagem.Create('Aguarde... Criando arquivo XML de estoque!',550,100,clBlack,clSilver);
                    formMensagem.mostrar;
                    Refresh;
                    NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'ESTOQUE_'+FormatDateTime('ddmmyyyy',Now)+'.xml';
                    DmWorkCom.GerarXMLEstoque(PrimeiroDia(aDataMov),UltimoDia(aDataMov),NomeArquivo);
                    MessageDlg('Arquivo XML de redução gerado: '+NomeArquivo, mtInformation, [mbOK], 0);
                  finally
                    FormMensagem.destruir;
                  end;
                end;
                DmAcBr.ACBrECF1.ReducaoZ();
                // atualiza o estoque
                DmWorkCom.AtualizaEstoquedoDia;
                // grava os dados da ultima Z
                if not DmWorkCom.GravaDadosUltimaReducaoZ(false) then
                begin
                  MessageDlg('Erro ao gravar os dados da redução. Use o cadastro para armazenar os mesmos!', mtWarning, [mbOK], 0);
                end
                else
                begin
                  try
                    NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'REDUCAO_'+FormatDateTime('ddmmyyyy',Now)+'.xml';
                    DmWorkCom.GerarXMLReducao(aDataMov,aDataMov,NomeArquivo);
                    MessageDlg('Arquivo XML de redução gerado: '+NomeArquivo, mtInformation, [mbOK], 0);
                  except
                    on E:Exception do
                    begin
                      ShowMessage(E.Message);
                    end;
                  end;
                  // grava arquivo de Moviumento por ECF
                  DmWorkCom.RetornaDadosImpressora(DmWorkCom.PAFECF.gCaixa);
                  aux := DmWorkCom.PAFECF.pSerial;
                  if Length(aux) > 14 then
                     aux := copy(aux,length(aux)-13,14);
                  aux := ZeroEsquerda(DmWorkCom.PAFECF.gCodNacional,6)+aux+FormatDateTime('DDMMYYYY',aDataMov)+'.TXT';
                  aArquivo := DmWorkCom.PAFECF.gPathArqMenu+aux;
                  if FileExists(aArquivo) then
                     DeleteFile(aArquivo);
                  DmWorkCom.RegistrosECF(aArquivo,aDataMov,aDataMov,True);
                  DmAcBr.ACBrEAD1.AssinarArquivoComEAD(aArquivo);
                  MessageDlg('Arquivo de movimento criado em: '+aArquivo, mtWarning, [mbOK], 0);
                end;
                DmWorkCom.PAFECF.ZeraContadorCER;
              end;
            end;
            // verifica e abre a jornada fiscal
            if (not DmWorkCom.PAFECF.VerificaJornadaFiscal) and
               (DmAcBr.ACBrECF1.Estado <> estBloqueada) then
            begin
              aRedZPendente := false;
              DmWorkCom.PAFECF.AbreJornadaFiscal(0.01);
              // verifica se tem caixa anterior aberto e fecha automaticamente
              FechaCaixaAutomaticoZPendente;
              // abre o caixa com a data atual para o vendedor do caixa anterio
              AbreCaixaAutomaticoZPendente;
              // realiza os procedimento da pendencia
              DmWorkCom.PAFECF.AtualizaINI(false);
              // resolve situações de pre-venda
              DmWorkCom.LocalizaCancelaPrevendaPendente(SVData-2);
              if DmWorkCom.PAFECF.gRestaurante then
              begin
                // resolve situações de mesas
                DmWorkCom.LocalizaEmiteMesaAberta(SVData-2);
              end;
              // resolve situações de posto
              if DmWorkCom.PAFECF.gPosto then
              begin
//                if not DmPosto.ConectaConcentrador then
//                begin
//                  DmPosto.GravaPerdaComunicacaoBico(1,'',0);
//                end;
//                DmPosto.DesconectaConcentrador;
                // imprime o estoque fisico
                // EMITE RELATORIO DE ESTOQUE FISICO
//                aDataMov := StrToDate(FormatDateTime('dd/mm/yyyy',DmAcBr.ACBrECF1.DataMovimento));
                aDataMes := StrToDate(FormatDateTime('dd/mm/yyyy',UltimoDia(aDataMov)));
                if aDataMov = aDataMes then
                begin
                  if aGerouEstFisico then
                  begin
                    if DmPosto.Dados_Tanque then
                    begin
                      DmWorkCom.PAFECF.RelatorioEstoqueCombustivel(DmPosto.CdsTanques);
                    end;
                  end;  
                end;
                // verifica perdas de combustivel
                if DmPosto.Dados_TanquePerda then
                begin
                  DmWorkCom.PAFECF.RelatorioPerdaCombustive(DmPosto.CdsTanquePerda);
                end;
                // VERIFICA SE TEM PERDA DE COMUNICAÇÃO
                if DmPosto.VerificaComunicacaoBicos(True,True,aDataMov) then
                begin
                  DmWorkCom.PAFECF.RelatorioSemComunicacao(DmPosto.CdsBicoComunica);
                end;
                //
                DmWorkCom.LocalizaEmiteAbastecPendente;
                DmPosto.GeraCupomSaldoRemanescente;
                DmWorkCom.LocalizaEmiteAbastecPendente;
                DmWorkCom.EmiteControleEncerranteReducaoZ;
                DmWorkCom.PAFECF.ZeraContadorCER;
              end;
            end;
          end;
        finally
          FormMensagem.destruir;
          FreeAndNil(FormMensagem);
        end;
        // verifica jornada aberta
        if DmWorkCom.PAFECF.VerificaJornadaFiscal then
        begin
          try
            formMensagem := TFormMensagem.Create('Aguarde... Gravando redução Z pendente!',550,150,clBlack,clSilver);
            formMensagem.mostrar;
            Refresh;
            // verifica se redução anterior foi gravada
            if not DmWorkCom.VerificaReducaoZGravada(DmAcBr.ACBrECF1.NumCRZ,
                                                     DmAcBr.ACBrECF1.NumSerie) then
            begin
              if not DmWorkCom.GravaDadosUltimaReducaoZ(true) then       // AUTOMATICA
                 MessageDlg('Erro ao gravar os dados da redução. Use o cadastro para armazenar os mesmos!', mtWarning, [mbOK], 0);
            end;
          finally
            FormMensagem.destruir;
          end;
          // abre a tela de venda
//          btVendasClick(Sender);
        end
        else
        begin
          if DmAcBr.ACBrECF1.Estado = estBloqueada then
          begin
            DmWorkCom.PAFECF.sControleECFAtivo := 3;
            MessageDlg('A ECF esta bloqueada. Sistema liberado apenas para consulta!',mtWarning,[mbOK],0);
            // verifica se redução anterior foi gravada
            try
              formMensagem := TFormMensagem.Create('Aguarde... Gravando dados da ultima redução!',550,150,clBlack,clSilver);
              formMensagem.mostrar;
              Refresh;
              if not DmWorkCom.VerificaReducaoZGravada(DmAcBr.ACBrECF1.NumCRZ,
                                                       DmAcBr.ACBrECF1.NumSerie) then
              begin
                if not DmWorkCom.GravaDadosUltimaReducaoZ(true) then  // AUTOMATICA
                   MessageDlg('Erro ao gravar os dados da redução. Use o cadastro para armazenar os mesmos!', mtWarning, [mbOK], 0);
              end;
            finally
              FormMensagem.destruir;
            end;
          end
          else
          begin
            if not aRedZPendente then
            begin
              DmWorkCom.PAFECF.LeituraX;
              if DmWorkCom.PAFECF.gPosto then
                 DmWorkCom.EmiteControleEncerranteReducaoZ;
              // atualiza o estoque
              DmWorkCom.AtualizaEstoquedoDia;
            end;
          end;
        end;
      end;
    end
    else Application.Terminate;
  finally
    FrmLoginUsuario.Destroy
  end;

end;

procedure TFrmPrincipalECF.CarregarConfiguracao;
begin
  // tela principal
  if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg') then
  begin
    ImgLogoMarca.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg');
    ImgLogoMarca.Visible  := true;
  end;
  
end;

procedure TFrmPrincipalECF.BtnAbreJornadaClick(Sender: TObject);
begin
  btJornadaClick(Sender);
end;

procedure TFrmPrincipalECF.BtnFechaJornadaClick(Sender: TObject);
begin
  btFimDiaClick(Sender);
end;

procedure TFrmPrincipalECF.BtnEmitirClick(Sender: TObject);
begin
  btVendasClick(Sender);
end;

procedure TFrmPrincipalECF.BtnMenuFiscalClick(Sender: TObject);
begin
  btMenuFiscalClick(Sender);
end;

procedure TFrmPrincipalECF.ShowHint(Sender: TObject);
begin
  statusbar1.Panels.Items[4].Text := Application.hint;

end;

procedure TFrmPrincipalECF.SobreoAplicativo1Click(Sender: TObject);
begin
  AbreForm(TFrmImforma,FrmImforma);

end;

procedure TFrmPrincipalECF.SpeedButton10Click(Sender: TObject);
begin
  ActEncerrarExecute(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton1Click(Sender: TObject);
begin
  ActAbreCaixaExecute(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton2Click(Sender: TObject);
begin
  ActFechaCaixaExecute(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton3Click(Sender: TObject);
begin
  ActSuprimentoExecute(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton4Click(Sender: TObject);
begin
  ActSangriaExecute(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton5Click(Sender: TObject);
begin
  ActCupomFiscalExecute(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton6Click(Sender: TObject);
begin
  ActMenuFiscalExecute(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton7Click(Sender: TObject);
begin
  Emitirorelatoriodefechamentodecaixa1Click(Sender);

end;

procedure TFrmPrincipalECF.SpeedButton8Click(Sender: TObject);
begin
  LerreduoArqSPED1Click(Sender);
end;

procedure TFrmPrincipalECF.SpeedButton9Click(Sender: TObject);
begin
  SobreoAplicativo1Click(Sender);

end;

procedure TFrmPrincipalECF.FormasdePagamentonoECF1Click(Sender: TObject);
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

procedure TFrmPrincipalECF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmWorkCom.PAFECF.FechaPortaSerial;

end;

procedure TFrmPrincipalECF.CancelarCupomPendente1Click(Sender: TObject);
begin
  if Confirmacao('Confirma o cancelamento do documento em aberto?') then
  begin
    try
      // fiscal
      if (DmAcBr.ACBrECF1.Estado = estVenda) or
         (DmAcBr.ACBrECF1.Estado = estPagamento) then
      begin
        DmWorkCom.PAFECF.CancelaCupomECF;
      end;
      // não fiscal
      if DmAcBr.ACBrECF1.Estado = estNaoFiscal then
      begin
        DmWorkCom.PAFECF.CancelarCupomNaoFiscal;
      end;
      // Gerencial
      if DmAcBr.ACBrECF1.Estado = estRelatorio then
      begin
        DmWorkCom.PAFECF.FechaRelatorioGerencial;
      end;
    except
      MessageDlg('Erro ao tentar cancelar documento na ECF!', mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TFrmPrincipalECF.CancelarDocumentoNoFiscal1Click(
  Sender: TObject);
begin
  DmWorkCom.PAFECF.CancelarCupomNaoFiscal;
end;

procedure TFrmPrincipalECF.CadastrarAliquotanoECF1Click(Sender: TObject);
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

procedure TFrmPrincipalECF.CadastrarAliquotasnoECF1Click(Sender: TObject);
var aAliq : String;
    aux : Double;
begin
  aAliq := '';
  if InputQuery('Cadastrar aliquota','Aliquota',aAliq) then
  begin
    try
      aux   := StrToFloat(aAliq);
      aAliq := FormatFloat('0.00',aux);
//      aAliq := FiltraNumero(aAliq);
      DmWorkCom.PAFECF.AdicionarAliquotaECF(aAliq,0);
    except
      MessageDlg('Erro ao cadastrar aliquota!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

end;

procedure TFrmPrincipalECF.CadastrarFormadePagamentonaImpressora1Click(Sender: TObject);
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

procedure TFrmPrincipalECF.CadastrarIndiceGerencial1Click(Sender: TObject);
var aDescricao : String;
begin
  aDescricao := '';
  if InputQuery('Cadastrar Relatório Gerencial','Descricao',aDescricao) then
  begin
    try
      DmWorkCom.PAFECF.AdicionarRelatorioGerencialECF(aDescricao);
    except
      MessageDlg('Erro ao cadastrar Relatório Gerencial!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

end;

procedure TFrmPrincipalECF.EfetuarSangria1Click(Sender: TObject);
begin
  ActSangriaExecute(Sender);
end;

procedure TFrmPrincipalECF.Emitirorelatoriodefechamentodecaixa1Click(
  Sender: TObject);
var formMensagem: TFormMensagem;
begin
  try
    formMensagem := TFormMensagem.Create('Aguarde... Emitindo relatorio de caixa!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    // Emite o relatorio de caixa
    DmWorkCom.RelatorioFechamentoCaixa(SVData);
  finally
    FormMensagem.destruir;
  end;

end;

procedure TFrmPrincipalECF.EmitirReduoZPendente1Click(Sender: TObject);
begin
  DmWorkCom.PAFECF.EmiteReducaoZ;

end;

procedure TFrmPrincipalECF.EmitirZPendente1Click(Sender: TObject);
begin
  DmWorkCom.PAFECF.EmiteReducaoZ;

end;

procedure TFrmPrincipalECF.Encerrar1Click(Sender: TObject);
begin
  ActEncerrarExecute(Sender);
end;

procedure TFrmPrincipalECF.Encerrar2Click(Sender: TObject);
begin
  ActEncerrarExecute(Sender);
end;

procedure TFrmPrincipalECF.btVendasClick(Sender: TObject);
var NomeOperador, aMensagem : String;
    DataCaixa : TDateTime;
begin
  sPAFNFCe := 0;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
     MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
     Exit;
  end;
  if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
  begin
    ShowMessage(aMensagem);
    DmWorkCom.PAFECF.sControleECFAtivo := 2;
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
     MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
     Exit;
  end;
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
       //
       if sPAFNFCe = 0 then
       begin
         if not DmWorkCom.PAFECF.VerificaJornadaFiscal then
         begin
           MessageDlg('É necessário abrir a jornada fiscal!!!', mtWarning, [mbOK], 0);
           Exit;
         end;
       end;
       AbreForm(TFrmEmiCupom,FrmEmiCupom);
    end;
  end;

end;

procedure TFrmPrincipalECF.btMenuFiscalClick(Sender: TObject);
var aMensagem : String;
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo = 0 then
  begin
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
  end;  
  Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
  Try
    FrmMenuFiscal.ShowModal;
  Finally
    FrmMenuFiscal.Destroy;
  End;
end;

procedure TFrmPrincipalECF.btSangriaClick(Sender: TObject);
var aValor, NomeOperador, aMensagem : String;
    aValorAux : Double;
    DataCaixa : TDateTime;
begin
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
  begin
    ShowMessage(aMensagem);
    DmWorkCom.PAFECF.sControleECFAtivo := 2;
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
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
        // Abre Jornada Fiscal
        if not DmWorkCom.PAFECF.VerificaJornadaFiscal then
        begin
          MessageDlg('É necessário abrir a jornada fiscal!!!', mtWarning, [mbOK], 0);
          Abort;
        end;
      end;
      //
      try
        aValor := '0';
        Application.CreateForm(TFrmValSupSangria,FrmValSupSangria);
        FrmValSupSangria.ShowModal;
        aValorAux := FrmValSupSangria.sValor;
      finally
        FreeAndNil(FrmValSupSangria);
      end;
      if aValorAux > 0 then
      begin
        aValor    := FormatFloat('0.00',aValorAux);
        if sPAFNFCe = 0 then // paf-ecf
        begin
          DmWorkCom.PAFECF.EfetuaSangria(aValor);
          DmWorkCom.PAFECF.EmiteGerencialSangria(DmWorkCom.PAFECF.gCaixa,
                                                 DmWorkCom.PAFECF.gOperador,
                                                 now,aValorAux);
          DmWorkCom.PAFECF.AtualizaINI(false);
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

procedure TFrmPrincipalECF.btSuprimentoClick(Sender: TObject);
var aValor, NomeOperador, aMensagem : String;
    aValorAux : Double;
    DataCaixa : TDateTime;
begin
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
  begin
    ShowMessage(aMensagem);
    DmWorkCom.PAFECF.sControleECFAtivo := 2;
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
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
        // Abre Jornada Fiscal
        if not DmWorkCom.PAFECF.VerificaJornadaFiscal then
        begin
          MessageDlg('É necessário abrir a jornada fiscal!!!', mtWarning, [mbOK], 0);
          exit;
        end;
      end;  
      //
      try
        aValor := '0';
        Application.CreateForm(TFrmValSupSangria,FrmValSupSangria);
        FrmValSupSangria.ShowModal;
        aValorAux := FrmValSupSangria.sValor;
      finally
        FreeAndNil(FrmValSupSangria);
      end;
      if aValorAux > 0 then
      begin
        aValor    := FormatFloat('0.00',aValorAux);
        if sPAFNFCe = 0 then // paf-ecf
        begin
          DmWorkCom.PAFECF.EfetuaSuprimento(aValor);
          DmWorkCom.PAFECF.AtualizaINI(false);
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

procedure TFrmPrincipalECF.btJornadaClick(Sender: TObject);
var formMensagem: TFormMensagem;
    DataCaixa : TDateTime;
    NomeOperador : String;
begin
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
   // Verifica se o caixa esta fechado
   if DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
   begin
     MessageDlg('O caixa esta aberto para '+NomeOperador+' na data '+DateToStr(DataCaixa)+'. Proceda o fechamento!', mtInformation, [mbOK], 0);
     Abort;
   end;
   // Verifica se a jornada esta fechada
   if DmWorkCom.PAFECF.VerificaJornadaFiscal then
   begin
     MessageDlg('A jornada fiscal esta aberta no ECF. Para suprimento use a opção do menu!', mtInformation, [mbOK], 0);
     Abort;
   end;
   DmWorkCom.PAFECF.ZeraContadorCER;
   // Abre a jornada fiscal
   Application.CreateForm(TFrmAbrecaixa,FrmAbrecaixa);
   try
     DmClientes.Dados_Funcionario;
     DmWorkCom.Dados_Caixa(SVData);
     FrmAbreCaixa.ShowModal;
     if FrmAbreCaixa.sValor > 0 then
     begin
       try
         formMensagem := TFormMensagem.Create('Aguarde... realizando abertura da jornada fiscal!',550,150,clBlack,clSilver);
         formMensagem.mostrar;
         Refresh;
         //
         DmWorkCom.PAFECF.AbreJornadaFiscal(FrmAbreCaixa.sValor);
         DmWorkCom.PAFECF.AtualizaINI(false);
       finally
         FormMensagem.destruir;
       end;
       // resolve situações de pre-venda
       try
         formMensagem := TFormMensagem.Create('Aguarde... Resolvendo pendentes!',550,150,clBlack,clSilver);
         formMensagem.mostrar;
         Refresh;
//         if DmWorkCom.PAFECF.gPosto then
//            DmWorkCom.EmiteControleEncerranteReducaoZ;
         //
         DmWorkCom.PAFECF.AtualizaINI(false);
         // resolve situações de pre-venda
         DmWorkCom.LocalizaCancelaPrevendaPendente(SVData-2);
         if DmWorkCom.PAFECF.gRestaurante then
         begin
           // resolve situações de mesas
           DmWorkCom.LocalizaEmiteMesaAberta(SVData-2);
         end;
         // resolve situações de posto
         if DmWorkCom.PAFECF.gPosto then
         begin
           // VERIFICA SE TEM PERDA DE COMUNICAÇÃO
           if DmPosto.VerificaComunicacaoBicos(true,True) then
           begin
             DmWorkCom.PAFECF.RelatorioSemComunicacao(DmPosto.CdsBicoComunica);
           end;
           //
           DmWorkCom.LocalizaEmiteAbastecPendente;
           DmPosto.GeraCupomSaldoRemanescente;
           DmWorkCom.LocalizaEmiteAbastecPendente;
           if DmWorkCom.PAFECF.gPosto then
              DmWorkCom.EmiteControleEncerranteReducaoZ;
         end;
       finally
         FormMensagem.destruir;
       end;
     end;
   finally
     FreeAndNil(FrmAbreCaixa);
   end;

end;

procedure TFrmPrincipalECF.btFimDiaClick(Sender: TObject);
var aArquivo, aux, NomeOperador, NomeArquivo : String;
    DadosPosto : Boolean;
    DataCaixa, DataECF, DataMov, DataMes : TDateTime;
begin
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  // Verifica se tem caixa aberto
  if DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    MessageDlg('Há caixa aberto. Proceda o fechamento antes de finalizar a jornada fiscal!', mtInformation, [mbOK], 0);
    Exit;
  end;
  // Fecha Jornada Fiscal
  if Confirmacao('Após o fechamento da jornada não mais será possível emitir cupons fiscais!'+#13+'Continuar?') then
  begin
    if DmWorkCom.PAFECF.VerificaJornadaFiscal then
    begin
      Application.CreateForm(TFrmLiberacao,FrmLiberacao);
      try
        FrmLiberacao.ShowModal;
        if FrmLiberacao.sOk then
        begin
          if DmWorkCom.VerificaUltimoCaixaAberto then
          begin
            // resolve situações de pre-venda
            DmWorkCom.LocalizaCancelaPrevendaPendente(SVData-1);
            if DmWorkCom.PAFECF.gRestaurante then
            begin
              // resolve situações de mesas
              DmWorkCom.LocalizaEmiteMesaAberta(SVData-1);
            end;
          end;
          // verifica se não esta em modo de redução Z pendente
          if DmAcBr.ACBrECF1.Estado <> estRequerZ then
          begin
            // emite relatorio de encerrantes
            if DmWorkCom.PAFECF.gPosto then
            begin
              // EMITE RELATORIO DE ESTOQUE FISICO
              DataECF := StrToDate(FormatDateTime('DD/MM/YYYY',DmAcBr.ACBrECF1.DataHora));
              DataMov := StrToDate(FormatDateTime('dd/mm/yyyy',DmAcBr.ACBrECF1.DataMovimento));
              DataMes := StrToDate(FormatDateTime('dd/mm/yyyy',UltimoDia(DataMov)));
              if DataMov = DataMes then
              begin
                // limpa informações anteriores
                DmPosto.LimpaEstoqueFisicoAnterior;
                // abre a tela para o cadastro
                AbreForm(TFrmEstoqueFisico,FrmEstoqueFisico);
                if DmPosto.Dados_Tanque then
                begin
                  DmWorkCom.PAFECF.RelatorioEstoqueCombustivel(DmPosto.CdsTanques);
                end;
              end;
              // verifica perdas de combustivel
              if DmPosto.Dados_TanquePerda then
              begin
                DmWorkCom.PAFECF.RelatorioPerdaCombustive(DmPosto.CdsTanquePerda);
              end;
              // VERIFICA SE TEM PERDA DE COMUNICAÇÃO
              if DmPosto.VerificaComunicacaoBicos(True,True) then
              begin
                DmWorkCom.PAFECF.RelatorioSemComunicacao(DmPosto.CdsBicoComunica);
              end;
              // resolve situações de posto
              DmWorkCom.LocalizaEmiteAbastecPendente;
              DmPosto.GeraCupomSaldoRemanescente(True);
              DmWorkCom.LocalizaEmiteAbastecPendente;
              DmWorkCom.EmiteControleEncerranteReducaoZ;
            end;
            // defini situação de posto para NÃO executar depois da Z
            DadosPosto := false;
          end
          else
          begin
            // defini situação de posto para executar depois da Z
            DadosPosto := true;
          end;
          DmWorkCom.PAFECF.FecharAbreJornadaFiscal;
          // grava redução Z
          if not DadosPosto then
          begin
            if not DmWorkCom.GravaDadosUltimaReducaoZ(false) then
               MessageDlg('Erro ao gravar os dados da redução. Use o cadastro para armazenar os mesmos!', mtWarning, [mbOK], 0);
          end
          else
          begin
            if not DmWorkCom.GravaDadosUltimaReducaoZ(true) then
               MessageDlg('Erro ao gravar os dados da redução. Use o cadastro para armazenar os mesmos!', mtWarning, [mbOK], 0);
          end;
          // grava o XML de redução
          try
            NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'REDUCAO_'+FormatDateTime('ddmmyyyy',DataMov)+'.xml';
            DmWorkCom.GerarXMLReducao(DataMov,DataMov,NomeArquivo);
            MessageDlg('Arquivo XML de redução gerado: '+NomeArquivo, mtInformation, [mbOK], 0);
          except
            on E:Exception do
            begin
              ShowMessage(E.Message);
            end;
          end;
          DmWorkCom.PAFECF.AtualizaINI(false);
          DmWorkCom.PAFECF.ZeraContadorCER;
          DmWorkCom.PAFECF.sControleECFAtivo := 3;
          // resolve situações de posto
          if DadosPosto then
          begin
            if DmWorkCom.PAFECF.gPosto then
            begin
              DmWorkCom.PAFECF.AbreJornadaFiscal(0.01);
              // verifica se tem caixa anterior aberto e fecha automaticamente
              FechaCaixaAutomaticoZPendente;
              // abre o caixa com a data atual para o vendedor do caixa anterio
              AbreCaixaAutomaticoZPendente;
              // realiza os procedimento da pendencia
              DmWorkCom.PAFECF.AtualizaINI(false);
              // resolve situações de pre-venda
              DmWorkCom.LocalizaCancelaPrevendaPendente(SVData-2);
              if DmWorkCom.PAFECF.gRestaurante then
              begin
                // resolve situações de mesas
                DmWorkCom.LocalizaEmiteMesaAberta(SVData-2);
              end;
              // resolve situações de posto
              if DmWorkCom.PAFECF.gPosto then
              begin
                // imprime o estoque fisico
                // EMITE RELATORIO DE ESTOQUE FISICO
                DataMov := StrToDate(FormatDateTime('dd/mm/yyyy',DmAcBr.ACBrECF1.DataMovimento));
                DataMes := StrToDate(FormatDateTime('dd/mm/yyyy',UltimoDia(DataMov)));
                if DataMov = DataMes then
                begin
                  if DmPosto.Dados_Tanque then
                  begin
                    DmWorkCom.PAFECF.RelatorioEstoqueCombustivel(DmPosto.CdsTanques);
                  end;
                end;
                // verifica perdas de combustivel
                if DmPosto.Dados_TanquePerda then
                begin
                  DmWorkCom.PAFECF.RelatorioPerdaCombustive(DmPosto.CdsTanquePerda);
                end;
                // VERIFICA SE TEM PERDA DE COMUNICAÇÃO
                if DmPosto.VerificaComunicacaoBicos(True,True) then
                begin
                  DmWorkCom.PAFECF.RelatorioSemComunicacao(DmPosto.CdsBicoComunica);
                end;
                //
                DmWorkCom.LocalizaEmiteAbastecPendente;
                DmPosto.GeraCupomSaldoRemanescente;
                DmWorkCom.LocalizaEmiteAbastecPendente;
                DmWorkCom.EmiteControleEncerranteReducaoZ;
                DmWorkCom.PAFECF.ZeraContadorCER;
                // Grava Redução Z como não automatica
                DmWorkCom.GravaReducaoZNaoAutomatica;
              end;
            end;
          end;
          // grava arquivo de Moviumento por ECF
          DmWorkCom.RetornaDadosImpressora(DmWorkCom.PAFECF.gCaixa);
          aux := DmWorkCom.PAFECF.pSerial;
          if Length(aux) > 14 then
             aux := copy(aux,length(aux)-13,14);
          aux := ZeroEsquerda(DmWorkCom.PAFECF.gCodNacional,6)+aux+FormatDateTime('DDMMYYYY',SVData)+'.TXT';
          aArquivo := DmWorkCom.PAFECF.gPathArqMenu+aux;
          if FileExists(aArquivo) then
             DeleteFile(aArquivo);
          DmWorkCom.RegistrosECF(aArquivo,SVData,SVData,True);
          DmAcBr.ACBrEAD1.AssinarArquivoComEAD(aArquivo);
          MessageDlg('Arquivo de movimento criado em: '+aArquivo, mtWarning, [mbOK], 0);
        end;
      finally
        FreeAndNil(FrmLiberacao);
      end;
    end
    else
    begin
       MessageDlg('A jornada fiscal já esta fechada!', mtWarning, [mbOK], 0);
       Abort;
    end;
  end;  
end;


{
procedure TFrmPrincipalECF.btFimDiaClick(Sender: TObject);
var aArquivo, aux, NomeOperador : String;
    DadosPosto, DadosMesa : Boolean;
    DataCaixa, DataECF, DataMov, DataMes : TDateTime;
begin
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  // Verifica se tem caixa aberto
  if DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    MessageDlg('Há caixa aberto. Proceda o fechamento antes de finalizar a jornada fiscal!', mtInformation, [mbOK], 0);
    Exit;
  end;
  // Fecha Jornada Fiscal
  if Confirmacao('Após o fechamento da jornada não mais será possível emitir cupons fiscais!'+#13+'Continuar?') then
  begin
    if DmWorkCom.PAFECF.VerificaJornadaFiscal then
    begin
      Application.CreateForm(TFrmLiberacao,FrmLiberacao);
      try
        FrmLiberacao.ShowModal;
        if FrmLiberacao.sOk then
        begin
          if DmWorkCom.VerificaUltimoCaixaAberto then
          begin
            // resolve situações de pre-venda
            DmWorkCom.LocalizaCancelaPrevendaPendente(SVData-1);
            if DmWorkCom.PAFECF.gRestaurante then
            begin
              // resolve situações de mesas
              DmWorkCom.LocalizaEmiteMesaAberta(SVData-1);
            end;
          end;
          // emite relatorio de encerrantes
          if DmWorkCom.PAFECF.gPosto then
          begin
            // EMITE RELATORIO DE ESTOQUE FISICO
            DataMov := StrToDate(FormatDateTime('dd/mm/yyyy',DmAcBr.ACBrECF1.DataMovimento));
            DataMes := StrToDate(FormatDateTime('dd/mm/yyyy',UltimoDia(DataMov)));
            if DataMov = DataMes then
            begin
              // limpa informações anteriores
              DmPosto.LimpaEstoqueFisicoAnterior;
              // abre a tela para o cadastro
              AbreForm(TFrmEstoqueFisico,FrmEstoqueFisico);
              if DmPosto.Dados_Tanque then
              begin
                DmWorkCom.PAFECF.RelatorioEstoqueCombustivel(DmPosto.CdsTanques);
              end;
            end;
            // verifica perdas de combustivel
            if DmPosto.Dados_TanquePerda then
            begin
              DmWorkCom.PAFECF.RelatorioPerdaCombustive(DmPosto.CdsTanquePerda);
            end;
            //
//            if not DmPosto.ConectaConcentrador then
//            begin
//              DmPosto.GravaPerdaComunicacaoBico(1,'',0);
//            end;
//            DmPosto.DesconectaConcentrador;
            // VERIFICA SE TEM PERDA DE COMUNICAÇÃO
            if DmPosto.VerificaComunicacaoBicos(True,True) then
            begin
              DmWorkCom.PAFECF.RelatorioSemComunicacao(DmPosto.CdsBicoComunica);
            end;
          end;
          // verifica data para definir situação de posto
          DadosPosto := false;
          DadosMesa  := false;
          DataECF := StrToDate(FormatDateTime('DD/MM/YYYY',DmAcBr.ACBrECF1.DataHora));
          DataMov := StrToDate(FormatDateTime('DD/MM/YYYY',DmAcBr.ACBrECF1.DataMovimento));
          if DataECF > DataMov  then
          begin
            if StrToTime(TimeToStr(DmAcBr.ACBrECF1.DataHora)) <= StrToTime('02:00:00') then
            begin
              DadosPosto := true;
              DadosMesa  := true;
            end;
          end
          else
          begin
            DadosPosto := true;
            DadosMesa  := true;
          end;
          // resolve situações de posto
          if DadosPosto then
          begin
            DmWorkCom.LocalizaEmiteAbastecPendente;
            DmPosto.GeraCupomSaldoRemanescente('S',True);
            DmWorkCom.LocalizaEmiteAbastecPendente;
            DmWorkCom.EmiteControleEncerranteReducaoZ;
          end;
          DmWorkCom.PAFECF.FecharAbreJornadaFiscal;
          // grava redução Z
          if not DmWorkCom.GravaDadosUltimaReducaoZ(false) then
             MessageDlg('Erro ao gravar os dados da redução. Use o cadastro para armazenar os mesmos!', mtWarning, [mbOK], 0);
          DmWorkCom.PAFECF.AtualizaINI(false);
          DmWorkCom.PAFECF.ZeraContadorCER;
          DmWorkCom.PAFECF.sControleECFAtivo := 3;
          // verifica data
          if DataECF > DataMov  then
          begin
            // resolve situações de restaurantes
//            if DmWorkCom.PAFECF.gRestaurante then
//               DmWorkCom.PAFECF.MesasAbertas;
            // resolve situações de posto
            if DmWorkCom.PAFECF.gPosto then
            begin
              if StrToTime(TimeToStr(DmAcBr.ACBrECF1.DataHora)) > StrToTime('02:00:00') then
              begin
                DmAcBr.ACBrECF1.LeituraX;
                // resolve situações de posto
                DmWorkCom.LocalizaEmiteAbastecPendente;
                DmPosto.GeraCupomSaldoRemanescente('S');
                DmWorkCom.LocalizaEmiteAbastecPendente;
              end;
            end;
          end;
          // grava arquivo de Moviumento por ECF
          DmWorkCom.RetornaDadosImpressora(DmWorkCom.PAFECF.gCaixa);
          aux := DmWorkCom.PAFECF.pSerial;
          if Length(aux) > 14 then
             aux := copy(aux,length(aux)-13,14);
          aux := ZeroEsquerda(DmWorkCom.PAFECF.gCodNacional,6)+aux+FormatDateTime('DDMMYYYY',SVData)+'.TXT';
          aArquivo := DmWorkCom.PAFECF.gPathArqMenu+aux;
          if FileExists(aArquivo) then
             DeleteFile(aArquivo);
          DmWorkCom.RegistrosECF(aArquivo,SVData,SVData);
          DmAcBr.ACBrEAD1.AssinarArquivoComEAD(aArquivo);
          MessageDlg('Arquivo de movimento criado em: '+aArquivo, mtWarning, [mbOK], 0);
        end;
      finally
        FreeAndNil(FrmLiberacao);
      end;
    end
    else
    begin
       MessageDlg('A jornada fiscal já esta fechada!', mtWarning, [mbOK], 0);
       Abort;
    end;
  end;
end;
}

procedure TFrmPrincipalECF.ActCupomFiscalExecute(Sender: TObject);
begin
  // verifica permissao
  if Verifica_Permissao(sIDPerfil,'PDV1') then
  begin
    btVendasClick(Sender);
  end;

end;

procedure TFrmPrincipalECF.ActMenuFiscalExecute(Sender: TObject);
begin
  // verifica permissao
  if Verifica_Permissao(sIDPerfil,'MenuFiscal1') then
  begin
    btMenuFiscalClick(Sender);
  end;

end;

procedure TFrmPrincipalECF.ActEncerrarExecute(Sender: TObject);
begin
  Application.Terminate;

end;

procedure TFrmPrincipalECF.ActSangriaExecute(Sender: TObject);
begin
  btSangriaClick(Sender);

end;

procedure TFrmPrincipalECF.ActSuprimentoExecute(Sender: TObject);
begin
  btSuprimentoClick(Sender);

end;

procedure TFrmPrincipalECF.ActAbrirJornadaExecute(Sender: TObject);
begin
  btJornadaClick(Sender);

end;

procedure TFrmPrincipalECF.ActFecharJornadaExecute(Sender: TObject);
begin
  btFimDiaClick(Sender);

end;

procedure TFrmPrincipalECF.AbrirCaixa1Click(Sender: TObject);
begin
  ActAbreCaixaExecute(Sender);
end;

procedure TFrmPrincipalECF.AbrirJornada1Click(Sender: TObject);
begin
  ActAbrirJornadaExecute(Sender);

end;

procedure TFrmPrincipalECF.ActAbreCaixaExecute(Sender: TObject);
var NomeOperador : String;
    DataCaixa : TDateTime;
begin
   if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
   begin
     MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
     Exit;
   end;
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
       begin
         DmWorkCom.PAFECF.EfetuaSuprimento(FloatToStr(FrmAbreCaixa.sValor));
       end;
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

procedure TFrmPrincipalECF.ActFechaCaixaExecute(Sender: TObject);
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
    if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
    begin
      MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
      Exit;
    end;
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

procedure TFrmPrincipalECF.BtnPlacasClick(Sender: TObject);
begin
  AbreForm(TFrmCadPlacasAbastec,FrmCadPlacasAbastec);
  
end;

procedure TFrmPrincipalECF.ActVendaNFCeExecute(Sender: TObject);
var NomeOperador, aMensagem : String;
    DataCaixa : TDateTime;
begin
  sPAFNFCe := 1;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
  begin
    ShowMessage(aMensagem);
    DmWorkCom.PAFECF.sControleECFAtivo := 2;
    Exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
     MessageDlg('Sistema habilitado apenas para consultas!', mtWarning, [mbOK], 0);
     Exit;
  end;
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
       //
       if sPAFNFCe = 0 then
       begin
         if not DmWorkCom.PAFECF.VerificaJornadaFiscal then
         begin
           MessageDlg('É necessário abrir a jornada fiscal!!!', mtWarning, [mbOK], 0);
           Exit;
         end;
       end;
       AbreForm(TFrmEmiCupom,FrmEmiCupom);
    end;
  end;

end;

procedure TFrmPrincipalECF.BtnContingenciaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmCadReg61,FrmCadReg61);
    if DmWorkCom.PAFECF.gPosto then
       FrmCadReg61.sContigencia := true
    else
       FrmCadReg61.sContigencia := false;
    FrmCadReg61.ShowModal;
  finally
    FreeAndNil(FrmCadReg61);
  end;  
  
end;

procedure TFrmPrincipalECF.AbreCaixaAutomaticoZPendente;
var NomeOperador : String;
    DataCaixa : TDateTime;
    formMensagem: TFormMensagem;
begin
   // Abre o caixa com o usuário anterior
  if not DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    DmWorkCom.Dados_Caixa(SVData);
    DmWorkCom.Dados_Config(sIDEmpresa);
    DmWorkCom.CdsCaixa.Append;
    DmWorkCom.CdsCaixa.FieldByName('CAIXA').AsString         := DmWorkCom.PAFECF.gCaixa;
    DmWorkCom.CdsCaixa.FieldByName('NUMSERIEFAB').AsString   := DmWorkCom.PAFECF.gSerial;
    DmWorkCom.CdsCaixa.FieldByName('IDOPERADOR').AsInteger   := DmWorkCom.PAFECF.gIDOperador;
    DmWorkCom.CdsCaixa.FieldByName('VALOR_ABERTURA').AsFloat := 0.01;
    DmWorkCom.CdsCaixa.FieldByName('IDFUNC').AsInteger       := DmWorkCom.CdsConfigVENDEDOR_PADRAO.AsInteger;
    Grava_Dados(DmWorkCom.CdsCaixa);
    // grava registro de movimento
    if DmWorkCom.Dados_Caixa(SVData,true) then
    begin
      DmWorkCom.Dados_CaixaMov(0);
      DmWorkCom.CdsCaixaMov.Append;
      DmWorkCom.CdsCaixaMov.FieldByName('HISTORICO').AsString := 'ABERTURA AUTOMATICA';
      DmWorkCom.CdsCaixaMov.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
      DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString        := 'C';
      DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := 0.01;
      Grava_Dados(DmWorkCom.CdsCaixaMov);
    end;
    DmWorkCom.PAFECF.AtualizaINI(false);
  end;

end;

procedure TFrmPrincipalECF.FechaCaixaAutomaticoZPendente;
var NomeOperador : String;
    DataCaixa : TDateTime;
    aValorTotal,aValDinheiro,aValCartao,aValCheque,aValOutros : Double;
begin
  // Abre Jornada Fiscal
  if DmWorkCom.VerificaCaixaAberto(NomeOperador,DataCaixa) then
  begin
    // localiza o caixa
    if DmWorkCom.Dados_Caixa(DataCaixa,true) then
    begin
      aValDinheiro := 0; // criar rotinas para capturar os valores gerados
      aValCartao   := 0;
      aValCheque   := 0;
      aValOutros   := 0;
      aValorTotal  := 0;
      // grava registro de movimento
      DmWorkCom.Dados_CaixaMov(0);
      DmWorkCom.CdsCaixaMov.Append;
      DmWorkCom.CdsCaixaMov.FieldByName('HISTORICO').AsString := 'FECHAMENTO AUTOMATICO';
      DmWorkCom.CdsCaixaMov.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
      DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString        := 'D';
      DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := aValorTotal;
      Grava_Dados(DmWorkCom.CdsCaixaMov);
      // grava caixa como fechado
      DmWorkCom.GravaFechamentoCaixaDiario(DataCaixa,aValDinheiro,aValCartao,aValCheque,aValOutros);
    end;
  end;  

end;

procedure TFrmPrincipalECF.FecharCaixa1Click(Sender: TObject);
begin
  ActFechaCaixaExecute(Sender);

end;

procedure TFrmPrincipalECF.FecharJornada1Click(Sender: TObject);
begin
  ActFecharJornadaExecute(Sender);

end;

end.
