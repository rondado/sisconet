unit uFrmLancItensGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls,
  ActnList, Buttons, Mask, Menus, DBClient, uFrameItensPedidoLaje,
  uFrameConfirmaCancela, System.Actions;

type
  TFrmLancItensGrid = class(TFrmPadrao)
    DataProdutos: TDataSource;
    DataProdutoComposto: TDataSource;
    GrpComposicaoProd: TGroupBox;
    GridComposicao: TDBGrid;
    GrpComposicaoItem: TGroupBox;
    DataCompItem: TDataSource;
    DataPedido: TDataSource;
    GridCompItem: TDBGrid;
    CdsDadosComp: TClientDataSet;
    DataDadosComp: TDataSource;
    CdsDadosCompNOME: TStringField;
    CdsDadosCompQUANT: TFloatField;
    CdsDadosCompVALOR: TCurrencyField;
    DataItens: TDataSource;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    GroupBox1: TGroupBox;
    GriInformacao: TDBGrid;
    ActionList1: TActionList;
    ActConfirmar: TAction;
    ActCancelar: TAction;
    procedure FormShow(Sender: TObject);
    procedure ActTotalItemExecute(Sender: TObject);
    procedure ComboGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure GridCompItemKeyPress(Sender: TObject; var Key: Char);
    procedure GridCompItemEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DataListaProdutosDataChange(Sender: TObject; Field: TField);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure GridGrupoCellClick(Column: TColumn);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure ListaDetalhes(fM2Laje:Double);
    procedure SelecionaDadosItem;
    procedure VerificaDados;
    procedure AtualizaDadosCompItens;
    function RetornaQuantidadeItem:Double;
  public
    { Public declarations }
    sIDPedido,sIDItemPedido : Integer;
  end;

var
  FrmLancItensGrid: TFrmLancItensGrid;

implementation

Uses uLibrary, uDmWorkCom, uFrmTabPreco, uDmProdutos;

{$R *.dfm}

procedure TFrmLancItensGrid.FormShow(Sender: TObject);
begin
  inherited;
  DataItens.DataSet           := DmWorkCom.CdsPedidoItens;
  DataProdutos.DataSet        := DmProdutos.CdsProdutos;
  DataPedido.DataSet          := DmWorkCom.CdsPedidos;
  DataProdutoComposto.DataSet := DmProdutos.CdsProdutoComposto;
  DataCompItem.DataSet        := DmWorkCom.CdsPedidoCompItem;
  DmWorkCom.Dados_PedidoCompItem(sIDPedido,sIDItemPedido);
  if DataCompItem.DataSet.RecordCount > 0 then
     SelecionaDadosItem;
  GridCompItem.SetFocus;
end;

procedure TFrmLancItensGrid.ActTotalItemExecute(Sender: TObject);
var aTotalItem : Double;
begin
  inherited;
end;

procedure TFrmLancItensGrid.ComboGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmLancItensGrid.GridCompItemKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
  begin
    AtualizaDadosCompItens;
    Grava_Dados(DataCompItem.DataSet);
  end;

end;

procedure TFrmLancItensGrid.ListaDetalhes(fM2Laje: Double);
begin
  if not(CdsDadosComp.State in [dsInactive]) then
  begin
    CdsDadosComp.EmptyDataSet;
    // lista quantidade de materiais
    DmProdutos.Dados_ProdComposto(DataItens.DataSet.FieldByName('IDPRODUTO').AsInteger);
    DataProdutoComposto.DataSet.First;
    while not DataProdutoComposto.DataSet.Eof do
    begin
      CdsDadosComp.Append;
      CdsDadosCompNOME.AsString    := Copy(DataProdutoComposto.DataSet.FieldByname('DESCRICAO').AsString,1,20);
      CdsDadosCompQUANT.AsFloat    := TruncaValor(DataProdutoComposto.DataSet.FieldByName('QUANTIDADE').AsFloat * fM2Laje,3);
      CdsDadosCompVALOR.AsCurrency := TruncaValor(DataProdutoComposto.DataSet.FieldByName('VALOR').AsFloat * fM2Laje,2);
      CdsDadosComp.Post;
      //
      DataProdutoComposto.DataSet.Next;
    end;
  end;  
end;

procedure TFrmLancItensGrid.SelecionaDadosItem;
begin
  // seleciona a composicao
  DmWorkCom.Dados_PedidoCompItem(sIDPedido,DataItens.DataSet.FieldByName('ID').AsInteger);
  // lista quantidade de materiais
  DmProdutos.Dados_ProdComposto(DataItens.DataSet.FieldByName('IDPRODUTO').AsInteger);
  // atualiza dados do cds de memoria
  ListaDetalhes(DataItens.DataSet.FieldByName('QUANTIDADE').AsFloat);
end;

procedure TFrmLancItensGrid.GridCompItemEnter(Sender: TObject);
var aKey : Char;
begin
  inherited;
  aKey := '1';
  GridCompItemKeyPress(Sender,aKey);
end;

procedure TFrmLancItensGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if DataCompItem.DataSet.State in [dsInsert,dsEdit] then
  begin
    MessageDlg('É necessário confirmar ou cancelar os dados!!!', mtWarning, [mbOK], 0);
    Abort;
  end;

end;

procedure TFrmLancItensGrid.FormCreate(Sender: TObject);
begin
  inherited;
  // cria dataset temporario auxiliar
  if not CdsDadosComp.Active then
     CdsDadosComp.CreateDataSet;
  CdsDadosComp.EmptyDataSet;
  CdsDadosComp.Open;

end;

procedure TFrmLancItensGrid.DataListaProdutosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DmProdutos.Dados_ProdComposto(DataItens.DataSet.FieldByName('IDPRODUTO').AsInteger);
  ListaDetalhes(0);

end;

procedure TFrmLancItensGrid.VerificaDados;
begin
  //
end;

procedure TFrmLancItensGrid.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmLancItensGrid.GridGrupoCellClick(Column: TColumn);
begin
  inherited;
  DmProdutos.Dados_ProdutoAux;

end;

procedure TFrmLancItensGrid.AtualizaDadosCompItens;
var aIndice,aTotalM2,aValorM2:Double;
   aQuantidade : Double;
begin
  inherited;
  aQuantidade := 0;
  if DataProdutos.DataSet.FieldByName('TIPOPROD').AsInteger = 1 then // produto Composto
  begin
    if DataProdutos.DataSet.FieldByName('TIPO_PRODUTO').AsInteger = 0 then
       aIndice := sIndiceTijolo
    else if DataProdutos.DataSet.FieldByName('TIPO_PRODUTO').AsInteger = 1 then
       aIndice := sIndiceIsopor
    else if DataProdutos.DataSet.FieldByName('TIPO_PRODUTO').AsInteger = 2 then
       aIndice := sIndiceOutros;
    aTotalM2 := (DataCompItem.DataSet.FieldByName('QUANT_VIGAS').AsFloat*aIndice)*
                 DataCompItem.DataSet.FieldByName('COMPRIMENTO_VIGA').AsFloat;
    DataCompItem.DataSet.FieldByName('TOTAL_M2').AsFloat := TruncaValor(aTotalM2,2);
    aValorM2 := (DataCompItem.DataSet.FieldByName('TOTAL_M2').AsFloat*
                 DataItens.DataSet.FieldByName('VALOR').AsCurrency);
    DataCompItem.DataSet.FieldByName('VALOR_M2').AsFloat := TruncaValor(aValorM2,2);
  end;
  if not(DataItens.DataSet.State in [dsInsert,dsEdit]) then
     DataItens.DataSet.Edit;
  aQuantidade := RetornaQuantidadeItem;
  DataItens.DataSet.FieldByname('QUANTIDADE').AsCurrency  := aQuantidade;
  // lista quantidade de materiais
  ListaDetalhes(aQuantidade);

end;

procedure TFrmLancItensGrid.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  // total do pedido
  if not(DataItens.DataSet.State in [dsInsert,dsEdit]) then
     DataItens.DataSet.Edit;
  DataItens.DataSet.FieldByname('QUANTIDADE').AsCurrency  := RetornaQuantidadeItem;
  Grava_Dados(DataCompItem.DataSet);
  Close;
  
end;

procedure TFrmLancItensGrid.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  DataCompItem.DataSet.Cancel;
  Close;

end;

function TFrmLancItensGrid.RetornaQuantidadeItem: Double;
begin
  Result := 0;
  DataCompItem.DataSet.First;
  while not DataCompItem.DataSet.Eof do
  begin
    Result := Result + DataCompItem.DataSet.FieldByname('TOTAL_M2').AsFloat;
    DataCompItem.DataSet.Next;
  end;
  Result := TruncaValor(Result,2);
end;

end.
