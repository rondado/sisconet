unit uFrmMenuFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB, ufrmPadrao,
  SqlExpr, Mask, ACBrDevice, ACBrSpedFiscal, ACBrTEFD, ACBrSintegra, ACBrPAF,
  ACBrRFD, ACBrBase, ACBrECF, IniFiles, ACBrEFDBlocos, ACBrUtil, ACBrTXTClass,
  Menus, jpeg, ACBrPAFClass, DBClient;

type
  TFrmMenuFiscal = class(TForm)
    DataEmpresa: TDataSource;
    DataProdutos: TDataSource;
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    GrpFaixa: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EdInicio: TMaskEdit;
    EdFim: TMaskEdit;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    ChData: TCheckBox;
    ChCOO: TCheckBox;
    BtnLeituraX: TBitBtn;
    BtnLMF: TBitBtn;
    BtnArqMF: TBitBtn;
    BtnArquivo: TBitBtn;
    BtnMovimento: TBitBtn;
    BtnIdentifica: TBitBtn;
    BtnParamentros: TBitBtn;
    BtnTabIndTec: TBitBtn;
    BtnTransfMesa: TBitBtn;
    RdLMF: TRadioGroup;
    RdEstoque: TRadioGroup;
    BtnEncerrantes: TBitBtn;
    BtnAbastecPend: TBitBtn;
    BtnArq1704: TBitBtn;
    BtnEncerrar: TBitBtn;
    CdsInventario: TClientDataSet;
    CdsInventariocd_produto: TIntegerField;
    CdsInventariounidade: TStringField;
    CdsInventarioquantidade: TFloatField;
    CdsInventariovalor: TFloatField;
    CdsInventariototal: TFloatField;
    CdsUFST: TClientDataSet;
    CdsUFSTUF: TStringField;
    CdsUFSTCREDITO: TFloatField;
    CdsUFSTDEBITO: TFloatField;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    BtnEspelho: TBitBtn;
    BtnFiscoRedZ: TBitBtn;
    BtnFiscoEst: TBitBtn;
    BtnVendasIdent: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    CbxMes: TComboBox;
    CbxAno: TComboBox;
    EdtCNPJCPF: TEdit;
    procedure BtnLeituraXClick(Sender: TObject);
    procedure BtnLMFClick(Sender: TObject);
    procedure BtnEspelhoClick(Sender: TObject);
    procedure BtnMovimentoClick(Sender: TObject);
    procedure BtnIdentificaClick(Sender: TObject);
    procedure BtnArquivoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChDataClick(Sender: TObject);
    function GeraNomeArquivo(pExtensao:Boolean):String;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnVendasClick(Sender: TObject);
    procedure ChCOOClick(Sender: TObject);
    procedure BtnEncerrantesClick(Sender: TObject);
    procedure BtnTransfMesaClick(Sender: TObject);
    procedure BtnTabIndTecClick(Sender: TObject);
    procedure BtnParamentrosClick(Sender: TObject);
    procedure BtnAbastecPendClick(Sender: TObject);
    procedure BtnArqMFClick(Sender: TObject);
    procedure BtnEncerrarClick(Sender: TObject);
    procedure BtnArq1704Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnFiscoRedZClick(Sender: TObject);
    procedure BtnFiscoEstClick(Sender: TObject);
    procedure BtnVendasIdentClick(Sender: TObject);
  private
    sArquivo : TextFile;
    NomeArquivo : String;
    procedure VendasPeriodo(pDatai,pdataf:TDatetime;pTipo:String);
    procedure PreencheInformacaoMesAno;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuFiscal: TFrmMenuFiscal;

implementation

uses uDmWorkCom,uLibrary, uFuncoesPAFECF, uFrmSelListaEstoque, MD5,
  uDmAcBr, uMensagem, uDmSPED, uDmAuxiliar, uDmProdutos;

{$R *.dfm}

procedure TFrmMenuFiscal.BtnLeituraXClick(Sender: TObject);
begin
  if (DmAcBr.ACBrECF1.Estado <> estLivre) and
     (DmAcBr.ACBrECF1.Estado <> estBloqueada) then
  begin
    MessageDlg('Existe um cupom aberto na ECF. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'LeituraX.txt';
  if FileExists(NomeArquivo) then
     DeleteFile(NomeArquivo);
  DmWorkCom.PAFECF.LeituraX;
  if (DmWorkCom.PAFECF.gPosto) and
     (DmWorkCom.PAFECF.sControleECFAtivo = 0) then
  begin
    DmWorkCom.EmiteControleEncerranteReducaoZ;
  end
  else
  begin
    if DmAcBr.ACBrECF1.Estado <> estBloqueada then
       MessageDlg('Existe dados incoerentes na configuração do sistema!',mtWarning,[mbOK],0);
//       MessageDlg('O GT, CRO, CRZ ou Venda bruta não confere!',mtWarning,[mbOK],0);
  end;
end;

procedure TFrmMenuFiscal.BtnLMFClick(Sender: TObject);
begin
  if (DmAcBr.ACBrECF1.Estado <> estLivre) and
     (DmAcBr.ACBrECF1.Estado <> estBloqueada) then
  begin
    MessageDlg('Existe um cupom aberto na ECF. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  
  if RdLMF.ItemIndex = 0 then
  begin
    if ChData.Checked then
       NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'LMFC_DATA.TXT'
    else
       NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'LMFC_CRZ.TXT';
    if FileExists(NomeArquivo) then
       DeleteFile(NomeArquivo);
    //
    DmWorkCom.PAFECF.MemoriaFiscal(EdInicio.Text,
                                   EdFim.Text,
                                   Datai.Date,
                                   Dataf.Date,
                                   false,
                                   ChData.Checked,
                                   false,
                                   NomeArquivo);
  end
  else if RdLMF.ItemIndex = 1 then
  begin
    if ChData.Checked then
       NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'LMFS_DATA.TXT'
    else
       NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'LMFS_CRZ.TXT';
    if FileExists(NomeArquivo) then
       DeleteFile(NomeArquivo);
    //

    DmWorkCom.PAFECF.MemoriaFiscal(EdInicio.Text,
                                   EdFim.Text,
                                   Datai.Date,
                                   Dataf.Date,
                                   false,
                                   ChData.Checked,
                                   true,
                                   NomeArquivo);
  end;

end;

procedure TFrmMenuFiscal.BtnEspelhoClick(Sender: TObject);
var formMensagem: TFormMensagem;
begin
  try
    formMensagem := TFormMensagem.Create('Aguarde... Criando arquivo de espelho MFD!',550,100,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    //
    if ChData.Checked then
       NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'ESPELHO_MFD_DATA.TXT'
    else
       NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'ESPELHO_MFD_COO.TXT';
    if FileExists(NomeArquivo) then
       DeleteFile(NomeArquivo);
    DmWorkCom.PAFECF.EspelhoMFD(NomeArquivo,
                                EdInicio.Text,
                                EdFim.Text,
                                Datai.Date,
                                Dataf.Date,
                                ChData.Checked);
    LocalizaRemoveAssinaturaEAD(NomeArquivo);
    DmAcBr.ACBrEAD1.AssinarArquivoComEAD(NomeArquivo);
  finally
    FormMensagem.destruir;
    MessageDlg('Arquivo '+NomeArquivo+#13+#10+
               'gerado com sucesso!!!', mtWarning, [mbOK], 0);
  end;

end;

procedure TFrmMenuFiscal.BtnMovimentoClick(Sender: TObject);
var aArquivo, aux : String;
    formMensagem: TFormMensagem;
begin
  if not(ChData.Checked) then
  begin
    MessageDlg('Apenas por intervado de data!', mtWarning, [mbOK], 0);
    Abort;
  end;
  try
    // verifica tipo de estoque
    DmAuxiliar.CdsListaEstoque.EmptyDataSet;
    if RdEstoque.ItemIndex = 1 then // estoque parcial
    begin
      // abre formulario para selecionar item
      Application.CreateForm(TFrmSelListaEstoque,FrmSelListaEstoque);
      try
        FrmSelListaEstoque.ShowModal;
      finally
        FreeAndNil(FrmSelListaEstoque);
      end;
    end;
    //
    formMensagem := TFormMensagem.Create('Aguarde... Criando arquivo de registros do PAF-ECF!',550,100,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    //
//    DmWorkCom.Dados_Empresa(sIDEmpresa);
//    DmWorkCom.RetornaDadosImpressora(DmWorkCom.PAFECF.gCaixa);
    aux := DmAcBr.ACBrECF1.NumSerie;
    if Length(aux) > 14 then
       aux := copy(aux,length(aux)-13,14);
    aux :=  ZeroEsquerda(DmWorkCom.PAFECF.gCodNacional,6)+aux+FormatDateTime('DDMMYYYY',Datai.Date)+'.TXT';
//    aux :=  ZeroEsquerda(DmWorkCom.PAFECF.gCodNacional,6)+aux+FormatDateTime('DDMMYYYY',SVData)+'.TXT';
    //    aArquivo := ExtractFilePath(NomeArquivo)+aux;
    aArquivo := DmWorkCom.PAFECF.gPathArqMenu+aux;
    if FileExists(aArquivo) then
       DeleteFile(aArquivo);
    //
    if DmWorkCom.RegistrosECF(aArquivo,Datai.Date,Dataf.Date) then
    begin
      DmAcBr.ACBrEAD1.AssinarArquivoComEAD(aArquivo);
      MessageDlg('Arquivo gerado em: '+aArquivo, mtInformation, [mbOK], 0);
    end;
  finally
    FormMensagem.destruir;
  end;

end;

procedure TFrmMenuFiscal.BtnIdentificaClick(Sender: TObject);
var IdentPaf: TACBrECFIdentificacaoPAF;
    I: Integer;
    cArquivo: TextFile;
    cLinhaArquivo : String;
    aDataHora : TDateTime;
begin
  if DmAcBr.ACBrECF1.Estado <> estLivre then
  begin
    MessageDlg('Existe um cupom aberto na ECF. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  // Se está usando o AAC, basta informar o Objeto IdentPAF //
  // Se NAO está usando o AAC, o Objeto IdentPAF deve ser instânciado e populado //
  if Assigned(DmAcBr.ACBrECF1.AAC ) then
    DmAcBr.ACBrECF1.PafMF_RelIdentificacaoPafECF(DmAcBr.ACBrECF1.AAC.IdentPAF, 0)
  else
  begin
    IdentPaf := TACBrECFIdentificacaoPAF.Create;
    try
      IdentPaf.NumeroLaudo := DmWorkCom.CdsDadosTecnicosNR_LAUDO_TECNICO.AsString; // retirar do laudo
      IdentPaf.VersaoER    := DmWorkCom.CdsDadosTecnicosVERSAO_ERPAFECF.AsString; // retirar do laudo
      IdentPaf.DataLaudo   := DmWorkCom.CdsDadosTecnicosDATA_LAUDO.AsDateTime; // retirar do laudo
      // preencher dados da empresa conforme o que foi informado no laudo de análise
      IdentPaf.Empresa.RazaoSocial := DmWorkCom.CdsDadosTecnicosEMPRESA.AsString;
      IdentPaf.Empresa.CNPJ        := DmWorkCom.CdsDadosTecnicosCNPJ.AsString;
      IdentPaf.Empresa.Endereco    := DmWorkCom.CdsDadosTecnicosENDERECO.AsString;
      IdentPaf.Empresa.Cidade      := DmWorkCom.CdsDadosTecnicosCIDADE.AsString;
      IdentPaf.Empresa.Uf          := DmWorkCom.CdsDadosTecnicosUF.AsString;
      IdentPaf.Empresa.Cep         := DmWorkCom.CdsDadosTecnicosCEP.AsString;
      IdentPaf.Empresa.Telefone    := DmWorkCom.CdsDadosTecnicosTELEFONE.AsString;
      IdentPaf.Empresa.Contato     := DmWorkCom.CdsDadosTecnicosCONTATO.AsString;
      IdentPaf.Empresa.Email       := DmWorkCom.CdsDadosTecnicosEMAIL.AsString;
      //
//      IdentPaf.Paf.Nome              := DmWorkCom.CdsDadosTecnicosDENOMINACAO.AsString;// preencher conforme o laudo
//      IdentPaf.Paf.Versao            := DmWorkCom.CdsDadosTecnicosVERSAO.AsString; // versão atual do aplicativo
//      IdentPaf.Paf.PrincipalExe.Nome := DmWorkCom.CdsDadosTecnicosPAFECF.AsString;
//      IdentPaf.Paf.PrincipalExe.MD5  := DmWorkCom.CdsDadosTecnicosMD5.AsString; // md5 atual do aplicativo
      //
      if FilesExists(ExtractFilePath(Application.ExeName)+'ArqMD5.txt') then
      begin
        IdentPaf.ArquivoListaAutenticados.Nome := 'ArqMD5.txt';
        IdentPaf.ArquivoListaAutenticados.MD5  := DmWorkCom.PAFECF.gMD5;
        // abre o arquivo para capturar outros aplicativos do sistema
        i:=0;
        AssignFile(cArquivo,ExtractFilePath(Application.ExeName)+'ArqMD5.txt');
        Reset(cArquivo);
        while not System.EOF(cArquivo) do
        begin
          ReadLn(cArquivo,cLinhaArquivo);
          if copy(cLinhaArquivo,1,2) = 'N3' then
          begin
            // verifica se é o principal EXE
//            if Trim(DmWorkCom.CdsDadosTecnicos.FieldByName('PAFECF').AsString) = Trim(copy(cLinhaArquivo,3,50)) then
            if Trim(UpperCase(DmWorkCom.CdsDadosTecnicos.FieldByName('PAFECF').AsString)) = Trim(copy(UpperCase(cLinhaArquivo),3,50)) then
            begin
              IdentPaf.Paf.Nome              := DmWorkCom.CdsDadosTecnicos.FieldByName('DENOMINACAO').AsString;// preencher conforme o laudo
              IdentPaf.Paf.Versao            := DmWorkCom.CdsDadosTecnicos.FieldByName('VERSAO').AsString; // versão atual do aplicativo
              IdentPaf.Paf.PrincipalExe.Nome := DmWorkCom.CdsDadosTecnicos.FieldByName('PAFECF').AsString;
              IdentPaf.Paf.PrincipalExe.MD5  := copy(cLinhaArquivo,53,32) // md5 atual do aplicativo
            end
            else
            begin
              // adicionar os arquivos adicionados ao arquivo da lista de autenticados
              with IdentPaf.OutrosArquivos.New do
              begin
                Nome := Format(Trim(copy(cLinhaArquivo,3,50)), [i]);
                MD5  := copy(cLinhaArquivo,53,32);
              end;
            end;  
          end;
        end;
      end;
      // ecfs autorizados para funcionamento na máquina
      IdentPaf.ECFsAutorizados.clear;
      with IdentPaf.ECFsAutorizados.New do
      begin
        NumeroSerie := DmAcBr.ACBrECF1.NumSerie;
      end;
      // verifica se tem o indice
      aDataHora := DmAcBr.ACBrECF1.DataHora;
      if DmWorkCom.PAFECF.gIndiceIdentifica > 0 then
         DmAcBr.ACBrECF1.PafMF_RelIdentificacaoPafECF(IdentPaf, DmWorkCom.PAFECF.gIndiceIdentifica)
      else   
         DmAcBr.ACBrECF1.PafMF_RelIdentificacaoPafECF(IdentPaf, 0);
      xDataECF :=  StrToDateTime(FormatDateTime('dd/mm/yyyy',DmAcBr.ACBrECF1.DataHora));
      xHoraECF := StrToDateTime(FormatDateTime('hh:mm:ss',DmAcBr.ACBrECF1.DataHora));
      DmWorkCom.PAFECF.GravaDadosDocECF('RG',1);
    finally
      IdentPaf.Free;
    end;
  end;

end;


procedure TFrmMenuFiscal.BtnArquivoClick(Sender: TObject);
var formMensagem: TFormMensagem;
    AuxNomeArq : String;
begin
  try
    formMensagem := TFormMensagem.Create('Aguarde... Criando arquivo MFD!',550,100,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    //
    NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+DmAcBr.ACBrECF1.NumSerie+'_'+FormatDateTime('DDMMYYYY',now)+'_'+FormatDateTime('HHMMSS',now)+'.MFD';
    AuxNomeArq := DmWorkCom.PAFECF.gPathArqMenu+DmAcBr.ACBrECF1.NumSerie+'_'+FormatDateTime('DDMMYYYY',now)+'_'+FormatDateTime('HHMMSS',now)+'.TXT';
    if FileExists(NomeArquivo) then
       DeleteFile(NomeArquivo);
    DmWorkCom.PAFECF.ArquivoMFD(NomeArquivo);
    if FileExists(NomeArquivo) then
    begin
      MessageDlg('Arquivo MFD '+NomeArquivo+' e '+#13+#10+
                 'Arquivo TXT ' +AuxNomeArq+#13+#10+
                 'gerado com sucesso!!!', mtWarning, [mbOK], 0);
    end
    else MessageDlg('Erro ao gerar o arquivo. Verifique a DLL.',mtWarning,[mbOK],0);
  finally
    FormMensagem.destruir;
  end;
end;

procedure TFrmMenuFiscal.FormShow(Sender: TObject);
begin
  DataEmpresa.DataSet     := DmWorkCom.CdsEmpresa;
  DataProdutos.DataSet    := DmProdutos.CdsProdutos2;
  //
  DmWorkCom.Dados_Empresa(sIDEmpresa);
  DmWorkCom.RetornaDadosImpressora(DmWorkCom.PAFECF.gCaixa);
  DmSPED.LeIni;
  // exibe botoes conforme configurado
  BtnTransfMesa.Visible    := false;
  BtnEncerrantes.Visible   := false;
  BtnAbastecPend.Visible   := false;
  if DmWorkCom.PAFECF.gPosto then
  begin
    BtnEncerrantes.Visible := true;
    BtnAbastecPend.Visible := true;
  end;
  if DmWorkCom.PAFECF.gRestaurante then
  begin
    BtnTransfMesa.Visible   := true;
  end;
  DmSPED.LeIni;
  DmSPED.oSpedEFD.sProgressBar1 := ProgressBar1;
  DmSPED.oSpedEFD.sProgressBar2 := ProgressBar2;
  StatusBar1.Panels.Items[0].Text := 'Pasta de gravação de arquivos: '+DmWorkCom.PAFECF.gPathArqMenu;
  NomeArquivo := GeraNomeArquivo(true);
  PreencheInformacaoMesAno;
  Datai.Date := SVData;
  Dataf.Date := SVData;
  ChDataClick(sender);
  // prepara botoes
  BtnLeituraX.Enabled := true;
  BtnLMF.Enabled := true;
  BtnArqMF.Enabled := true;
  BtnArquivo.Enabled := true;
  BtnArq1704.Enabled := true;
  BtnIdentifica.Enabled := true;
//  BtnVendas.Enabled := true;
  BtnTabIndTec.Enabled := true;
  BtnParamentros.Enabled := true;
  BtnMovimento.Enabled := true;
  BtnTransfMesa.Enabled := true;
  BtnEncerrantes.Enabled := true;
  BtnAbastecPend.Enabled := true;
  if DmWorkCom.PAFECF.sControleECFAtivo = 1 then
  begin
    BtnLeituraX.Enabled := false;
    BtnLMF.Enabled := false;
//    BtnArqMF.Enabled := false;
//    BtnArquivo.Enabled := false;
//    BtnArq1704.Enabled := false;
    BtnIdentifica.Enabled := false;
//    BtnVendas.Enabled := false;
//    BtnTabIndTec.Enabled := false;
    BtnParamentros.Enabled := false;
//    BtnMovimento.Enabled := false;
    BtnTransfMesa.Enabled := false;
    BtnEncerrantes.Enabled := false;
    BtnAbastecPend.Enabled := false;
  end;
  if DmWorkCom.PAFECF.sControleECFAtivo = 2 then
  begin
//    BtnLeituraX.Enabled := false;
//    BtnLMF.Enabled := false;
//    BtnArqMF.Enabled := false;
//    BtnArquivo.Enabled := false;
//    BtnArq1704.Enabled := false;
    BtnIdentifica.Enabled := false;
//    BtnVendas.Enabled := false;
//    BtnTabIndTec.Enabled := false;
    BtnParamentros.Enabled := false;
//    BtnMovimento.Enabled := false;
    BtnTransfMesa.Enabled := false;
    BtnEncerrantes.Enabled := false;
    BtnAbastecPend.Enabled := false;
  end;
  if DmWorkCom.PAFECF.sControleECFAtivo = 3 then
  begin
//    BtnLeituraX.Enabled := false;
//    BtnLMF.Enabled := false;
//    BtnArqMF.Enabled := false;
//    BtnArquivo.Enabled := false;
//    BtnArq1704.Enabled := false;
    BtnIdentifica.Enabled := false;
//    BtnVendas.Enabled := false;
//    BtnTabIndTec.Enabled := false;
    BtnParamentros.Enabled := false;
//    BtnMovimento.Enabled := false;
    BtnTransfMesa.Enabled := false;
    BtnEncerrantes.Enabled := false;
    BtnAbastecPend.Enabled := false;
  end;

//  FrmMenuFiscal.WindowState := wsMaximized;

end;

procedure TFrmMenuFiscal.ChDataClick(Sender: TObject);
begin
  inherited;
  GrpFaixa.Caption := ' Faixa de Dados - CRZ ';
  ChCOO.Enabled := true;
  ChCOO.Checked := false;
  EdInicio.Text := '';
  EdFim.Text    := '';
  EdInicio.MaxLength := 4;
  EdFim.MaxLength    := 4;
  EdInicio.Visible := true;
  EdFim.Visible    := true;
  Datai.Visible     := false;
  Dataf.Visible     := false;
  if ChData.Checked then
  begin
    GrpFaixa.Caption := ' Faixa de Dados - Data ';
    ChCOO.Enabled := false;
    EdInicio.Visible := false;
    EdFim.Visible    := false;
    Datai.Visible     := true;
    Dataf.Visible     := true;
  end;

end;

function TFrmMenuFiscal.GeraNomeArquivo(pExtensao:Boolean): String;
var aux : string;
begin
  aux := FormatDateTime('DDMMYYYY',SVData)+FormatDateTime('HHMMSS',SVHora);
  if pExtensao then
     Result := DmWorkCom.PAFECF.gPathArqMenu+'MFD'+aux+'.TXT'
  else
     Result := DmWorkCom.PAFECF.gPathArqMenu+'MFD'+aux;

end;

procedure TFrmMenuFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataProdutos.DataSet.Close;
  FreeAndNil(CdsInventario);
  FreeAndNil(CdsUFST);

end;

procedure TFrmMenuFiscal.BtnVendasClick(Sender: TObject);
var aTipoRel : String;
begin
  inherited;
  if not(ChData.Checked) then
  begin
    MessageDlg('Apenas por intervado de data!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if ChData.Checked then
  begin
    aTipoRel := '';
    if InputQuery('Selecione o Tipo de Relatorio','S - Sintegra / E - SPED EFD',aTipoRel) then
    begin
      if (Trim(UpperCase(aTipoRel)) <> 'S') and (Trim(UpperCase(aTipoRel)) <> 'E') then
      begin
        MessageDlg('O tipo de relatório selecionado é inválido!',mtWarning,[mbOK],0);
        Exit;
      end;
      VendasPeriodo(Datai.Date,Dataf.Date,aTipoRel);
    end;
  end
  else
  begin
    MessageDlg('Deve seleionar um período!!!', mtError, [mbOK], 0);
    Abort;
  end;

end;

procedure TFrmMenuFiscal.VendasPeriodo(pDatai, pdataf: TDatetime;pTipo:String);
var aData, aHora : String;
begin
  try
    // pTipo = S - Sintegra
    //         E - SPED EFD
    DmWorkCom.Dados_Empresa(sIDEmpresa);
    DmWorkCom.Dados_Contador(DmWorkCom.CdsEmpresa.FieldByName('IDCONTADOR').AsInteger);
    DmWorkCom.Dados_DadosTecnicos;
    // gera arquivo de sintegra
    aData := FormatDateTime('DDMMYYYY',Datai.DateTime);
    aHora := FormatDateTime('HHMMSS',Now);
    if UpperCase(pTipo) = 'S' then
    begin
      NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+
                     DmWorkCom.CdsDadosTecnicosNR_LAUDO_TECNICO.AsString+
                     aData+aHora+'.TXT';
      if FileExists(NomeArquivo) then
         DeleteFile(NomeArquivo);
      // verifica se existe arquivo
      DmAcBr.ACBrSintegra1.FileName:=NomeArquivo;
      DmAcBr.ACBrSintegra1.VersaoValidador:=TVersaoValidador(1);

      DmWorkCom.GerarRegistro10(pDatai,pdataf,'3','3','1');
      DmWorkCom.GerarRegistro11;
      DmWorkCom.GerarRegistro50(pDatai,pdataf);
      DmWorkCom.GerarRegistro54(pDatai,pdataf);
      DmWorkCom.GerarRegistro60M(pDatai,pdataf,True,True,True);
      DmWorkCom.GerarRegistro61(pDatai,pdataf);
//      DmWorkCom.GerarRegistro61R(pDatai,pdataf);
      DmAcBr.ACBrSintegra1.GeraArquivo;
      // assina arquio
      DmAcBr.ACBrEAD1.AssinarArquivoComEAD(NomeArquivo);
    end;
    if UpperCase(pTipo) = 'E' then
    begin
      NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+
                     DmWorkCom.CdsDadosTecnicosNR_LAUDO_TECNICO.AsString+
                     aData+aHora+'.TXT';
      if FileExists(NomeArquivo) then
         DeleteFile(NomeArquivo);
      // verifica se existe arquivo
      if FileExists(NomeArquivo) then
         DeleteFile(NomeArquivo);
      // gera os blocos solicitados
      DmSPED.oSpedEFD.sNotasEntrada := True;
      DmWorkCom.sControleReg := '0000';
      DmWorkCom.sLRegistro   := -1;
      DmSPED.oSpedEFD.DadosBloco_0(CdsInventario,
                                   CdsUFST,
                                   DmWorkCom.CdsEmpresa,
                                   DmWorkCom.CdsContador,
                                   Datai.Date,
                                   Dataf.Date,
                                   IntToStr(sIDEmpresa),
                                   false,
                                   true,
                                   DmSPED.sCOD_VER,
                                   DmSPED.sPERFIL,
                                   DmSPED.sINDICADOR,
                                   DmSPED.sCOD_FIN,
                                   false,
                                   now);
      DmSPED.oSpedEFD.DadosBloco_C(cdsUFST,
                                   '10',
                                   '1000',
                                   IntToStr(sIDEmpresa),
                                   Datai.Date,
                                   Dataf.Date,
                                   false,
                                   false,
                                   DmSPED.sPERFIL);
      DmSPED.oSpedEFD.DadosBloco_D;
      DmSPED.oSpedEFD.DadosBloco_E(cdsUFST,
                                   Datai.Date,
                                   Dataf.Date,
                                   DmSPED.sCodRec,
                                   IntToStr(sIDEmpresa),
                                   true,
                                   DmSPED.sINDICADOR);
      DmSPED.oSpedEFD.DadosBloco_G(Datai.Date,
                                   Dataf.Date,
                                   IntToStr(sIDEmpresa));
      DmSPED.oSpedEFD.DadosBloco_H(CdsInventario,
                                   true,
                                   Dataf.Date,
                                   now);
      DmSPED.oSpedEFD.DadosBloco_1(Datai.Date,
                                   now);
      // informa dados
      DmAcBr.ACBrSPEDFiscal1.LinhasBuffer := StrToIntDef( '1000', 0 );
      DmAcBr.ACBrSpedFiscal1.DT_INI := Datai.Date;
      DmAcBr.ACBrSpedFiscal1.DT_FIN := Dataf.Date;
      // Informa o pata onde será salvo o arquivo TXT.
      DmAcBr.ACBrSpedFiscal1.Path    := DmWorkCom.PAFECF.gPathArqMenu;
      DmAcBr.ACBrSpedFiscal1.Arquivo := ExtractFileName(NomeArquivo);
      // Método que gera o arquivo TXT.
      DmAcBr.ACBrSpedFiscal1.SaveFileTXT;
      // totaliza regisyros
      DmSPED.oSpedEFD.DadosBloco_9;
      // assina arquio
      DmAcBr.ACBrEAD1.AssinarArquivoComEAD(NomeArquivo);
   end;
  finally
    MessageDlg('Arquios gerados em: '+NomeArquivo, mtInformation, [mbOK], 0);
  end;
end;

procedure TFrmMenuFiscal.ChCOOClick(Sender: TObject);
begin
  inherited;
  EdInicio.Text      := '';
  EdFim.Text         := '';
  EdInicio.MaxLength := 4;
  EdFim.MaxLength    := 4;
  GrpFaixa.Caption := ' Faixa de Dados - CRZ ';
  if ChCOO.Checked then
  begin
    GrpFaixa.Caption := ' Faixa de Dados - COO ';
    EdInicio.MaxLength := 6;
    EdFim.MaxLength    := 6;
  end;

end;

procedure TFrmMenuFiscal.BtnEncerrantesClick(Sender: TObject);
//var aArquivo, aux : String;
begin
  inherited;
  if DmAcBr.ACBrECF1.Estado <> estLivre then
  begin
    MessageDlg('Existe um cupom aberto na ECF. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  if not(ChData.Checked) then
  begin
    MessageDlg('Apenas por intervado de data!', mtWarning, [mbOK], 0);
    Abort;
  end;
  DmWorkCom.EmiteControleEncerranteReducaoZ;

end;

procedure TFrmMenuFiscal.BtnTransfMesaClick(Sender: TObject);
begin
  inherited;
  if DmAcBr.ACBrECF1.Estado <> estLivre then
  begin
    MessageDlg('Existe um cupom aberto na ECF. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  DmWorkCom.PAFECF.MesasTransferidas;

end;

procedure TFrmMenuFiscal.BtnTabIndTecClick(Sender: TObject);
var aNomeArq,aMensagem:String;
begin
  inherited;
  aNomeArq := DmWorkCom.PAFECF.gPathArqMenu+'TAB.IND.TEC.PRODUCAO.TXT';
  if FileExists(aNomeArq) then
     DeleteFile(aNomeArq);
  if DmWorkCom.GeraRelatorioEstoqueComposto(aNomeArq) then
  begin
    DmAcBr.ACBrEAD1.AssinarArquivoComEAD(aNomeArq);
    MessageDlg('Arquivo "'+aNomeArq+'",'#13+#10+
               'gerado com sucesso!!!', mtWarning, [mbOK], 0);
  end;

end;

procedure TFrmMenuFiscal.BtnParamentrosClick(Sender: TObject);
begin
  inherited;
  if DmAcBr.ACBrECF1.Estado <> estLivre then
  begin
    MessageDlg('Existe um cupom aberto na ECF. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  DmWorkCom.Imprime_ParametrosPAFECF;

end;

procedure TFrmMenuFiscal.BtnAbastecPendClick(Sender: TObject);
begin
  inherited;
  if DmAcBr.ACBrECF1.Estado <> estLivre then
  begin
    MessageDlg('Existe um cupom aberto na ECF. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  if not DmWorkCom.AbastecimentosPendentes then
  begin
    MessageDlg('Erro ao emitir relatorio de abastecimentos pendentes!!!', mtError, [mbOK], 0);
  end;
  
end;

procedure TFrmMenuFiscal.BtnArqMFClick(Sender: TObject);
var formMensagem: TFormMensagem;
    AuxNomeArq : String;
begin
  try
    formMensagem := TFormMensagem.Create('Aguarde... Criando arquivo MF!',550,100,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    //
    NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+DmAcBr.ACBrECF1.NumSerie+'_'+FormatDateTime('DDMMYYYY',now)+'_'+FormatDateTime('HHMMSS',now)+'.MF' ;
    AuxNomeArq := DmWorkCom.PAFECF.gPathArqMenu+DmAcBr.ACBrECF1.NumSerie+'_'+FormatDateTime('DDMMYYYY',now)+'_'+FormatDateTime('HHMMSS',now)+'.TXT';
    if FileExists(NomeArquivo) then
       DeleteFile(NomeArquivo);
    DmWorkCom.PAFECF.ArquivoMF(NomeArquivo);
    if FileExists(NomeArquivo) then
    begin
      MessageDlg('Arquivo MF '+NomeArquivo+' e '+#13+#10+
                 'Arquivo TXT ' +AuxNomeArq+#13+#10+
                 'gerado com sucesso!!!', mtWarning, [mbOK], 0);
    end
    else MessageDlg('Erro ao gerar o arquivo. Verifique a DLL.',mtWarning,[mbOK],0);
  finally
    FormMensagem.destruir;
  end;

end;

procedure TFrmMenuFiscal.BtnEncerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMenuFiscal.BtnArq1704Click(Sender: TObject);
var formMensagem: TFormMensagem;
begin
  try
    formMensagem := TFormMensagem.Create('Aguarde... Criando arquivo AC 17/04!',550,100,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    //
    NomeArquivo := DmWorkCom.PAFECF.gPathArqMenu+'MFD'+DmAcBr.ACBrECF1.NumSerie+'_'+FormatDateTime('DDMMYYYY',now)+'_'+FormatDateTime('HHMMSS',now)+'.TXT';
    if FileExists(NomeArquivo) then
       DeleteFile(NomeArquivo);
    DmWorkCom.PAFECF.ArqAC1704(NomeArquivo,EdInicio.Text,EdFim.Text,Datai.Date,Dataf.Date,ChData.Checked);
    LocalizaRemoveAssinaturaEAD(NomeArquivo);
    DmAcBr.ACBrEAD1.AssinarArquivoComEAD(NomeArquivo);
  finally
    FormMensagem.destruir;
    MessageDlg('Arquivo '+NomeArquivo+#13+#10+
               'gerado com sucesso!!!', mtWarning, [mbOK], 0);
  end;

end;

procedure TFrmMenuFiscal.FormCreate(Sender: TObject);
begin
  if not CdsInventario.Active then
     CdsInventario.CreateDataSet;
  CdsInventario.EmptyDataSet;
  //
  if not CdsUFST.Active then
     CdsUFST.CreateDataSet;
  CdsUFST.EmptyDataSet;

end;


procedure TFrmMenuFiscal.BtnFiscoRedZClick(Sender: TObject);
var aTotalArqivos : Integer;
begin
  try
    // verifica a quantidade de arquivos pendentes de envio
    aTotalArqivos := DmWorkCom.PAFECF.RetornaQuantArqXML(0);
    if aTotalArqivos > 0 then
        MessageDlg('Arquivo pendentes de envio: '+IntToStr(aTotalArqivos), mtInformation, [mbOK], 0);
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TFrmMenuFiscal.BtnFiscoEstClick(Sender: TObject);
var aTotalArqivos : Integer;
begin
  try
    // verifica a quantidade de arquivos pendentes de envio
    aTotalArqivos := DmWorkCom.PAFECF.RetornaQuantArqXML(1);
    if aTotalArqivos > 0 then
        MessageDlg('Arquivo pendentes de envio: '+IntToStr(aTotalArqivos), mtInformation, [mbOK], 0);
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TFrmMenuFiscal.BtnVendasIdentClick(Sender: TObject);
var aArquivo : String;
begin
  //
  aArquivo := DmWorkCom.PAFECF.gPathArqMenu+'Vendas_Identifidacadas.txt';
  if FileExists(aArquivo) then
     DeleteFile(aArquivo);
  //
  if DmWorkCom.VendasIdentificadas(aArquivo,EdtCNPJCPF.Text,CbxMes.ItemIndex+1,StrToInt(CbxAno.Text)) then
  begin
    DmAcBr.ACBrEAD1.AssinarArquivoComEAD(aArquivo);
    MessageDlg('Arquivo gerado em: '+aArquivo, mtInformation, [mbOK], 0);
  end;

end;

procedure TFrmMenuFiscal.PreencheInformacaoMesAno;
var Dia, Mes, Ano, I : Word;
begin
  DecodeDate(Now,Ano,Mes,Dia);
  CbxAno.Items.Clear;
  for I := 2000 to 2200 do
      CbxAno.Items.Add(IntToStr(I)) ;
  CbxAno.ItemIndex := CbxAno.Items.IndexOf(IntToStr(Ano));
  CbxMes.ItemIndex := Mes-1;

end;


end.
