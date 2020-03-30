unit uAjustePreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, Datasnap.DBClient;

type
  TfrmAjustePreco = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    DataProduto: TDataSource;
    Label2: TLabel;
    EdtGTin: TEdit;
    GrpDados: TGroupBox;
    Label7: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    dbedtDESCRICAO: TDBEdit;
    dbedtESTOQUE: TDBEdit;
    dbedtPRECO_COMPRA: TDBEdit;
    dbedtMARGEM_LUCRO: TDBEdit;
    dbedtPRECO_VENDA: TDBEdit;
    dbedtPRECO_PROMOCAO: TDBEdit;
    dbedtDT_INI_PROMO: TDBEdit;
    dbedtDT_FIM_PROMO: TDBEdit;
    CdsEntrada: TClientDataSet;
    CdsEntradaENTRADA: TFloatField;
    DsEntrada: TDataSource;
    DBEdit1: TDBEdit;
    DataEstoque: TDataSource;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label46: TLabel;
    DbFrete: TDBEdit;
    DbCustOp: TDBEdit;
    DbOutrDesp: TDBEdit;
    DbAliqssimples: TDBEdit;
    edvendasemcalc: TEdit;
    Label11: TLabel;
    procedure EdtGTinExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdtGTinKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure edvendasemcalcKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAjustePreco: TfrmAjustePreco;

implementation

{$R *.dfm}

uses uDmWorkCom, uLibrary, uFrmProdutos, uDmProdutos;

procedure TfrmAjustePreco.Button1Click(Sender: TObject);
var
aliqsSimples: string;

begin
  if DataProduto.DataSet.State in [dsInsert,dsEdit] then
  begin
//fabricio inicio
if DmProdutos.CdsProdutosPRECO_COMPRA.IsNull then
begin
   ShowMessage ('É necessário informar um valor para o preço de compra');
   exit;
end;
if DmProdutos.CdsProdutosMARGEM_LUCRO.IsNull then
   DmProdutos.CdsProdutosMARGEM_LUCRO.AsCurrency :=0;

if DmProdutos.CdsProdutosFRETE.IsNull then
   DmProdutos.CdsProdutosFRETE.AsCurrency := 0;

if DmProdutos.CdsProdutosOUTRAS_DESP.IsNull then
   DmProdutos.CdsProdutosOUTRAS_DESP.AsCurrency := 0;

if DmProdutos.CdsProdutosCUSTO_OPER.IsNull then
   DmProdutos.CdsProdutosCUSTO_OPER.AsCurrency := 0;

if DmProdutos.CdsProdutosALIQ_SSIMPLES.IsNull then
   DmProdutos.CdsProdutosALIQ_SSIMPLES.AsCurrency := 0;

DbedtPreco_Venda.Text:=FloatToStr((DmProdutos.CdsProdutosPRECO_COMPRA.AsFloat * DmProdutos.CdsProdutosMARGEM_LUCRO.AsFloat /100));

aliqsSimples:= FloatToStr(((DmProdutos.CdsProdutosPRECO_COMPRA.AsFloat
                                   + (DmProdutos.CdsProdutosPRECO_COMPRA.AsFloat * DmProdutos.CdsProdutosMARGEM_LUCRO.AsFloat /100))
                                   * ((1 +(DmProdutos.CdsProdutosFRETE.AsFloat
                                   +  DmProdutos.CdsProdutosOUTRAS_DESP.AsFloat
                                   +  DmProdutos.CdsProdutosCUSTO_OPER.AsFloat) /100)))
                                   *  (DmProdutos.CdsProdutosALIQ_SSIMPLES.AsFloat / 100));

DbedtPreco_Venda.Text:= FloatToStr(((DmProdutos.CdsProdutosPRECO_COMPRA.AsFloat
                                   + StrToFloat(DbedtPreco_Venda.Text))
                                   * ((1 +(DmProdutos.CdsProdutosFRETE.AsFloat
                                   +  DmProdutos.CdsProdutosOUTRAS_DESP.AsFloat
                                   +  DmProdutos.CdsProdutosCUSTO_OPER.AsFloat) /100)))
                                   +  (StrToFloat(aliqsSimples)));

//fabricio fim
    Grava_Dados(DataProduto.DataSet);
  end;


if edvendasemcalc.Text <> '' then
begin
  DataProduto.DataSet.Edit;
  DbedtPreco_Venda.Text := edvendasemcalc.Text;
  Grava_Dados(DataProduto.DataSet);
end;

  // movimenta o estoque
  if CdsEntrada.State in [dsinsert,dsedit] then
     CdsEntrada.Post;
  if CdsEntradaENTRADA.AsFloat <> 0 then
  begin
    if DmProdutos.Dados_Estoque(DataProduto.DataSet.FieldByname('ID').AsInteger,sIDEmpresa) then
    begin
      if not(DmProdutos.CdsEstoque.State in [dsInsert,dsedit]) then
         DmProdutos.CdsEstoque.Edit;
      DmProdutos.CdsEstoque.FieldByName('QUANTIDADE').AsFloat := DmProdutos.CdsEstoque.FieldByName('QUANTIDADE').AsFloat +
                                                                 CdsEntradaENTRADA.AsFloat;
      Grava_Dados(DmProdutos.CdsEstoque);
    end;
    CdsEntrada.Edit;
    CdsEntradaENTRADA.AsFloat := 0;
    CdsEntrada.Post;
  end;
  DmProdutos.Dados_Produto(-1);
  DmProdutos.Dados_Estoque(-1,sIDEmpresa);
  GrpDados.Enabled := false;
  EdtGTin.Clear;
  EdtGTin.SetFocus;
  edvendasemcalc.Text:='';
end;

procedure TfrmAjustePreco.Button2Click(Sender: TObject);
begin
  if DataProduto.DataSet.Active then
  begin
    if DataProduto.DataSet.State in [dsInsert,dsEdit] then
       DataProduto.DataSet.Cancel;
    //
    DataProduto.DataSet.Close;
  end;
  Close;
end;

procedure TfrmAjustePreco.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
   edvendasemcalc.SetFocus;
end;

procedure TfrmAjustePreco.EdtGTinExit(Sender: TObject);
begin
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
    begin
      DmProdutos.Dados_Estoque(DataProduto.DataSet.FieldByName('id').AsInteger,
                              sIDEmpresa);
      GrpDados.Enabled := true;
      Dbedit1.SetFocus;
    end;
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
          GrpDados.Enabled := true;
          Dbedit1.SetFocus;
        end;
      finally
        FreeAndNil(FrmProdutos);
//fabricio inicio
        DbEdit1.SetFocus;
//fabricio fim

      end;
    end
    else
    close;
  end;

end;

procedure TfrmAjustePreco.EdtGTinKeyPress(Sender: TObject; var Key: Char);
begin
if key=#27 then
close
else
  TabEnter(Self,Key);
end;

procedure TfrmAjustePreco.edvendasemcalcKeyPress(Sender: TObject;
  var Key: Char);
begin
if key = #13 then
   Button1.SetFocus;
end;

procedure TfrmAjustePreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataProduto.DataSet.Close;
  DataEstoque.DataSet.Close;
end;

procedure TfrmAjustePreco.FormCreate(Sender: TObject);
begin
  if not CdsEntrada.Active then
     CdsEntrada.CreateDataSet;
  CdsEntrada.EmptyDataSet;
end;

procedure TfrmAjustePreco.FormShow(Sender: TObject);
begin
  CdsEntrada.Append;
  CdsEntradaENTRADA.AsFloat := 0;
  CdsEntrada.Post;
  GrpDados.Enabled := false;
  DataProduto.DataSet := DmProdutos.CdsProdutos;
  DataEstoque.DataSet := DmProdutos.CdsEstoque;
  EdtGTin.SetFocus;
end;

end.
