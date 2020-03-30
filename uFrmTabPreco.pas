unit uFrmTabPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, Grids, DBGrids, DB, StdCtrls, ExtCtrls, DBCtrls,
  Buttons, FMTBcd, DBClient, Provider, SqlExpr, ActnList, Menus, System.Actions;

type
  TFrmTabPreco = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    DataTabela: TDataSource;
    GridTabela: TDBGrid;
    RadioTipo: TRadioGroup;
    GrpGrupo: TGroupBox;
    ComboGrupo: TDBLookupComboBox;
    ComboSubGrupo: TDBLookupComboBox;
    DataGrupo: TDataSource;
    DataSubGrupo: TDataSource;
    ChReajuste: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GrpCodRef: TGroupBox;
    GrpFornecedor: TGroupBox;
    EdtCodPro: TEdit;
    ComboFornecedor: TDBLookupComboBox;
    ActionList1: TActionList;
    ActLocalizar: TAction;
    ActEncerrar: TAction;
    DataFornecedor: TDataSource;
    GrpReajuste: TGroupBox;
    RadioAcreDes: TRadioGroup;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    EdtPerc: TEdit;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    ActReajustar: TAction;
    PopupMenu1: TPopupMenu;
    ReajustarPrecodeVenda1: TMenuItem;
    ReajustarPreosdevendadeprodutoscomposto1: TMenuItem;
    RadioPreco: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure RadioTipoClick(Sender: TObject);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure ChReajusteClick(Sender: TObject);
    procedure ActReajustarExecute(Sender: TObject);
    procedure ReajustarPrecodeVenda1Click(Sender: TObject);
    procedure ReajustarPreosdevendadeprodutoscomposto1Click(
      Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTabPreco: TFrmTabPreco;

implementation

Uses uLiBrary, uDmWorkCom, uDmProdutos, uDMClientes;

{$R *.dfm}

procedure TFrmTabPreco.FormShow(Sender: TObject);
begin
  inherited;
  DataTabela.DataSet     := DmProdutos.CdsTabela;
  DataGrupo.DataSet      := DmProdutos.CdsGrupo;
  DataSubGrupo.DataSet   := DmProdutos.CdsSubGrupo;
  DataFornecedor.DataSet := DmClientes.CdsCliForAux;
  DmProdutos.Dados_Grupo;
  DmClientes.Dados_CliFor('F');
  RadioTipoClick(Sender);
  ChReajusteClick(Sender);


end;

procedure TFrmTabPreco.RadioTipoClick(Sender: TObject);
begin
  inherited;
  GrpCodRef.Visible     := false;
  GrpGrupo.Visible      := false;
  GrpFornecedor.Visible := false;
  if (RadioTipo.ItemIndex = 0) or (RadioTipo.ItemIndex = 1) then // codigo/referencia
     GrpCodRef.Visible     := true
  else if RadioTipo.ItemIndex = 2 then // grupo/subgrupo
     GrpGrupo.Visible      := true
  else if RadioTipo.ItemIndex = 3 then // fornecedor
     GrpFornecedor.Visible := true;

end;

procedure TFrmTabPreco.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  //
  DmProdutos.CdsTabela.Close;
  DmProdutos.CdsTabela.Params.Clear;
  DmProdutos.QryTabela.Close;
  DmProdutos.QryTabela.SQL.Clear;
  DmProdutos.QryTabela.SQL.Add('select * from produtos');
  if RadioTipo.ItemIndex = 0 then // codigo
     DmProdutos.QryTabela.SQL.Add('where produtos.id = :pLocalizar')
  else if RadioTipo.ItemIndex = 1 then // referencia
     DmProdutos.QryTabela.SQL.Add('where produtos.referencia = :pLocalizar')
  else if RadioTipo.ItemIndex = 2 then // grupo/subgrupo
  begin
     DmProdutos.QryTabela.SQL.Add('where produtos.grupo = :pGrupo');
     if ComboSubGrupo.Text <> '' then
     begin
       DmProdutos.QryTabela.SQL.Add('and (produtos.subgrupo1 = :pSubGrupo');
       DmProdutos.QryTabela.SQL.Add(' or produtos.subgrupo2 = :pSubGrupo)');
     end;
  end
  else if RadioTipo.ItemIndex = 3 then // fornecedor
  begin
     DmProdutos.QryTabela.SQL.Add('left outer join produto_fornecedor on');
     DmProdutos.QryTabela.SQL.Add('produtos.id = produto_fornecedor.idproduto');
     DmProdutos.QryTabela.SQL.Add('where produto_fornecedor.idfornecedor = :pLocalizar');
  end;
  // parametros
  DmProdutos.CdsTabela.FetchParams;
  if RadioTipo.ItemIndex = 0 then // codigo
     DmProdutos.CdsTabela.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtCodPro.Text)
  else if RadioTipo.ItemIndex = 1 then // referencia
     DmProdutos.CdsTabela.Params.ParamByName('pLocalizar').AsString := EdtCodPro.Text
  else if RadioTipo.ItemIndex = 2 then // grupo/subgrupo
  begin
     DmProdutos.CdsTabela.Params.ParamByName('pGrupo').AsInteger    := DataGrupo.DataSet.FieldByName('ID').AsInteger;
     if ComboSubGrupo.Text <> '' then
        DmProdutos.CdsTabela.Params.ParamByName('pSubGrupo').AsInteger := DataSubGrupo.DataSet.FieldByName('ID').AsInteger;
  end
  else if RadioTipo.ItemIndex = 3 then // fornecedor
     DmProdutos.CdsTabela.Params.ParamByName('pLocalizar').AsInteger := DataFornecedor.DataSet.FieldByName('ID').AsInteger;
  //
  DmProdutos.CdsTabela.Open;

end;

procedure TFrmTabPreco.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  //
  close;

end;


procedure TFrmTabPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataTabela.DataSet.Close;
  DataGrupo.DataSet.Close;
  DataSubGrupo.DataSet.Close;
  DataFornecedor.DataSet.Close;

end;

procedure TFrmTabPreco.GridTabelaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
     Grava_Dados(DataTabela.DataSet);
end;

procedure TFrmTabPreco.ChReajusteClick(Sender: TObject);
begin
  inherited;
  if ChReajuste.Checked then
  begin
    GridTabela.Height    := 265;
    GrpReajuste.Visible  := true;
    ActReajustar.Enabled := true;
  end
  else
  begin
    GridTabela.Height    := 335;
    GrpReajuste.Visible  := false;
    ActReajustar.Enabled := false;
  end;

end;

procedure TFrmTabPreco.ActReajustarExecute(Sender: TObject);
var aVarReajuste, aPerc : Double;
begin
  inherited;
  //
  if EdtPerc.Text = '' then
  begin
    MessageDlg('É necessário informar o percentual de reajuste!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  try
    if StrToFloat(EdtPerc.Text) > 100 then
    begin
      MessageDlg('Reajuste não pode ser superior a 100%!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
    if StrToFloat(EdtPerc.Text) <= 0 then
    begin
      MessageDlg('Reajuste não pode ser 0%. Verifique!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  except
    MessageDlg('Erro ao informar o percentual. Válido apenas numeros.', mtWarning, [mbOK], 0);
    Abort;
  end;
  if (not DataTabela.DataSet.Active) or (DataTabela.DataSet.RecordCount = 0) then
  begin
    MessageDlg('É necessário selecionar os produtos a serem reajustados!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  aVarReajuste := 0;
  aPerc := StrToFloat(EdtPerc.Text);
  DataTabela.DataSet.First;
  while not DataTabela.DataSet.Eof do
  begin
    if RadioPreco.ItemIndex = 0 then // preco de compra
    begin
      if RadioAcreDes.ItemIndex = 0 then // acrescimo
         aVarReajuste := DataTabela.DataSet.FieldByName('PRECO_COMPRA').AsFloat * Retorna_IndicePercentual('P',aPerc)
      else if RadioAcreDes.ItemIndex = 1 then // Decrescimo
         aVarReajuste := DataTabela.DataSet.FieldByName('PRECO_COMPRA').AsFloat * Retorna_IndicePercentual('N',aPerc);
    end
    else if RadioPreco.ItemIndex = 1 then // preco de venda
    begin
      if RadioAcreDes.ItemIndex = 0 then // acrescimo
         aVarReajuste := DataTabela.DataSet.FieldByName('PRECO_VENDA').AsFloat * Retorna_IndicePercentual('P',aPerc)
      else if RadioAcreDes.ItemIndex = 1 then // Decrescimo
         aVarReajuste := DataTabela.DataSet.FieldByName('PRECO_VENDA').AsFloat * Retorna_IndicePercentual('N',aPerc);
    end;
    // grava o reajuste
    DataTabela.DataSet.Edit;
    if RadioPreco.ItemIndex = 0 then
       DataTabela.DataSet.FieldByName('PRECO_COMPRA').AsFloat := aVarReajuste
    else if RadioPreco.ItemIndex = 1 then
       DataTabela.DataSet.FieldByName('PRECO_VENDA').AsFloat := aVarReajuste;
    Grava_Dados(DataTabela.DataSet);
    DataTabela.DataSet.Next;
  end;

end;


procedure TFrmTabPreco.ReajustarPrecodeVenda1Click(Sender: TObject);
begin
  inherited;
  AtualizaPrecoProdutosComposto(1);

end;

procedure TFrmTabPreco.ReajustarPreosdevendadeprodutoscomposto1Click(
  Sender: TObject);
begin
  inherited;
  AtualizaPrecoProdutosComposto(0);

end;

end.
