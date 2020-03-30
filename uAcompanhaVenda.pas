unit uAcompanhaVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, Data.DB, Data.SqlExpr,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmAcompanhaVenda = class(TForm)
    PageControl1: TPageControl;
    TbsTotais: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtTotalBruto: TEdit;
    EdtDescontos: TEdit;
    EdtTotalLiqu: TEdit;
    EdtTotalCupons: TEdit;
    QryGeral: TSQLQuery;
    DspGeral: TDataSetProvider;
    CdsTotais: TClientDataSet;
    CdsFormaPag: TClientDataSet;
    Timer1: TTimer;
    DsTotais: TDataSource;
    DsFormaPag: TDataSource;
    TbsCupons: TTabSheet;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    DsCupons: TDataSource;
    DsItens: TDataSource;
    CdsCupons: TClientDataSet;
    CdsItens: TClientDataSet;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox5: TGroupBox;
    DBGrid2: TDBGrid;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DsTotaisDataChange(Sender: TObject; Field: TField);
    procedure DsCuponsDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAcompanhaVenda: TfrmAcompanhaVenda;

implementation

{$R *.dfm}

uses ufrmDetalhaCupom, uLibrary, uDmConexao;

procedure TfrmAcompanhaVenda.DBGrid1DblClick(Sender: TObject);
begin
  AbreForm(TfrmDetalhaCupom,frmDetalhaCupom);
end;

procedure TfrmAcompanhaVenda.DsCuponsDataChange(Sender: TObject; Field: TField);
begin
  if CdsCupons.RecordCount > 0 then
  begin
    with CdsItens do
    begin
      Close;
      CommandText := 'select i.idproduto,i.descricao,i.quantidade,i.valor, '+
                     '       i.desconto,i.valor_total '+
                     'from pedido_itens i '+
                     'where i.idpedido = '+CdsCupons.FieldByName('ID').AsString;
      Open;
    end;
  end;
end;

procedure TfrmAcompanhaVenda.DsTotaisDataChange(Sender: TObject; Field: TField);
begin
  // formas de pagamento
  if CdsTotais.RecordCount > 0 then
  begin
    EdtTotalBruto.Text := FormatFloat('0.00',CdsTotais.FieldByName('VALOR_TOTAL').AsFloat);
    EdtDescontos.Text := FormatFloat('0.00',CdsTotais.FieldByName('DESCONTO').AsFloat);
    EdtTotalLiqu.Text := FormatFloat('0.00',CdsTotais.FieldByName('VALOR_LIQUIDO').AsFloat);
    EdtTotalCupons.Text := CdsTotais.FieldByName('QUANT_CUPONS').AsString;
    with CdsFormaPag do
    begin
      Close;
      CommandText := 'select f.descricao,sum(f.valor) as valor '+
                     'from pedido p '+
                     'inner join pedido_formapag f on p.id = f.idpedido '+
                     'where p.idempresa = '+CdsTotais.FieldByName('ID_EMPRESA').AsString+' '+
                     'and p.caixa = '+QuotedStr(CdsTotais.FieldByName('CAIXA').AsString)+' '+
                     'and p.data_entrega = current_date '+
                     'group by f.descricao';
      Open;
    end;
    //
    with CdsCupons do
    begin
      Close;
      CommandText := 'select c.id,c.coo,c.data_entrega,c.cliente,c.valor_total '+
                     'from pedido c '+
                     'where c.idempresa = '+CdsTotais.FieldByName('ID_EMPRESA').AsString+' '+
                     'and c.caixa = '+QuotedStr(CdsTotais.FieldByName('CAIXA').AsString)+' '+
                     'and c.data_entrega = current_date';
      Open;
    end;
  end;

end;

procedure TfrmAcompanhaVenda.FormCreate(Sender: TObject);
begin
  Self.Caption := 'Acompanhamento de Venda Diária. Data atual: '+FormatDateTime('dd/mm/yyyy',Now);
end;

procedure TfrmAcompanhaVenda.FormShow(Sender: TObject);
begin
//  frmAcompanhaVenda.Caption := 'Acompanhamento de Venda Diária. Data: '+FormatDateTime('dd/mm/yyyy',Now);
  Timer1Timer(Sender);
end;

procedure TfrmAcompanhaVenda.Timer1Timer(Sender: TObject);
begin
  try
    Timer1.Enabled := false;
    with CdsTotais do
    begin
      Close;
      CommandText := 'select * from proc_acompanhamento_venda';
      Open;
    end;
    Timer1.Enabled := true;
  except
    on E:Exception do
    begin
      Timer1.Enabled := true;
      ShowMessage(E.Message);
    end;
  end;
end;

end.
