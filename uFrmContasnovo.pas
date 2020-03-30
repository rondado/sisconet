unit uFrmContasnovo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmConsPadrao, Data.DB, Data.FMTBcd,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList,
  Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, frxClass, frxDBSet;

type
  TFrmContasnovo = class(TFrmConsPadrao)
    BitBtn2: TBitBtn;
    ActQuitar: TAction;
    StatusBar1: TStatusBar;
    BitBtn3: TBitBtn;
    ActRemoveQuit: TAction;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    GrpPeriodo: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    ChPeriodo: TCheckBox;
    RadioStatusConsulta: TRadioGroup;
    DataItens: TDataSource;
    DspItens: TDataSetProvider;
    QryItens: TSQLQuery;
    CdsItens: TClientDataSet;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    CdsConsultaDATA_LANC: TSQLTimeStampField;
    CdsConsultaDATA_VENC: TSQLTimeStampField;
    CdsConsultaID: TIntegerField;
    CdsConsultaNUMCONTA: TStringField;
    CdsConsultaCONTATO: TStringField;
    CdsConsultaVALOR_CONTA: TFloatField;
    CdsConsultaDATA_QUIT: TSQLTimeStampField;
    CdsConsultaVALOR_QUITATO: TFloatField;
    CdsConsultaSERIE: TIntegerField;
    QryConsultaDATA_LANC: TSQLTimeStampField;
    QryConsultaDATA_VENC: TSQLTimeStampField;
    QryConsultaID: TIntegerField;
    QryConsultaNUMCONTA: TStringField;
    QryConsultaCONTATO: TStringField;
    QryConsultaVALOR_CONTA: TFloatField;
    QryConsultaDATA_QUIT: TSQLTimeStampField;
    QryConsultaVALOR_QUITATO: TFloatField;
    QryConsultaSERIE: TIntegerField;
    QryConsultaIDPEDIDO: TIntegerField;
    CdsConsultaIDPEDIDO: TIntegerField;
    QryConsultaSTATUS: TIntegerField;
    CdsConsultaSTATUS: TIntegerField;
    frxDBDataset2: TfrxDBDataset;
    frxDBDataset3: TfrxDBDataset;
    QryConsultaID_1: TIntegerField;
    QryConsultaPEDIDO_NUM: TStringField;
    QryConsultaDATA_PEDIDO: TSQLTimeStampField;
    QryConsultaVALOR: TFloatField;
    QryConsultaDESCONTO: TFloatField;
    QryConsultaACRESCIMO: TFloatField;
    QryConsultaOUTRAS_DESPESAS: TFloatField;
    QryConsultaVALOR_TOTAL: TFloatField;
    CdsConsultaID_1: TIntegerField;
    CdsConsultaPEDIDO_NUM: TStringField;
    CdsConsultaDATA_PEDIDO: TSQLTimeStampField;
    CdsConsultaVALOR: TFloatField;
    CdsConsultaDESCONTO: TFloatField;
    CdsConsultaACRESCIMO: TFloatField;
    CdsConsultaOUTRAS_DESPESAS: TFloatField;
    CdsConsultaVALOR_TOTAL: TFloatField;
    DataCliente: TDataSource;
    CdsCliente: TClientDataSet;
    DspCliente: TDataSetProvider;
    QryCliente: TSQLQuery;
    QryClienteID: TIntegerField;
    QryClienteNOME: TStringField;
    QryClienteCNPJ_CPF: TStringField;
    QryClienteCIDADE_END: TStringField;
    QryClienteUF_END: TStringField;
    QryClienteTELEFONE: TStringField;
    QryClienteATIVO: TStringField;
    QryClienteTIPO_CONTATO: TStringField;
    CdsClienteID: TIntegerField;
    CdsClienteNOME: TStringField;
    CdsClienteCNPJ_CPF: TStringField;
    CdsClienteCIDADE_END: TStringField;
    CdsClienteUF_END: TStringField;
    CdsClienteTELEFONE: TStringField;
    CdsClienteATIVO: TStringField;
    CdsClienteTIPO_CONTATO: TStringField;
    QryConsultaIDCONTATO: TIntegerField;
    CdsConsultaIDCONTATO: TIntegerField;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LbClientes: TLabel;
    LbConta: TLabel;
    LbQuitado: TLabel;
    CdsPeriodo: TClientDataSet;
    CdsPeriododata_inicio: TDateField;
    CdsPeriododata_final: TDateField;
    frxDBDataset4: TfrxDBDataset;
    Label6: TLabel;
    lbnegociado: TLabel;
    Label7: TLabel;
    lbgeralquitado: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lbgeralnegociado: TLabel;
    lbgeraldevido: TLabel;
    DataSource1: TDataSource;
    DataSetProvider1: TDataSetProvider;
    CdsPeriodototalconta: TCurrencyField;
    CdsPeriodototalquitado: TCurrencyField;
    CdsPeriodototalnegociado: TCurrencyField;
    QryConsultaIDFORMA_PAGTO: TIntegerField;
    QryConsultaCOO: TIntegerField;
    QryConsultaCCF: TIntegerField;
    CdsConsultaIDFORMA_PAGTO: TIntegerField;
    CdsConsultaCOO: TIntegerField;
    CdsConsultaCCF: TIntegerField;
    CdsConsultaFORMAPAGTO: TStringField;
    procedure FormShow(Sender: TObject);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure ActQuitarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActImprimirExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure ActAlterarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridDadosDblClick(Sender: TObject);
    procedure GridDadosKeyPress(Sender: TObject; var Key: Char);
    procedure ActRemoveQuitExecute(Sender: TObject);
    procedure EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
    procedure CdsConsultaAfterOpen(DataSet: TDataSet);
    procedure CdsClienteAfterOpen(DataSet: TDataSet);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CapturaTotaisPeriodo;
  public
    { Public declarations }
    sIDCta : Integer;
    sApenasConsulta : Boolean;
    procedure PassaPeriodoRelatorio(pDatai,pDataf:TdateTime;totalconta,totalquitado,totalnegociado:currency);
  end;

var
  FrmContasnovo: TFrmContasnovo;
  iddopedido: integer;
  totalconta,totalquitado,totalnegociado: currency;

implementation

{$R *.dfm}

uses uDmWorkCom, uLibrary, uFrmCadastroCliente, uFrmClientes, uFrmCadContas,
  uFrmSelEndereco, uFrmContatosADC, uDmconexao;
//fabricio novo inicio
procedure TFrmContasnovo.PassaPeriodoRelatorio(pDatai,pDataf:TdateTime;totalconta,totalquitado,totalnegociado:currency);
begin
  with CdsPeriodo do
  begin
    if not Active then
    begin
       CreateDataSet;
       EmptyDataSet;
    end
    else EmptyDataSet;
    Append;
    FieldByName('data_inicio').AsDateTime := pDatai;
    FieldByName('data_final').AsDateTime := pDataf;
    FieldByName('totalconta').AsCurrency := totalconta;
    FieldByName('totalquitado').AsCurrency := totalquitado;
    FieldByName('totalnegociado').AsCurrency := totalnegociado;
    Post;
  end;

end;
//fabricio fim novo
procedure TFrmContasnovo.ActAlterarExecute(Sender: TObject);
begin
  inherited;
  if CdsConsulta.FieldByName('STATUS').AsInteger = 1 then
  begin
    MessageDlg('Esta conta já está quitada no sistema.', mtWarning, [mbOK], 0);
    Exit;
  end;
  //
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    try
      Application.CreateForm(TFrmCadContas,FrmCadContas);
      Application.CreateForm(TFrmCadastroCliente,FrmCadastroCliente);
      Application.CreateForm(TFrmClientes,FrmClientes);
      Application.CreateForm(TFrmSelEndereco,FrmSelEndereco);
      Application.CreateForm(TFrmContatosADC,FrmContatosADC);
      FrmCadContas.sIDConta := DataConsulta.DataSet.FieldByName('ID').AsInteger;
      DmWorkCom.sProcessoQui := 0;
      if DmWorkCom.sTipoConta = 0 then
         FrmCadContas.GrpContato.Caption := ' Cliente '
      else
         FrmCadContas.GrpContato.Caption := ' Fornecedores ';
      FrmCadContas.ShowModal;
      ActLocalizarExecute(Sender);
    finally
      FreeAndNil(FrmContatosADC);
      FreeAndNil(FrmSelEndereco);
      FreeAndNil(FrmCadastroCliente);
      FreeAndNil(FrmClientes);
      FreeAndNil(FrmCadContas);
    end;
  end;

end;

procedure TFrmContasnovo.ActExcluirExecute(Sender: TObject);
begin
  inherited;
  if CdsConsulta.FieldByName('STATUS').AsInteger = 1 then
  begin
    MessageDlg('Esta conta já está quitada no sistema.'+#13+#10+
               'Para excluir, use a opção de remover a quitação!!!', mtWarning, [mbOK], 0);
    Exit;
  end;
  //
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    if DmWorkCom.Dados_Contas(DataConsulta.DataSet.FieldByName('ID').AsInteger) then
    begin
      if Confirmacao('Confirma a exclusão da conta selecionada?') then
      begin
        DmWorkCom.CdsContas.Delete;
        Grava_Dados(DmWorkCom.CdsContas);
        ActLocalizarExecute(Sender);
      end;
    end;
  end;

end;

procedure TFrmContasnovo.ActImprimirExecute(Sender: TObject);
begin
  inherited;
  PassaPeriodoRelatorio(Datai.Date,Dataf.Date,totalconta,totalquitado,totalnegociado);
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ContasDetalhesok.fr3');
  frxReport1.ShowReport;

end;

procedure TFrmContasnovo.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  totalconta := 0;
  totalquitado :=0;
  totalnegociado:=0;

  //fabricio alterou tudo

  // consulta de contas
  CdsCliente.Close;
  CdsCliente.Params.Clear;
  QryCliente.Close;
  QryCliente.SQL.Clear;

  QryCliente.SQL.Add('select contato.id,contato.nome,contato.cnpj_cpf, contato.cidade_end,contato.uf_end,contato.telefone, contato.ativo, contato.tipo_contato from contato ');
  QryCliente.SQL.Add(' where upper(contato.nome) like :pLocaliza');

  QryCliente.SQL.Add(' order by contato.nome');

  CdsCliente.FetchParams;
  CdsCliente.Params.ParamByName('pLocaliza').AsString := UpperCase(EdtLocalizar.Text)+'%';

  // parametros
  CdsCliente.Open;

    if DataCliente.DataSet.RecordCount = 0 then
    begin
      ShowMessage('Cliente não encontrado');
      Abort;
    end;


  CdsCliente.First;



  // consulta de contas
  CdsConsulta.Close;
  CdsConsulta.Params.Clear;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;
  //fabricio incluido o campo contas.idpedido (incluir tbem na string do object inspector do qryconsulta e no add fields do qryconsulta e cdsconsulta
  QryConsulta.SQL.Add('select contas.data_lanc,contas.data_venc,Contas.ID, contas.idpedido,');
  QryConsulta.SQL.Add('contas.numconta,contas.contato,contas.idcontato,contas.valor_conta, contas.status,');
  QryConsulta.SQL.Add('contas.idforma_pagto,contas.data_quit,contas.valor_quitato,Contas.Serie,');
//fabricio novo abaixo
  QryConsulta.SQL.Add(' pedido.coo, pedido.ccf, pedido.id, pedido.pedido_num, pedido.data_pedido, pedido.valor, pedido.desconto,pedido.acrescimo,pedido.outras_despesas, pedido.valor_total ');
  QryConsulta.SQL.Add('from contas inner join pedido on pedido.id = contas.idpedido ');
  QryConsulta.SQL.Add('where contas.idcontato = :IDCONTATO');


//  QryConsulta.SQL.Add('and contas.idcontato > 0');

  // período
  if not ChPeriodo.Checked then
     QryConsulta.SQL.Add('and contas.data_lanc between :pDatai and :pDataf')
  else if ChPeriodo.Checked then
     QryConsulta.SQL.Add('and contas.data_venc between :pDatai and :pDataf');
  QryConsulta.SQL.Add('and Contas.tipo = :pTipo');

//fabricio inicio
if RadioStatusConsulta.ItemIndex < 3 then
   QryConsulta.SQL.Add('and Contas.status = :pStatus')
else
begin
   QryConsulta.SQL.Add('and Contas.status < :pStatus');
end;
//fabricio fim

  // tipo de pesquisa

  if CbxTipoPesq.ItemIndex = 0 then  // nome do contati
     QryConsulta.SQL.Add('and upper(contas.contato) like :pLocaliza')
  else if CbxTipoPesq.ItemIndex = 1 then // doc. do contato
     QryConsulta.SQL.Add('and contas.doc_contato = :pLocaliza')
  else if CbxTipoPesq.ItemIndex = 2 then // numeroDoc
     QryConsulta.SQL.Add('and contas.numconta = :pLocaliza')
  else if CbxTipoPesq.ItemIndex = 3 then // Id do pedido
     QryConsulta.SQL.Add('and contas.idpedido = :pLocaliza');

  // parametros
  CdsConsulta.FetchParams;
  CdsConsulta.Params.ParamByName('IDCONTATO').AsString     := CdsCliente.FieldByName('ID').AsString;
  CdsConsulta.Params.ParamByName('pDatai').AsDate     := Datai.Date;
  CdsConsulta.Params.ParamByName('pDataf').AsDate     := Dataf.Date;
  CdsConsulta.Params.ParamByName('pTipo').AsInteger   := DmWorkCom.sTipoConta;
  CdsConsulta.Params.ParamByName('pStatus').AsInteger := RadioStatusConsulta.ItemIndex;

//fabricio
if RadioStatusConsulta.ItemIndex < 3 then
  CdsConsulta.Params.ParamByName('pStatus').AsInteger := RadioStatusConsulta.ItemIndex
else
  CdsConsulta.Params.ParamByName('pStatus').AsInteger := 7;

  if CbxTipoPesq.ItemIndex = 0 then
     CdsConsulta.Params.ParamByName('pLocaliza').AsString := UpperCase(EdtLocalizar.Text)+'%'
  else if CbxTipoPesq.ItemIndex = 1 then
     CdsConsulta.Params.ParamByName('pLocaliza').AsString := EdtLocalizar.Text
  else if CbxTipoPesq.ItemIndex = 2 then
     CdsConsulta.Params.ParamByName('pLocaliza').AsString := EdtLocalizar.Text
  else if CbxTipoPesq.ItemIndex = 3 then
     CdsConsulta.Params.ParamByName('pLocaliza').AsInteger := StrToInt(EdtLocalizar.Text);



  QryConsulta.SQL.Add('order by contas.contato, contas.idpedido');
  CdsConsulta.Open;



//fabricionovo  TFloatField(DataConsulta.DataSet.FieldByName('valor_conta')).DisplayFormat := '###,###,###0.000';
//fabricionovo  TFloatField(DataConsulta.DataSet.FieldByName('valor_quitato')).DisplayFormat := '###,###,###0.000';
  CdsConsulta.RecordCount;
  // captura o total recebibo e quitado
//  CapturaTotaisPeriodo;

 //fabricio
  CdsItens.Close;
  CdsItens.Params.Clear;
  QryItens.Close;
  QryItens.SQL.Clear;
//fabricio idpedido
  QryItens.SQL.Add('select pedido_itens.* ');
  QryItens.SQL.Add('from pedido_itens inner join pedido on pedido.id = pedido_itens.idpedido ');
  QryItens.SQL.Add('where pedido_itens.idpedido = :IDPEDIDO');

  CdsItens.FetchParams;
  CdsItens.Params.ParamByName('IDPEDIDO').AsInteger     := CdsConsulta.FieldByName('IDPEDIDO').AsInteger;
  CdsItens.Open;
//  DbGrid2.Refresh;
//fabricio fim







//  if Datacliente.DataSet.RecordCount = 1 then


  LbConta.Caption:= 'R$ 0,00';
  LbQuitado.Caption:= 'R$ 0,00';
  Lbnegociado.Caption:= 'R$ 0,00';



  lbgeralquitado.Caption:= FormatFloat('R$ #,##0.00',totalquitado);
  lbgeralnegociado.Caption:= FormatFloat('R$ #,##0.00',totalnegociado);
  lbgeraldevido.Caption:= FormatFloat('R$ #,##0.00',totalconta);
  CdsCliente.First;
  CdsConsulta.First;



  DbGrid1.columns[0].Width:=400;
  DbGrid2.columns[0].Width:=120;


  Totalquitado:=0;
  totalnegociado:=0;
  totalconta:=0;
  Dbgrid1.OnCellClick(Dbgrid1.Columns[0]);
  EdtLocalizar.SetFocus;

end;

procedure TFrmContasnovo.ActNovoExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmCadContas,FrmCadContas);
    Application.CreateForm(TFrmCadastroCliente,FrmCadastroCliente);
    Application.CreateForm(TFrmClientes,FrmClientes);
    Application.CreateForm(TFrmSelEndereco,FrmSelEndereco);
    Application.CreateForm(TFrmContatosADC,FrmContatosADC);
    FrmCadContas.sIDConta := 0;
    DmWorkCom.sProcessoQui := 0;
    if DmWorkCom.sTipoConta = 0 then
    begin
       FrmCadContas.Caption := 'Cadastro de Contas a receber';
       FrmCadContas.GrpContato.Caption := ' Cliente ';
    end
    else
    begin
       FrmCadContas.Caption := 'Cadastro de Contas a pagar';
       FrmCadContas.GrpContato.Caption := ' Fornecedores ';
    end;
    FrmCadContas.ShowModal;
    ActLocalizarExecute(Sender);
  finally
    FreeAndNil(FrmContatosADC);
    FreeAndNil(FrmSelEndereco);
    FreeAndNil(FrmCadastroCliente);
    FreeAndNil(FrmClientes);
    FreeAndNil(FrmCadContas);
  end;

end;

procedure TFrmContasnovo.ActQuitarExecute(Sender: TObject);
begin
  inherited;
  if DataConsulta.DataSet.RecordCount = 0 then
  begin
    MessageDlg('É necessário selecionar a conta a ser quitada!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  if not DmWorkCom.Dados_Contas(DataConsulta.DataSet.FieldByName('ID').AsInteger) then
  begin
    MessageDlg('É foi localizado a conta a ser quitada!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  if (DmWorkCom.CdsContas.FieldByName('DATA_QUIT').AsDateTime > 0) or
     (not DmWorkCom.CdsContas.FieldByName('DATA_QUIT').IsNull) or
     (DmWorkCom.CdsContas.FieldByName('STATUS').AsInteger = 1) then
  begin
    MessageDlg('Esta conta já se encontra quitada no sistema. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  // verifica caixa aberto
  if sLancCaixa = 'S' then
  begin
    if not DmWorkCom.Dados_Caixa(SVData,true) then //fabricio - colocado o true
    begin
      MessageDlg('Favor proceder a abertura do caixa diário!!!', mtWarning, [mbOK], 0);
      DmWorkCom.Dados_Contas(0);
      Exit;
    end;
    DmWorkCom.Dados_CaixaMov(DmWorkCom.CdsCaixa.FieldByname('ID').AsInteger);
  end;
  //
  try
    Application.CreateForm(TFrmCadContas,FrmCadContas);
    Application.CreateForm(TFrmCadastroCliente,FrmCadastroCliente);
    Application.CreateForm(TFrmClientes,FrmClientes);
    Application.CreateForm(TFrmSelEndereco,FrmSelEndereco);
    Application.CreateForm(TFrmContatosADC,FrmContatosADC);
    FrmCadContas.sIDConta := DataConsulta.DataSet.FieldByName('ID').AsInteger;
    DmWorkCom.sProcessoQui := 1;
    if DmWorkCom.sTipoConta = 0 then
    begin
      FrmCadContas.Caption := 'Quitação de Contas a receber';
      FrmCadContas.GrpContato.Caption := ' Cliente ';
    end
    else
    begin
      FrmCadContas.Caption := 'Quitação de Contas a pagar';
      FrmCadContas.GrpContato.Caption := ' Fornecedores ';
    end;
    FrmCadContas.ShowModal;
    DmWorkCom.sProcessoQui := 0;
    ActLocalizarExecute(Sender);
  finally
    FreeAndNil(FrmContatosADC);
    FreeAndNil(FrmSelEndereco);
    FreeAndNil(FrmCadastroCliente);
    FreeAndNil(FrmClientes);
    FreeAndNil(FrmCadContas);
  end;

end;

procedure TFrmContasnovo.ActRemoveQuitExecute(Sender: TObject);
begin
  inherited;
  if not CdsConsulta.IsEmpty then
  begin
    if CdsConsulta.FieldByName('STATUS').AsInteger = 1 then
    begin
      if DmWorkCom.Dados_Contas(CdsConsulta.FieldByName('ID').AsInteger) then
      begin
        if Confirmacao('Confirma a retirada de quitação da conta selecionada?') then
        begin
          DmWorkCom.sRemoveQui := 1;
          DmWorkCom.sProcessoQui := 0;
          if not(DmWorkCom.CdsContas.State in [dsInsert,dsEdit]) then
             DmWorkCom.CdsContas.Edit;
          DmWorkCom.CdsContas.FieldByName('DATA_QUIT').Clear;
//fabricio novo
          DmWorkCom.sValorQuitato:= DmWorkCom.CdsContas.FieldByName('VALOR_QUITATO').AsFloat;
          DmWorkCom.CdsContas.FieldByName('VALOR_QUITATO').AsFloat := 0;
          DmWorkCom.CdsContas.FieldByName('STATUS').AsInteger      := 0;
  //        DmWorkCom.sValorQuitacao := 0;
          Grava_Dados(DmWorkCom.CdsContas);
          DmWorkCom.sRemoveQui := 0;
          DmWorkCom.Dados_Contas(0);
          ActLocalizarExecute(Sender);
        end;
      end
      else MessageDlg('É foi localizado a conta a ser retirada a quitação!!!', mtWarning, [mbOK], 0);
    end
    else MessageDlg('Esta conta não está quitada no sistema. Verifique!!!', mtWarning, [mbOK], 0);
  end
  else MessageDlg('É necessário selecionar a conta para remover a quitação!!!', mtWarning, [mbOK], 0);
DmWorkCom.sValorQuitato:=0;
end;

procedure TFrmContasnovo.CapturaTotaisPeriodo;
var Q : TSQLQuery;
begin
  StatusBar1.Panels.Items[1].Text := FormatFloat('0.00',0);
  StatusBar1.Panels.Items[3].Text := FormatFloat('0.00',0);
  Q := TSQLQuery.Create(nil);
  Q.SQLConnection := DmConexao.ConexaoDBX;
  Q.Close;
  Q.SQL.Clear;
  Q.SQL.Add('select sum((x.valor_conta + x.valor_acrescimo +');
  Q.SQL.Add('            x.juros + x.multa) -');
  Q.SQL.Add('            x.valor_desconto) as valor_conta,');
  Q.SQL.Add('       sum(x.valor_quitato) as valor_quitato');
  Q.SQL.Add('from contas x');
  // período
  if not ChPeriodo.Checked then
     Q.SQL.Add('where x.data_lanc between :pDatai and :pDataf')
  else if ChPeriodo.Checked then
     Q.SQL.Add('where x.data_venc between :pDatai and :pDataf');

  Q.SQL.Add('and x.tipo = :pTipo');
//  Q.SQL.Add('and x.status = :pStatus');
  // tipo de pesquisa
  if CbxTipoPesq.ItemIndex = 0 then  // nome do contati
     Q.SQL.Add('and upper(x.contato) like :pLocaliza')
  else if CbxTipoPesq.ItemIndex = 1 then // doc. do contato
     Q.SQL.Add('and x.doc_contato = :pLocaliza')
  else if CbxTipoPesq.ItemIndex = 2 then // numeroDoc
     Q.SQL.Add('and x.numconta = :pLocaliza')
  else if CbxTipoPesq.ItemIndex = 3 then // Id do pedido
     Q.SQL.Add('and x.idpedido = :pLocaliza');

  // parametros
  Q.Params.ParamByName('pDatai').AsDate     := Datai.Date;
  Q.Params.ParamByName('pDataf').AsDate     := Dataf.Date;
  Q.Params.ParamByName('pTipo').AsInteger   := DmWorkCom.sTipoConta;
//  Q.Params.ParamByName('pStatus').AsInteger := RadioStatusConsulta.ItemIndex;
  if CbxTipoPesq.ItemIndex = 0 then
     Q.Params.ParamByName('pLocaliza').AsString := UpperCase(EdtLocalizar.Text)+'%'
  else if CbxTipoPesq.ItemIndex = 1 then
     Q.Params.ParamByName('pLocaliza').AsString := EdtLocalizar.Text
  else if CbxTipoPesq.ItemIndex = 2 then
     Q.Params.ParamByName('pLocaliza').AsString := EdtLocalizar.Text
  else if CbxTipoPesq.ItemIndex = 3 then
     Q.Params.ParamByName('pLocaliza').AsInteger := StrToInt(EdtLocalizar.Text);
  //
  Q.Open;
  StatusBar1.Panels.Items[1].Text := FormatFloat('0.00',Q.FieldByName('valor_conta').AsFloat-
                                        Q.FieldByName('valor_quitato').AsFloat);
  StatusBar1.Panels.Items[3].Text := FormatFloat('0.00',Q.FieldByName('valor_quitato').AsFloat);
  Q.Close;

end;

procedure TFrmContasnovo.CdsClienteAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LbClientes.Caption:= FormatFloat('000',CdsCliente.RecordCount);
end;

procedure TFrmContasnovo.CdsConsultaAfterOpen(DataSet: TDataSet);
var
valor_conta, valor_quitado, valor_negociado: currency;

begin
  inherited;
  Valor_conta := 0;
  valor_quitado :=0;
  valor_negociado :=0;


  while not CdsCliente.Eof do
  begin
      Cdsconsulta.First;
      while not CdsConsulta.Eof do
      begin
        if CdsConsultaStatus.AsInteger = 0 then
        begin
           valor_conta := CdsconsultaValor_Conta.AsCurrency + valor_conta;
           totalconta:= totalconta + CdsconsultaValor_Conta.AsCurrency;
        end
        else
        if CdsConsultaStatus.AsInteger = 1 then
        begin
           valor_quitado := CdsConsultaValor_Quitato.AsCurrency + valor_quitado;
           totalquitado := totalquitado + CdsConsultaValor_Quitato.AsCurrency;
        end
        else
        if CdsConsultaStatus.AsInteger = 2 then
        begin
           valor_negociado := CdsconsultaValor_Conta.AsCurrency + valor_negociado;
           totalnegociado:= totalnegociado + CdsconsultaValor_Conta.AsCurrency;
        end;
        CdsConsulta.Next;
      end;
      CdsCliente.Next;
  end;
    LbConta.Caption:= FormatFloat('R$ #,##0.00',valor_conta);
    LbQuitado.Caption:= FormatFloat('R$ #,##0.00',valor_quitado);
    Lbnegociado.Caption:= FormatFloat('R$ #,##0.00',valor_negociado);



end;

procedure TFrmContasnovo.DBGrid1CellClick(Column: TColumn);
var
valor_conta, valor_quitado, valor_negociado: currency;

begin
     inherited;
//fabricio inicio
  Valor_conta := 0;
  valor_quitado :=0;
  valor_negociado :=0;
      Cdsconsulta.First;
      while not CdsConsulta.Eof do
      begin
        if CdsConsultaStatus.AsInteger = 0 then
        begin
           valor_conta := CdsconsultaValor_Conta.AsCurrency + valor_conta;
           totalconta:= totalconta + CdsconsultaValor_Conta.AsCurrency;
        end
        else
        if CdsConsultaStatus.AsInteger = 1 then
        begin
           valor_quitado := CdsConsultaValor_Quitato.AsCurrency + valor_quitado;
           totalquitado := totalquitado + CdsConsultaValor_Quitato.AsCurrency;
        end
        else
        if CdsConsultaStatus.AsInteger = 2 then
        begin
           valor_negociado := CdsconsultaValor_Conta.AsCurrency + valor_negociado;
           totalnegociado:= totalnegociado + CdsconsultaValor_Conta.AsCurrency;
        end;
        CdsConsulta.Next;
      end;

    LbConta.Caption:= FormatFloat('R$ #,##0.00',valor_conta);
    LbQuitado.Caption:= FormatFloat('R$ #,##0.00',valor_quitado);
    Lbnegociado.Caption:= FormatFloat('R$ #,##0.00',valor_negociado);




end;



procedure TFrmContasnovo.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
valor_conta, valor_quitado, valor_negociado: currency;

begin
     inherited;
//fabricio inicio
  Valor_conta := 0;
  valor_quitado :=0;
  valor_negociado :=0;
      Cdsconsulta.First;
      while not CdsConsulta.Eof do
      begin
        if CdsConsultaStatus.AsInteger = 0 then
        begin
           valor_conta := CdsconsultaValor_Conta.AsCurrency + valor_conta;
           totalconta:= totalconta + CdsconsultaValor_Conta.AsCurrency;
        end
        else
        if CdsConsultaStatus.AsInteger = 1 then
        begin
           valor_quitado := CdsConsultaValor_Quitato.AsCurrency + valor_quitado;
           totalquitado := totalquitado + CdsConsultaValor_Quitato.AsCurrency;
        end
        else
        if CdsConsultaStatus.AsInteger = 2 then
        begin
           valor_negociado := CdsconsultaValor_Conta.AsCurrency + valor_negociado;
           totalnegociado:= totalnegociado + CdsconsultaValor_Conta.AsCurrency;
        end;
        CdsConsulta.Next;
      end;

    LbConta.Caption:= FormatFloat('R$ #,##0.00',valor_conta);
    LbQuitado.Caption:= FormatFloat('R$ #,##0.00',valor_quitado);
    Lbnegociado.Caption:= FormatFloat('R$ #,##0.00',valor_negociado);




end;

procedure TFrmContasnovo.EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

procedure TFrmContasnovo.FormCreate(Sender: TObject);
begin
  inherited;
  sApenasConsulta := false;

end;

procedure TFrmContasnovo.FormShow(Sender: TObject);
begin
  inherited;
  iddopedido:=0;

if DmWorkCom.sTipoConta = 0 then
   Self.Caption := 'Controle de contas a receber'
else
   Self.Caption := 'Controle de contas a pagar';
  DmWorkCom.Dados_Contas(0);
  Datai.Date := SVData;
  Dataf.Date := SVData;
  CbxTipoPesq.ItemIndex := 0;
  CbxTipoPesq.Text := '0 - Nome do contato';
  DmWorkCom.sProcessoQui := 0;
  ActLocalizarExecute(Sender);
  Datai.SetFocus;

end;

procedure TFrmContasnovo.GridDadosDblClick(Sender: TObject);
begin
  inherited;
  BitBtn2.Click;
 {
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    if not sApenasConsulta then
    begin
      ActAlterarExecute(Sender);
    end
    else
    begin
      sIDCta := CdsConsulta.FieldByName('ID').AsInteger;
      Close;
    end;
  end;
}
end;

procedure TFrmContasnovo.GridDadosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = #13) then
  begin
    if DataConsulta.DataSet.RecordCount > 0 then
    begin
      if not sApenasConsulta then
      begin
        ActAlterarExecute(Sender);
      end
      else
      begin
        sIDCta := CdsConsulta.FieldByName('ID').AsInteger;
        Close;
      end;
    end;
  end;

end;

end.
