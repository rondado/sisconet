unit uFrmGravaArqVerificacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, IniFiles, ExtCtrls, uFuncoesPAFECF, ActnList,
  ComCtrls, ACBrDevice, ACBrECF, TypInfo, ACBrECFClass, StrUtils, jpeg,
  ACBrCNIEE, DB, DBCtrls, Mask, System.Actions;

type
  TFrmGravaArqVerificacao = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ActionList1: TActionList;
    ActLeDadosECF: TAction;
    ActGravarArqIni: TAction;
    PageControl1: TPageControl;
    OpenDialog1: TOpenDialog;
    ActGerarChaves: TAction;
    GroupBox1: TGroupBox;
    GroupBox9: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    cbxModelo: TComboBox;
    cbxPorta: TComboBox;
    ComboBaudECF: TComboBox;
    cmbDataBitsECF: TComboBox;
    cmbParityECF: TComboBox;
    cmbStopBitsECF: TComboBox;
    cmbHandShakingECF: TComboBox;
    chHardFlow: TCheckBox;
    chSoftFlow: TCheckBox;
    GroupBox10: TGroupBox;
    Label2: TLabel;
    Label30: TLabel;
    Label1: TLabel;
    EdtTotalizador: TEdit;
    EdtCaixa: TEdit;
    EdtSerial: TEdit;
    GroupBox15: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    EdtDinheiro: TEdit;
    EdtCartao: TEdit;
    EdtCheque: TEdit;
    EdtNP: TEdit;
    EdtCarne: TEdit;
    EdtBoleto: TEdit;
    EdtOutros: TEdit;
    Panel3: TPanel;
    memoFormas: TMemo;
    GroupBox5: TGroupBox;
    Label31: TLabel;
    SpeedButton2: TSpeedButton;
    RadioTipoTEF: TRadioGroup;
    ChTEF: TCheckBox;
    ChVias: TCheckBox;
    ChEstadoECF: TCheckBox;
    EdtTEFDial: TEdit;
    GroupBox4: TGroupBox;
    Label28: TLabel;
    Label27: TLabel;
    Label26: TLabel;
    Label25: TLabel;
    Label29: TLabel;
    Label36: TLabel;
    Label35: TLabel;
    cmbBaudRate: TComboBox;
    cmbPortaSerial: TComboBox;
    cmbBalanca: TComboBox;
    cmbParity: TComboBox;
    cmbStopBits: TComboBox;
    cmbHandShaking: TComboBox;
    cmbDataBits: TComboBox;
    ChBalanca: TCheckBox;
    GroupBox7: TGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    EdParametros: TEdit;
    EdIdentificacao: TEdit;
    EdGerencial: TEdit;
    Label22: TLabel;
    EdtConvenio: TEdit;
    GroupBox2: TGroupBox;
    Label32: TLabel;
    SpeedButton7: TSpeedButton;
    Label33: TLabel;
    SpeedButton8: TSpeedButton;
    EdtVLEnvio: TEdit;
    EdtVLResposta: TEdit;
    EdtPendente: TEdit;
    Label34: TLabel;
    Label39: TLabel;
    EdtIndNFCe: TEdit;
    EdtEncerrante: TEdit;
    Label40: TLabel;
    Label41: TLabel;
    EdtMesaAberta: TEdit;
    Label42: TLabel;
    EdtConfMesa: TEdit;
    Label43: TLabel;
    EdtTransMesa: TEdit;
    Label44: TLabel;
    EdtAfericao: TEdit;
    GroupBox3: TGroupBox;
    ChGerFechaCaixa: TCheckBox;
    ChLXFechaCaixa: TCheckBox;
    Label14: TLabel;
    EdValSangria: TMaskEdit;
    Label13: TLabel;
    CbxAbastCupom: TComboBox;
    Label12: TLabel;
    EdtCodNacional: TEdit;
    SpeedButton1: TSpeedButton;
    ComboDecimais: TComboBox;
    Label15: TLabel;
    Label16: TLabel;
    EdtCER: TEdit;
    Label45: TLabel;
    EdtEstFisico: TEdit;
    EdtPerdaCom: TEdit;
    Label46: TLabel;
    Label47: TLabel;
    EdtRetCom: TEdit;
    EdtSemCom: TEdit;
    Label48: TLabel;
    Label49: TLabel;
    EdtPerdaEst: TEdit;
    Label50: TLabel;
    EdtDescontinua: TEdit;
    ChArqTXTDav: TCheckBox;
    ChTXTAutomatico: TCheckBox;
    Label3: TLabel;
    EdtDigito: TEdit;
    Label51: TLabel;
    CbxDigitos: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioModeloClick(Sender: TObject);
    procedure ActGravarArqIniExecute(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure cbxModeloChange(Sender: TObject);
    procedure cbxPortaChange(Sender: TObject);
    procedure ActLeDadosECFExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdValSangriaExit(Sender: TObject);
    procedure cbxModeloKeyPress(Sender: TObject; var Key: Char);
    procedure ChBalancaClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure RadioTipoTEFClick(Sender: TObject);
    procedure CbxDigitosClick(Sender: TObject);
  private
    procedure GravaDadosGlobal;
    procedure ExibeDadosINI;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGravaArqVerificacao: TFrmGravaArqVerificacao;

implementation

Uses uLibrary, uDmAcBr, uDmWorkCom;

{$R *.dfm}

procedure TFrmGravaArqVerificacao.FormShow(Sender: TObject);
var i : TACBrECFModelo;
begin
  cbxModelo.Items.Clear ;
  for i := Low(TACBrECFModelo) to High(TACBrECFModelo) do
     cbxModelo.Items.Add( GetEnumName(TypeInfo(TACBrECFModelo), integer(i)));
  cbxModelo.Items[0] := 'Procurar' ;
  cbxModelo.ItemIndex := 0 ;

  cbxPorta.Items.Clear;

  DmAcBr.ACBrECF1.Device.AcharPortasSeriais(cbxPorta.Items);

  cbxPorta.Items.Insert(0,'Procurar');
  cbxPorta.Items.Add('LPT1');
  cbxPorta.Items.Add('LPT2');
  cbxPorta.Items.Add('LPT3');
  cbxPorta.Items.Add('/dev/ttyS0') ;
  cbxPorta.Items.Add('/dev/ttyS1') ;
  cbxPorta.Items.Add('/dev/ttyUSB0') ;
  cbxPorta.Items.Add('/dev/ttyUSB1') ;
  cbxPorta.Items.Add('c:\temp\ecf.txt') ;
  cbxPorta.Items.Add('/tmp/ecf.txt') ;

  PageControl1.TabIndex := 0;
  DmWorkCom.PAFECF.LeArquivoINI;
  cbxModelo.ItemIndex := DmWorkCom.PAFECF.GModeloECF;
  ExibeDadosINI;
  ChBalancaClick(Sender);

end;

procedure TFrmGravaArqVerificacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmWorkCom.PAFECF.FechaPortaSerial;
end;

procedure TFrmGravaArqVerificacao.RadioModeloClick(Sender: TObject);
begin
  DmWorkCom.PAFECF.FechaPortaSerial;
  DmWorkCom.PAFECF.GModeloECF := cbxModelo.ItemIndex;
  DmWorkCom.PAFECF.AbrePortaSerial;

end;

procedure TFrmGravaArqVerificacao.ActGravarArqIniExecute(Sender: TObject);
var Teste : Boolean;
begin
  try
    GravaDadosGlobal;
    DmWorkCom.PAFECF.GravaArqINI(EdtSerial.Text,EdtTotalizador.Text,DmWorkCom.PAFECF.gMD5,cbxModelo.ItemIndex);
    DmWorkCom.GravaConfigECFBanco;
  finally
    ShowMessage('Arquivo gravado com sucesso!');
    Close;
  end

end;

procedure TFrmGravaArqVerificacao.ExibeDadosINI;
begin
  EdtSerial.Text         := DmWorkCom.PAFECF.gSerial;
  EdtTotalizador.Text    := DmWorkCom.PAFECF.gGT;
  EdtCaixa.Text          := DmWorkCom.PAFECF.gCaixa;
  cbxPorta.Text          := DmWorkCom.PAFECF.gPortaECF;
  // configuração do ECF
  ComboBaudECF.ItemIndex      := ComboBaudECF.Items.IndexOf(IntToStr(DmWorkCom.PAFECF.gBaudRateECF));
  cmbDataBitsECF.ItemIndex    := cmbDataBitsECF.Items.IndexOf(IntToStr(DmWorkCom.PAFECF.gDataBitsECF));
  cmbParityECF.ItemIndex      := DmWorkCom.PAFECF.gParityECF;
  cmbStopBitsECF.ItemIndex    := DmWorkCom.PAFECF.gStopBitsECF;
  cmbHandShakingECF.ItemIndex := DmWorkCom.PAFECF.gHandShakingECF;
  chHardFlow.Checked       := DmWorkCom.PAFECF.gHardFlowECF;
  chSoftFlow.Checked       := DmWorkCom.PAFECF.gSoftFlowECF;
  // dados da balanca
  cmbBalanca.ItemIndex     := DmWorkCom.PAFECF.gModeloBal;
  cmbHandShaking.ItemIndex := DmWorkCom.PAFECF.gHandShake;
  cmbParity.ItemIndex      := DmWorkCom.PAFECF.gParity;
  cmbStopBits.ItemIndex    := DmWorkCom.PAFECF.gStopBits;
  cmbDataBits.Text         := IntToStr(DmWorkCom.PAFECF.gDataBits);
  cmbBaudRate.Text         := IntToStr(DmWorkCom.PAFECF.gBaudRate);
  cmbPortaSerial.Text      := DmWorkCom.PAFECF.gPortaBal;
  EdtDigito.Text           := DmWorkCom.PAFECF.gDigito;
  ChBalanca.Checked        := DmWorkCom.PAFECF.gBalAtiva;
  CbxDigitos.ItemIndex     := CbxDigitos.Items.IndexOf(IntToStr(DmWorkCom.PAFECF.gNumDigito));
  //
  EdtDinheiro.Text        := DmWorkCom.PAFECF.gDINHEIRO;
  EdtCartao.Text          := DmWorkCom.PAFECF.gCARTAO;
  EdtCheque.Text          := DmWorkCom.PAFECF.gCHEQUE;
  EdtNP.Text              := DmWorkCom.PAFECF.gNP;
  EdtCarne.Text           := DmWorkCom.PAFECF.gCARNE;
  EdtBoleto.Text          := DmWorkCom.PAFECF.gBOLETO;
  EdtOutros.Text          := DmWorkCom.PAFECF.gOUTROS;
  EdtConvenio.Text        := DmWorkCom.PAFECF.gCONVENIO;
  // TEF
  ChTEF.Checked           := DmWorkCom.PAFECF.gTEF;
  EdtTEFDial.Text         := DmWorkCom.PAFECF.gPathTEF;
  EdtCER.Text             := IntToStr(DmWorkCom.PAFECF.sContaCER);
  ChVias.Checked          := DmWorkCom.PAFECF.sTEFViaUnica;
  RadioTipoTEF.ItemIndex  := DmWorkCom.PAFECF.sTipoTef;
  ChEstadoECF.Checked     := DmWorkCom.PAFECF.gVerEstadoECF;
  // geral
  ComboDecimais.Text      := IntToStr(DmWorkCom.PAFECF.gDecimais);
  EdtCodNacional.Text     := DmWorkCom.PAFECF.gCodNacional;
  EdValSangria.Text       := FormatFloat('0.00',DmWorkCom.PAFECF.gValorSangria);
  EdGerencial.Text        := IntToStr(DmWorkCom.PAFECF.gIndiceGerencial);
  EdIdentificacao.Text    := IntToStr(DmWorkCom.PAFECF.gIndiceIdentifica);
  EdParametros.Text       := IntToStr(DmWorkCom.PAFECF.gIndiceParametro);
  EdtEncerrante.Text      := IntToStr(DmWorkCom.PAFECF.gIndiceEncerrante);
  EdtPendente.Text        := IntToStr(DmWorkCom.PAFECF.gIndiceAbastec);
  EdtIndNFCe.Text         := IntToStr(DmWorkCom.PAFECF.gIndiceNFCe);
  EdtMesaAberta.Text      := IntToStr(DmWorkCom.PAFECF.gIndiceMesaAbr);
  EdtConfMesa.Text        := IntToStr(DmWorkCom.PAFECF.gIndiceConfMesa);
  EdtTransMesa.Text       := IntToStr(DmWorkCom.PAFECF.gIndiceTransfMesa);
  EdtAfericao.Text        := IntToStr(DmWorkCom.PAFECF.gIndiceAfericao);
  EdtEstFisico.Text       := IntToStr(DmWorkCom.PAFECF.gIndiceEstFisico);
  EdtPerdaCom.Text        := IntToStr(DmWorkCom.PAFECF.gIndicePerdaCom);
  EdtRetCom.Text          := IntToStr(DmWorkCom.PAFECF.gIndiceRetCom);
  EdtSemCom.Text          := IntToStr(DmWorkCom.PAFECF.gIndiceSemCom);
  EdtPerdaEst.Text        := IntToStr(DmWorkCom.PAFECF.gIndicePerdaEst);
  EdtDescontinua.Text     := IntToStr(DmWorkCom.PAFECF.gIndiceDescontinua);
  ChGerFechaCaixa.Checked := DmWorkCom.PAFECF.gGerFechaCaixa;
  ChLXFechaCaixa.Checked  := DmWorkCom.PAFECF.gLXFechaCaixa;
  CbxAbastCupom.ItemIndex := DmWorkCom.PAFECF.gAbastCupom-1;
  EdtVLEnvio.Text         := DmWorkCom.PAFECF.gVLEnvio;
  EdtVLResposta.Text      := DmWorkCom.PAFECF.gVLResposta;
  ChArqTXTDav.Checked     := DmWorkCom.PAFECF.gArqTXTDav;
  ChTXTAutomatico.Checked := DmWorkCom.PAFECF.gTXTAutomatico;

end;

procedure TFrmGravaArqVerificacao.GravaDadosGlobal;
begin
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+'Menu Fiscal\') then
     CreateDir(ExtractFilePath(Application.ExeName)+'Menu Fiscal\');
  //
  DmWorkCom.PAFECF.gSerial         := EdtSerial.Text;
  DmWorkCom.PAFECF.gGT             := EdtTotalizador.Text;
  DmWorkCom.PAFECF.gPortaECF       := cbxPorta.Text;
  // configuração do ECF
  DmWorkCom.PAFECF.gBaudRateECF    := StrToInt(ComboBaudECF.Text);
  DmWorkCom.PAFECF.gDataBitsECF    := StrToInt(cmbDataBitsECF.Text);
  DmWorkCom.PAFECF.gParityECF      := cmbParityECF.ItemIndex;
  DmWorkCom.PAFECF.gStopBitsECF    := cmbStopBitsECF.ItemIndex;
  DmWorkCom.PAFECF.gHandShakingECF := cmbHandShakingECF.ItemIndex;
  DmWorkCom.PAFECF.gHardFlowECF    := chHardFlow.Checked;
  DmWorkCom.PAFECF.gSoftFlowECF    := chSoftFlow.Checked;
  //
  DmWorkCom.PAFECF.gCaixa           := EdtCaixa.Text;
  DmWorkCom.PAFECF.gPathArqMenu     := ExtractFilePath(Application.ExeName)+'Menu Fiscal\';
  // dados da balanca
  DmWorkCom.PAFECF.gModeloBal       := cmbBalanca.ItemIndex;
  DmWorkCom.PAFECF.gHandShake       := cmbHandShaking.ItemIndex;
  DmWorkCom.PAFECF.gParity          := cmbParity.ItemIndex;
  DmWorkCom.PAFECF.gStopBits        := cmbStopBits.ItemIndex;
  DmWorkCom.PAFECF.gDataBits        := StrToInt(cmbDataBits.Text);
  DmWorkCom.PAFECF.gBaudRate        := StrToInt(cmbBaudRate.Text);
  DmWorkCom.PAFECF.gPortaBal        := cmbPortaSerial.Text;
  DmWorkCom.PAFECF.gDigito          := EdtDigito.Text;
  DmWorkCom.PAFECF.gBalAtiva        := ChBalanca.Checked;
  DmWorkCom.PAFECF.gNumDigito       := StrToInt(CbxDigitos.Text);
  //
  DmWorkCom.PAFECF.gDINHEIRO        := EdtDinheiro.Text;
  DmWorkCom.PAFECF.gCARTAO          := EdtCartao.Text;
  DmWorkCom.PAFECF.gCHEQUE          := EdtCheque.Text;
  DmWorkCom.PAFECF.gNP              := EdtNP.Text;
  DmWorkCom.PAFECF.gCARNE           := EdtCarne.Text;
  DmWorkCom.PAFECF.gBOLETO          := EdtBoleto.Text;
  DmWorkCom.PAFECF.gOUTROS          := EdtOutros.Text;
  DmWorkCom.PAFECF.gCONVENIO        := EdtConvenio.Text;
  // tef
  DmWorkCom.PAFECF.gTEF             := ChTEF.Checked;
  DmWorkCom.PAFECF.gPathTEF         := EdtTEFDial.Text;
  if not ChTEF.Checked then
  begin
    DmWorkCom.PAFECF.gCartoes       := 0;
  end
  else
  begin
    if DmWorkCom.PAFECF.gCartoes = 0 then
       DmWorkCom.PAFECF.gCartoes    := 1;
  end;
  DmWorkCom.PAFECF.sContaCER        := StrToInt(EdtCER.Text);
  DmWorkCom.PAFECF.sTEFViaUnica     := ChVias.Checked;
  DmWorkCom.PAFECF.sTipoTef         := RadioTipoTEF.ItemIndex;
  DmWorkCom.PAFECF.gVerEstadoECF    := ChEstadoECF.Checked;
  // geral
  DmWorkCom.PAFECF.gDAVPV           := true;
//  DmWorkCom.PAFECF.gPosto           := false;
//  DmWorkCom.PAFECF.gRestaurante     := true;
  DmWorkCom.PAFECF.gDecimais         := StrToInt(ComboDecimais.Text);
  DmWorkCom.PAFECF.gCodNacional      := EdtCodNacional.Text;
  DmWorkCom.PAFECF.gValorSangria     := StrToFloat(EdValSangria.Text);
  DmWorkCom.PAFECF.gIndiceGerencial  := StrToInt(EdGerencial.Text);
  DmWorkCom.PAFECF.gIndiceIdentifica := StrToInt(EdIdentificacao.Text);
  DmWorkCom.PAFECF.gIndiceEncerrante := StrToInt(EdtEncerrante.Text);
  DmWorkCom.PAFECF.gIndiceAbastec    := StrToInt(EdtPendente.Text);
  DmWorkCom.PAFECF.gIndiceNFCe       := StrToInt(EdtIndNFCe.Text);
  DmWorkCom.PAFECF.gIndiceParametro  := StrToInt(EdParametros.Text);
  DmWorkCom.PAFECF.gIndiceMesaAbr    := StrToInt(EdtMesaAberta.Text);
  DmWorkCom.PAFECF.gIndiceConfMesa   := StrToInt(EdtConfMesa.Text);
  DmWorkCom.PAFECF.gIndiceTransfMesa := StrToInt(EdtTransMesa.Text);
  DmWorkCom.PAFECF.gIndiceAfericao   := StrToInt(EdtAfericao.Text);
  DmWorkCom.PAFECF.gIndiceEstFisico  := StrToInt(EdtEstFisico.Text);
  DmWorkCom.PAFECF.gIndicePerdaCom   := StrToInt(EdtPerdaCom.Text);
  DmWorkCom.PAFECF.gIndiceRetCom     := StrToInt(EdtRetCom.Text);
  DmWorkCom.PAFECF.gIndiceSemCom     := StrToInt(EdtSemCom.Text);
  DmWorkCom.PAFECF.gIndicePerdaEst   := StrToInt(EdtPerdaEst.Text);
  DmWorkCom.PAFECF.gIndiceDescontinua:= StrToInt(EdtDescontinua.Text);
  DmWorkCom.PAFECF.gGerFechaCaixa    := ChGerFechaCaixa.Checked;
  DmWorkCom.PAFECF.gLXFechaCaixa     := ChLXFechaCaixa.Checked;
  DmWorkCom.PAFECF.gAbastCupom       := CbxAbastCupom.ItemIndex+1;
  DmWorkCom.PAFECF.gVLEnvio          := EdtVLEnvio.Text;
  DmWorkCom.PAFECF.gVLResposta       := EdtVLResposta.Text;
  DmWorkCom.PAFECF.gArqTXTDav        := ChArqTXTDav.Checked;
  DmWorkCom.PAFECF.gTXTAutomatico    := ChTXTAutomatico.Checked;


end;


procedure TFrmGravaArqVerificacao.SpeedButton2Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdtTEFDial.Text := ExtractFilePath(OpenDialog1.FileName);
  
end;

procedure TFrmGravaArqVerificacao.cbxModeloChange(Sender: TObject);
begin
  DmWorkCom.PAFECF.GModeloECF := cbxModelo.ItemIndex;

end;

procedure TFrmGravaArqVerificacao.cbxPortaChange(Sender: TObject);
begin
  DmWorkCom.PAFECF.gPortaECF := cbxPorta.Text;

end;

procedure TFrmGravaArqVerificacao.ActLeDadosECFExecute(Sender: TObject);
var fsFormas : TACBrECFFormasPagamento;
    i : Integer;
begin
  if not DmAcBr.ACBrECF1.Ativo then
  begin
     DmAcBr.ACBrECF1.Device.Baud      := StrToInt(ComboBaudECF.Text);
     DmAcBr.ACBrECF1.Device.Data      := StrToInt(cmbDataBits.Text);
     DmAcBr.ACBrECF1.Device.Parity    := TACBrSerialParity(cmbParity.ItemIndex);
     DmAcBr.ACBrECF1.Device.Stop      := TACBrSerialStop(cmbStopBits.ItemIndex);
     DmAcBr.ACBrECF1.Device.HardFlow  := chHardFlow.Checked;
     DmAcBr.ACBrECF1.Device.SoftFlow  := chSoftFlow.Checked;
     DmAcBr.ACBrECF1.Device.HandShake := TACBrHandShake(cmbHandShaking.ItemIndex);
     DmWorkCom.PAFECF.AbrePortaSerial;
  end;
  EdtSerial.Text      := DmAcBr.ACBrECF1.NumSerie;
  EdtTotalizador.Text := FormatFloat('0.00',DmAcBr.ACBrECF1.GrandeTotal);
  // formas de pagamento
  DmACBr.ACBrECF1.CarregaFormasPagamento;
  fsFormas := DmACBr.ACBrECF1.FormasPagamento;
  //
  for i := 0 to fsFormas.Count -1 do
  begin
     memoformas.Lines.Add('Cod='+fsFormas[i].Indice+' - Nome='+fsFormas[i].Descricao+' - Vinculado='+
     ifThen(fsFormas[i].PermiteVinculado,'Sim','Não'));

  end;


end;

procedure TFrmGravaArqVerificacao.SpeedButton1Click(Sender: TObject);
var ECF: TACBrCNIEERegistro;
    Marca, Modelo, Firmware, Arquivo: String;
begin
  if not DmAcBr.ACBrECF1.Ativo then
  begin
    MessageDlg('É necessário ativar a ECF antes de prosseguir!', mtWarning, [mbOK], 0);
    Exit;
  end;
  //
  Arquivo := ExtractFilePath(Application.ExeName)+'Tabela_CNIEE.bin';
  DmAcBr.ACBrCNIEE1.Arquivo := Arquivo;
  if not FileExists(Arquivo) then
  begin
    if not DmAcBr.ACBrCNIEE1.DownloadTabela then
    begin
      MessageDlg('Erro ao efetuar download do arquivo de codigos!',mtWarning,[mbOK],0);
      Abort;
    end;
  end;
  //
  Marca    := Trim(DmAcBr.ACBrECF1.ModeloStr);
  Modelo   := Trim(DmAcBr.ACBrECF1.SubModeloECF);
  Firmware := Trim(DmAcBr.ACBrECF1.NumVersao);

  ECF := DmAcBr.ACBrCNIEE1.BuscarECF(Marca, Modelo, Firmware);
  if ECF <> nil then
  begin
    EdtCodNacional.Text := Format('%s%s%s', [ECF.CodMarca, ECF.CodModelo, ECF.CodVersao]);
  end;

end;

procedure TFrmGravaArqVerificacao.EdValSangriaExit(Sender: TObject);
var Aux : Double;
begin
  try
    Aux := StrToFloat(EdValSangria.Text);
    EdValSangria.Text := FormatFloat('0.00',Aux);
  except
    MessageDlg('Valor inválido. Verifique!!!', mtWarning, [mbOK], 0);
  end;
end;

procedure TFrmGravaArqVerificacao.cbxModeloKeyPress(Sender: TObject;
  var Key: Char);
begin
  TabEnter(Self,Key);
end;

procedure TFrmGravaArqVerificacao.ChBalancaClick(Sender: TObject);
begin
  EdtDigito.Enabled := false;
  if ChBalanca.Checked then
     EdtDigito.Enabled := true;

end;

procedure TFrmGravaArqVerificacao.SpeedButton7Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdtVLEnvio.Text := ExtractFilePath(OpenDialog1.FileName);

end;

procedure TFrmGravaArqVerificacao.SpeedButton8Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdtVLResposta.Text := ExtractFilePath(OpenDialog1.FileName);

end;

procedure TFrmGravaArqVerificacao.RadioTipoTEFClick(Sender: TObject);
begin
  ChVias.Checked := false;
  if RadioTipoTEF.ItemIndex = 0 then
     ChVias.Checked := true;
end;

procedure TFrmGravaArqVerificacao.CbxDigitosClick(Sender: TObject);
begin
  case CbxDigitos.ItemIndex of
    0: EdtDigito.MaxLength := 3;
    1: EdtDigito.MaxLength := 2;
    2: EdtDigito.MaxLength := 1;
  end;

end;

end.
