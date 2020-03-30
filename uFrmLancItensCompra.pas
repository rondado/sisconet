unit uFrmLancItensCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, ActnList, uFrameConfirmaCancela, ExtCtrls,
  StdCtrls, Mask, DBCtrls, System.Actions;

type
  TFrmLancItensCompra = class(TFrmPadrao)
    DataItens: TDataSource;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    DbIDProduto: TDBEdit;
    Label4: TLabel;
    DbDescricao: TDBEdit;
    Label5: TLabel;
    DbQuantidade: TDBEdit;
    Label6: TLabel;
    DbValor: TDBEdit;
    Label7: TLabel;
    DbDesconto: TDBEdit;
    Label8: TLabel;
    DbAcrescimo: TDBEdit;
    Label9: TLabel;
    DbTotal: TDBEdit;
    Panel1: TPanel;
    Frame: TFrameConfirmaCancela;
    ActionList1: TActionList;
    ActConfirmar: TAction;
    ActCancelar: TAction;
    ActCalculaValorTotal: TAction;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    DBEdit3: TDBEdit;
    Label11: TLabel;
    DBEdit4: TDBEdit;
    Label12: TLabel;
    DBEdit5: TDBEdit;
    Label13: TLabel;
    DBEdit6: TDBEdit;
    Label14: TLabel;
    DBEdit7: TDBEdit;
    Label15: TLabel;
    DBEdit8: TDBEdit;
    Label16: TLabel;
    DBEdit9: TDBEdit;
    Label17: TLabel;
    DBEdit10: TDBEdit;
    Label18: TLabel;
    DBEdit11: TDBEdit;
    Label19: TLabel;
    DBEdit12: TDBEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    DBEdit16: TDBEdit;
    Label24: TLabel;
    DBEdit17: TDBEdit;
    Label25: TLabel;
    DBEdit18: TDBEdit;
    Label26: TLabel;
    DBEdit19: TDBEdit;
    Label27: TLabel;
    DBEdit20: TDBEdit;
    Label28: TLabel;
    DBEdit21: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DataCFOP: TDataSource;
    DBComboBox2: TDBComboBox;
    DBComboBox3: TDBComboBox;
    DBComboBox4: TDBComboBox;
    Label29: TLabel;
    DBEdit1: TDBEdit;
    DataCompra: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure DbIDProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure DbIDProdutoExit(Sender: TObject);
    procedure ActCalculaValorTotalExecute(Sender: TObject);
    procedure DbQuantidadeExit(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit11Exit(Sender: TObject);
    procedure DBEdit12Exit(Sender: TObject);
    procedure DBEdit18Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UF_Fornecedor : String;
  end;

var
  FrmLancItensCompra: TFrmLancItensCompra;

implementation

Uses uLibrary, uDmWorkCom, uFrmProdutos, uDmPosto, uDmProdutos;

{$R *.dfm}

procedure TFrmLancItensCompra.FormShow(Sender: TObject);
begin
  inherited;
  DataItens.DataSet  := DmWorkCom.CdsComprasItens;
  DataCFOP.DataSet   := DmWorkCom.CdsCFOP;
  DataCompra.DataSet := DmWorkCom.CdsCompras;
  DmWorkCom.Dados_CFOP;
  DbIDProduto.SetFocus;
  
end;

procedure TFrmLancItensCompra.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  //
  DataItens.DataSet.post;
  Grava_Dados(DataItens.DataSet);
  close;

end;

procedure TFrmLancItensCompra.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  //
  DataItens.DataSet.Cancel;
  Grava_Dados(DataItens.DataSet);
  close;

end;

procedure TFrmLancItensCompra.DbIDProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmLancItensCompra.DbIDProdutoExit(Sender: TObject);
var CST, CFOP : String;
    ALIQUOTA, REDUCAOBASE : Double;
begin
  inherited;
  if DbIDProduto.Text <> '' then
  begin
    if DmProdutos.Dados_Produto(StrToInt(DbIDProduto.Text)) then
    begin
      DmWorkCom.RetornaCSTCFOPItemCompra(CST,CFOP,ALIQUOTA,REDUCAOBASE,UF_Fornecedor,
                                         DataItens.DataSet.FieldByName('IDPRODUTO').AsInteger);
      DataItens.DataSet.FieldByName('DESCRICAO').AsString   := DmProdutos.CdsProdutosDESCRICAO.AsString;
      DataItens.DataSet.FieldByName('VALOR').AsFloat        := DmProdutos.CdsProdutosPRECO_COMPRA.AsFloat;
      DataItens.DataSet.FieldByName('CST').AsString         := CST;
      DataItens.DataSet.FieldByName('CFOP').AsString        := CFOP;
      DataItens.DataSet.FieldByName('REDUCAO_BASE').AsFloat := REDUCAOBASE;
      DataItens.DataSet.FieldByName('ALIQ_ICMS').AsFloat    := ALIQUOTA;
      DataItens.DataSet.FieldByName('ALIQ_ICMS_ST').AsFloat := ALIQUOTA;
      DataItens.DataSet.FieldByName('ALIQ_IPI').AsFloat     := DmProdutos.CdsProdutosALIQUOTA_IPI.AsFloat;
      DataItens.DataSet.FieldByName('ALIQ_PIS').AsFloat     := DmProdutos.CdsProdutosALIQUOTA_PIS.AsFloat;
      DataItens.DataSet.FieldByName('ALIQ_COFINS').AsFloat  := DmProdutos.CdsProdutosALIQUOTA_COFINS.AsFloat;
      DataItens.DataSet.FieldByName('MVA').AsFloat          := DmProdutos.CdsProdutosMVA.AsFloat;
    end
    else
    begin
      MessageDlg('Produto não encontrado. Verifique!!!', mtWarning, [mbOK], 0);
      DbIDProduto.SetFocus;
      Abort;
    end;
  end
  else
  begin
    FrmProdutos.sIDProd := 0;
    FrmProdutos.sApenasConsulta := true;
    FrmProdutos.ShowModal;
    if FrmProdutos.sIDProd > 0 then
    begin
      DataItens.DataSet.FieldByName('IDPRODUTO').AsInteger := FrmProdutos.sIDProd;
      DbIDProduto.SetFocus;
    end;
  end;
end;

procedure TFrmLancItensCompra.ActCalculaValorTotalExecute(Sender: TObject);
var aTotalItem : Double;
begin
  inherited;
  aTotalItem := 0;
  aTotalItem := DataItens.DataSet.FieldByName('QUANTIDADE').AsFloat*
                DataItens.DataSet.FieldByName('VALOR').AsFloat+
                DataItens.DataSet.FieldByName('ACRESCIMO').AsFloat-
                DataItens.DataSet.FieldByName('DESCONTO').AsFloat;
  DataItens.DataSet.FieldByName('VALOR_TOTAL').AsFloat  := aTotalItem;
  DataItens.DataSet.FieldByName('BASE_ICMS').AsFloat    := aTotalItem;
  DataItens.DataSet.FieldByName('BASE_ICMS_ST').AsFloat := aTotalItem;
  DataItens.DataSet.FieldByName('BASE_IPI').AsFloat     := aTotalItem;
  DataItens.DataSet.FieldByName('BASE_PIS').AsFloat     := aTotalItem;
  DataItens.DataSet.FieldByName('BASE_COFINS').AsFloat  := aTotalItem;
end;

procedure TFrmLancItensCompra.DbQuantidadeExit(Sender: TObject);
var Capacidade, Estoque : Double;
begin
  inherited;
  if DmProdutos.CdsProdutosCOMBUSTIVEL.AsString = 'S' then
  begin
    Capacidade := DmPosto.RetornaCapacidadeTanque(DmProdutos.CdsProdutosID.AsInteger);
    Estoque    := Retorna_EstoqueAtual(DmProdutos.CdsProdutosID.AsInteger);
    if (DataItens.DataSet.FieldByName('QUANTIDADE').AsFloat + Estoque) > Capacidade then
    begin
      MessageDlg('A quantidade informada irá exceder a capacidade do tanque. Verifique!',mtWarning,[mbOK],0);
      DbQuantidade.SelectAll;
      DbQuantidade.SetFocus;
      Abort;
    end;
  end;
  ActCalculaValorTotalExecute(Sender);

end;

procedure TFrmLancItensCompra.DBEdit3Exit(Sender: TObject);
var aValorICMS : Double;
begin
  inherited;
  if DataItens.DataSet.FieldByName('ALIQ_ICMS').AsFloat > 0 then
  begin
    aValorICMS := ((DataItens.DataSet.FieldByName('BASE_ICMS').AsFloat * DataItens.DataSet.FieldByName('ALIQ_ICMS').AsFloat) / 100);
    DataItens.DataSet.FieldByName('VALOR_ICMS').AsFloat := aValorICMS;
  end;

end;

procedure TFrmLancItensCompra.DBEdit6Exit(Sender: TObject);
var aBaseCalculo : Double;
begin
  inherited;
  // se tiver redução na base, aplica
  aBaseCalculo := DataItens.DataSet.FieldByName('VALOR_TOTAL').AsFloat;
  if DataItens.DataSet.FieldByName('REDUCAO_BASE').AsFloat > 0 then
  begin
    aBaseCalculo := TruncaValor((aBaseCalculo * ((100-DataItens.DataSet.FieldByName('REDUCAO_BASE').AsFloat)/100)),2);
  end;
  DataItens.DataSet.FieldByName('BASE_ICMS').AsFloat   := aBaseCalculo;
  DataItens.DataSet.FieldByName('BASE_IPI').AsFloat    := aBaseCalculo;
  DataItens.DataSet.FieldByName('BASE_PIS').AsFloat    := aBaseCalculo;
  DataItens.DataSet.FieldByName('BASE_COFINS').AsFloat := aBaseCalculo;

end;

procedure TFrmLancItensCompra.DBEdit7Exit(Sender: TObject);
var aValorICMS, aBaseCalculo : Double;
begin
  inherited;
  if DataItens.DataSet.FieldByName('ALIQ_ICMS_ST').AsFloat > 0 then
  begin
    aBaseCalculo := DataItens.DataSet.FieldByName('BASE_ICMS_ST').AsFloat;
    aBaseCalculo := ((aBaseCalculo*DataItens.DataSet.FieldByName('MVA').AsFloat)/100)+aBaseCalculo;
    aValorICMS   := ((DataItens.DataSet.FieldByName('BASE_ICMS_ST').AsFloat * DataItens.DataSet.FieldByName('ALIQ_ICMS_ST').AsFloat) / 100);
    DataItens.DataSet.FieldByName('VALOR_ICMS_ST').AsFloat := aValorICMS;
  end;

end;

procedure TFrmLancItensCompra.DBEdit11Exit(Sender: TObject);
var aValorIPI : Double;
begin
  inherited;
  if DataItens.DataSet.FieldByName('ALIQ_IPI').AsFloat > 0 then
  begin
    aValorIPI := ((DataItens.DataSet.FieldByName('BASE_IPI').AsFloat * DataItens.DataSet.FieldByName('ALIQ_IPI').AsFloat) / 100);
    DataItens.DataSet.FieldByName('VALOR_IPI').AsFloat := aValorIPI;
  end;

end;

procedure TFrmLancItensCompra.DBEdit12Exit(Sender: TObject);
var aValorPIS : Double;
begin
  inherited;
  if DataItens.DataSet.FieldByName('ALIQ_PIS').AsFloat > 0 then
  begin
    aValorPIS := ((DataItens.DataSet.FieldByName('BASE_PIS').AsFloat * DataItens.DataSet.FieldByName('ALIQ_PIS').AsFloat) / 100);
    DataItens.DataSet.FieldByName('VALOR_PIS').AsFloat := aValorPIS;
  end;

end;

procedure TFrmLancItensCompra.DBEdit18Exit(Sender: TObject);
var aValorCOFINS : Double;
begin
  inherited;
  if DataItens.DataSet.FieldByName('ALIQ_COFINS').AsFloat > 0 then
  begin
    aValorCOFINS := ((DataItens.DataSet.FieldByName('BASE_COFINS').AsFloat * DataItens.DataSet.FieldByName('ALIQ_COFINS').AsFloat) / 100);
    DataItens.DataSet.FieldByName('VALOR_COFINS').AsFloat := aValorCOFINS;
  end;

end;

end.
