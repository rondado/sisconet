unit uFrmTabNCM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, FMTBcd, DBClient, Provider, DB, SqlExpr,
  Grids, DBGrids;

type
  TFrmTabNCM = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    EdtDescricao: TEdit;
    GroupBox2: TGroupBox;
    DataNCM: TDataSource;
    GridNCM: TDBGrid;
    QryNCM: TSQLQuery;
    DspNCM: TDataSetProvider;
    CdsNCM: TClientDataSet;
    QryNCMCODIGO: TStringField;
    QryNCMEXCECAO: TIntegerField;
    QryNCMTABELA: TIntegerField;
    QryNCMDESCRICAO: TStringField;
    QryNCMALIQ_NACIONAL: TFloatField;
    QryNCMALIQ_IMPORTACAO: TFloatField;
    CdsNCMCODIGO: TStringField;
    CdsNCMEXCECAO: TIntegerField;
    CdsNCMTABELA: TIntegerField;
    CdsNCMDESCRICAO: TStringField;
    CdsNCMALIQ_NACIONAL: TFloatField;
    CdsNCMALIQ_IMPORTACAO: TFloatField;
    procedure EdtDescricaoExit(Sender: TObject);
    procedure GridNCMTitleClick(Column: TColumn);
    procedure EdtDescricaoKeyPress(Sender: TObject; var Key: Char);
    procedure GridNCMDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridNCMKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sCodigo : String;
    sExcecao : Integer;
  end;

var
  FrmTabNCM: TFrmTabNCM;

implementation

uses uDmConexao, uLibrary;

{$R *.dfm}

procedure TFrmTabNCM.EdtDescricaoExit(Sender: TObject);
begin
  inherited;
  CdsNCM.Close;
  CdsNCM.Params.ParamByName('pDesc').AsString := EdtDescricao.Text;
  CdsNCM.Open;
  GridNCM.SetFocus;
  
end;

procedure TFrmTabNCM.GridNCMTitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(CdsNCM,GridNCM,Column);
end;

procedure TFrmTabNCM.EdtDescricaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

procedure TFrmTabNCM.GridNCMDblClick(Sender: TObject);
begin
  inherited;
  if CdsNCM.RecordCount > 0 then
  begin
    sCodigo  := CdsNCM.FieldByName('CODIGO').AsString;
    sExcecao := CdsNCM.FieldByName('EXCECAO').AsInteger;
    Close;
  end;
end;

procedure TFrmTabNCM.FormCreate(Sender: TObject);
begin
  inherited;
  sCodigo  := '';
  sExcecao := 0;

end;

procedure TFrmTabNCM.GridNCMKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if CdsNCM.RecordCount > 0 then
    begin
      sCodigo  := CdsNCM.FieldByName('CODIGO').AsString;
      sExcecao := CdsNCM.FieldByName('EXCECAO').AsInteger;
      Close;
    end;
  end;
  //
  if Key = #27 then
  begin
    sCodigo  := '';
    sExcecao := 0;
    Close;
  end;  
end;

end.
