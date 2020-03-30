unit uFrmProdutoTamanho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmProdutoTamanho = class(TFrmPadrao)
    DataProdutoTamanho: TDataSource;
    GridCor: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridCorKeyPress(Sender: TObject; var Key: Char);
    procedure GridCorDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDTamanho : Integer;
    xTamanho : String;
    sApenasConsulta : Boolean;
  end;

var
  FrmProdutoTamanho: TFrmProdutoTamanho;

implementation

{$R *.dfm}

uses uDmProdutos, uLibrary;

procedure TFrmProdutoTamanho.FormCreate(Sender: TObject);
begin
  inherited;
  sApenasConsulta := false;
  sIDTamanho := 0;
  xTamanho := '';

end;

procedure TFrmProdutoTamanho.FormShow(Sender: TObject);
begin
  inherited;
  DataProdutoTamanho.DataSet := DmProdutos.CdsProdutoTamanho;
  DmProdutos.Dados_ProdTamanho;

end;

procedure TFrmProdutoTamanho.GridCorDblClick(Sender: TObject);
begin
  inherited;
  if sApenasConsulta then
  begin
    if DataProdutoTamanho.DataSet.RecordCount > 0 then
    begin
      sIDTamanho := DataProdutoTamanho.DataSet.FieldByName('ID').AsInteger;
      xTamanho := DataProdutoTamanho.DataSet.FieldByName('METRAGEM').AsString;
      Close;
    end;
  end;

end;

procedure TFrmProdutoTamanho.GridCorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if not sApenasConsulta then
    begin
      if Confirmacao('Confirma os dados?') then
      begin
        Grava_Dados(DataProdutoTamanho.DataSet);
        DmProdutos.Dados_ProdCor;
      end;
    end
    else
    begin
      if DataProdutoTamanho.DataSet.RecordCount > 0 then
      begin
        sIDTamanho := DataProdutoTamanho.DataSet.FieldByName('ID').AsInteger;
        xTamanho := DataProdutoTamanho.DataSet.FieldByName('METRAGEM').AsString;
        Close;
      end;
    end;
  end;
end;

end.
