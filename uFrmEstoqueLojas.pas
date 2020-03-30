unit uFrmEstoqueLojas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr;

type
  TFrmEstoqueLoja = class(TFrmPadrao)
    DataEstoque: TDataSource;
    GridEstoque: TDBGrid;
    Panel1: TPanel;
    LbProduto: TLabel;
    QryEstoque: TSQLQuery;
    DspEstoque: TDataSetProvider;
    CdsEstoque: TClientDataSet;
    QryEstoqueIDEMPRESA: TIntegerField;
    QryEstoqueRAZAO_SOCIAL: TStringField;
    QryEstoqueQUANTIDADE: TFloatField;
    CdsEstoqueIDEMPRESA: TIntegerField;
    CdsEstoqueRAZAO_SOCIAL: TStringField;
    CdsEstoqueQUANTIDADE: TFloatField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Dados_EstoqueLoja;
  public
    { Public declarations }
    sIDProduto : Integer;
  end;

var
  FrmEstoqueLoja: TFrmEstoqueLoja;

implementation

{$R *.dfm}

uses uDmProdutos, uLibrary, uDmConexao;

procedure TFrmEstoqueLoja.Dados_EStoqueLoja;
begin
  CdsEstoque.Close;
  CdsEstoque.Params.ParamByName('pIDProduto').AsInteger := sIDProduto;
  CdsEstoque.Open;
  GridEstoque.SetFocus;
end;

procedure TFrmEstoqueLoja.FormShow(Sender: TObject);
begin
  inherited;
  DataEstoque.DataSet := CdsEstoque;
  Dados_EstoqueLoja;

end;

end.
