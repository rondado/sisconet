unit uFrmMunicipio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, StdCtrls, DBCtrls, FMTBcd, SqlExpr, Grids,
  DBGrids, DBClient, Provider;

type
  TFrmMunicipio = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DataUF: TDataSource;
    ComboUF: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtCidade: TEdit;
    DataCidades: TDataSource;
    DspCidades: TDataSetProvider;
    CdsCidades: TClientDataSet;
    GridCidade: TDBGrid;
    QryCidades: TSQLQuery;
    QryCidadesCOD_UF: TStringField;
    QryCidadesCOD_MUNICIPIO: TStringField;
    QryCidadesUF: TStringField;
    QryCidadesMUNICIPIO: TStringField;
    QryCidadesUF_SIGLA: TStringField;
    CdsCidadesCOD_UF: TStringField;
    CdsCidadesCOD_MUNICIPIO: TStringField;
    CdsCidadesUF: TStringField;
    CdsCidadesMUNICIPIO: TStringField;
    CdsCidadesUF_SIGLA: TStringField;
    procedure FormShow(Sender: TObject);
    procedure EdtCidadeExit(Sender: TObject);
    procedure ComboUFKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure GridCidadeDblClick(Sender: TObject);
    procedure GridCidadeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sCodCidade : String;
  end;

var
  FrmMunicipio: TFrmMunicipio;

implementation

uses uDmConexao, uDmWorkCom, uLibrary, uDMClientes;

{$R *.dfm}

procedure TFrmMunicipio.FormShow(Sender: TObject);
begin
  inherited;
  DataUF.DataSet := DmClientes.CdsUF;
  DmClientes.Dados_UF;
  ComboUF.SetFocus;

end;

procedure TFrmMunicipio.EdtCidadeExit(Sender: TObject);
begin
  inherited;
  CdsCidades.Close;
  CdsCidades.Params.Clear;
  QryCidades.Close;
  QryCidades.SQL.Clear;
  QryCidades.SQL.Add('select * from cod_mun_ibge c');
  QryCidades.SQL.Add('where upper(c.uf_sigla) = '+QuotedStr(ComboUF.Text));
  QryCidades.SQL.Add('and upper(c.municipio) like '+QuotedStr('%'+Trim(UpperCase(EdtCidade.Text))+'%'));
  CdsCidades.FetchParams;
  CdsCidades.Open;
  GridCidade.SetFocus;
end;

procedure TFrmMunicipio.ComboUFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

procedure TFrmMunicipio.FormCreate(Sender: TObject);
begin
  inherited;
  sCodCidade := '';
end;

procedure TFrmMunicipio.GridCidadeDblClick(Sender: TObject);
begin
  inherited;
  if CdsCidades.RecordCount > 0 then
  begin
    sCodCidade := CdsCidades.FieldByName('COD_UF').AsString+CdsCidades.FieldByName('COD_MUNICIPIO').AsString;
    Close;
  end;
end;

procedure TFrmMunicipio.GridCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    GridCidadeDblClick(Sender);
  if key = #27 then
     Close;
end;

end.
