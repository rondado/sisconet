unit uFrmPedidosagrupa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, StdCtrls, ComCtrls, ExtCtrls, Grids, DBGrids,
  Buttons, ActnList, System.Actions, Data.FMTBcd, Data.SqlExpr,
  Datasnap.Provider, Datasnap.DBClient;

type
  TFrmPedidosAgrupa = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    DataPedido: TDataSource;
    GrpPeriodo: TGroupBox;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    ChTipoData: TCheckBox;
    RadioTipo: TRadioGroup;
    RadioConfirmados: TRadioGroup;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EdtLocalizar: TEdit;
    DBGrid1: TDBGrid;
    ActionList1: TActionList;
    ActLocalizar: TAction;
    ActEncerrar: TAction;
    sementrega: TCheckBox;
    RadioGroup1: TRadioGroup;
    BtnAgrupar: TBitBtn;
    DataWork: TDataSource;
    CdsItens: TClientDataSet;
    CdsItensID: TIntegerField;
    CdsItensIDPEDIDO: TIntegerField;
    CdsItensIDPRODUTO: TIntegerField;
    CdsItensDESCRICAO: TStringField;
    CdsItensQUANTIDADE: TFloatField;
    CdsItensVALOR: TFloatField;
    CdsItensDESCONTO: TFloatField;
    CdsItensACRESCIMO: TFloatField;
    CdsItensVALOR_TOTAL: TFloatField;
    CdsItensMARGEM: TFloatField;
    CdsItensVALOR_REAL: TFloatField;
    CdsItensTIPOPROD: TIntegerField;
    CdsItensCANCELADO: TStringField;
    CdsItensNUM_ITEM: TIntegerField;
    CdsItensEAN13: TStringField;
    CdsItensCST: TStringField;
    CdsItensCFOP: TStringField;
    CdsItensALIQ_ICMS: TFloatField;
    CdsItensBASE_ICMS: TFloatField;
    CdsItensVALOR_ICMS: TFloatField;
    CdsItensREDUCAO_BASE: TFloatField;
    CdsItensALIQ_ICMS_ST: TFloatField;
    CdsItensBASE_ICMS_ST: TFloatField;
    CdsItensVALOR_ICMS_ST: TFloatField;
    CdsItensVALOR_PIS: TFloatField;
    CdsItensVALOR_COFINS: TFloatField;
    CdsItensVALOR_IPI: TFloatField;
    CdsItensMD5REGISTRO: TStringField;
    CdsItensID_BICO: TIntegerField;
    CdsItensID_TANQUE: TIntegerField;
    CdsItensID_BOMBA: TIntegerField;
    CdsItensEI: TFloatField;
    CdsItensEF: TFloatField;
    CdsItensMVA: TFloatField;
    CdsItensID_VENDEDOR: TIntegerField;
    CdsItensCOO: TIntegerField;
    CdsItensCCF: TIntegerField;
    CdsItensGNF: TIntegerField;
    CdsItensNUMSERIEECF: TStringField;
    CdsItensID_ABASTECIMENTO: TIntegerField;
    CdsItensALIQ_PIS: TFloatField;
    CdsItensALIQ_COFINS: TFloatField;
    CdsItensBASE_PIS: TFloatField;
    CdsItensBASE_COFINS: TFloatField;
    CdsItensALIQ_IPI: TFloatField;
    CdsItensBASE_IPI: TFloatField;
    CdsItensCST_IPI: TStringField;
    CdsItensCST_PIS: TStringField;
    CdsItensCST_COFINS: TStringField;
    CdsItensALIQ_ISS: TFloatField;
    CdsItensBASE_ISS: TFloatField;
    CdsItensVALOR_ISS: TFloatField;
    CdsItensUNIDADE: TStringField;
    CdsItensVALOR_REENBOLSO: TFloatField;
    CdsItensVALOR_SUBSIDIO: TFloatField;
    CdsItensID_BICO_PERDA: TIntegerField;
    CdsItensID_COR: TIntegerField;
    CdsItensID_TAMANHO: TIntegerField;
    CdsItensCSOSN: TStringField;
    CdsItensDESCONTO_TOTAL: TFloatField;
    CdsItensPERC_FCP: TFloatField;
    CdsItensALIQ_INTERNO: TFloatField;
    CdsItensPERC_DIFAL: TFloatField;
    CdsItensPERC_PART_DIFAL: TFloatField;
    CdsItensVALOR_FCP: TFloatField;
    CdsItensVALOR_ICMS_INTERNO: TFloatField;
    CdsItensVALOR_ICMS_DEST: TFloatField;
    DspItens: TDataSetProvider;
    QryItens: TSQLQuery;
    QryItensID: TIntegerField;
    QryItensIDPEDIDO: TIntegerField;
    QryItensIDPRODUTO: TIntegerField;
    QryItensDESCRICAO: TStringField;
    QryItensQUANTIDADE: TFloatField;
    QryItensVALOR: TFloatField;
    QryItensDESCONTO: TFloatField;
    QryItensACRESCIMO: TFloatField;
    QryItensVALOR_TOTAL: TFloatField;
    QryItensMARGEM: TFloatField;
    QryItensVALOR_REAL: TFloatField;
    QryItensTIPOPROD: TIntegerField;
    QryItensCANCELADO: TStringField;
    QryItensNUM_ITEM: TIntegerField;
    QryItensEAN13: TStringField;
    QryItensCST: TStringField;
    QryItensCFOP: TStringField;
    QryItensALIQ_ICMS: TFloatField;
    QryItensBASE_ICMS: TFloatField;
    QryItensVALOR_ICMS: TFloatField;
    QryItensREDUCAO_BASE: TFloatField;
    QryItensALIQ_ICMS_ST: TFloatField;
    QryItensBASE_ICMS_ST: TFloatField;
    QryItensVALOR_ICMS_ST: TFloatField;
    QryItensVALOR_PIS: TFloatField;
    QryItensVALOR_COFINS: TFloatField;
    QryItensVALOR_IPI: TFloatField;
    QryItensMD5REGISTRO: TStringField;
    QryItensID_BICO: TIntegerField;
    QryItensID_TANQUE: TIntegerField;
    QryItensID_BOMBA: TIntegerField;
    QryItensEI: TFloatField;
    QryItensEF: TFloatField;
    QryItensMVA: TFloatField;
    QryItensID_VENDEDOR: TIntegerField;
    QryItensCOO: TIntegerField;
    QryItensCCF: TIntegerField;
    QryItensGNF: TIntegerField;
    QryItensNUMSERIEECF: TStringField;
    QryItensID_ABASTECIMENTO: TIntegerField;
    QryItensALIQ_PIS: TFloatField;
    QryItensALIQ_COFINS: TFloatField;
    QryItensBASE_PIS: TFloatField;
    QryItensBASE_COFINS: TFloatField;
    QryItensALIQ_IPI: TFloatField;
    QryItensBASE_IPI: TFloatField;
    QryItensCST_IPI: TStringField;
    QryItensCST_PIS: TStringField;
    QryItensCST_COFINS: TStringField;
    QryItensALIQ_ISS: TFloatField;
    QryItensBASE_ISS: TFloatField;
    QryItensVALOR_ISS: TFloatField;
    QryItensUNIDADE: TStringField;
    QryItensVALOR_REENBOLSO: TFloatField;
    QryItensVALOR_SUBSIDIO: TFloatField;
    QryItensID_BICO_PERDA: TIntegerField;
    QryItensID_COR: TIntegerField;
    QryItensID_TAMANHO: TIntegerField;
    QryItensCSOSN: TStringField;
    QryItensDESCONTO_TOTAL: TFloatField;
    QryItensPERC_FCP: TFloatField;
    QryItensALIQ_INTERNO: TFloatField;
    QryItensPERC_DIFAL: TFloatField;
    QryItensPERC_PART_DIFAL: TFloatField;
    QryItensVALOR_FCP: TFloatField;
    QryItensVALOR_ICMS_INTERNO: TFloatField;
    QryItensVALOR_ICMS_DEST: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DataiKeyPress(Sender: TObject; var Key: Char);
    procedure EdtLocalizarExit(Sender: TObject);
    procedure BtnAgruparClick(Sender: TObject);
  private
    { Private declarations }

    procedure ConfirmaDadosItens;


  public
    { Public declarations }
    sIDPedido:Integer;
  end;

var
  FrmPedidosAgrupa: TFrmPedidosAgrupa;

implementation

Uses uLibrary, uDmWorkCom, uDmProdutos, uFrmLancPedidos;

{$R *.dfm}

procedure Grava_Dados(pDataDados: TDataSet);
begin
  try
    Randomize;
    IniciaTransacao;
    if TClientDataSet(pDataDados).Active then
    begin
      if TClientDataSet(pDataDados).State in [dsInsert,dsEdit] then
         TClientDataSet(pDataDados).Post;
      if TClientDataSet(pDataDados).ChangeCount > 0 then
         TClientDataSet(pDataDados).ApplyUpdates(0);
    end;
    ConexaoDados.Commit(Transc);
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;


procedure TFrmPedidosAgrupa.ConfirmaDadosItens;
var ValorTotalItem, ValorCarga : Double;
begin
  ValorTotalItem := TruncaValor((((DmWorkCom.CdsPedidoItens.FieldByName('QUANTIDADE').AsFloat*
                                   DmWorkCom.CdsPedidoItens.FieldByName('VALOR').AsFloat)-
                                   DmWorkCom.CdsPedidoItens.FieldByName('DESCONTO').AsFloat)+
                                   DmWorkCom.CdsPedidoItens.FieldByName('ACRESCIMO').AsFloat),2);
  // calcula a carga a ser adicionada
  ValorCarga := ((ValorTotalItem * DmProdutos.CdsNCM.FieldByName('ALIQ_NACIONAL').AsFloat) / 100);
  // grava no pedido
  if not(DmWorkCom.CdsPedidos.State in [dsInsert,dsEdit]) then
     DmWorkCom.CdsPedidos.Edit;
  DmWorkCom.CdsPedidos.FieldByName('valor_carga_trib').AsFloat := DmWorkCom.CdsPedidos.FieldByName('valor_carga_trib').AsFloat + ValorCarga;
  DmWorkCom.CdsPedidos.FieldByName('VALOR').AsFloat       := Retorna_Total_Pedido(DmWorkCom.CdsPedidos.FieldByname('ID').AsInteger);
  DmWorkCom.CdsPedidos.FieldByName('VALOR_TOTAL').AsFloat := Retorna_Total_Pedido(DmWorkCom.CdsPedidos.FieldByname('ID').AsInteger);
  DmWorkCom.CdsPedidos.FieldByName('VALOR_TOTAL').AsFloat :=
                  DmWorkCom.CdsPedidos.FieldByname('VALOR').AsFloat+
                  DmWorkCom.CdsPedidos.FieldByname('OUTRAS_DESPESAS').AsFloat+
                  DmWorkCom.CdsPedidos.FieldByname('ACRESCIMO').AsFloat-
                  DmWorkCom.CdsPedidos.FieldByname('DESCONTO').AsFloat;

end;






procedure TFrmPedidosAgrupa.FormShow(Sender: TObject);
begin
  inherited;

  DataPedido.DataSet := DmWorkCom.CdsConsulta;
  DBGrid1.Columns.Items[0].Width := 30;
  DBGrid1.Columns.Items[1].Width := 200;
  DBGrid1.Columns.Items[2].Width := 70;
  DBGrid1.Columns.Items[3].Width := 70;
  DBGrid1.Columns.Items[4].Width := 70;

  Datai.Date := SVData;
  dataf.Date := SVData;
  sIDPedido  := 0;
  EdtLocalizar.SetFocus;

end;

procedure TFrmPedidosAgrupa.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(DmWorkCom.CdsConsulta,DBGrid1,Column);

end;

procedure TFrmPedidosAgrupa.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  //
//fabricio
if RAdioGroup1.ItemIndex = 0 then
begin
  //
  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select * from pedido');
//  DmWorkCom.QryConsulta.SQL.Add('pedido.data_entrega,pedido.valor_total,pedido.cliente from pedido');
  DmWorkCom.QryConsulta.SQL.Add(' inner join caixa_mov on (caixa_mov.idpedido = pedido.id)');

  if (RadioTipo.ItemIndex > 1) then
  begin
    if ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_entrega between :pDatai and :pDataf')
    else if not ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_pedido between :pDatai and :pDataf');
    if sementrega.Checked then
       DmWorkCom.QryConsulta.SQL.Add(' and pedido.data_entrega is null ');

    if RadioTipo.ItemIndex = 2 then // codigo do clienye
       DmWorkCom.QryConsulta.SQL.Add('and pedido.idcliente = :pLocalizar')
    else if RadioTipo.ItemIndex = 3 then // mome do cliente
       DmWorkCom.QryConsulta.SQL.Add('and upper(pedido.cliente) like :pLocalizar')
    else if RadioTipo.ItemIndex = 4 then // codigo do vendedor
       DmWorkCom.QryConsulta.SQL.Add('and pedido.id_vendedor = :pLocalizar')
  end
  else if (RadioTipo.ItemIndex = 0) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.id = :pLocalizar')
  else if (RadioTipo.ItemIndex = 1) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.pedido_num = :pLocalizar');
  // confirmados
  if RadioConfirmados.ItemIndex = 0 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('S'))
  else if RadioConfirmados.ItemIndex = 1 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('N'));

//fabricio incluir
  DmWorkCom.QryConsulta.SQL.Add(' order by pedido.id desc');

  // parametros
  DmWorkCom.CdsConsulta.FetchParams;

//fabricio
  Datai.Time:= StrToTime('00:00:00');
  Dataf.Time:= StrToTime('23:59:59');

//fabricio


  if (RadioTipo.ItemIndex > 1) then
  begin
    DmWorkCom.CdsConsulta.Params.ParamByName('pDatai').AsDateTime := Datai.DateTime;
    DmWorkCom.CdsConsulta.Params.ParamByName('pDataf').AsDateTime := Dataf.DateTime;
    if (RadioTipo.ItemIndex = 2) or (RadioTipo.ItemIndex = 4) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
    else if (RadioTipo.ItemIndex = 3) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString := UpperCase(EdtLocalizar.Text)+'%';
  end
  else if (RadioTipo.ItemIndex = 0) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
  else if (RadioTipo.ItemIndex = 1) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString  := EdtLocalizar.Text;
  //
  DmWorkCom.CdsConsulta.Open;
  DmWorkCom.CdsConsulta.RecordCount;
  DBGrid1.SetFocus;


end
else
begin

  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select * from pedido');
//  DmWorkCom.QryConsulta.SQL.Add('pedido.data_entrega,pedido.valor_total,pedido.cliente from pedido');
  if (RadioTipo.ItemIndex > 1) then
  begin
    if ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_entrega between :pDatai and :pDataf')
    else if not ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_pedido between :pDatai and :pDataf');
    if sementrega.Checked then
       DmWorkCom.QryConsulta.SQL.Add(' and pedido.data_entrega is null ');


    if RadioTipo.ItemIndex = 2 then // codigo do clienye
       DmWorkCom.QryConsulta.SQL.Add('and pedido.idcliente = :pLocalizar')
    else if RadioTipo.ItemIndex = 3 then // mome do cliente
       DmWorkCom.QryConsulta.SQL.Add('and upper(pedido.cliente) like :pLocalizar')
    else if RadioTipo.ItemIndex = 4 then // codigo do vendedor
       DmWorkCom.QryConsulta.SQL.Add('and pedido.id_vendedor = :pLocalizar')
  end
  else if (RadioTipo.ItemIndex = 0) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.id = :pLocalizar')
  else if (RadioTipo.ItemIndex = 1) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.pedido_num = :pLocalizar');
  // confirmados
  if RadioConfirmados.ItemIndex = 0 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('S'))
  else if RadioConfirmados.ItemIndex = 1 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('N'));

//fabricio incluir
  DmWorkCom.QryConsulta.SQL.Add(' order by pedido.id desc');


  // parametros
  DmWorkCom.CdsConsulta.FetchParams;

//fabricio
  Datai.Time:= StrToTime('00:00:00');
  Dataf.Time:= StrToTime('23:59:59');

//fabricio


  if (RadioTipo.ItemIndex > 1) then
  begin
    DmWorkCom.CdsConsulta.Params.ParamByName('pDatai').AsDateTime := Datai.DateTime;
    DmWorkCom.CdsConsulta.Params.ParamByName('pDataf').AsDateTime := Dataf.DateTime;
    if (RadioTipo.ItemIndex = 2) or (RadioTipo.ItemIndex = 4) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
    else if (RadioTipo.ItemIndex = 3) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString := UpperCase(EdtLocalizar.Text)+'%';
  end
  else if (RadioTipo.ItemIndex = 0) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
  else if (RadioTipo.ItemIndex = 1) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString  := EdtLocalizar.Text;
  //
  DmWorkCom.CdsConsulta.Open;
  DmWorkCom.CdsConsulta.RecordCount;
  DBGrid1.SetFocus;


//fabricio

if RadioGroup1.ItemIndex = 1 then
begin
  DataPedido.DataSet.First;
  while not DataPedido.DataSet.Eof do
  begin
  DmWorkCom.CdsCaixaMov.Close;
  DmWorkCom.CdsCaixaMov.Params.Clear;
  DmWorkCom.QryCaixaMov.Close;
  DmWorkCom.QryCaixaMov.SQL.Clear;
  DmWorkCom.QryCaixaMov.SQL.Add('select * from caixa_mov where ');
  DmWorkCom.QryCaixaMov.SQL.Add('caixa_mov.idpedido = ');
//  DmWorkCom.CdsCaixaMov.Params.ParamByName('pID').AsString  := DataPedido.DataSet.FieldByname('ID').AsString;
  DmWorkCom.QryCaixaMov.SQL.Add(DataPedido.DataSet.FieldByname('ID').AsString);
  DmWorkCom.CdsCaixaMov.Open;

  if DmWorkCom.CdsCaixaMov.RecordCount > 0 then
//    if DmWorkCom.Dados_CaixaMov(DataPedido.DataSet.FieldByname('ID').AsInteger) then
    begin
      DataPedido.DataSet.Delete;
    end
    else
      DataPedido.DataSet.Next;

  end;
end;

// DbGrid1.Refresh;






//fabricio incluir
    (dbgrid1.fields[5] as Tfloatfield).DisplayFormat := 'R$ ###,##0.00';
     dbgrid1.columns[2].Width:=200;


end;


end;

procedure TFrmPedidosAgrupa.BtnAgruparClick(Sender: TObject);
var
idtemp, contador: integer;
begin
  inherited;
contador:=0;
DBgrid1.DataSource.DataSet.First;
while not DBgrid1.DataSource.DataSet.eof do
begin
       if DBGrid1.SelectedRows.CurrentRowSelected = True then
       begin
            contador:= contador + 1;
            if contador = 1 then
            begin
               DmWorkCom.CdsPedidos.Close;
               DmWorkCom.CdsPedidos.Params.Clear;
               DmWorkCom.QryPedidos.Close;
               DmWorkCom.QryPedidos.SQL.Clear;
               DmWorkCom.QryPedidos.SQL.Add('select * from pedido where pedido.id =:pID');
               DmWorkCom.CdsPedidos.FetchParams;
               DmWorkCom.CdsPedidos.Params.ParamByName('pID').AsInteger  := DbGrid1.DataSource.DataSet.FieldByName('ID').AsInteger;
               DmWorkCom.CdsPedidos.Open;

               DmWorkCom.CdsPedidos.Insert;
               DmWorkcom.CdsPedidosPEDIDO_NUM.AsString := ZeroEsquerda(DmWorkcom.CdsPedidosID.asstring,10);
               DmWorkcom.CdsPedidosIDCLIENTE.AsInteger := DmWorkcom.CdsConsulta.FieldByName('IDCLIENTE').AsInteger;
               DmWorkcom.CdsPedidosID_VENDEDOR.AsInteger:= DmWorkcom.CdsConsulta.FieldByName('ID_VENDEDOR').AsInteger;
               DmWorkCom.CdsPedidosID_CLASSIFICACAO.AsInteger :=DmWorkcom.CdsConsulta.FieldByName('ID_CLASSIFICACAO').AsInteger;
               DmWorkCom.CdsPedidosID_FORMAPAG.AsInteger:= DmWorkcom.CdsConsulta.FieldByName('ID_FORMAPAG').AsInteger;
               DmworkCom.CdsPedidosIDEMPRESA.AsInteger:= DmWorkcom.CdsConsulta.FieldByName('IDEMPRESA').AsInteger;
//               DmWorkCom.CdsPedidosID_MESA.AsString:= DmWorkcom.CdsConsulta.FieldByName('ID_MESA').AsString;
//               DmWorkcom.CdsPedidosIDUSUARIOCANC.AsInteger:= DmWorkcom.CdsConsulta.FieldByName('IDUSUARIOCANC').AsInteger;
               DmWorkCom.CdsPedidosIDPLANOCONTAS.AsInteger:= DmWorkcom.CdsConsulta.FieldByName('IDPLANOCONTAS').AsInteger;
               DmWorkCom.CdsPedidosIDCENTROCUSTO.AsInteger:= DmWorkcom.CdsConsulta.FieldByName('IDCENTROCUSTO').AsInteger;
               DmWorkCom.CdsPedidosCLIENTE.AsString:= DmWorkcom.CdsConsulta.FieldByName('CLIENTE').AsString;
               DmWorkCom.CdsPedidosEND_ENTREGA.AsString:= DmWorkcom.CdsConsulta.FieldByName('END_ENTREGA').AsString;
               DmWorkCom.CdsPedidosNUM_END_ENTREGA.AsString:= DmWorkcom.CdsConsulta.FieldByName('NUM_END_ENTREGA').AsString;
               DmWorkCom.CdsPedidosCOMPL_END_ENTREGA.AsString:= DmWorkcom.CdsConsulta.FieldByName('COMPL_END_ENTREGA').AsString;
               DmWorkCom.CdsPedidosBAIRRO_END_ENTREGA.AsString:= DmWorkcom.CdsConsulta.FieldByName('BAIRRO_END_ENTREGA').AsString;
               DmWorkCom.CdsPedidosCID_END_ENTREGA.AsString:= DmWorkcom.CdsConsulta.FieldByName('CID_END_ENTREGA').AsString;
               DmWorkCom.CdsPedidosUF_END_ENTREGA.AsString:= DmWorkcom.CdsConsulta.FieldByName('UF_END_ENTREGA').AsString;
               DmWorkCom.CdsPedidosTIPODOC.AsString:= DmWorkcom.CdsConsulta.FieldByName('TIPODOC').AsString;
               DmWorkCom.CdsPedidosTIPO_PEDIDO.AsString:= DmWorkcom.CdsConsulta.FieldByName('TIPO_PEDIDO').AsString;

               DmWorkCom.CdsPedidosCONFIRMADA.AsString:= 'N';
               DmWorkCom.CdsPedidosENTREGUE.AsString:= 'N';

               DmWorkCom.CdsPedidosCOO.AsString:= DmWorkcom.CdsConsulta.FieldByName('COO').AsString;
               DmWorkCom.CdsPedidosCCF.AsString:= DmWorkcom.CdsConsulta.FieldByName('CCF').AsString;
               DmWorkCom.CdsPedidosGNF.AsString:= DmWorkcom.CdsConsulta.FieldByName('GNF').AsString;
               DmWorkCom.CdsPedidosDAV.AsString:= DmWorkcom.CdsConsulta.FieldByName('DAV').AsString;
               DmWorkCom.CdsPedidosCNPJCPF.AsString:= DmWorkcom.CdsConsulta.FieldByName('CNPJCPF').AsString;
               DmWorkCom.CdsPedidosINSCEST.AsString:= DmWorkcom.CdsConsulta.FieldByName('INSCEST').AsString;
               DmWorkCom.CdsPedidosNATOP.AsString:= DmWorkcom.CdsConsulta.FieldByName('NATOP').AsString;

               DmWorkCom.CdsPedidosMODELO.AsString:= DmWorkcom.CdsConsulta.FieldByName('MODELO').AsString;
               DmWorkCom.CdsPedidosOBSNFE_1.AsString:= DmWorkcom.CdsConsulta.FieldByName('OBSNFE_1').AsString;
               DmWorkCom.CdsPedidosOBSNFE_2.AsString:= DmWorkcom.CdsConsulta.FieldByName('OBSNFE_2').AsString;
               DmWorkCom.CdsPedidosOBSNFE_3.AsString:= DmWorkcom.CdsConsulta.FieldByName('OBSNFE_3').AsString;
               DmWorkCom.CdsPedidosOBSNFE_4.AsString:= DmWorkcom.CdsConsulta.FieldByName('OBSNFE_4').AsString;
               Grava_Dados(DmWorkCom.CdsPedidos);
            end;

            if contador > 0 then
            begin
                CdsItens.Close;
                CdsItens.Params.Clear;
                QryItens.close;
                QryItens.SQL.Clear;
                QryItens.SQL.Add('select pedido_itens.* from pedido_itens ');
                QryItens.SQL.Add('where pedido_itens.idpedido =:pID');
                QryItens.SQL.Add('order by id ');

                CdsItens.FetchParams;
                CdsItens.Params.ParamByName('pID').AsInteger  := DbGrid1.DataSource.DataSet.FieldByName('ID').AsInteger;
                CdsItens.Open;
                CdsItens.First;
                while not CdsItens.Eof do
                begin


                     if not DmProdutos.Dados_Produto(CdsItensIDPRODUTO.AsInteger) then
                     Begin
                        ShowMessage(' Produto nao cadastrado no sistema' );
                        abort;
                     End;

                      DmProdutos.Dados_NCM(DmProdutos.CdsProdutos.FieldByName('CODIGO_NCM').AsString,
                               DmProdutos.CdsProdutos.FieldByName('EXCECAO_NCM').AsInteger);

                      DmWorkcom.CdsPedidoItens.Insert;
//                      DmWorkcom.CdsPedidoItensIDPEDIDO.AsInteger:= DmWorkCom.CdsPedidosID.AsInteger;
                      DmWorkcom.CdsPedidoItensIDPRODUTO.AsInteger:= CdsItensIDPRODUTO.AsInteger;
                      DmWorkcom.CdsPedidoItensDESCRICAO.AsString:= CdsItensDESCRICAO.AsString;
                      DmWorkcom.CdsPedidoItensQUANTIDADE.AsString:= CdsItensQUANTIDADE.AsString;
                      DmWorkcom.CdsPedidoItensVALOR.AsString:= CdsItensVALOR.AsString;
                      DmWorkcom.CdsPedidoItensDESCONTO.AsString:= CdsItensDESCONTO.AsString;
                      DmWorkcom.CdsPedidoItensACRESCIMO.AsString:= CdsItensACRESCIMO.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_TOTAL.AsString:= CdsItensVALOR_TOTAL.AsString;
                      DmWorkcom.CdsPedidoItensMARGEM.AsString:= CdsItensMARGEM.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_REAL.AsString:= CdsItensVALOR_REAL.AsString;
                      DmWorkcom.CdsPedidoItensTIPOPROD.AsString:= CdsItensTIPOPROD.AsString;
                      DmWorkcom.CdsPedidoItensCANCELADO.AsString:= CdsItensCANCELADO.AsString;
                      DmWorkcom.CdsPedidoItensEAN13.AsString:= CdsItensEAN13.AsString;
                      DmWorkcom.CdsPedidoItensCST.AsString:= CdsItensCST.AsString;
                      DmWorkcom.CdsPedidoItensCFOP.AsString:= CdsItensCFOP.AsString;
                      DmWorkcom.CdsPedidoItensALIQ_ICMS.AsString:= CdsItensALIQ_ICMS.AsString;
                      DmWorkcom.CdsPedidoItensBASE_ICMS.AsString:= CdsItensBASE_ICMS.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_ICMS.AsString:= CdsItensVALOR_ICMS.AsString;
                      DmWorkcom.CdsPedidoItensREDUCAO_BASE.AsString:= CdsItensREDUCAO_BASE.AsString;
                      DmWorkcom.CdsPedidoItensALIQ_ICMS_ST.AsString:= CdsItensALIQ_ICMS_ST.AsString;
                      DmWorkcom.CdsPedidoItensBASE_ICMS_ST.AsString:= CdsItensBASE_ICMS_ST.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_ICMS_ST.AsString:= CdsItensVALOR_ICMS_ST.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_PIS.AsString:= CdsItensVALOR_PIS.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_COFINS.AsString:= CdsItensVALOR_COFINS.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_IPI.AsString:= CdsItensVALOR_IPI.AsString;
                      DmWorkcom.CdsPedidoItensID_BICO.AsString:= CdsItensID_BICO.AsString;
                      DmWorkcom.CdsPedidoItensID_TANQUE.AsString:= CdsItensID_TANQUE.AsString;
                      DmWorkcom.CdsPedidoItensID_BOMBA.AsString:= CdsItensID_BOMBA.AsString;
                      DmWorkcom.CdsPedidoItensEI.AsString:= CdsItensEI.AsString;
                      DmWorkcom.CdsPedidoItensEF.AsString:= CdsItensEF.AsString;
                      DmWorkcom.CdsPedidoItensMVA.AsString:= CdsItensMVA.AsString;
                      DmWorkcom.CdsPedidoItensID_VENDEDOR.AsString:= CdsItensID_VENDEDOR.AsString;
                      DmWorkcom.CdsPedidoItensCOO.AsString:= CdsItensCOO.AsString;
                      DmWorkcom.CdsPedidoItensCCF.AsString:= CdsItensCCF.AsString;
                      DmWorkcom.CdsPedidoItensGNF.AsString:= CdsItensGNF.AsString;
                      DmWorkcom.CdsPedidoItensNUMSERIEECF.AsString:= CdsItensNUMSERIEECF.AsString;
                      DmWorkcom.CdsPedidoItensID_ABASTECIMENTO.AsString:= CdsItensID_ABASTECIMENTO.AsString;
                      DmWorkcom.CdsPedidoItensALIQ_PIS.AsString:= CdsItensALIQ_PIS.AsString;
                      DmWorkcom.CdsPedidoItensALIQ_COFINS.AsString:= CdsItensALIQ_COFINS.AsString;
                      DmWorkcom.CdsPedidoItensBASE_PIS.AsString:= CdsItensBASE_PIS.AsString;
                      DmWorkcom.CdsPedidoItensCST_IPI.AsString:= CdsItensCST_IPI.AsString;
                      DmWorkcom.CdsPedidoItensCST_PIS.AsString:= CdsItensCST_PIS.AsString;
                      DmWorkcom.CdsPedidoItensCST_COFINS.AsString:= CdsItensCST_COFINS.AsString;
                      DmWorkcom.CdsPedidoItensALIQ_ISS.AsString:= CdsItensALIQ_ISS.AsString;
                      DmWorkcom.CdsPedidoItensBASE_ISS.AsString:= CdsItensBASE_ISS.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_ISS.AsString:= CdsItensVALOR_ISS.AsString;
                      DmWorkcom.CdsPedidoItensID_BICO.AsString:= CdsItensID_BICO.AsString;
                      DmWorkcom.CdsPedidoItensUNIDADE.AsString:= CdsItensUNIDADE.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_REENBOLSO.AsString:= CdsItensVALOR_REENBOLSO.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_SUBSIDIO.AsString:= CdsItensVALOR_SUBSIDIO.AsString;
                      DmWorkcom.CdsPedidoItensID_BICO_PERDA.AsString:= CdsItensID_BICO_PERDA.AsString;
                      DmWorkcom.CdsPedidoItensID_COR.AsString:= CdsItensID_COR.AsString;
                      DmWorkcom.CdsPedidoItensID_TAMANHO.AsString:= CdsItensID_TAMANHO.AsString;
                      DmWorkcom.CdsPedidoItensCSOSN.AsString:= CdsItensCSOSN.AsString;
                      DmWorkcom.CdsPedidoItensDESCONTO_TOTAL.AsString:= CdsItensDESCONTO_TOTAL.AsString;
                      DmWorkcom.CdsPedidoItensPERC_FCP.AsString:= CdsItensPERC_FCP.AsString;
                      DmWorkcom.CdsPedidoItensALIQ_INTERNO.AsString:= CdsItensALIQ_INTERNO.AsString;
                      DmWorkcom.CdsPedidoItensPERC_DIFAL.AsString:= CdsItensPERC_DIFAL.AsString;
                      DmWorkcom.CdsPedidoItensPERC_PART_DIFAL.AsString:= CdsItensPERC_PART_DIFAL.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_FCP.AsString:= CdsItensVALOR_FCP.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_ICMS_INTERNO.AsString:= CdsItensVALOR_ICMS_INTERNO.AsString;
                      DmWorkcom.CdsPedidoItensVALOR_ICMS_DEST.AsString:= CdsItensVALOR_ICMS_DEST.AsString;
                      Grava_Dados(DmWorkCom.CdsPedidoItens);
                      ConfirmaDadosItens;
                      Grava_Dados(DmWorkCom.CdsPedidos);
                      DmWorkCom.Dados_ContasPedido(DmWorkCom.CdsPedidos.FieldByName('ID').AsInteger,0);
                      DmWorkCom.Dados_VolumesNFe(DmWorkCom.CdsPedidos.FieldByName('ID').AsInteger);
                      CdsItens.Next;

                end;
            end;

       end;
       DBgrid1.DataSource.DataSet.next;
end;
{
if contador > 0 then
begin
   Grava_Dados(DmWorkCom.CdsPedidos);
   Grava_Dados(DmWorkCom.CdsPedidoItens);
end;
}
end;




procedure TFrmPedidosAgrupa.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmPedidosAgrupa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataPedido.DataSet.Close;
   
end;

procedure TFrmPedidosAgrupa.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  sIDPedido := 0;
  if DataPedido.DataSet.RecordCount > 0 then
     sIDPedido := DataPedido.DataSet.FieldByname('ID').AsInteger;
  Close;

end;

procedure TFrmPedidosAgrupa.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
     DBGrid1DblClick(Sender);
     
end;

procedure TFrmPedidosAgrupa.DataiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmPedidosAgrupa.EdtLocalizarExit(Sender: TObject);
begin
  inherited;
  if RadioTipo.ItemIndex = 1 then
  begin
    if sPedidoSeq = 'S' then
       EdtLocalizar.Text := ZeroEsquerda(EdtLocalizar.Text,10)
    else if sPedidoSeq = 'N' then
       EdtLocalizar.Text := ZeroEsquerda(EdtLocalizar.Text,6);
  end;
end;

end.
