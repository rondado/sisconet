unit uFrmProdComposto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, ExtCtrls, DBCtrls, StdCtrls,
  Mask, Grids, DBGrids, ComCtrls, ActnList, DB, System.Actions;

type
  TFrmProdComposto = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DbID: TDBEdit;
    DbIDProduto: TDBEdit;
    DbQuantidade: TDBEdit;
    ComboProduto: TDBLookupComboBox;
    Panel1: TPanel;
    Frame: TFrameBotaoVertical;
    Dataproduto: TDataSource;
    DbUnidade: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DbValor: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActIncluirExecute(Sender: TObject);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure MostraProdutos;
  public
    { Public declarations }
    sIdProduto : Integer;
  end;

var
  FrmProdComposto: TFrmProdComposto;

implementation

uses uLibrary,uDmWorkCom, uDmProdutos;

{$R *.dfm}

procedure TFrmProdComposto.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet    := DmProdutos.CdsProdutoComposto;
  Dataproduto.DataSet := DmWorkCom.CdsConsulta;
  DmProdutos.Dados_ProdComposto(sIdProduto);
  PageControl1.TabIndex := 0;
  MostraProdutos;

end;

procedure TFrmProdComposto.MostraProdutos;
begin
  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select produtos.id,produtos.descricao,');
  DmWorkCom.QryConsulta.SQL.Add('produtos.unidade,produtos.PRECO_COMPRA from produtos');
  DmWorkCom.QryConsulta.SQL.Add('order by produtos.descricao');
  //
  DmWorkCom.CdsConsulta.FetchParams;
  DmWorkCom.CdsConsulta.Open;
  //
  ComboProduto.ListSource := Dataproduto;
  ComboProduto.ListField  := 'DESCRICAO';
  ComboProduto.KeyField   := 'ID';

end;

procedure TFrmProdComposto.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);

end;

procedure TFrmProdComposto.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbIDProduto.SetFocus;

end;

procedure TFrmProdComposto.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmProdComposto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Dataproduto.DataSet.Close;
  DataWork.DataSet.Close;
end;

procedure TFrmProdComposto.ActConfirmarExecute(Sender: TObject);
begin
  DataWork.DataSet.FieldByName('UNIDADE').AsString := Dataproduto.DataSet.FieldByname('UNIDADE').AsString;
  DataWork.DataSet.FieldByName('VALOR').AsCurrency := DataWork.DataSet.FieldByName('QUANTIDADE').AsCurrency * Dataproduto.DataSet.FieldByname('PRECO_COMPRA').AsCurrency;
  inherited;

end;

end.
