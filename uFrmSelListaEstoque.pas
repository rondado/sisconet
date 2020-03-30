unit uFrmSelListaEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ActnList, StdCtrls, Grids, DBGrids, DB, Menus,
  System.Actions;

type
  TFrmSelListaEstoque = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    ActionList1: TActionList;
    ActIncluir: TAction;
    ActExcluir: TAction;
    DataLista: TDataSource;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    InsIncluiritem1: TMenuItem;
    DelExcluirItem1: TMenuItem;
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSelListaEstoque: TFrmSelListaEstoque;

implementation

uses uDmWorkCom, uFrmProdutos, uLibrary, uDmAuxiliar, uDmProdutos;

{$R *.dfm}

procedure TFrmSelListaEstoque.ActIncluirExecute(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmProdutos,FrmProdutos);
  try
    FrmProdutos.sIDProd := 0;
    FrmProdutos.ShowModal;
    if FrmProdutos.sIDProd > 0 then
    begin
      if DmProdutos.Dados_Produto(FrmProdutos.sIDProd) then
      begin
        DataLista.DataSet.Append;
        DataLista.DataSet.FieldByName('IDPRODUTO').AsInteger := DmProdutos.CdsProdutosID.AsInteger;
        DataLista.DataSet.FieldByName('DESCRICAO').AsString  := DmProdutos.CdsProdutosDESCRICAO.AsString;
        DataLista.DataSet.FieldByName('UNIDADE').AsString    := DmProdutos.CdsProdutosUNIDADE.AsString;
        DataLista.DataSet.Post;
      end;
    end;
  finally
    FrmProdutos.Free;
  end;

end;

procedure TFrmSelListaEstoque.ActExcluirExecute(Sender: TObject);
begin
  inherited;
  if DataLista.DataSet.RecordCount > 0 then
  begin
    if Confirmacao('Confirma a exclusão do item') then
       DataLista.DataSet.Delete;
  end;
  
end;

procedure TFrmSelListaEstoque.FormShow(Sender: TObject);
begin
  inherited;
  DataLista.DataSet := DmAuxiliar.CdsListaEstoque;

end;

end.
