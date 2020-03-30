unit uConsEmpenho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, Datasnap.DBClient, Data.FMTBcd, Vcl.ExtCtrls, Data.SqlExpr,
  Datasnap.Provider, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmConsempenho = class(TForm)
    Label7: TLabel;
    DBGrid1: TDBGrid;
    CdsEmpenho: TClientDataSet;
    CdsEmpenhoID: TIntegerField;
    CdsEmpenhoIDPRODUTO: TIntegerField;
    CdsEmpenhoTABELA: TIntegerField;
    CdsEmpenhoMARGEM: TFloatField;
    CdsEmpenhoPRECO: TFloatField;
    CdsEmpenhoQTDE: TFloatField;
    CdsEmpenhoDESCRICAO: TStringField;
    DspEmpenho: TDataSetProvider;
    QryEmpenho: TSQLQuery;
    QryEmpenhoID: TIntegerField;
    QryEmpenhoIDPRODUTO: TIntegerField;
    QryEmpenhoTABELA: TIntegerField;
    QryEmpenhoMARGEM: TFloatField;
    QryEmpenhoPRECO: TFloatField;
    QryEmpenhoQTDE: TFloatField;
    QryEmpenhoDESCRICAO: TStringField;
    DataEmpenhos: TDataSource;
    SbLocalizar: TBitBtn;
    Edit1: TEdit;
    QryEmpenhoTOT: TFloatField;
    CdsEmpenhoTOT: TFloatField;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    procedure SbLocalizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit2Enter(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsempenho: TfrmConsempenho;
  ok: boolean;


implementation

{$R *.dfm}

uses uDmWorkCom, uLibrary, uFrmProdutos, uDmProdutos;

procedure TfrmConsempenho.BitBtn1Click(Sender: TObject);
begin
if CdsEmpenho.RecordCount > 0 then
begin
   CdsEmpenho.Delete;
   Grava_Dados(DataEmpenhos.DataSet);
   SbLocalizar.Click;

end;

end;

procedure TfrmConsempenho.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if CdsEmpenho.RecordCount > 0 then
   CdsEmpenho.Post;
   TabEnter(Self,Key);
end;

procedure TfrmConsempenho.DBEdit2Enter(Sender: TObject);
begin
if CdsEmpenho.RecordCount > 0 then
   CdsEmpenho.Edit;
end;

procedure TfrmConsempenho.DBEdit2Exit(Sender: TObject);
begin
if CdsEmpenho.RecordCount > 0 then
begin
   CdsEmpenhoMargem.AsString := DbEdit2.Text;
   CdsEmpenhoPreco.AsString := DbEdit3.Text;
   CdsEmpenhoQtde.AsString := DbEdit4.Text;
   CdsEmpenhoDescricao.AsString := DbEdit6.Text;
   Grava_Dados(DataEmpenhos.DataSet);
   SbLocalizar.Click;

end;
end;

procedure TfrmConsempenho.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  TabEnter(Self,Key);
end;

procedure TfrmConsempenho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CdsEmpenho.Close;
end;

procedure TfrmConsempenho.SbLocalizarClick(Sender: TObject);
var
Totg: Currency;
begin

  CdsEmpenho.Close;
  CdsEmpenho.Params.Clear;
  QryEmpenho.SQL.Clear;
  QryEmpenho.SQL.Add('select id, idproduto, tabela, margem, preco, qtde, descricao, ');
  QryEmpenho.SQL.Add('(preco * qtde) as tot from empenho ');
 if Edit1.Text <> '' then
 begin
    QryEmpenho.SQL.Add('where empenho.tabela = :pID ');
    CdsEmpenho.FetchParams;
    CdsEmpenho.Params.ParamByName('pID').AsString  := Edit1.Text;
 end
 else
 begin
    QryEmpenho.SQL.Add('where empenho.tabela > :pID ');
    CdsEmpenho.FetchParams;
    CdsEmpenho.Params.ParamByName('pID').AsString  := '0';
 end;

  CdsEmpenho.Open;

  if CdsEmpenho.RecordCount > 0 then
  begin
      totg:=0;
      CdsEmpenho.First;
      while not CdsEmpenho.Eof do
      begin
      Totg:= Totg + (CdsEmpenhoPreco.AsCurrency * CdsEmpenhoQtde.AsCurrency);
      CdsEmpenho.Next;
      end;
      Label2.Caption:= FormatFloat('R$ #,##0.00',totg);
  end
  else
  ShowMessage('Não Encontrou Registros');

  Edit1.SetFocus;
end;

end.
