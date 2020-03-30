unit uFrmFecharCupom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmPadrao, DB, StdCtrls, Mask, DBCtrls, ExtCtrls, ActnList,
  Buttons, Grids, ValEdit, DBGrids, Menus, jpeg, DBClient, StrUtils,
  System.Actions;

type
  TFrmFecharCupom = class(TFrmPadrao)
    ImgFundo: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DataCupom: TDataSource;
    ActionList1: TActionList;
    ActConfirmar: TAction;
    ActCancelar: TAction;
    ActIncluir: TAction;
    DataPagamento: TDataSource;
    PopupMenu1: TPopupMenu;
    Excluirformadepagamento1: TMenuItem;
    DbValorProd: TDBEdit;
    Label1: TLabel;
    DbValorPago: TDBEdit;
    Label5: TLabel;
    DbTotal: TDBEdit;
    Label4: TLabel;
    DbAcres: TDBEdit;
    Label3: TLabel;
    DbDesc: TDBEdit;
    Label2: TLabel;
    DbTroco: TDBEdit;
    Label6: TLabel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    DBGrid1: TDBGrid;
    Bevel1: TBevel;
    CdsTotalPago: TClientDataSet;
    DataTotalPago: TDataSource;
    DbRestante: TDBEdit;
    Label7: TLabel;
    CdsTotalPagoRESTANTE: TFloatField;
    Bevel2: TBevel;
    Label8: TLabel;
    ComboFormaPag: TDBLookupComboBox;
    DataFormaPag: TDataSource;
    CdsTotalPagoTATALPAGO: TFloatField;
    ActDinheiro: TAction;
    ActCheque: TAction;
    ActCartao: TAction;
    ActPromissoria: TAction;
    ActCarnet: TAction;
    ActBoleto: TAction;
    ActOutras: TAction;
    chkimprimec: TCheckBox;
    chkduasvias: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure DbValorProdKeyPress(Sender: TObject; var Key: Char);
    procedure DbDescExit(Sender: TObject);
    procedure DbAcresExit(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActIncluirExecute(Sender: TObject);
    procedure Excluirformadepagamento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DataPagamentoDataChange(Sender: TObject; Field: TField);
    procedure ActDinheiroExecute(Sender: TObject);
    procedure ActChequeExecute(Sender: TObject);
    procedure ActCartaoExecute(Sender: TObject);
    procedure ActPromissoriaExecute(Sender: TObject);
    procedure ActCarnetExecute(Sender: TObject);
    procedure ActBoletoExecute(Sender: TObject);
    procedure ActOutrasExecute(Sender: TObject);
  private
    { Private declarations }
    sValorPago, sValorFormaPag : Double;
    sFormaPag : Integer;
    sVincular : String;
  public
    { Public declarations }
    sOK : Boolean;
    sTroco : Double; 
  end;

var
  FrmFecharCupom: TFrmFecharCupom;

implementation

Uses uDmWorkCom,uLibrary, uFrmValorFormaPag, uFuncoesPAFECF, uFrmIdenticaCliente,
  uDMClientes;
//fabricio incluir udmclientes e ufrmidenticacliente

{$R *.dfm}

procedure TFrmFecharCupom.FormShow(Sender: TObject);
var aTroco, aTotal, aResto, aTotalCupom, aTotDescItem : Double;
begin
  inherited;

//fabricio inicio

  if DmWorkCom.imprimec = 'S' then
     chkimprimec.Checked:=true;
  if DmWorkCom.duasvias = 'S' then
     chkduasvias.Checked:=true;

//fabricio fim
  DataCupom.DataSet     := DmWorkCom.CdsPedidos;
  DataPagamento.DataSet := DmWorkCom.CdsPedidoFP;
  DataFormaPag.DataSet  := DmWorkCom.CdsFormaPag;
  sOK := False;
  DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByname('ID').AsInteger);
  DmWorkCom.Dados_FormaPagto;
  // grava total pago
  aTotalCupom  := DmWorkCom.RetornaTotalCupom(DataCupom.DataSet.FieldByname('ID').AsInteger);
  aTotDescItem := DmWorkCom.RetornaTotalDescItensCupom(DataCupom.DataSet.FieldByname('ID').AsInteger);
  aTotal       := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
  aResto       := aTotalCupom - aTotal;
  if aResto < 0 then
     aResto := 0;
  CdsTotalPago.Edit;
  CdsTotalPagoTATALPAGO.AsFloat := aTotal;
  CdsTotalPagoRESTANTE.AsFloat  := aResto;
  CdsTotalPago.Post;
  // grava valores
  aTroco := aTotal - aTotalCupom;
  if aTroco < 0 then
     aTroco := 0;
  if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
     DataCupom.DataSet.Edit;
  DataCupom.DataSet.FieldByName('VALOR').AsFloat         := aTotalCupom;
  DataCupom.DataSet.FieldByName('DESCONTO_PROD').AsFloat := aTotDescItem;
  DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat   := (aTotalCupom +
                                                             DataCupom.DataSet.FieldByName('ACRESCIMO').AsFloat) -
                                                             DataCupom.DataSet.FieldByName('DESCONTO').AsFloat;
  DataCupom.DataSet.FieldByName('VALOR_TROCO').AsFloat   := aTroco;
  Grava_Dados(DataCupom.DataSet);

end;

procedure TFrmFecharCupom.DbValorProdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmFecharCupom.DbDescExit(Sender: TObject);
var aTotal, aResto : Double;
begin
  inherited;
  if DataCupom.DataSet.FieldByName('DESCONTO').AsFloat < 0 then
  begin
    MessageDlg('Não é permitido desconto negativo!!!', mtWarning, [mbOK], 0);
    DataCupom.DataSet.FieldByName('DESCONTO').AsFloat := 0;
    DbDesc.SetFocus;
    exit;
  end;
  if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
     DataCupom.DataSet.Edit;
  //
  if DataCupom.DataSet.FieldByName('DESCONTO').AsFloat > 0 then
     DataCupom.DataSet.FieldByName('ACRESCIMO').AsFloat := 0;
  sValorPago := (DataCupom.DataSet.FieldByName('VALOR').AsFloat +
                 DataCupom.DataSet.FieldByName('ACRESCIMO').AsFloat) -
                 DataCupom.DataSet.FieldByName('DESCONTO').AsFloat;
  DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat := sValorPago;
  // grava total pago
  aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
  aResto := TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais) - TruncaValor(aTotal,DmWorkCom.PAFECF.gDecimais);
  if aResto < 0 then
     aResto := 0;
  CdsTotalPago.Edit;
  CdsTotalPagoTATALPAGO.AsFloat := aTotal;
  CdsTotalPagoRESTANTE.AsFloat  := aResto;
  CdsTotalPago.Post;

end;

procedure TFrmFecharCupom.DbAcresExit(Sender: TObject);
var aTotal, aResto : Double;
begin
  inherited;
  if DataCupom.DataSet.FieldByName('ACRESCIMO').AsFloat < 0 then
  begin
    MessageDlg('Não é permitido acrescimo negativo!!!', mtWarning, [mbOK], 0);
    DataCupom.DataSet.FieldByName('ACRESCIMO').AsFloat := 0;
    DbAcres.SetFocus;
    Exit;
  end;
  if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
     DataCupom.DataSet.Edit;
  //
  if DataCupom.DataSet.FieldByName('ACRESCIMO').AsFloat > 0 then
     DataCupom.DataSet.FieldByName('DESCONTO').AsFloat := 0;
  //
  sValorPago := (DataCupom.DataSet.FieldByName('VALOR').AsFloat +
                 DataCupom.DataSet.FieldByName('ACRESCIMO').AsFloat) -
                 DataCupom.DataSet.FieldByName('DESCONTO').AsFloat;
  DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat := sValorPago;
  // grava total pago
  aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
  aResto := TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais) - TruncaValor(aTotal,DmWorkCom.PAFECF.gDecimais);
  if aResto < 0 then
     aResto := 0;
  CdsTotalPago.Edit;
  CdsTotalPagoTATALPAGO.AsFloat := aTotal;
  CdsTotalPagoRESTANTE.AsFloat  := aResto;
  CdsTotalPago.Post;

end;

procedure TFrmFecharCupom.ActConfirmarExecute(Sender: TObject);
var aTotal : Double;
begin
  inherited;
  // verifica total preenchido
  if DataPagamento.DataSet.RecordCount = 0 then
  begin
    sVincular := 'N';
    sFormaPag := 0;
    // Registra forma de pagamento
    DataPagamento.DataSet.Append;
    DataPagamento.DataSet.FieldByName('ID_FORMAPAG_CUPOM').AsInteger := DataFormaPag.DataSet.FieldByName('ID').AsInteger;
    DataPagamento.DataSet.FieldByName('TIPO_DOCUMENTO').AsInteger    := sFormaPag;
    DataPagamento.DataSet.FieldByName('VALOR').AsFloat               := CdsTotalPagoRESTANTE.AsFloat;
    DataPagamento.DataSet.FieldByName('VINCULAR').AsString           := sVincular;
    DataPagamento.DataSet.FieldByName('DESCRICAO').AsString          := 'Dinheiro';
    DataPagamento.DataSet.FieldByName('TROCO').AsFloat               := 0;
    Grava_Dados(DataPagamento.DataSet);
  end;
  aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
  if TruncaValor(aTotal,DmWorkCom.PAFECF.gDecimais) < TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais) then
  begin
    MessageDlg('O total de pagamento informado não pode ser menor que o total a pagar',mtWarning,[mbOK],0);
    BitBtn3.SetFocus;
    Abort;
  end;
  // verifica total preenchido
  Grava_Dados(DataCupom.DataSet);
  sOK := True;
  Close;

end;

procedure TFrmFecharCupom.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  DataCupom.DataSet.Cancel;
  sOK := False;
  Close;
end;

procedure TFrmFecharCupom.FormClose(Sender: TObject;
  var Action: TCloseAction);
var aTotal : Double;
begin
  inherited;
  // verifica total preenchido
  if sOK then
  begin
    aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
    if (TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais) >
        TruncaValor(aTotal,DmWorkCom.PAFECF.gDecimais)) and
       (DataPagamento.DataSet.RecordCount > 0) then
    begin
      MessageDlg('É necessário informar o valor pago!', mtWarning, [mbOK], 0);
      Abort;
    end;
    if DataCupom.DataSet.FieldByName('VALOR_TROCO').AsFloat > 0 then
       sTroco := DataCupom.DataSet.FieldByName('VALOR_TROCO').AsFloat;
  end;
//fabricio      inicio
  if chkimprimec.Checked then
     DmWorkCom.imprimec:= 'S'
  else
     DmWorkCom.imprimec:= 'N';


  if chkduasvias.Checked then
      DmWorkCom.duasvias:= 'S'
  else
      DmWorkCom.duasvias:= 'N';
//fabricio fim

end;

procedure TFrmFecharCupom.ActIncluirExecute(Sender: TObject);
var aValor, aTotal, aResto, aTroco : Double;
    aCartoes : Integer;
begin
  inherited;
  // Chama o formulário para informar o valor pago
  aValor := 0;
  Application.CreateForm(TFrmValorFormaPag,FrmValorFormaPag);
  try
    FrmValorFormaPag.Caption:=IfThen(sFormaPag=0,'Dinheiro',IfThen(sFormaPag=1,'Cheque',IfThen(sFormaPag=2,'Cartão','A Prazo')));
    FrmValorFormaPag.ShowModal;
    if FrmValorFormaPag.sOK then
       aValor := FrmValorFormaPag.sValor
    else
       Abort;
  finally
    FreeAndNil(FrmValorFormaPag);
  end;
  // verifica se valor do lançamento é igual ao total em caso de cartão lançado
  aCartoes := RetornaNumCartoesFechamento(DataCupom.DataSet.FieldByName('ID').AsInteger);
  if (aCartoes > 0) and (sFormaPag = 0) and (DmWorkCom.PAFECF.sTipoTef in [0,2]) then
  begin
    if aValor >= DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat then
    begin
      MessageDlg('O valor do restante não pode ser igual ou maior que o total da venda!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
  // verifica se tem lançamento do mesmo tipo e soma
  if DataPagamento.DataSet.Locate('TIPO_DOCUMENTO',sFormaPag,[]) then
  begin
    if (sFormaPag <> 1) and (sFormaPag <> 2) then
       aValor := aValor + DataPagamento.DataSet.FieldByName('VALOR').AsFloat;
    // verifica troco
    aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
    aTroco := TruncaValor(((aTotal + aValor) - DataPagamento.DataSet.FieldByName('VALOR').AsFloat),DmWorkCom.PAFECF.gDecimais) -
              TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais);
  end
  else
  begin
    // verifica troco
    aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
    aTroco := TruncaValor((aTotal + aValor),DmWorkCom.PAFECF.gDecimais) -
              TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais);
  end;
  //
  if aTroco < 0 then
     aTroco := 0;
  if aTroco > 0 then
  begin
    if sFormaPag <> 0 then
    begin
      MessageDlg('Apenas é permitido troco em dinheiro!',mtWarning,[mbOK],0);
      Abort;
    end;
    //
//    if aTroco >= DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat then
//    begin
//      MessageDlg('Troco não pode ser igual ou maior que total do cupom!',mtWarning,[mbOK],0);
//      Abort;
//    end;
    // registra forma de pagamento na tabela de cuopom
    if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
       DataCupom.DataSet.Edit;
    DataCupom.DataSet.FieldByName('VALOR_TROCO').AsFloat := aTroco;
    Grava_Dados(DataCupom.DataSet);
  end;
  // elimina forma de pagamento em caso de duplicitade
  if DataPagamento.DataSet.Locate('TIPO_DOCUMENTO',sFormaPag,[]) then
  begin
    if (sFormaPag <> 1) and (sFormaPag <> 2) then
       DataPagamento.DataSet.Delete;
  end;
  // Registra forma de pagamento
  DataPagamento.DataSet.Append;
  DataPagamento.DataSet.FieldByName('ID_FORMAPAG_CUPOM').AsInteger := DataFormaPag.DataSet.FieldByName('ID').AsInteger;
  DataPagamento.DataSet.FieldByName('TIPO_DOCUMENTO').AsInteger    := sFormaPag;
  DataPagamento.DataSet.FieldByName('VALOR').AsFloat               := aValor;
  DataPagamento.DataSet.FieldByName('VINCULAR').AsString           := sVincular;
  DataPagamento.DataSet.FieldByName('CNPJ_OPERADORA').AsString     := DataFormaPag.DataSet.FieldByName('CNPJ_OPERADORA').AsString;
  //
  case sFormaPag of
    0:begin // dinheiro
        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'Dinheiro';
        DataPagamento.DataSet.FieldByName('TROCO').AsFloat            := aTroco;
      end;
    1:begin // cheque
        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'Cheque';
      end;
    2:begin // cartão
        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'Cartão';
      end;
    3:begin // Nota Promissoria
        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'A Prazo';
//        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'Nota Promissoria';
      end;
    4:begin // Carnet
        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'Carnet';
      end;
    5:begin // Boleto
        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'Boleto';
      end;
    6:begin // Outros
        DataPagamento.DataSet.FieldByName('DESCRICAO').AsString       := 'Duplicata';
      end;
   end;
   Grava_Dados(DataPagamento.DataSet);
   // grava total pago
   aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
   aResto := TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais) - TruncaValor(aTotal,DmWorkCom.PAFECF.gDecimais);
   if aResto < 0 then
      aResto := 0;
   CdsTotalPago.Edit;
   CdsTotalPagoTATALPAGO.AsFloat := aTotal;
   CdsTotalPagoRESTANTE.AsFloat  := aResto;
   CdsTotalPago.Post;
   // verifica se total de pagamento ja foi alcançada e fecha a tela
   if aTotal >= DataCupom.DataSet.FieldByName('VALOR').AsFloat then
   begin
     ActConfirmarExecute(Sender);
   end;

end;

procedure TFrmFecharCupom.Excluirformadepagamento1Click(Sender: TObject);
var aTotal, aResto : Double;
begin
  inherited;
  // apaga forma de pagamento incluida
  if DataPagamento.DataSet.RecordCount > 0 then
  begin
    if Confirmacao('Confirma a exclusão desta forma de pagamento?') then
    begin
      if DataPagamento.DataSet.FieldByName('CONFIRMADO').AsString = 'N' then
      begin
        DataPagamento.DataSet.Delete;
        Grava_Dados(DataPagamento.DataSet);
        // grava total pago
        aTotal := DmWorkCom.RetornaTotalFormaPafCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
        aResto := DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat - aTotal;
        if aResto < 0 then
           aResto := 0;
        CdsTotalPago.Edit;
        CdsTotalPagoTATALPAGO.AsFloat := aTotal;
        CdsTotalPagoRESTANTE.AsFloat  := aResto;
        CdsTotalPago.Post;
      end
      else MessageDlg('Forma de pagamento confirmada não pode ser excluída!', mtWarning, [mbOK], 0);
    end;
  end;  
end;

procedure TFrmFecharCupom.FormCreate(Sender: TObject);
begin
  inherited;
  sTroco := 0;
  if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fechamento.jpg') then
    ImgFundo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fechamento.jpg');
  //
  if not CdsTotalPago.Active then
     CdsTotalPago.CreateDataSet;
  CdsTotalPago.EmptyDataSet;
  CdsTotalPago.Append;
  CdsTotalPagoTATALPAGO.AsFloat := 0;
  CdsTotalPago.Post;
  //
  TFloatField(CdsTotalPago.FieldByName('TATALPAGO')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(CdsTotalPago.FieldByName('RESTANTE')).DisplayFormat  := DmWorkCom.PAFECF.gMascaraDec;
  
end;

procedure TFrmFecharCupom.DataPagamentoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if DataPagamento.DataSet.Active then
  begin
    DbDesc.Enabled  := true;
    DbAcres.Enabled := true;
    if DataPagamento.DataSet.RecordCount > 0 then
    begin
      DbDesc.Enabled  := false;
      DbAcres.Enabled := false;
    end;
  end;

end;

procedure TFrmFecharCupom.ActDinheiroExecute(Sender: TObject);
begin
  inherited;
  sVincular := 'N';
  sFormaPag := 0;
  ActIncluirExecute(Sender);

end;

procedure TFrmFecharCupom.ActChequeExecute(Sender: TObject);
var aCartoes : Integer;
begin
  inherited;
  // verifica se forma de pagamento vincula

//fabricio inicio
{
  sVincular := 'N';
  if Confirmacao('Deseja realizar consulta do cheque?') then
  begin
    aCartoes := RetornaNumCartoesFechamento(DataCupom.DataSet.FieldByName('ID').AsInteger);
    if (aCartoes < DmWorkCom.PAFECF.gCartoes) or
       (DmWorkCom.PAFECF.gCartoes = 0) then
    begin
      sVincular := 'S';
      sFormaPag := 1;
      ActIncluirExecute(Sender);
    end
    else
      MessageDlg('Numero de transações permitidas já atingido!', mtInformation, [mbOK], 0);
  end
  else
  begin
 //fabricio fim
 }
    sVincular := 'N';
    sFormaPag := 1;
    ActIncluirExecute(Sender);
//fabricio  end;

end;

procedure TFrmFecharCupom.ActCartaoExecute(Sender: TObject);
var aCartoes : Integer;
begin
  inherited;
  if DataFormaPag.DataSet.FieldByName('TIPO_DOCUMENTO').AsInteger <> 2 then
  begin
    MessageDlg('É necessário selecionar uma forma de pagamento para cartão!!', mtInformation, [mbOK], 0);
    Exit
  end;
  //
  aCartoes := RetornaNumCartoesFechamento(DataCupom.DataSet.FieldByName('ID').AsInteger);
  if (aCartoes < DmWorkCom.PAFECF.gCartoes) or
     (DmWorkCom.PAFECF.gCartoes = 0) then
  begin
    sVincular := 'N';
//fabricio tirar    if Confirmacao('Deseja emitir documento vinculado para o documento?') then
//fabricio tirar       sVincular := 'S';
    sFormaPag := 2;
    ActIncluirExecute(Sender);
  end
  else
    MessageDlg('Numero de transações permitidas já atingido!', mtInformation, [mbOK], 0);

end;

procedure TFrmFecharCupom.ActPromissoriaExecute(Sender: TObject);
begin
  inherited;
//fabriciO novo inicio
{
  if comboformapag.Text = 'A VISTA' then
  Begin
    ShowMessage('VENDA PROMISSÓRIA A VISTA?');
    if Confirmacao('CANCELAR A VENDA A VISTA PARA PROMISSÓRIA?') then
       Exit;
  End;
}
  if DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger = ClienteCupom.ID then
  begin

  try
  Application.CreateForm(TfrmIdenticaCliente,frmIdenticaCliente);
  FrmIdenticaCliente.IDCliente := DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger;
  FrmIdenticaCliente.EdtCliente.Text     := '';
  FrmIdenticaCliente.EdtEndereco.Text    := '';
  FrmIdenticaCliente.EdtCidade.Text      := '';
  FrmIdenticaCliente.EdtCep.Text         := '';
  FrmIdenticaCliente.EdtCPF.Text         := '';
  FrmIdenticaCliente.EdtIdentidade.Text  := '';
  FrmIdenticaCliente.EdtPlaca.Text       := '';
  FrmIdenticaCliente.EdtOdometro.Text    := '';
  FrmIdenticaCliente.EdtNumero.Text      := '';
  FrmIdenticaCliente.EdtComplemento.Text := '';
  FrmIdenticaCliente.EdtBairro.Text      := '';
  frmIdenticaCliente.ShowModal;
  finally
    frmIdenticaCliente.Destroy;
  end;


      if DmClientes.Dados_Contato(ClienteCupom.ID) then
      begin
       if DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger = ClienteCupom.ID then
       begin
          ShowMessage('É necessário informar um cliente para venda a prazo');
          Exit;
       end;
       if not(DataCupom.DataSet.State in [dsinsert,dsedit]) then
          DataCupom.DataSet.Edit;

        DataCupom.DataSet.FieldByName('IDCLIENTE').AsInteger := ClienteCupom.ID;
        DataCupom.DataSet.FieldByName('CLIENTE').AsString := ClienteCupom.Cliente;
        DataCupom.DataSet.FieldByName('END_ENTREGA').AsString := ClienteCupom.Endereco;
        DataCupom.DataSet.FieldByName('NUM_END_ENTREGA').AsString :=
          ClienteCupom.Numero;
        DataCupom.DataSet.FieldByName('COMPL_END_ENTREGA').AsString :=
          ClienteCupom.Complemento;
        DataCupom.DataSet.FieldByName('BAIRRO_END_ENTREGA').AsString :=
          ClienteCupom.Bairro;
        DataCupom.DataSet.FieldByName('CID_END_ENTREGA').AsString :=
          ClienteCupom.Cidade;
        DataCupom.DataSet.FieldByName('UF_END_ENTREGA').AsString := ClienteCupom.UF;
        DataCupom.DataSet.FieldByName('CEP_END_ENTREGA').AsString := ClienteCupom.Cep;
        DataCupom.DataSet.FieldByName('CNPJCPF').AsString := ClienteCupom.CPF;
        DataCupom.DataSet.FieldByName('INSCEST').AsString := ClienteCupom.Identidade;
        DataCupom.DataSet.FieldByName('PLACA_VEIC').AsString := ClienteCupom.Placa;
        DataCupom.DataSet.FieldByName('ODOMETRO').AsString := ClienteCupom.Odometro;
      end;
      // confirma os dados no banco
      Grava_Dados(DataCupom.DataSet);


  end;






//  if DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger = ClienteCupom.ID then
//  begin
//    MessageDlg('Não é permitido venda a prazo para cupom identificado para consumidor final!', mtWarning, [mbOK], 0);
//    Exit;
//  end;
  // verifica se forma de pagamento vincula
  sVincular := 'N';
//  if Confirmacao('Deseja emitir documento vinculado para o documento?') then
//     sVincular := 'S';
  sFormaPag := 3;
  ActIncluirExecute(Sender);

end;

procedure TFrmFecharCupom.ActCarnetExecute(Sender: TObject);
begin
  inherited;
  if DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger = ClienteCupom.ID then
  begin
    MessageDlg('Não é permitido venda a prazo para cupom identificado para consumidor final!', mtWarning, [mbOK], 0);
    Exit;
  end;
  // verifica se forma de pagamento vincula
  sVincular := 'N';
  if Confirmacao('Deseja emitir documento vinculado para o documento?') then
     sVincular := 'S';
  sFormaPag := 4;
  ActIncluirExecute(Sender);

end;

procedure TFrmFecharCupom.ActBoletoExecute(Sender: TObject);
begin
  inherited;
  if DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger = ClienteCupom.ID then
  begin
    MessageDlg('Não é permitido venda a prazo para cupom identificado para consumidor final!', mtWarning, [mbOK], 0);
    Exit;
  end;
  // verifica se forma de pagamento vincula
  sVincular := 'N';
  if Confirmacao('Deseja emitir documento vinculado para o documento?') then
     sVincular := 'S';
  sFormaPag := 5;
  ActIncluirExecute(Sender);

end;

procedure TFrmFecharCupom.ActOutrasExecute(Sender: TObject);
begin
  inherited;
  sVincular := 'N';
  sFormaPag := 6;
  ActIncluirExecute(Sender);

end;

end.
