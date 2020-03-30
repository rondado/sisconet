unit uFrmLivroLMCProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.DBCtrls, Data.DB,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.Buttons;

type
  TFrmLivroLMCProd = class(TFrmPadrao)
    DataProdutos: TDataSource;
    ActionList1: TActionList;
    ActConfirmar: TAction;
    ActCancelar: TAction;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Produto: TLabel;
    DataMovto: TDateTimePicker;
    DBLookupComboBox1: TDBLookupComboBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDProduto : Integer;
    sDataMov : TDateTime;
  end;

var
  FrmLivroLMCProd: TFrmLivroLMCProd;

implementation

{$R *.dfm}

uses uDmProdutos;

procedure TFrmLivroLMCProd.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  sIDProduto := 0;
  Close;

end;

procedure TFrmLivroLMCProd.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  if DataProdutos.DataSet.RecordCount > 0 then
  begin
    sIDProduto := DataProdutos.DataSet.FieldByName('ID').AsInteger;
    sDataMov   := DataMovto.Date;
  end;
  Close;

end;

procedure TFrmLivroLMCProd.FormCreate(Sender: TObject);
begin
  inherited;
  sIDProduto := 0;

end;

procedure TFrmLivroLMCProd.FormShow(Sender: TObject);
begin
  inherited;
  DataProdutos.DataSet := DmProdutos.CdsProdutos;
  DmProdutos.Dados_ProdutoPosto;
  DataMovto.Date := Now;
  DataMovto.SetFocus;

end;

end.
