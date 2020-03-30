unit dXML;

interface

uses
  Classes, SysUtils, ExtCtrls, ACBrNFe,
  ACBrMail, ACBrNFeDANFeRLClass, db, ACBrDFe,
  ACBrDFeSSL, Data.FMTBcd, Data.SqlExpr, ACBrNFeDANFEClass, ACBrBase,
  DbxSqlite, Forms, Datasnap.DBClient, Datasnap.Provider, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.SQLite, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type

  { Tdtmxml }

  Tdtmxml = class(TDataModule)
    ACBrMail1: TACBrMail;
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    AutoExec: TTimer;
    qXmlDfe: TFDQuery;
    qXmlNfe: TFDQuery;
    qXmlRes: TFDQuery;
    qXmlCfg: TFDQuery;
    Conn: TFDConnection;
    pXmlCfg: TDataSetProvider;
    XmlCfg: TClientDataSet;
    pXmlRes: TDataSetProvider;
    XmlRes: TClientDataSet;
    pXmlDfe: TDataSetProvider;
    XmlDfe: TClientDataSet;
    pXmlNfe: TDataSetProvider;
    XmlNfe: TClientDataSet;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDSQLiteValidate1: TFDSQLiteValidate;
    XmlCfgIDDFE: TIntegerField;
    XmlCfgULTNSU: TIntegerField;
    XmlCfgUF: TStringField;
    XmlCfgTIMEINTERVAL: TIntegerField;
    XmlCfgNUMEROSERIE: TStringField;
    XmlCfgIDDFEAUTOINC: TIntegerField;
    XmlCfgSENHA: TStringField;
    XmlCfgARQUIVOPFX: TStringField;
    XmlCfgPATHDB: TStringField;
    XmlCfgSSLLIB: TStringField;
    XmlCfgAUTOEXECUTE: TIntegerField;
    XmlCfgAUTOTIMER: TIntegerField;
    XmlResIDDFE: TIntegerField;
    XmlResXNUMERONFE: TStringField;
    XmlResXSERIE: TStringField;
    XmlResCHNFE: TStringField;
    XmlResCNPJCPF: TStringField;
    XmlResXNOME: TStringField;
    XmlResIE: TStringField;
    XmlResDHEMI: TSQLTimeStampField;
    XmlResTPNF: TIntegerField;
    XmlResVNF: TBCDField;
    XmlResDIGVAL: TStringField;
    XmlResDHRECBTO: TSQLTimeStampField;
    XmlResNPROT: TStringField;
    XmlResCSITNFE: TIntegerField;
    XmlResNSU: TIntegerField;
    XmlResNFE: TStringField;
    XmlResDFE: TStringField;
    procedure AutoExecTimer(Sender: TObject);
    procedure xmlcfgAfterPost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure XmlCfgAfterOpen(DataSet: TDataSet);
    procedure pXmlCfgUpdateData(Sender: TObject; DataSet: TCustomClientDataSet);
    procedure pXmlResUpdateData(Sender: TObject; DataSet: TCustomClientDataSet);
    procedure XmlCfgNewRecord(DataSet: TDataSet);
  private

  public
    procedure SetaConfiguracoes;

    function GetPathXMLNFe(const ADataEmissao: TDateTime;
      const AChaveNFe: String): String;
    function GetPathPDFNFe(const ADataEmissao: TDateTime;
      const AChaveNFe: String): String;
  end;

var
  dtmxml: Tdtmxml;

implementation

uses
  uXML, ACBrUtil;

{$R *.dfm}

{ Tdtmxml }

function Tdtmxml.GetPathXMLNFe(const ADataEmissao: TDateTime; const AChaveNFe: String): String;
begin
  Result := PathWithDelim(ACbrNFe1.Configuracoes.Arquivos.DownloadNFe.PathDownload) +
            PathWithDelim(FormatDateTime('YYYYMM', ADataEmissao)) +
            PathWithDelim('Down') +
            AChaveNFe + '-nfe.xml';
end;

function Tdtmxml.GetPathPDFNFe(const ADataEmissao: TDateTime; const AChaveNFe: String): String;
begin
  Result := PathWithDelim(dtmxml.ACBrNFe1.DANFE.PathPDF) +
            PathWithDelim(FormatDateTime('YYYYMM', ADataEmissao)) +
            AChaveNFe + '-nfe.pdf';
end;

procedure Tdtmxml.DataModuleCreate(Sender: TObject);
var
  sDirEXE: String;
  sdirNFe: String;
begin
  sDirEXE := ExtractFilePath(Application.ExeName);
  sdirNFe  := IncludeTrailingPathDelimiter(sDirEXE + 'Documentos');

  // diretorios
  ACbrNFe1.Configuracoes.Arquivos.PathSchemas := sDirEXE + 'Schemas\nfe';
  ACbrNFe1.Configuracoes.Arquivos.PathEvento  := sdirNFe + 'Eventos\';
  ACbrNFe1.Configuracoes.Arquivos.PathInu     := sdirNFe + 'Inu\';
  ACbrNFe1.Configuracoes.Arquivos.PathNFe     := sdirNFe + 'NFe\';
  ACbrNFe1.Configuracoes.Arquivos.PathSalvar  := sdirNFe + 'Salvar\';

  // diretorio de padfs
  ACbrNFe1.DANFE.PathPDF := sdirNFe + 'PDF';

  // arquivos baixados
  ACbrNFe1.Configuracoes.Arquivos.DownloadNFe.PathDownload := sdirNFe + 'Download\';

  // selects gerais
  xmlcfg.CommandText := 'select * from xmlcfg';
  xmldfe.CommandText := 'select * from xmlnfe where NFe = ''F''';
  xmlnfe.CommandText := 'select * from xmlnfe where NFe = ''T''';
  xmlres.CommandText := 'select * from xmlnfe where idDFe = -1';

  // arquivo de bancos de dados, usa o mesmo nome do aplicativo porem com extensão .DB
  Conn.Params.Database := 'C:\Sisconet18\Exec\Dados\DADOS.FDB'; //fabricio

  // manutenção da base de dados
  FDSQLiteValidate1.Database := Conn.Params.Database;
//  FDSQLiteValidate1.Sweep;
//  FDSQLiteValidate1.Analyze;

  Conn.Connected := True;

  xmlcfg.Open;
end;

procedure Tdtmxml.xmlcfgAfterPost(DataSet: TDataSet);
begin
  xmlcfg.ApplyUpdates(0);
  SetaConfiguracoes;
end;

procedure Tdtmxml.XmlCfgNewRecord(DataSet: TDataSet);
begin
  XmlCfg.FieldByName('idDFe').Value        := 1;
  XmlCfg.FieldByName('TimeInterval').Value := 1000;
  XmlCfg.FieldByName('idDFeAutoInc').Value := 0;
  XmlCfg.FieldByName('SSLLib').Value       := '01';
  XmlCfg.FieldByName('AutoExecute').Value  := '0';
  XmlCfg.FieldByName('AutoTimer').Value    := 1000;
end;

procedure Tdtmxml.AutoExecTimer(Sender: TObject);
begin
  frmxml.AutoExecuteProcessos;
end;

procedure Tdtmxml.DataModuleDestroy(Sender: TObject);
begin
  Conn.Connected := False;
  xmlcfg.Close;
end;

procedure Tdtmxml.pXmlCfgUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  XmlCfg.FieldByName('idDFe').ProviderFlags := [pfInKey];
end;

procedure Tdtmxml.pXmlResUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  XmlCfg.FieldByName('idDFe').ProviderFlags := [pfInKey];
end;

procedure Tdtmxml.SetaConfiguracoes;
begin
  // Atribui as configurações ao componente
  if XmlCfg.FieldByName('SSLLib').AsString = '01' then
  begin
    ACBrNFe1.Configuracoes.Geral.SSLLib             := libWinCrypt;
    ACBrNFe1.Configuracoes.Certificados.NumeroSerie := xmlcfg.FieldByName('NumeroSerie').AsString
  end
  else
  begin
    ACBrNFe1.Configuracoes.Geral.SSLLib            := libOpenSSL;
    ACBrNFe1.Configuracoes.Certificados.ArquivoPFX := xmlcfg.FieldByName('ArquivoPFX').AsString;
  end;

  ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib := xsMsXml;
  ACBrNFe1.Configuracoes.WebServices.UF      := xmlcfg.FieldByName('UF').AsString;
  ACBrNFe1.Configuracoes.Certificados.Senha  := xmlcfg.FieldByName('Senha').AsAnsiString;

  AutoExec.Enabled  := Boolean(xmlcfg.FieldByName('AutoExecute').AsInteger);
  AutoExec.Interval := xmlcfg.FieldByName('AutoTimer').AsInteger * 60000;
end;

procedure Tdtmxml.XmlCfgAfterOpen(DataSet: TDataSet);
begin
  SetaConfiguracoes;
end;

end.
