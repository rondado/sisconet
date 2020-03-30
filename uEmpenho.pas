unit uEmpenho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, Datasnap.DBClient;

type
  Tfrmempenho = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    DataProduto: TDataSource;
    Label2: TLabel;
    EdtGTin: TEdit;
    DbDescricao: TDBEdit;
    DataEmpenho: TDataSource;
    Label7: TLabel;
    DbTabela: TDBEdit;
    Label9: TLabel;
    DbMargem: TDBEdit;
    Label10: TLabel;
    DbPreco: TDBEdit;
    Label6: TLabel;
    DbQuantidade: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure EdtGTinExit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdtGTinKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edvendasemcalcKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DbQuantidadeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmempenho: Tfrmempenho;
  ok: boolean;


implementation

{$R *.dfm}

uses uDmWorkCom, uLibrary, uFrmProdutos, uDmProdutos;

procedure Tfrmempenho.Button1Click(Sender: TObject);
begin
 if (DataProduto.DataSet.RecordCount > 0) and
     (ok = true) then
 begin


      if DataEmpenho.DataSet.FieldByName('TABELA').AsString = '' then
      begin
         ShowMessage('É Necessário informar um valor para a Tabela de Preços');
         Abort;
      end;
      if DataEmpenho.DataSet.FieldByName('MARGEM').AsString = '' then
         DataEmpenho.DataSet.FieldByName('MARGEM').AsInteger:=0;

      if (DataEmpenho.DataSet.FieldByName('PRECO').AsString = '') and
         (DataEmpenho.DataSet.FieldByName('MARGEM').AsInteger=0) then
      begin
         ShowMessage('É Necessário informar um valor para o Preço do Produto ou a Margem não pode ser 0');
         Abort;
      end;
      if DataEmpenho.DataSet.FieldByName('QTDE').AsString = '' then
      begin
         DataEmpenho.DataSet.FieldByName('QTDE').AsString:='0';
      end;

      if not (DataEmpenho.DataSet.State in [dsInsert,dsEdit]) then
         DataEmpenho.DataSet.Append;

      Grava_Dados(DataEmpenho.DataSet);
      EdtGTin.Text:= '';
      EdtGTin.SetFocus;
      ok:=false;

 end;
end;

procedure Tfrmempenho.Button2Click(Sender: TObject);
begin
  if DataEmpenho.DataSet.Active then
  begin
    if DataEmpenho.DataSet.State in [dsInsert,dsEdit] then
       DataEmpenho.DataSet.Cancel;
    //
    DataEmpenho.DataSet.Close;
  end;
  Close;
end;

procedure Tfrmempenho.DbQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  TabEnter(Self,Key);
end;

procedure Tfrmempenho.EdtGTinExit(Sender: TObject);

begin
  ok:=false;
  if EdtGTin.Text <> '' then
  begin
    if Length(Trim(FiltraNumero(EdtGTin.Text))) < 5 then
       DmProdutos.Dados_Produto(StrToInt(Trim(FiltraNumero(EdtGTin.Text))))
    else
       DmProdutos.Dados_Produto(EdtGTin.Text);
    //
    if DataProduto.DataSet.RecordCount <= 0 then
    begin
      ShowMessage('Produto não encontrado!');
      EdtGTin.SelectAll;
      EdtGTin.SetFocus;
    end
    else
    ok:=true;
  end
  else
  begin
    if Confirmacao('Pesquisar produtos?') then
    begin
      Application.CreateForm(TFrmProdutos,FrmProdutos);
      try
        FrmProdutos.sIDProd := 0;
        FrmProdutos.sApenasConsulta := true;
        FrmProdutos.ShowModal;
        if FrmProdutos.sIDProd > 0 then
        begin
          EdtGTin.Text := IntToStr(FrmProdutos.sIDProd);
          DmProdutos.Dados_Produto(FrmProdutos.sIDProd);
          ok:=true;
        end;
      finally
        FreeAndNil(FrmProdutos);
      end;
    end;
  end;

      if (DataProduto.DataSet.RecordCount > 0) and
         (ok = true) then
      begin
         DataEmpenho.DataSet.Active:=true;
         DataEmpenho.DataSet.Open;
         DataEmpenho.DataSet.Append;
         DataEmpenho.DataSet.FieldByName('DESCRICAO').AsString := DmProdutos.CdsProdutosDESCRICAO.AsString;
         DataEmpenho.DataSet.FieldByName('IDPRODUTO').AsString := DmProdutos.CdsProdutosID.AsString;
         Label4.Caption:= 'R$ '+FormatFloat('###0.00',StrToCurr(DmProdutos.CdsProdutosPRECO_VENDA.AsString));
      end;

end;

procedure Tfrmempenho.EdtGTinKeyPress(Sender: TObject; var Key: Char);
begin
  TabEnter(Self,Key);
end;

procedure Tfrmempenho.edvendasemcalcKeyPress(Sender: TObject;
  var Key: Char);
begin
if key = #13 then
   Button1.SetFocus;
end;

procedure Tfrmempenho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataProduto.DataSet.Close;
  DataEmpenho.DataSet.Close;
end;

procedure Tfrmempenho.FormShow(Sender: TObject);
begin
  DataProduto.DataSet := DmProdutos.CdsProdutos;
  DataEmpenho.DataSet := DmProdutos.CdsEmpenho;
end;

end.
