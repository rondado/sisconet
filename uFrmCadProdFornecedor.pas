unit uFrmCadProdFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, StdCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, Mask, uFrameBotaoVertical, ExtCtrls, System.Actions;

type
  TFrmCadProdFornecedor = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    DbID: TDBEdit;
    Label2: TLabel;
    DbIDProduto: TDBEdit;
    Label3: TLabel;
    DbIDFornecedor: TDBEdit;
    Label4: TLabel;
    ComboFornecedor: TDBLookupComboBox;
    DataFornecedor: TDataSource;
    Panel1: TPanel;
    Frame: TFrameBotaoVertical;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure Retornar_Fornecedores;
  public
    { Public declarations }
    sIDProduto : Integer;
  end;

var
  FrmCadProdFornecedor: TFrmCadProdFornecedor;

implementation

Uses uLibrary, uDmWorkCom, uDmProdutos;

{$R *.dfm}

procedure TFrmCadProdFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet       := DmProdutos.CdsProdutoFornecedor;
  DataFornecedor.DataSet := DmWorkCom.CdsConsulta;
  DmProdutos.Dados_ProdFornecedor(sIDProduto);
  Retornar_Fornecedores;
  PageControl1.TabIndex := 0;
  DBGrid1.SetFocus;

end;

procedure TFrmCadProdFornecedor.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(DmProdutos.CdsProdutoFornecedor,DBGrid1,Column);

end;

procedure TFrmCadProdFornecedor.Retornar_Fornecedores;
begin
  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select contato.id,contato.nome from contato');
  DmWorkCom.QryConsulta.SQL.Add('where (contato.tipo_contato = '+QuotedStr('F'));
  DmWorkCom.QryConsulta.SQL.Add(' or contato.tipo_contato = '+QuotedStr('A')+')');
  DmWorkCom.CdsConsulta.FetchParams;
  DmWorkCom.CdsConsulta.Open;
  ComboFornecedor.ListSource := DataFornecedor;
  ComboFornecedor.ListField  := 'NOME';
  ComboFornecedor.KeyField   := 'ID';

end;

procedure TFrmCadProdFornecedor.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbIDFornecedor.SetFocus;

end;

procedure TFrmCadProdFornecedor.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);
   
end;

procedure TFrmCadProdFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataFornecedor.DataSet.Close;
  DataWork.DataSet.Close;
  
end;

end.
