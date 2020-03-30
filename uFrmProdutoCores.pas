unit uFrmProdutoCores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmProdutoCores = class(TFrmPadrao)
    DataProdutoCor: TDataSource;
    GridCor: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridCorKeyPress(Sender: TObject; var Key: Char);
    procedure GridCorDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDCor : Integer;
    sNomeCor : String;
    sApenasConsulta : Boolean;
  end;

var
  FrmProdutoCores: TFrmProdutoCores;

implementation

{$R *.dfm}

uses uDmProdutos, uLibrary;

procedure TFrmProdutoCores.FormCreate(Sender: TObject);
begin
  inherited;
  sIDCor := 0;
  sNomeCor := '';
  sApenasConsulta := false;

end;

procedure TFrmProdutoCores.FormShow(Sender: TObject);
begin
  inherited;
  DataProdutoCor.DataSet := DmProdutos.CdsProdutoCor;
  DmProdutos.Dados_ProdCor;

end;

procedure TFrmProdutoCores.GridCorDblClick(Sender: TObject);
begin
  inherited;
  if sApenasConsulta then
  begin
    if DataProdutoCor.DataSet.RecordCount > 0 then
    begin
      sIDCor := DataProdutoCor.DataSet.FieldByName('ID').AsInteger;
      sNomeCor := DataProdutoCor.DataSet.FieldByName('NOME').AsString;
      Close;
    end;
  end;

end;

procedure TFrmProdutoCores.GridCorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if not sApenasConsulta then
    begin
      if Confirmacao('Confirma os dados?') then
      begin
        Grava_Dados(DataProdutoCor.DataSet);
        DmProdutos.Dados_ProdCor;
      end;
    end
    else
    begin
      if DataProdutoCor.DataSet.RecordCount > 0 then
      begin
        sIDCor := DataProdutoCor.DataSet.FieldByName('ID').AsInteger;
        sNomeCor := DataProdutoCor.DataSet.FieldByName('NOME').AsString;
        Close;
      end;
    end;
  end;
end;

end.
