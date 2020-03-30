unit uFrmRelGiroEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, ComCtrls, StdCtrls, uFrameConfirmaCancela,
  DB, DBCtrls, FMTBcd, SqlExpr, Datasnap.DBClient, Datasnap.Provider, frxClass,
  frxDBSet;

type
  TFrmRelGiroEstoque = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    RadioTipo: TRadioGroup;
    GrpGrupo: TGroupBox;
    GrpProduto: TGroupBox;
    DataProduto: TDataSource;
    DataGrupo: TDataSource;
    ComboProduto: TDBLookupComboBox;
    ComboGrupo: TDBLookupComboBox;
    RadioOrdem: TRadioGroup;
    frxReport1: TfrxReport;
    frxDbGiroProd: TfrxDBDataset;
    DspGiroProd: TDataSetProvider;
    CdsGiroProd: TClientDataSet;
    CdsGiroProdIDPRODUTO: TIntegerField;
    CdsGiroProdDESCRICAO: TStringField;
    CdsGiroProdESTOQUE_ATUAL: TFloatField;
    CdsGiroProdQTD_COMPRAS: TFloatField;
    CdsGiroProdVALOR_COMPRA: TFloatField;
    CdsGiroProdQTD_VENDA: TFloatField;
    CdsGiroProdVALOR_VENDA: TFloatField;
    procedure RadioTipoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    Linha,Pagina : Integer;
  public
    { Public declarations }
  end;

var
  FrmRelGiroEstoque: TFrmRelGiroEstoque;

implementation

Uses uLibrary,uDmWorkCom,uDmConexao, uDmProdutos, uDmAuxiliar, uDmRelatorios;

{$R *.dfm}

procedure TFrmRelGiroEstoque.RadioTipoClick(Sender: TObject);
begin
  inherited;
  GrpGrupo.Visible   := false;
  GrpProduto.Visible := false;
  if RadioTipo.ItemIndex = 1 then
     GrpGrupo.Visible := true
  else if RadioTipo.ItemIndex = 2 then
     GrpProduto.Visible := true;
     
end;

procedure TFrmRelGiroEstoque.FormShow(Sender: TObject);
begin
  inherited;
  DataProduto.DataSet := DmProdutos.CdsProdutoAux;
  DataGrupo.DataSet   := DmProdutos.CdsGrupo;
  DmProdutos.Dados_ProdutoAux;
  DmProdutos.Dados_Grupo;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);
  RadioTipoClick(Sender);

end;

procedure TFrmRelGiroEstoque.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  close;

end;

procedure TFrmRelGiroEstoque.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  if (RadioTipo.ItemIndex = 1) and (ComboGrupo.Text = '') then // grupo
  begin
    MessageDlg('É necessário selecionar o grupo!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if (RadioTipo.ItemIndex = 2) and (ComboProduto.Text = '') then // produto
  begin
    MessageDlg('É necessário selecionar o produto!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  with CdsGiroProd do
  begin
     Close;
     CommandText := 'select * from proc_giro_produto(:pIDEmpresa,:pTipo,:pIDGrupo,:pidproduto,:pOrdem,:pDatai,:pDataf)';
     Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
     Params.ParamByName('pTipo').AsInteger := RadioTipo.ItemIndex;
     Params.ParamByName('pIDGrupo').AsInteger := DataGrupo.DataSet.FieldByName('ID').AsInteger;
     Params.ParamByName('pidproduto').AsInteger := DataProduto.DataSet.FieldByName('ID').AsInteger;
     Params.ParamByName('pOrdem').AsInteger := RadioOrdem.ItemIndex;
     Params.ParamByName('pDatai').AsDate := Datai.Date;
     Params.ParamByName('pDataf').AsDate := Dataf.Date;
     Open;
  end;
  //
  DmRelatorios.PassaPeriodoRelatorio(Datai.Date,Dataf.Date);
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\GiroProduto.fr3');
  frxReport1.ShowReport();



end;


end.
