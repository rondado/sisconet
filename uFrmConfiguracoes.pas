unit uFrmConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoHorizontal, ExtCtrls, StdCtrls, blcksock,
  DBCtrls, Buttons, Mask, ComCtrls, ActnList, DB, uFrameConfirmaCancela,
  Spin, ACBrUtil, Printers, ACBrSAT, ACBrSATClass, ACBrSATExtratoESCPOS,
  ACBrSATExtratoFortesFr, ACBrBase, ACBrSATExtratoClass, OleCtrls, SHDocVw,
  ACBrPosPrinter, Menus, System.Actions, System.IniFiles, Vcl.FileCtrl,
  ACBrDFeOpenSSL;

type
  TFrmConfiguracoes = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabEmpresa: TTabSheet;
    TabGeral: TTabSheet;
    GroupBox2: TGroupBox;
    DataConfig: TDataSource;
    DataFormaPag: TDataSource;
    DataGrupo: TDataSource;
    DataPedidoClass: TDataSource;
    Datavendedor: TDataSource;
    DataUF: TDataSource;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    DBCheckBox14: TDBCheckBox;
    ActConfirmaConfig: TAction;
    ActCancelaConfig: TAction;
    DataDadosTecnicos: TDataSource;
    DataContador: TDataSource;
    TabDadosTecnicos: TTabSheet;
    GroupBox7: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    Panel4: TPanel;
    BitBtn2: TBitBtn;
    DBEdit4: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    PgcConfig: TPageControl;
    TbsConfigGeral: TTabSheet;
    TbsSPED: TTabSheet;
    GroupBox1: TGroupBox;
    RadioTipoEmpresa: TDBRadioGroup;
    RadioTipoDocPadrao: TDBRadioGroup;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    DBEdit1: TDBEdit;
    Combovendedor: TDBLookupComboBox;
    ComboClassificacao: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    ComboFormaPag: TDBLookupComboBox;
    ComboGrupo: TDBLookupComboBox;
    RadioTipoBusca: TDBRadioGroup;
    RadioExibir: TDBRadioGroup;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    ChConfLancCaixa: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    GroupBox4: TGroupBox;
    SpeedButton1: TSpeedButton;
    DbPathLogomarca: TDBEdit;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    RadioModelo: TDBRadioGroup;
    TbsNFe: TTabSheet;
    PagNFe: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    SpeedButton2: TSpeedButton;
    DBEdit26: TDBEdit;
    GroupBox11: TGroupBox;
    SpeedButton3: TSpeedButton;
    DBEdit27: TDBEdit;
    DBRadioGroup4: TDBRadioGroup;
    DBCheckBox17: TDBCheckBox;
    TabSheet2: TTabSheet;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    SpeedButton4: TSpeedButton;
    DBEdit28: TDBEdit;
    GroupBox15: TGroupBox;
    DBEdit30: TDBEdit;
    GroupBox16: TGroupBox;
    SpeedButton5: TSpeedButton;
    DBEdit29: TDBEdit;
    TabSheet4: TTabSheet;
    GroupBox17: TGroupBox;
    UF: TLabel;
    GroupBox18: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBLookupComboBox3: TDBLookupComboBox;
    DBRadioGroup5: TDBRadioGroup;
    TabSheet5: TTabSheet;
    GroupBox19: TGroupBox;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    DBEdit38: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DataCnae: TDataSource;
    GroupBox6: TGroupBox;
    DBEdit9: TDBEdit;
    TbsGerRel: TTabSheet;
    GroupBox8: TGroupBox;
    Label32: TLabel;
    DBEdit24: TDBEdit;
    Label49: TLabel;
    DBEdit25: TDBEdit;
    Label61: TLabel;
    DBEdit42: TDBEdit;
    Label62: TLabel;
    DBEdit43: TDBEdit;
    Label63: TLabel;
    DBEdit44: TDBEdit;
    Label64: TLabel;
    DBEdit45: TDBEdit;
    Label65: TLabel;
    DBEdit46: TDBEdit;
    Label66: TLabel;
    DBEdit47: TDBEdit;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    PgcEmpresa: TPageControl;
    TbsDadosEmpresa: TTabSheet;
    Panel1: TPanel;
    FrameBotaoHorizontal1: TFrameBotaoHorizontal;
    TbsResponsavel: TTabSheet;
    GroupBox21: TGroupBox;
    Label68: TLabel;
    DBEdit49: TDBEdit;
    Label70: TLabel;
    DBEdit51: TDBEdit;
    Label71: TLabel;
    DBEdit52: TDBEdit;
    Label72: TLabel;
    DBEdit53: TDBEdit;
    Label73: TLabel;
    DBEdit54: TDBEdit;
    Label74: TLabel;
    DBEdit55: TDBEdit;
    Label75: TLabel;
    DBEdit56: TDBEdit;
    Label76: TLabel;
    DBEdit57: TDBEdit;
    Label77: TLabel;
    DBEdit58: TDBEdit;
    Label78: TLabel;
    DBEdit59: TDBEdit;
    DBRadioGroup8: TDBRadioGroup;
    GroupBox22: TGroupBox;
    Label69: TLabel;
    GroupBox23: TGroupBox;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    DBEdit50: TDBEdit;
    DBEdit60: TDBEdit;
    DBEdit61: TDBEdit;
    DBEdit62: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBRadioGroup3: TDBRadioGroup;
    DBCheckBox18: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    GroupBox12: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    edBufLinhas: TEdit;
    edBufNotas: TEdit;
    edNotas: TEdit;
    GroupBox24: TGroupBox;
    SpeedButton9: TSpeedButton;
    EdtPath: TEdit;
    ChTruncado: TCheckBox;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    GroupBox25: TGroupBox;
    Label83: TLabel;
    Label84: TLabel;
    ComboVersao: TComboBox;
    EdtCodRec: TEdit;
    RadioPerfil: TRadioGroup;
    RadioFinalidade: TRadioGroup;
    RadioIndicador: TRadioGroup;
    TabSheet8: TTabSheet;
    GroupBox26: TGroupBox;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    ComboVersaoPC: TComboBox;
    ComboSituacao: TComboBox;
    RadioTipoEsc: TRadioGroup;
    RadioNatureza: TRadioGroup;
    ComboIndicador: TComboBox;
    ComboEscrituracao: TComboBox;
    TabSheet9: TTabSheet;
    GroupBox27: TGroupBox;
    RadioIncidencia: TRadioGroup;
    RadioAproCred: TRadioGroup;
    RadioContrApur: TRadioGroup;
    RadioEscrApur: TRadioGroup;
    TabSheet10: TTabSheet;
    ChSPEDEfd: TCheckBox;
    ChSPEDContribuicao: TCheckBox;
    BtnGravaSPED: TBitBtn;
    DBCheckBox20: TDBCheckBox;
    GroupBox28: TGroupBox;
    DBEdit40: TDBEdit;
    Label90: TLabel;
    DBLookupComboBox4: TDBLookupComboBox;
    DBCheckBox21: TDBCheckBox;
    DBLookupComboBox5: TDBLookupComboBox;
    Label91: TLabel;
    DBCheckBox22: TDBCheckBox;
    TbsSAT: TTabSheet;
    GroupBox29: TGroupBox;
    PgcSAT: TPageControl;
    tsDadosSAT: TTabSheet;
    Label92: TLabel;
    SbArqLog: TSpeedButton;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    tsRede: TTabSheet;
    gbIPFix: TGroupBox;
    lSSID2: TLabel;
    lSSID3: TLabel;
    lSSID4: TLabel;
    lSSID5: TLabel;
    lSSID6: TLabel;
    gbPPPoE: TGroupBox;
    lSSID7: TLabel;
    lSSID8: TLabel;
    gbWiFi: TGroupBox;
    lSSID: TLabel;
    lSSID1: TLabel;
    gbProxy: TGroupBox;
    lSSID9: TLabel;
    lSSID10: TLabel;
    lSSID11: TLabel;
    lSSID12: TLabel;
    Impressao: TTabSheet;
    GroupBox30: TGroupBox;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    bImpressora: TButton;
    DBEdit41: TDBEdit;
    Label102: TLabel;
    PrintDialog1: TPrintDialog;
    DBEdit63: TDBEdit;
    DBEdit64: TDBEdit;
    DBEdit65: TDBEdit;
    DBEdit66: TDBEdit;
    DBEdit67: TDBEdit;
    DBCheckBox24: TDBCheckBox;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox26: TDBCheckBox;
    DBCheckBox27: TDBCheckBox;
    DBCheckBox28: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    DBCheckBox30: TDBCheckBox;
    DBEdit68: TDBEdit;
    rgRedeTipoInter: TDBRadioGroup;
    rgRedeTipoLan: TDBRadioGroup;
    DBEdit69: TDBEdit;
    DBEdit70: TDBEdit;
    DBEdit71: TDBEdit;
    DBEdit72: TDBEdit;
    DBEdit73: TDBEdit;
    DBEdit74: TDBEdit;
    DBEdit75: TDBEdit;
    DBEdit76: TDBEdit;
    DBEdit77: TDBEdit;
    DBEdit78: TDBEdit;
    DBEdit79: TDBEdit;
    DBEdit80: TDBEdit;
    DBEdit81: TDBEdit;
    DBText2: TDBText;
    DBCheckBox31: TDBCheckBox;
    DBRadioGroup7: TDBRadioGroup;
    DBRadioGroup9: TDBRadioGroup;
    DBRadioGroup10: TDBRadioGroup;
    DBEdit82: TDBEdit;
    DBEdit83: TDBEdit;
    DBEdit84: TDBEdit;
    DBEdit85: TDBEdit;
    DBEdit86: TDBEdit;
    DBRadioGroup6: TDBRadioGroup;
    Button1: TButton;
    Button2: TButton;
    bInicializar: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    GroupBox31: TGroupBox;
    Label96: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    btSerial: TBitBtn;
    DBRadioGroup2: TDBRadioGroup;
    DBCheckBox32: TDBCheckBox;
    DBCheckBox33: TDBCheckBox;
    cbxPortaPOS: TDBComboBox;
    DBEdit87: TDBEdit;
    DBEdit88: TDBEdit;
    DBEdit89: TDBEdit;
    cbxModeloPosPrinter: TComboBox;
    cbxPagCodigo: TComboBox;
    GroupBox32: TGroupBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    TbsGeral2: TTabSheet;
    GroupBox5: TGroupBox;
    GrpIndice: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    DbTijolo: TDBEdit;
    DbIsopor: TDBEdit;
    DbOutros: TDBEdit;
    RadioTipoCalcPerc: TDBRadioGroup;
    GrpDiasComissao: TGroupBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    GroupBox20: TGroupBox;
    DbMargemPadrao: TDBEdit;
    GroupBox33: TGroupBox;
    ComboDias: TDBComboBox;
    RadioTipoComissao: TDBRadioGroup;
    Label105: TLabel;
    DBLookupComboBox6: TDBLookupComboBox;
    Label106: TLabel;
    DBLookupComboBox7: TDBLookupComboBox;
    GroupBox34: TGroupBox;
    DBEdit90: TDBEdit;
    GroupBox35: TGroupBox;
    Senha: TLabel;
    Frase: TLabel;
    DBEdit91: TDBEdit;
    DBEdit92: TDBEdit;
    TbsNFSe: TTabSheet;
    gbConfiguracoes: TGroupBox;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    Label107: TLabel;
    Label108: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    edtEmitCNPJ: TEdit;
    edtEmitIM: TEdit;
    edtEmitRazao: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitCEP: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitComp: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCidade: TEdit;
    edtEmitUF: TEdit;
    cbCidades: TComboBox;
    edtCodCidade: TEdit;
    TabSheet7: TTabSheet;
    gbCertificado: TGroupBox;
    Label125: TLabel;
    Label126: TLabel;
    sbtnCaminhoCert: TSpeedButton;
    Label127: TLabel;
    sbtnGetCert: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    edtNumSerie: TEdit;
    TabSheet11: TTabSheet;
    gbGeral: TGroupBox;
    Label128: TLabel;
    sbtnLogoMarca: TSpeedButton;
    sbtnPathSalvar: TSpeedButton;
    lblSchemas: TLabel;
    sbtSchemas: TSpeedButton;
    Label129: TLabel;
    sbtnPrestLogo: TSpeedButton;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    sbtArqINI: TSpeedButton;
    edtLogoMarca: TEdit;
    edtPathLogs: TEdit;
    ckSalvar: TCheckBox;
    edtSchemas: TEdit;
    edtPrestLogo: TEdit;
    edtPrefeitura: TEdit;
    edtArqINI: TEdit;
    TabSheet12: TTabSheet;
    Label133: TLabel;
    Label134: TLabel;
    gbWebService: TGroupBox;
    ckVisualizar: TCheckBox;
    rgTipoAmb: TRadioGroup;
    ckSalvarSoap: TCheckBox;
    GroupBox36: TGroupBox;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    edtSenhaWeb: TEdit;
    edtUserWeb: TEdit;
    TabSheet13: TTabSheet;
    gbEmail: TGroupBox;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label145: TLabel;
    edtSmtpHost: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPass: TEdit;
    edtEmailAssunto: TEdit;
    cbEmailSSL: TCheckBox;
    edtEmailRemetente: TEdit;
    cbEmailTLS: TCheckBox;
    btnSalvarConfig: TBitBtn;
    TbsBoleto: TTabSheet;
    GroupBox37: TGroupBox;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    DBEdit93: TDBEdit;
    DBEdit94: TDBEdit;
    DBEdit95: TDBEdit;
    DBEdit96: TDBEdit;
    DBEdit97: TDBEdit;
    DBEdit98: TDBEdit;
    DBEdit99: TDBEdit;
    DBEdit100: TDBEdit;
    DBEdit101: TDBEdit;
    DBEdit102: TDBEdit;
    DBEdit103: TDBEdit;
    DBEdit104: TDBEdit;
    DBEdit105: TDBEdit;
    DBComboBox1: TDBComboBox;
    GrpEmpresa: TGroupBox;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label45: TLabel;
    Label29: TLabel;
    Label28: TLabel;
    DBText1: TDBText;
    Label67: TLabel;
    Label89: TLabel;
    Label144: TLabel;
    Label146: TLabel;
    DbSite: TDBEdit;
    DbEmail: TDBEdit;
    DbContato: TDBEdit;
    DbTelefone: TDBEdit;
    DbTelefax: TDBEdit;
    DbInscricao: TDBEdit;
    DbDocumento: TDBEdit;
    ComboUF: TDBLookupComboBox;
    DbCep: TDBEdit;
    DbCidade: TDBEdit;
    DbBairro: TDBEdit;
    DbComplemento: TDBEdit;
    DbNumero: TDBEdit;
    DbEndereco: TDBEdit;
    DbRazao: TDBEdit;
    DbID: TDBEdit;
    DBEdit2: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBEdit3: TDBEdit;
    DBLookupComboBox2: TDBLookupComboBox;
    DBEdit6: TDBEdit;
    DbCodCidade: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit48: TDBEdit;
    DBEdit39: TDBEdit;
    DBCheckBox23: TDBCheckBox;
    DBRadioGroup11: TDBRadioGroup;
    DBRadioGroup12: TDBRadioGroup;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    DBCheckBox39: TDBCheckBox;
    Button6: TButton;
    DBText3: TDBText;
    Label1: TLabel;
    DBEdit106: TDBEdit;
    lSSLLib1: TLabel;
    cbSSLType: TComboBox;
    gbxRetornoEnvio: TGroupBox;
    Label2: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    lSSLLib: TLabel;
    cbSSLLib: TComboBox;
    lCryptLib: TLabel;
    cbCryptLib: TComboBox;
    lHttpLib: TLabel;
    cbHttpLib: TComboBox;
    lXmlSign: TLabel;
    cbXmlSignLib: TComboBox;
    DBCheckBox40: TDBCheckBox;
    DBEdit107: TDBEdit;
    DBEdit108: TDBEdit;
    DBEdit109: TDBEdit;
    lTimeOut: TLabel;
    DBCheckBox41: TDBCheckBox;
    DBEdit110: TDBEdit;
    DBCheckBox42: TDBCheckBox;
    DBCheckBox43: TDBCheckBox;
    DBCheckBox44: TDBCheckBox;
    GroupBox38: TGroupBox;
    SpeedButton10: TSpeedButton;
    DBEdit112: TDBEdit;
    GroupBox39: TGroupBox;
    DBEdit111: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioTipoEmpresaChange(Sender: TObject);
    procedure RadioTipoComissaoChange(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DataConfigDataChange(Sender: TObject; Field: TField);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure ActConfirmaConfigExecute(Sender: TObject);
    procedure ActCancelaConfigExecute(Sender: TObject);
    procedure TabNFeExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DbCodCidadeExit(Sender: TObject);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure BtnGravaSPEDClick(Sender: TObject);
    procedure ComboUFExit(Sender: TObject);
    procedure ComboUFClick(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure bImpressoraClick(Sender: TObject);
    procedure SbArqLogClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bInicializarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure cbCidadesChange(Sender: TObject);
    procedure sbtSchemasClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPrestLogoClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure sbtArqINIClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboVersaoDropDown(Sender: TObject);
    procedure ComboVersaoSelect(Sender: TObject);
    procedure ComboVersaoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
  private
    { Private declarations }
    procedure HabilitaFrameConfig;
    procedure Le_INI_SPED;
    procedure Grava_INI_SPED;
    procedure RepassaDadosNFSe;
    procedure GravarConfiguracao;
    procedure SelecionaPerfilUF;
    procedure LeDadosRedeSAT;
    procedure PreenchePortas;
    procedure AtualizaSSLLibsCombo;
  public
    { Public declarations }
    sControle : Integer;
  end;

var
  FrmConfiguracoes: TFrmConfiguracoes;

const
  SELDIRHELP = 1000;

implementation

Uses uLibrary,uDmWorkCom, uFrmClientes, uDmAcBr, uFrmMunicipio,
  uDMClientes, uDmSPED, ACBrDFe, ACBrDFeSSL, pcnRede, typinfo, pcnConversao,
  synacode, RLPrinters, uDmProdutos;

{$R *.dfm}

procedure TFrmConfiguracoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
  DataConfig.DataSet.Close;
  DataUF.DataSet.Close;
  DataFormaPag.DataSet.Close;
  DataPedidoClass.DataSet.Close;
  Datavendedor.DataSet.Close;
  DataGrupo.DataSet.Close;
  MessageDlg('O Aplicativo precisa ser reiniciado para atualizar as configurações!', mtWarning, [mbOK], 0);
//  Application.Terminate;

end;

procedure TFrmConfiguracoes.FormCreate(Sender: TObject);
var T : TSSLLib;
 U: TSSLCryptLib;
 V: TSSLHttpLib;
 X: TSSLXmlSignLib;
 Y: TSSLType;
begin
  inherited;
  cbSSLLib.Items.Clear ;
  For T := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add( GetEnumName(TypeInfo(TSSLLib), integer(T) ) ) ;
  cbSSLLib.ItemIndex := 0 ;

  cbCryptLib.Items.Clear ;
  For U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add( GetEnumName(TypeInfo(TSSLCryptLib), integer(U) ) ) ;
  cbCryptLib.ItemIndex := 0 ;

  cbHttpLib.Items.Clear ;
  For V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add( GetEnumName(TypeInfo(TSSLHttpLib), integer(V) ) ) ;
  cbHttpLib.ItemIndex := 0 ;

  cbXmlSignLib.Items.Clear ;
  For X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add( GetEnumName(TypeInfo(TSSLXmlSignLib), integer(X) ) ) ;
  cbXmlSignLib.ItemIndex := 0 ;

  cbSSLType.Items.Clear ;
  For Y := Low(TSSLType) to High(TSSLType) do
    cbSSLType.Items.Add( GetEnumName(TypeInfo(TSSLType), integer(Y) ) ) ;
  cbSSLType.ItemIndex := 0 ;

end;

procedure TFrmConfiguracoes.FormShow(Sender: TObject);
var N: TACBrPosPrinterModelo;
    O: TACBrPosPaginaCodigo;
begin
  DataWork.DataSet        := DmWorkCom.CdsEmpresa;
  inherited;
  DataWork.DataSet        := DmWorkCom.CdsEmpresa;
  DataConfig.DataSet      := DmWorkCom.CdsConfig;
  DataUF.DataSet          := DmClientes.CdsUF;
  Datavendedor.DataSet    := DmClientes.CdsFuncionarios;
  DataPedidoClass.DataSet := DmWorkCom.CdsPedidoClass;
  DataFormaPag.DataSet    := DmWorkCom.CdsFormaPag;
  DataGrupo.DataSet       := DmProdutos.CdsGrupo;
  DataContador.DataSet    := DmWorkCom.CdsContador;
  DataDadosTecnicos.DataSet := DmWorkCom.CdsDadosTecnicos;
  DataCnae.DataSet        := DmWorkCom.CdsCNAE;
  DmWorkCom.Dados_Empresa;
  DataUF.DataSet.Open;
  DmWorkCom.Dados_PedidoClassificacao(-1);
  DmClientes.Dados_Funcionario;
  DmWorkCom.Dados_FormaPagto;
  DmProdutos.Dados_Grupo;
  DmWorkCom.Dados_Contador;
  DmWorkCom.AtualizaConfigAcBr;
  Le_INI_SPED;
  DmWorkCom.LerConfiguracaoNFSe;
  RepassaDadosNFSe;
  PageControl1.TabIndex := 1;
  PgcConfig.TabIndex := 0;
  PagNFe.TabIndex := 0;
  PgcSAT.TabIndex := 0;
  PgcEmpresa.TabIndex := 0;
  GrpEmpresa.Enabled := false;
  if sControle = 0 then
  begin
    GrpEmpresa.Enabled := true;
    PageControl1.TabIndex := 0;
  end;
  TabDadosTecnicos.TabVisible := false;
  if not DmWorkCom.Dados_DadosTecnicos  then
  begin
    TabDadosTecnicos.TabVisible := true;
    DataDadosTecnicos.DataSet.Append;
    PageControl1.TabIndex := 2;
  end;

  cbxModeloPosPrinter.Items.Clear ;
  For N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
     cbxModeloPosPrinter.Items.Add( GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ) ) ;

  cbxPagCodigo.Items.Clear ;
  For O := Low(TACBrPosPaginaCodigo) to High(TACBrPosPaginaCodigo) do
     cbxPagCodigo.Items.Add( GetEnumName(TypeInfo(TACBrPosPaginaCodigo), integer(O) ) ) ;

  PreenchePortas;

  cbxModeloPosPrinter.ItemIndex := DataConfig.DataSet.FieldByName('SAT_POS_MODELO').AsInteger;
  cbxPagCodigo.ItemIndex := DataConfig.DataSet.FieldByName('SAT_POS_PAGCODIGO').AsInteger;

  AtualizaSSLLibsCombo;

end;

procedure TFrmConfiguracoes.SpeedButton10Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('NFE_SCHEMAS').AsString := ExtractFilePath(OpenDialog1.FileName);

end;

procedure TFrmConfiguracoes.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('PATHLOGOMARCA').AsString := OpenDialog1.FileName;

end;

procedure TFrmConfiguracoes.BitBtn1Click(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmClientes,FrmClientes);
  try
    FrmClientes.sCodCli := 0;
    FrmClientes.ShowModal;
    if FrmClientes.sCodCli > 0 then
    begin
      if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
         DataConfig.DataSet.Edit;
      DataConfig.DataSet.FieldByName('CLIENTE_PADRAO').AsInteger := FrmClientes.sCodCli;
    end;  
  finally
    FrmClientes.Destroy;
  end;

end;

procedure TFrmConfiguracoes.RadioTipoEmpresaChange(Sender: TObject);
begin
  inherited;
  GrpIndice.Visible := false;
  if RadioTipoEmpresa.ItemIndex = 2 then
     GrpIndice.Visible := true;

end;

procedure TFrmConfiguracoes.RadioTipoComissaoChange(Sender: TObject);
begin
  inherited;
  GrpDiasComissao.Visible := false;
  if RadioTipoComissao.ItemIndex = 0 then
     GrpDiasComissao.Visible := true;

end;

procedure TFrmConfiguracoes.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  if not DmWorkCom.Dados_Config(DataWork.DataSet.FieldByName('ID').AsInteger) then
  begin
    DataConfig.DataSet.Append;
    Grava_Dados(DataConfig.DataSet);
  end;

end;

procedure TFrmConfiguracoes.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  DataConfig.DataSet.Cancel;
  Grava_Dados(DataWork.DataSet);
  Grava_Dados(DataConfig.DataSet);

end;

procedure TFrmConfiguracoes.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmConfiguracoes.HabilitaFrameConfig;
begin
  ActConfirmaConfig.Enabled := false;
  ActCancelaConfig.Enabled  := false;
  if (DataConfig.DataSet.State in [dsInsert,dsEdit]) then
  begin
    ActConfirmaConfig.Enabled := true;
    ActCancelaConfig.Enabled  := true;
  end;
  
end;

procedure TFrmConfiguracoes.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoHorizontal1,DataWork.DataSet);

end;

procedure TFrmConfiguracoes.AtualizaSSLLibsCombo;
begin
  cbSSLLib.ItemIndex := DataConfig.DataSet.FieldByName('SSLLIB').AsInteger;
  cbCryptLib.ItemIndex := DataConfig.DataSet.FieldByName('CRYPTLIB').AsInteger;
  cbHttpLib.ItemIndex := DataConfig.DataSet.FieldByName('HTTPLIB').AsInteger;
  cbXmlSignLib.ItemIndex := DataConfig.DataSet.FieldByName('XMLSIGNLIB').AsInteger;
  cbSSLType.ItemIndex := DataConfig.DataSet.FieldByName('SSLTYPE').AsInteger;
end;

procedure TFrmConfiguracoes.DataConfigDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  HabilitaFrameConfig;

end;

procedure TFrmConfiguracoes.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmConfiguracoes.ActConfirmaConfigExecute(Sender: TObject);
begin
  inherited;
  DataConfig.DataSet.FieldByName('SSLLIB').AsInteger := cbSSLLib.ItemIndex;
  DataConfig.DataSet.FieldByName('CRYPTLIB').AsInteger := cbCryptLib.ItemIndex;
  DataConfig.DataSet.FieldByName('HTTPLIB').AsInteger := cbHttpLib.ItemIndex;
  DataConfig.DataSet.FieldByName('XMLSIGNLIB').AsInteger := cbXmlSignLib.ItemIndex;
  DataConfig.DataSet.FieldByName('SSLTYPE').AsInteger := cbSSLType.ItemIndex;
  DataConfig.DataSet.FieldByName('SAT_POS_MODELO').AsInteger := cbxModeloPosPrinter.ItemIndex;
  DataConfig.DataSet.FieldByName('SAT_POS_PAGCODIGO').AsInteger := cbxPagCodigo.ItemIndex;
  Grava_Dados(DataConfig.DataSet);
  Grava_INI_SPED;

end;

procedure TFrmConfiguracoes.ActCancelaConfigExecute(Sender: TObject);
begin
  inherited;
  DataConfig.DataSet.Cancel;
  Grava_Dados(DataConfig.DataSet);

end;

procedure TFrmConfiguracoes.TabNFeExit(Sender: TObject);
begin
  inherited;
  if DataDadosTecnicos.DataSet.State in [dsInsert,dsEdit] then
  begin
    MessageDlg('É necessário confirmar os dados técnicos!!', mtWarning, [mbOK], 0);
    PageControl1.ActivePage := TabDadosTecnicos;
  end;
  
end;

procedure TFrmConfiguracoes.BitBtn2Click(Sender: TObject);
begin
  inherited;
  if Confirmacao('Confirma os dados técnicos?') then
  begin
    Grava_Dados(DataDadosTecnicos.DataSet);
    PageControl1.TabIndex := 0;
    TabDadosTecnicos.TabVisible := false;
  end;
  
end;

procedure TFrmConfiguracoes.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  {$IFNDEF ACBrNFeOpenSSL}
  DataConfig.DataSet.FieldByName('NFE_SERIE_CERTF').AsString := DmAcBr.ACBrNFe1.SSL.SelecionarCertificado;
  {$ENDIF}

end;

procedure TFrmConfiguracoes.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('NFE_PATH_LOGOMARCA').AsString := OpenDialog1.FileName;

end;

procedure TFrmConfiguracoes.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('NFE_PATH_ARQUIVO').AsString := ExtractFilePath(OpenDialog1.FileName);

end;

procedure TFrmConfiguracoes.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('NFE_PATH_CERTF').AsString := OpenDialog1.FileName;

end;

procedure TFrmConfiguracoes.DbCodCidadeExit(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.State in [dsInsert,dsEdit] then
  begin
    if (DataWork.DataSet.FieldByName('COD_MUNICIPIO').AsString <> '') then
    begin
      if not DmClientes.Dados_CodCidade(DataWork.DataSet.FieldByName('COD_MUNICIPIO').AsString,true) then
      begin
        MessageDlg('O código da cidade informado é inválido. Verifique!!!', mtWarning, [mbOK], 0);
        DbCodCidade.SetFocus;
      end;
    end
    else
    begin
      Application.CreateForm(TFrmMunicipio,FrmMunicipio);
      try
        FrmMunicipio.ShowModal;
        if FrmMunicipio.sCodCidade <> '' then
           DataWork.DataSet.FieldByName('COD_MUNICIPIO').AsString := FrmMunicipio.sCodCidade;
      finally
        FreeAndNil(FrmMunicipio);
        DbCodCidade.SetFocus;
      end;
    end;
  end;

end;

procedure TFrmConfiguracoes.DataWorkDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if DataWork.DataSet.FieldByName('CNAE').AsString <> '' then
  begin
    DmWorkCom.Dados_CNAE(DataWork.DataSet.FieldByName('CNAE').AsString);
  end;
end;

procedure TFrmConfiguracoes.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('SCPATH_DB').AsString := OpenDialog1.FileName;

end;

procedure TFrmConfiguracoes.SpeedButton7Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('SCPATH_REL').AsString := ExtractFilePath(OpenDialog1.FileName);

end;

procedure TFrmConfiguracoes.SpeedButton8Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  DataConfig.DataSet.FieldByName('SCPATH_SCRIBES').AsString := OpenDialog1.FileName;

end;

procedure TFrmConfiguracoes.GravarConfiguracao;
var IniFile: String;
    Ini: TIniFile;
begin
 IniFile := ExtractFilePath(Application.ExeName)+'Config_NFSe.ini';

 Ini := TIniFile.Create( IniFile );
 try
  Ini.WriteString( 'Emitente', 'CNPJ'       , edtEmitCNPJ.Text);
  Ini.WriteString( 'Emitente', 'IM'         , edtEmitIM.Text);
  Ini.WriteString( 'Emitente', 'RazaoSocial', edtEmitRazao.Text);
  Ini.WriteString( 'Emitente', 'Fantasia'   , edtEmitFantasia.Text);
  Ini.WriteString( 'Emitente', 'Fone'       , edtEmitFone.Text);
  Ini.WriteString( 'Emitente', 'CEP'        , edtEmitCEP.Text);
  Ini.WriteString( 'Emitente', 'Logradouro' , edtEmitLogradouro.Text);
  Ini.WriteString( 'Emitente', 'Numero'     , edtEmitNumero.Text);
  Ini.WriteString( 'Emitente', 'Complemento', edtEmitComp.Text);
  Ini.WriteString( 'Emitente', 'Bairro'     , edtEmitBairro.Text);
  Ini.WriteString( 'Emitente', 'CodCidade'  , edtCodCidade.Text);
  Ini.WriteString( 'Emitente', 'Cidade'     , edtEmitCidade.Text);
  Ini.WriteString( 'Emitente', 'UF'         , edtEmitUF.Text);

  Ini.WriteString( 'Certificado', 'Caminho' , edtCaminho.Text);
  Ini.WriteString( 'Certificado', 'Senha'   , edtSenha.Text);
  Ini.WriteString( 'Certificado', 'NumSerie', edtNumSerie.Text);

  Ini.WriteString( 'Geral', 'Schemas'   , edtSchemas.Text);
  Ini.WriteString( 'Geral', 'LogoMarca' , edtLogoMarca.Text);
  Ini.WriteString( 'Geral', 'PrestLogo' , edtPrestLogo.Text);
  Ini.WriteBool(   'Geral', 'Salvar'    , ckSalvar.Checked);
  Ini.WriteString( 'Geral', 'PathSalvar', edtPathLogs.Text);
  Ini.WriteString( 'Geral', 'Prefeitura', edtPrefeitura.Text);
  Ini.WriteString( 'Geral', 'PathINI', edtArqINI.Text);

  Ini.WriteInteger( 'WebService', 'Ambiente'  , rgTipoAmb.ItemIndex);
  Ini.WriteBool(    'WebService', 'Visualizar', ckVisualizar.Checked);
  Ini.WriteString(  'WebService', 'SenhaWeb'  , edtSenhaWeb.Text);
  Ini.WriteString(  'WebService', 'UserWeb'   , edtUserWeb.Text);
  Ini.WriteBool(    'WebService', 'SalvarSoap', ckSalvarSoap.Checked);

  Ini.WriteString( 'Proxy', 'Host' , edtProxyHost.Text);
  Ini.WriteString( 'Proxy', 'Porta', edtProxyPorta.Text);
  Ini.WriteString( 'Proxy', 'User' , edtProxyUser.Text);
  Ini.WriteString( 'Proxy', 'Pass' , edtProxySenha.Text);

  Ini.WriteString( 'Email', 'Host'     , edtSmtpHost.Text);
  Ini.WriteString( 'Email', 'Port'     , edtSmtpPort.Text);
  Ini.WriteString( 'Email', 'User'     , edtSmtpUser.Text);
  Ini.WriteString( 'Email', 'Pass'     , edtSmtpPass.Text);
  Ini.WriteString( 'Email', 'Assunto'  , edtEmailAssunto.Text);
  Ini.WriteBool(   'Email', 'SSL'      , cbEmailSSL.Checked );
  Ini.WriteBool(   'Email', 'TLS'      , cbEmailTLS.Checked );
  Ini.WriteString( 'Email', 'Remetente', edtEmailRemetente.Text);

 finally
  Ini.Free;
 end;

end;

procedure TFrmConfiguracoes.Grava_INI_SPED;
begin
  // SPED EFD
  DmSPED.sCOD_VER   := ComboVersao.ItemIndex;
  DmSPED.sPERFIL    := RadioPerfil.ItemIndex;
  DmSPED.sINDICADOR := RadioIndicador.ItemIndex;
  DmSPED.sCOD_FIN   := RadioFinalidade.ItemIndex;
  DmSPED.sBUF_LINHA := edBufLinhas.Text;
  DmSPED.sBUF_NOTA  := edBufNotas.Text;
  DmSPED.sNOTA      := edNotas.Text;
  DmSPED.sPATH      := EdtPath.Text;
  DmSPED.sCodRec    := EdtCodRec.Text;
  DmSPED.sTruncado  := ChTruncado.Checked;
  DmSPED.sExibeEFD  := ChSPEDEfd.Checked;
  DmSPED.sExibeCont := ChSPEDContribuicao.Checked;
  // SPED Pis/Cofins
  DmSPED.sCOD_VERPC      := ComboVersaoPC.ItemIndex;
  DmSPED.sSitEspecial    := ComboSituacao.ItemIndex;
  DmSPED.sIndicadorPC    := ComboIndicador.ItemIndex;
  DmSPED.sTpEscrituracao := RadioTipoEsc.ItemIndex;
  DmSPED.sEscrituracao   := ComboEscrituracao.ItemIndex;
  DmSPED.sNatureza       := RadioNatureza.ItemIndex;
  // Regime Apuração
  DmSPED.sIncidencia := RadioIncidencia.ItemIndex;
  DmSPED.sAproCred   := RadioAproCred.ItemIndex;
  DmSPED.sContrApur  := RadioContrApur.ItemIndex;
  DmSPED.sEscrApur   := RadioEscrApur.ItemIndex;
  //
  DmSPED.GravaIni;

end;

procedure TFrmConfiguracoes.Le_INI_SPED;
begin
  DmSPED.LeIni;
  ComboVersao.ItemIndex      := DmSPED.sCOD_VER;
  RadioPerfil.ItemIndex      := DmSPED.sPERFIL;
  RadioIndicador.ItemIndex   := DmSPED.sINDICADOR;
  RadioFinalidade.ItemIndex  := DmSPED.sCOD_FIN;
  edBufLinhas.Text           := DmSPED.sBUF_LINHA;
  edBufNotas.Text            := DmSPED.sBUF_NOTA;
  edNotas.Text               := DmSPED.sNOTA;
  EdtPath.Text               := DmSPED.sPATH;
  EdtCodRec.Text             := DmSPED.sCodRec;
  ChTruncado.Checked         := DmSPED.sTruncado;
  ChSPEDEfd.Checked          := DmSPED.sExibeEFD;
  ChSPEDContribuicao.Checked := DmSPED.sExibeCont;
  // dados do sped pis cofins
  ComboVersaoPC.ItemIndex     := DmSPED.sCOD_VERPC;
  ComboSituacao.ItemIndex     := DmSPED.sSitEspecial;
  ComboIndicador.ItemIndex    := DmSPED.sIndicadorPC;
  RadioTipoEsc.ItemIndex      := DmSPED.sTpEscrituracao;
  ComboEscrituracao.ItemIndex := DmSPED.sEscrituracao;
  RadioNatureza.ItemIndex     := DmSPED.sNatureza;
  // Regime Apuração
  RadioIncidencia.ItemIndex := DmSPED.sIncidencia;
  RadioAproCred.ItemIndex   := DmSPED.sAproCred;
  RadioContrApur.ItemIndex  := DmSPED.sContrApur;
  RadioEscrApur.ItemIndex   := DmSPED.sEscrApur;

end;

procedure TFrmConfiguracoes.BtnGravaSPEDClick(Sender: TObject);
begin
  inherited;
  Grava_INI_SPED;

end;

procedure TFrmConfiguracoes.btnSalvarConfigClick(Sender: TObject);
begin
  inherited;
  GravarConfiguracao;
end;

procedure TFrmConfiguracoes.ComboUFExit(Sender: TObject);
begin
  inherited;
  SelecionaPerfilUF;
end;

procedure TFrmConfiguracoes.ComboVersaoDropDown(Sender: TObject);
begin
  inherited;
  ComboVersao.Width := 360;
end;

procedure TFrmConfiguracoes.ComboVersaoExit(Sender: TObject);
begin
  inherited;
  ComboVersao.Width := 113;
end;

procedure TFrmConfiguracoes.ComboVersaoSelect(Sender: TObject);
begin
  inherited;
  ComboVersao.Width := 113;
end;

procedure TFrmConfiguracoes.SelecionaPerfilUF;
begin
  if (DataWork.DataSet.FieldByName('UF').AsString = 'MS') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'SC') then
  begin
    DataWork.DataSet.FieldByName('PERFIL_PAFECF').AsString := 'V';
  end;
  if (DataWork.DataSet.FieldByName('UF').AsString = 'AM') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'DF') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'GO') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'MA') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'PE') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'RJ') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'RR') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'TO') then
  begin
    DataWork.DataSet.FieldByName('PERFIL_PAFECF').AsString := 'W';
  end;
  if (DataWork.DataSet.FieldByName('UF').AsString = 'ES') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'PB') then
  begin
    DataWork.DataSet.FieldByName('PERFIL_PAFECF').AsString := 'Y';
  end;
  if (DataWork.DataSet.FieldByName('UF').AsString = 'BA') then
  begin
    DataWork.DataSet.FieldByName('PERFIL_PAFECF').AsString := 'Z';
  end;
  if (DataWork.DataSet.FieldByName('UF').AsString = 'AC') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'AL') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'AP') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'CE') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'MG') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'PA') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'PR') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'PI') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'RN') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'RS') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'RO') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'SP') or
     (DataWork.DataSet.FieldByName('UF').AsString = 'CE') then
  begin
    DataWork.DataSet.FieldByName('PERFIL_PAFECF').AsString := 'N';
  end;

end;

procedure TFrmConfiguracoes.ComboUFClick(Sender: TObject);
begin
  inherited;
  SelecionaPerfilUF;
end;

procedure TFrmConfiguracoes.SpeedButton9Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  EdtPath.Text := ExtractFilePath(OpenDialog1.FileName);
end;

procedure TFrmConfiguracoes.bImpressoraClick(Sender: TObject);
begin
  inherited;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  if PrintDialog1.Execute then
    DataConfig.DataSet.FieldByName('SAT_IMP_NOME').AsString := Printer.Printers[Printer.PrinterIndex];

end;

procedure TFrmConfiguracoes.SbArqLogClick(Sender: TObject);
begin
  inherited;
  OpenURL( ExtractFilePath( Application.ExeName ) + 'LogSAT.Log');

end;

procedure TFrmConfiguracoes.sbtArqINIClick(Sender: TObject);
var Dir : string;
begin
  inherited;
 if Length(edtArqINI.Text) <= 0
  then Dir := ExtractFileDir(application.ExeName)
  else Dir := edtArqINI.Text;

 if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP)
  then edtArqINI.Text := Dir;

end;

procedure TFrmConfiguracoes.sbtnCaminhoCertClick(Sender: TObject);
begin
  inherited;
 OpenDialog1.Title := 'Selecione o Certificado';
 OpenDialog1.DefaultExt := '*.pfx';
 OpenDialog1.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

 if OpenDialog1.Execute then
  begin
   edtCaminho.Text := OpenDialog1.FileName;
  end;

end;

procedure TFrmConfiguracoes.sbtnGetCertClick(Sender: TObject);
begin
  inherited;
  edtNumSerie.Text := DmAcBr.ACBrNFSe1.SSL.SelecionarCertificado;

end;

procedure TFrmConfiguracoes.sbtnLogoMarcaClick(Sender: TObject);
begin
  inherited;
 OpenDialog1.Title := 'Selecione o Logo';
 OpenDialog1.DefaultExt := '*.bmp';
 OpenDialog1.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

 if OpenDialog1.Execute then
 begin
  edtLogoMarca.Text := OpenDialog1.FileName;
 end;

end;

procedure TFrmConfiguracoes.sbtnPathSalvarClick(Sender: TObject);
var Dir : string;
begin
  inherited;
 if Length(edtPathLogs.Text) <= 0
  then Dir := ExtractFileDir(application.ExeName)
  else Dir := edtPathLogs.Text;

 if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP)
  then edtPathLogs.Text := Dir;

end;

procedure TFrmConfiguracoes.sbtnPrestLogoClick(Sender: TObject);
begin
  inherited;
 OpenDialog1.Title := 'Selecione o Logo';
 OpenDialog1.DefaultExt := '*.bmp';
 OpenDialog1.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

 if OpenDialog1.Execute then
 begin
  edtPrestLogo.Text := OpenDialog1.FileName;
 end;

end;

procedure TFrmConfiguracoes.sbtSchemasClick(Sender: TObject);
var Dir : string;
begin
  inherited;
 if Length(edtSchemas.Text) <= 0
  then Dir := ExtractFileDir(application.ExeName)
  else Dir := edtSchemas.Text;

 if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP)
  then edtSchemas.Text := Dir;

end;

procedure TFrmConfiguracoes.Button1Click(Sender: TObject);
begin
  inherited;
  DmAcBr.ACBrSAT1.AtualizarSoftwareSAT;

end;

procedure TFrmConfiguracoes.bInicializarClick(Sender: TObject);
begin
  inherited;
  DmWorkCom.AjustaACBrSAT;

  DmAcBr.ACBrSAT1.Inicializado := not DmAcBr.ACBrSAT1.Inicializado;

  if DmAcBr.ACBrSAT1.Inicializado then
    bInicializar.Caption := 'DesInicializar'
  else
    bInicializar.Caption := 'Inicializar' ;

end;

procedure TFrmConfiguracoes.Button2Click(Sender: TObject);
begin
  inherited;
  try
    DmAcBr.ACBrSAT1.AtivarSAT(1,DataWork.DataSet.FieldByName('CNPJ_CPF').AsString,StrToInt(DmWorkCom.sCOD_UF_SAT));
  except
    on E:Exception do ShowMessage(E.Message);
  end;    

end;

procedure TFrmConfiguracoes.Button3Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Filter := 'Arquivo XML|*.xml';
  if OpenDialog1.Execute then
  begin
    DmAcBr.ACBrSAT1.Rede.LoadFromFile( OpenDialog1.FileName );

    LeDadosRedeSAT;
    DmAcBr.ACBrSAT1.ConfigurarInterfaceDeRede( );
  end ;

end;

procedure TFrmConfiguracoes.LeDadosRedeSAT;
begin
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
    DataConfig.DataSet.Edit;
  with DmAcBr.ACBrSAT1.Rede do
  begin
    DataConfig.DataSet.FieldByName('SAT_TIPO_REDE').AsInteger      := Integer(tipoInter);
    DataConfig.DataSet.FieldByName('SAT_WIFI_SSID').AsString       := SSID;
    DataConfig.DataSet.FieldByName('SAT_WIFI_SEG').AsInteger       := Integer(seg);
    DataConfig.DataSet.FieldByName('SAT_WIFI_SENHA').AsString      := codigo;
    DataConfig.DataSet.FieldByName('SAT_PROTOCOLO_REDE').AsInteger := Integer(tipoLan);
    DataConfig.DataSet.FieldByName('IPFIX_IP').AsString            := lanIP;
    DataConfig.DataSet.FieldByName('IPFIX_MASK').AsString          := lanMask;
    DataConfig.DataSet.FieldByName('IPFIX_GATEWAY').AsString       := lanGW;
    DataConfig.DataSet.FieldByName('IPFIX_DNS1').AsString          := lanDNS1;
    DataConfig.DataSet.FieldByName('IPFIX_DNS2').AsString          := lanDNS2;
    DataConfig.DataSet.FieldByName('SAT_PPPoE_USER').AsString      := usuario;
    DataConfig.DataSet.FieldByName('SAT_PPPoE_LOGIN').AsString     := senha;
    DataConfig.DataSet.FieldByName('SAT_REDE_PROXY').AsInteger     := proxy;
    DataConfig.DataSet.FieldByName('SAT_REDE_IP').AsString         := proxy_ip;
    DataConfig.DataSet.FieldByName('SAT_REDE_PORTA').AsInteger     := proxy_porta;
    DataConfig.DataSet.FieldByName('SAT_REDE_USER').AsString       := proxy_user;
    DataConfig.DataSet.FieldByName('SAT_REDE_LOGIN').AsString      := proxy_senha;
  end;

end;

procedure TFrmConfiguracoes.RepassaDadosNFSe;
begin
  {$IFDEF ACBrNFSeOpenSSL}
   edtCaminho.Text := DmWorkCom.sNFSeCaminho;
   edtSenha.Text   := DmWorkCom.sNFSeCertSenha;

   edtNumSerie.Visible := False;
   Label25.Visible     := False;
   sbtnGetCert.Visible := False;
  {$ELSE}
   edtNumSerie.Text := DmWorkCom.sNFSeNumSerie;
{
   Label1.Caption   := 'Informe o número de série do certificado'#13+
                       'Disponível no Internet Explorer no menu'#13+
                       'Ferramentas - Opções da Internet - Conteúdo '#13+
                       'Certificados - Exibir - Detalhes - '#13+
                       'Número do certificado';

   Label2.Visible     := False; }
   edtCaminho.Visible := False;
   edtSenha.Visible   := False;
   sbtnCaminhoCert.Visible := False;
  {$ENDIF}

  edtEmitCNPJ.Text       := DmWorkCom.sNFSeEmitCNPJ;
  edtEmitIM.Text         := DmWorkCom.sNFSeEmitIM;
  edtEmitRazao.Text      := DmWorkCom.sNFSeEmitRazao;
  edtEmitFantasia.Text   := DmWorkCom.sNFSeEmitFantasia;
  edtEmitFone.Text       := DmWorkCom.sNFSeEmitFone;
  edtEmitCEP.Text        := DmWorkCom.sNFSeEmitCEP;
  edtEmitLogradouro.Text := DmWorkCom.sNFSeEmitLogradouro;
  edtEmitNumero.Text     := DmWorkCom.sNFSeEmitNumero;
  edtEmitComp.Text       := DmWorkCom.sNFSeEmitComp;
  edtEmitBairro.Text     := DmWorkCom.sNFSeEmitBairro;
  edtEmitCidade.Text     := DmWorkCom.sNFSeEmitCidade;
  edtEmitUF.Text         := DmWorkCom.sNFSeEmitUF;
  edtCodCidade.Text      := DmWorkCom.sNFSeCodCidade;
  cbCidades.ItemIndex    := cbCidades.Items.IndexOf(edtEmitCidade.Text + '/' +
                                                    edtCodCidade.Text + '/' +
                                                    edtEmitUF.Text);

  edtSchemas.Text    := DmWorkCom.sNFSeSchemas;
  edtLogoMarca.Text  := DmWorkCom.sNFSeLogoMarca;
  edtPrestLogo.Text  := DmWorkCom.sNFSePrestLogo;
  ckSalvar.Checked   := DmWorkCom.sNFSeSalvar;
  edtPathLogs.Text   := DmWorkCom.sNFSePathLogs;
  edtPrefeitura.Text := DmWorkCom.sNFSePrefeitura;
  edtArqINI.Text     := DmWorkCom.sNFSeArqINI;

  rgTipoAmb.ItemIndex  := DmWorkCom.sNFSeTipoAmb;
  ckVisualizar.Checked := DmWorkCom.sNFSeVisualizar;
  edtSenhaWeb.Text     := DmWorkCom.sNFSeSenhaWeb;
  edtUserWeb.Text      := DmWorkCom.sNFSeUserWeb;
  ckSalvarSoap.Checked := DmWorkCom.sNFSeSalvarSoap;

  edtProxyHost.Text  := DmWorkCom.sNFSeProxyHost;
  edtProxyPorta.Text := DmWorkCom.sNFSeProxyPorta;
  edtProxyUser.Text  := DmWorkCom.sNFSeProxyUser;
  edtProxySenha.Text := DmWorkCom.sNFSeProxySenha;

  edtSmtpHost.Text       := DmWorkCom.sNFSeSmtpHost;
  edtSmtpPort.Text       := DmWorkCom.sNFSeSmtpPort;
  edtSmtpUser.Text       := DmWorkCom.sNFSeSmtpUser;
  edtSmtpPass.Text       := DmWorkCom.sNFSeSmtpPass;
  edtEmailAssunto.Text   := DmWorkCom.sNFSeEmailAssunto;
  cbEmailSSL.Checked     := DmWorkCom.sNFSeEmailSSL;
  cbEmailTLS.Checked     := DmWorkCom.sNFSeEmailTLS;
  edtEmailRemetente.Text := DmWorkCom.sNFSeEmailRemetente;

end;

procedure TFrmConfiguracoes.Button4Click(Sender: TObject);
begin
  inherited;
  DmWorkCom.ConfiguraRedeSAT;
  DmAcBr.ACBrSAT1.ConfigurarInterfaceDeRede( );

end;

procedure TFrmConfiguracoes.Button5Click(Sender: TObject);
begin
  inherited;
  DmAcBr.ACBrSAT1.AssociarAssinatura(DmWorkCom.CdsDadosTecnicosCNPJ.AsString +
                                     DmWorkCom.CdsEmpresaCNPJ_CPF.AsString,
                                     DmWorkCom.CdsDadosTecnicosSWH_ASSINATURA.AsString);

end;

procedure TFrmConfiguracoes.Button6Click(Sender: TObject);
begin
  inherited;
  if not(DataConfig.DataSet.State in [dsInsert,dsEdit]) then
     DataConfig.DataSet.Edit;
  if PrintDialog1.Execute then
    DataConfig.DataSet.FieldByName('IMPRESSORA').AsString := Printer.Printers[Printer.PrinterIndex];

end;

procedure TFrmConfiguracoes.cbCidadesChange(Sender: TObject);
var
 Tamanho: Integer;
begin
  inherited;
  Tamanho   := Length(Trim(cbCidades.Text));
  edtEmitCidade.Text := Copy(cbCidades.Text, 1, Tamanho - 11);
  edtEmitUF.Text     := Copy(cbCidades.Text, Tamanho - 1, 2);
  edtCodCidade.Text  := Copy(cbCidades.Text, Tamanho - 9, 7);

end;

procedure TFrmConfiguracoes.cbSSLLibChange(Sender: TObject);
begin
  inherited;
  DataConfig.DataSet.Edit;

end;

procedure TFrmConfiguracoes.PreenchePortas;
var aArquivo : TextFile;
    aNomeArq, Linha : string;
begin
  cbxPortaPOS.Items.Clear;
  DmAcBr.ACBrPosPrinter1.Device.AcharPortasSeriais(cbxPortaPOS.Items);
  //
  aNomeArq := ExtractFilePath(Application.ExeName)+'Portas.txt';
  if FileExists(aNomeArq) then
  begin
    AssignFile(aArquivo,aNomeArq);
    Reset(aArquivo);
    while not Eof(aArquivo) do
    begin
      ReadLn(aArquivo,Linha);
      cbxPortaPOS.Items.Add(Linha);
    end;
    CloseFile(aArquivo);
  end
  else
  begin
    AssignFile(aArquivo,aNomeArq);
    Rewrite(aArquivo);
    Writeln(aArquivo,'LPT1') ;
    Writeln(aArquivo,'LPT2') ;
    Writeln(aArquivo,'/dev/ttyS0') ;
    Writeln(aArquivo,'/dev/ttyS1') ;
    Writeln(aArquivo,'/dev/ttyUSB0') ;
    Writeln(aArquivo,'/dev/ttyUSB1') ;
    Writeln(aArquivo,'/dev/USB_VOX_1') ;
    Writeln(aArquivo,'\\localhost\Epson') ;
    Writeln(aArquivo,'c:\temp\ecf.txt') ;
    Writeln(aArquivo,'/tmp/ecf.txt') ;
    Writeln(aArquivo,'USB_VOX_1') ;
    CloseFile(aArquivo);
    PreenchePortas;
  end;

end;

end.
