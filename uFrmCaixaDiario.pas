unit uFrmCaixaDiario;
//fabricio adicionar u_relcxdiario no projeto
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ActnList, StdCtrls, Buttons, DB, ExtCtrls, Mask,
  DBCtrls, DBClient, Grids, DBGrids, System.Actions, winspool, charprinter,
  Vcl.ComCtrls;

type
  TFrmCaixaDiario = class(TFrmPadrao)
    ActionList1: TActionList;
    ActAbreCaixa: TAction;
    ActSuprimento: TAction;
    ActSangria: TAction;
    ActLancamento: TAction;
    ActFecharCaixa: TAction;
    ActEncerrar: TAction;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DataCaixa: TDataSource;
    DataCaixaMov: TDataSource;
    DbDataMov: TDBEdit;
    DbHoraAbre: TDBEdit;
    DbHoraFecha: TDBEdit;
    DbValorAbre: TDBEdit;
    DbValorFecha: TDBEdit;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    ActRecebimento: TAction;
    ActPesquisar: TAction;
    Bevel1: TBevel;
    GridCaixaMov: TDBGrid;
    CdsCaixaAux: TClientDataSet;
    CdsCaixaAuxTOTALDESPESAS: TCurrencyField;
    CdsCaixaAuxTOTALRECEITAS: TCurrencyField;
    CdsCaixaAuxTOTALMOV: TCurrencyField;
    DataCaixaAux: TDataSource;
    DbTotalRec: TDBEdit;
    DbTotalDesp: TDBEdit;
    DbTotalMov: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DataFuncionario: TDataSource;
    ComboFunc: TDBLookupComboBox;
    Label10: TLabel;
    Edit1: TEdit;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    Datac: TDateTimePicker;
    Label11: TLabel;
    Label12: TLabel;
    Edit2: TEdit;
    Datax: TDateTimePicker;
    Horac: TDateTimePicker;
    Horax: TDateTimePicker;
    RadioCx: TRadioGroup;
    Panel2: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    lbid: TLabel;
    lbhoraab: TLabel;
    lbabertopor: TLabel;
    lbvalorab: TLabel;
    lbtotrb: TLabel;
    lbtotp: TLabel;
    lbtotdesc: TLabel;
    lbtotacres: TLabel;
    lbtroco: TLabel;
    lbtotvb: TLabel;
    lbtotsup: TLabel;
    lbtotsang: TLabel;
    lbqtp: TLabel;
    lbvendacar: TLabel;
    lbqtcar: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    lbhorafe: TLabel;
    Label32: TLabel;
    lbmov: TLabel;
    Label47: TLabel;
    lbpedcan: TLabel;
    Label29: TLabel;
    lbtotgav: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    lbdinheiro: TLabel;
    lbcartao: TLabel;
    lbcheque: TLabel;
    lboutros: TLabel;
    Label37: TLabel;
    lbtotglobal: TLabel;
    Label38: TLabel;
    lbdifcaixa: TLabel;
    Panel3: TPanel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    lbqtpedcan: TLabel;
    lbtotpedinh: TLabel;
    lbtotpedche: TLabel;
    lbtotpedprz: TLabel;
    lbtotpedout: TLabel;
    lbtotnotas: TLabel;
    lbqtecf: TLabel;
    lbtotecf: TLabel;
    lbqtnotas: TLabel;
    lbqtorca: TLabel;
    lbtotorca: TLabel;
    Label70: TLabel;
    lbtotpedcar: TLabel;
    Label72: TLabel;
    lbtotpedcan: TLabel;
    Label76: TLabel;
    lbtotpedbol: TLabel;
    Label86: TLabel;
    lbtotpedcrn: TLabel;
    Label88: TLabel;
    lbtotpeddup: TLabel;
    Label90: TLabel;
    lbRecbto: TLabel;
    Label45: TLabel;
    Label48: TLabel;
    Label53: TLabel;
    lbqtpedreg: TLabel;
    Label54: TLabel;
    lbqtpedfin: TLabel;
    Label55: TLabel;
    lbtotpedreg: TLabel;
    Label56: TLabel;
    lbtotpedfin: TLabel;
    Label57: TLabel;
    lbtopcbdo: TLabel;
    Label59: TLabel;
    Label58: TLabel;
    lbqtdifpc: TLabel;
    lbtotdifpc: TLabel;
    Label60: TLabel;
    lbtotdcc: TLabel;
    procedure ActAbreCaixaExecute(Sender: TObject);
    procedure ActSuprimentoExecute(Sender: TObject);
    procedure ActSangriaExecute(Sender: TObject);
    procedure ActLancamentoExecute(Sender: TObject);
    procedure ActFecharCaixaExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActRecebimentoEecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboFuncKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
  private
    { Private declarations }
    procedure GravaTotaisCaixa;
  public
    { Public declarations }
  end;

var
  FrmCaixaDiario: TFrmCaixaDiario;

implementation

uses uLibrary, uDmWorkCom, uFrmAbreCaixa, uFrmMovCaixa, uFrmCadContas,
  uFrmCadastroCliente, uFrmClientes, uFrmSelEndereco, uFrmContatosADC,
  uDMClientes,u_relcxdiario;

{$R *.dfm}

procedure TFrmCaixaDiario.ActAbreCaixaExecute(Sender: TObject);
begin
  inherited;
  //
  if DmWorkCom.Dados_Caixa(SVData) then
  begin
    MessageDlg('Já existe caixa aberto para o dia!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  // efetua abertura
  AbreForm(TFrmAbrecaixa,FrmAbrecaixa);
  DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
  GravaTotaisCaixa;
end;

procedure TFrmCaixaDiario.ActSuprimentoExecute(Sender: TObject);
var aValorAbre:String;
    aValor:Double;
begin
  inherited;
  //
  if DataCaixa.DataSet.FieldByName('DATA_ABERTURA').AsDateTime <> SVData then
  begin
    MessageDlg('Não é permitido efetuar lançamentos em data diferente da atual!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if not DmWorkCom.Dados_Caixa(SVData) then
  begin
    MessageDlg('Não há caixa aberto. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end
  else
  begin
    if DataCaixa.DataSet.FieldByName('FECHADO').AsString = 'S' then
    begin
      MessageDlg('O caixa já foi fechado!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
  //
  if InputQuery('Suprimento','Informe o valor:',aValorAbre) then
  begin
    try
      aValor := StrToFloat(aValorAbre);
      DataCaixaMov.DataSet.Append;
      DataCaixaMov.DataSet.FieldByName('HISTORICO').AsString := 'SUPRIMENTO DE CAIXA';
      DataCaixaMov.DataSet.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
      DataCaixaMov.DataSet.FieldByName('DC').AsString        := 'C';
      DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency   := aValor;
      DataCaixaMov.DataSet.Post;
      Grava_Dados(DataCaixaMov.DataSet);
    except
      MessageDlg('Erro ao lançar suprimento!!!', mtWarning, [mbOK], 0);
    end;
  end;
  GravaTotaisCaixa;
end;

procedure TFrmCaixaDiario.BitBtn11Click(Sender: TObject);
var
  epson: string[5];
  aDataMov:String;
  aData,aDataF:TDateTime;
  Datade, Dataate, Horade, Horaate:String;
  prn: TCharPrinter;
  ContItens, contCancelados, contpedidos, contcartoes, CodCaixa: Integer;
  ValorTroco: Double;
  Handle: THandle;
  CaracteresImpressos: DWORD;
  Documento: TDocInfo1;
  TextoAnsiString : AnsiString;
  TextoUnicode: string;
  idescricao: string[28];
  ipgto:string[11];
  recbto:string[6];
  totrecbto, totreceita, totdespesa, vlrgaveta,ped_valorTotal,ped_valor,ped_Desconto, ped_acrescimo, ped_ValorTroco, totoutros: currency;
begin
  inherited;
  //
   try
    totrecbto:=0;
    vlrgaveta:=0;
    totreceita:=0;
    totdespesa:=0;
    contpedidos:=0;
    contcancelados:=0;
    ped_valorTotal:=0;
    ped_valor:=0;
    ped_Desconto:=0;
    ped_acrescimo:=0;
    ped_valorTroco:=0;
    totoutros:=0;
    contcartoes:=0;
     if Edit2.Text <> '' then
     begin
      if not DmWorkCom.Dados_CaixaID(StrToInt(Edit2.Text),false) then
      begin
        MessageDlg('Não foi encontrado movimento para o caixa informado!!!', mtWarning, [mbOK], 0);
        Abort;
      end;
      DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
      GravaTotaisCaixa;
     end
     else
     begin
      aData := Datac.DateTime;
      if not DmWorkCom.Dados_Caixa(aData) then
      begin
        MessageDlg('Não foi encontrado movimento para a data informada!!!', mtWarning, [mbOK], 0);
        Abort;
      end;
      DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
      GravaTotaisCaixa;
     end;
     CodCaixa:= DataCaixa.DataSet.FieldByname('ID').AsInteger;
     if dmworkcom.nomecupom = '' then
        exit
     else
     if not OpenPrinter(PChar(dmworkcom.nomecupom), Handle, nil) then
     begin
       ShowMessage('Impressora não encontrada. Defina em Configuraçòes de cupom');
       Exit;
     end;

      Documento.pOutputFile := nil;
      Documento.pDataType := 'RAW';

    //Inicia um novo documento no Spool do Windows
      StartDocPrinter(Handle, 1, @Documento);

    //Apenas notifica o Windows que uma nova página começará.
    //Nenhum controle é aplicado a impressora.
      StartPagePrinter(Handle);

  TextoUnicode := 'DATA DO MOVIMENTO :  '+ DbDataMov.Text
                + #13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'CODIGO DO CAIXA   :  '+ IntToStr(CodCaixa)
                + #13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);


  TextoUnicode := 'HORA DA ABERTURA  :  ' + DbHoraabre.Text
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'HORA DO FECHAMENTO:  ' + DbHorafecha.Text
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'ABERTO POR        :  ' + Combofunc.Text
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VALOR ABERTURA    :  ' + AlinhaCampoValor((DbValorAbre.Field.AsFloat), 10, 2)

                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'TOT RECEITA BRUTA :  ' + AlinhaCampoValor((DbTotalRec.Field.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'TOTAL DESPESA FISC:  ' + AlinhaCampoValor((DbTotalDesp.Field.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'TOTAL MOVIM FISCAL:  ' + AlinhaCampoValor((DbTotalMov.Field.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VALOR FECH FISCAL :  ' + AlinhaCampoValor((DbValorFecha.Field.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := ('------------------------------------------')
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VALOR DINHEIRO OP :  ' + AlinhaCampoValor((DmWorkCom.CdsCaixaVALOR_DINHEIRO.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VALOR CARTAO OP   :  ' + AlinhaCampoValor((DmWorkCom.CdsCaixaVALOR_CARTAO.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VALOR CHEQUE OP   :  ' + AlinhaCampoValor((DmWorkCom.CdsCaixaVALOR_CHEQUE.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VALOR OUTROS OP   :  ' + AlinhaCampoValor((DmWorkCom.CdsCaixaVALOR_OUTROS.AsFloat), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);



  DataCaixaMov.DataSet.First;
  while not DataCaixaMov.DataSet.Eof do
  begin
     if DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsInteger > 0 then
     begin
        if not DmWorkCom.Dados_Pedido(DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsInteger,0) then
               if not DmWorkCom.Dados_Pedido(DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsInteger) then
               begin
                 ShowMessage('Não encontrou o pedido ' + DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsString);

               end;
               contpedidos:=contpedidos + 1;
               if DmWorkCom.CdsPedidosCANCELADO.AsString = 'S' then
               begin
                  contcancelados:= contcancelados + 1;
               end
               else
               begin
               ped_valorTotal:= ped_valorTotal + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
               ped_valor:=ped_valor + DmWorkcom.CdsPedidosVALOR.AsCurrency ;
               ped_Desconto:=ped_Desconto + DmWorkcom.CdsPedidosDESCONTO.AsCurrency;
               ped_acrescimo:=ped_acrescimo + DmWorkcom.CdsPedidosACRESCIMO.AsCurrency;
               ped_valorTroco:=ped_valorTroco + DmWorkcom.CdsPedidosVALOR_TROCO.AsCurrency;
               end;
              if (DmWorkCom.CdsPedidosID.AsInteger > 0)
                 and(DmWorkCom.CdsPedidosCANCELADO.AsString = 'N')
                 and (DmWorkCom.CdsPedidosID_FORMAPAG.AsInteger > 2) then
                 begin
                     totoutros := totoutros + DmWorkCom.CdsPedidosVALOR_TOTAL.AsCurrency;
                     contcartoes:= contcartoes+1;
                 end;
     end
     else
     begin
         recbto:=DataCaixaMov.DataSet.FieldByName('HISTORICO').AsString;
         if recbto = 'RECBTO' then
            totrecbto:=totrecbto + DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency;
         if DataCaixaMov.DataSet.FieldByName('DC').AsString = 'C' then
            totreceita:=totreceita + DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency
         else
         if DataCaixaMov.DataSet.FieldByName('DC').AsString = 'D' then
            totdespesa:=totdespesa + DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency;
     end;
     DataCaixaMov.DataSet.Next;
  end;

  TextoUnicode := 'VALOR PEDIDOS     :  ' + AlinhaCampoValor((ped_valor), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VLR DESCONTOS     :  ' + AlinhaCampoValor((ped_Desconto), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VLR ACRESCIMOS    :  ' + AlinhaCampoValor((ped_acrescimo), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := ('------------------------------------------')
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'TOT SUPRIMTO PED  :  ' + AlinhaCampoValor((totreceita), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VLR TOTAL PEDIDOS :  ' + AlinhaCampoValor((ped_valorTotal), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'VLR TOTAL TROCOS  :  ' + AlinhaCampoValor((ped_valorTroco), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'TOT VENDA BRUTA   :  ' + AlinhaCampoValor((ped_valorTotal + ped_valorTroco ), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'TOT SANGRIAS PED  :  ' + AlinhaCampoValor((totdespesa), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'QTDE TOTAL PEDIDOS:  ' + AlinhaCampoValor((contpedidos), 10, 0)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'PEDIDOS CANCELADOS:  ' + AlinhaCampoValor((contcancelados), 10, 0)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  vlrgaveta:= ped_valorTotal + totreceita - totdespesa;

  TextoUnicode := 'TOTAL VALOR GAVETA:  ' + AlinhaCampoValor((vlrgaveta), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    Datade:= FormatDateTime('DD/MM/YYYY', DmWorkCom.CdsCaixaHORA_ABERTURA.AsDateTime);
    Horade:= FormatDateTime('HH:mm:ss', DmWorkCom.CdsCaixaHORA_ABERTURA.AsDateTime);
    Dataate:= FormatDateTime('DD/MM/YYYY', DmWorkCom.CdsCaixaHORA_FECHAMENTO.AsDateTime);
    Horaate:= FormatDateTime('HH:mm:ss', DmWorkCom.CdsCaixaHORA_FECHAMENTO.AsDateTime);

    Datade:= Datade + ' ' + Horade;
    Dataate:= Dataate + ' ' + Horaate;
{
  if DmWorkCom.Dados_PedidoDeAte(Datade, Dataate, '','') then
  begin
  DmWorkCom.CdsPedidos.First;
  while not DmWorkCom.CdsPedidos.Eof do
  begin
     if (DmWorkCom.CdsPedidosID.AsInteger > 0)
     and(DmWorkCom.CdsPedidosCANCELADO.AsString = 'N')
     and (DmWorkCom.CdsPedidosID_FORMAPAG.AsInteger > 2) then
     begin
         totoutros := totoutros + DmWorkCom.CdsPedidosVALOR_TOTAL.AsCurrency;
         contcartoes:= contcartoes+1;
     end;
     DmWorkCom.CdsPedidos.Next;
  end;


  end;
}
  TextoUnicode := ('------------------------------------------')
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);


  TextoUnicode := 'VENDAS CARTOES/OUT:  ' + AlinhaCampoValor((totoutros), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'QTDE CARTOES/OUTR :  ' + AlinhaCampoValor((contcartoes), 10, 0)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := 'TOT RECBTO CONTA  :  ' + AlinhaCampoValor((totrecbto), 10, 2)
                +#13#10;
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  epson:=DmWorkCom.nomecupom;
  if epson = 'EPSON' then
  begin
     TextoUnicode := ' '+ #13+#10+ ' '+ #13+#10+ ' '+ #13+#10+ ' '+ #13+#10+ ' '+ #13+#10+ ' '+ #13+#10+ ' '+ #13+#10+ ' '+ #13+#10;
     TextoAnsiString := AnsiString(TextoUnicode);
     WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

     TextoUnicode := #27+#105;
     TextoAnsiString := AnsiString(TextoUnicode);
     WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  end;


  //Finaliza o documento no Spool
      EndDocPrinter(Handle);

  //Fecha a impressora
      ClosePrinter(Handle);

   except
       MessageDlg('Data inválida. Verifique!!!', mtWarning, [mbOK], 0);
     end;

    Edit1.Text := '';
    Edit2.Text := '';

end;
//fabricio inicio
procedure TFrmCaixaDiario.BitBtn12Click(Sender: TObject);
var Datade, Dataate, Horade, Horaate:String;
    aData, aDataF:TDateTime;
begin
  inherited;
    try
    if Datac.DateTime > Datax.DateTime then
    begin
    ShowMessage('Data final não pode ser menor que data inicial');
    Abort;
    end;

      Datade:= FormatDateTime('DD/MM/YYYY', Datac.Date);
      Horade:= FormatDateTime('HH:mm:ss', Horac.Time);
      Dataate:= FormatDateTime('DD/MM/YYYY', Datax.Date);
      Horaate:= FormatDateTime('HH:mm:ss', Horax.Time);

      Datade:= Datade + ' ' + Horade;
      Dataate:= Dataate + ' ' + Horaate;
{
      if datade = dataate then
      begin
        Horaate:= FormatDateTime('HH:mm:ss', StrToTime('23:59:59'));
        Dataate:= Dataate + ' ' + Horaate;
      end;
}
    if not DmWorkCom.Dados_PedidoDeAte(Datade, Dataate, Edit1.Text, Edit2.Text) then
    begin
      if Edit2.Text <> '' then
      if not DmWorkCom.Dados_PedidoDeAte(Datade, Dataate, Edit1.Text, '') then
      begin
              MessageDlg('Não foi encontrado movimento para as datas informadas!!!', mtWarning, [mbOK], 0);
              Abort;
      end;
    end;
      FrmCxDiarios.QRLabel2.Caption:= 'Período de '+ Datade + ' até '+ Dataate;
      FrmCxDiarios.QrcxDiarios.Preview;
     except
       MessageDlg('Data inválida. Verifique!!!', mtWarning, [mbOK], 0);
     end;

    Edit1.Text := '' ;
end;
//fabricio fim
procedure TFrmCaixaDiario.ActSangriaExecute(Sender: TObject);
var aValorAbre:String;
    aValor:Double;
begin
  inherited;
  //
  if DataCaixa.DataSet.FieldByName('DATA_ABERTURA').AsDateTime <> SVData then
  begin
    MessageDlg('Não é permitido efetuar lançamentos em data diferente da atual!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if not DmWorkCom.Dados_Caixa(SVData) then
  begin
    MessageDlg('Não há caixa aberto. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end
  else
  begin
    if DataCaixa.DataSet.FieldByName('FECHADO').AsString = 'S' then
    begin
      MessageDlg('O caixa já foi fechado!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
  //
  if InputQuery('Sangria','Informe o valor:',aValorAbre) then
  begin
    try
      aValor := StrToFloat(aValorAbre);
      DataCaixaMov.DataSet.Append;
      DataCaixaMov.DataSet.FieldByName('HISTORICO').AsString := 'SANGRIA DE CAIXA';
      DataCaixaMov.DataSet.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
      DataCaixaMov.DataSet.FieldByName('DC').AsString        := 'D';
      DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency   := aValor;
      DataCaixaMov.DataSet.Post;
      Grava_Dados(DataCaixaMov.DataSet);
    except
      MessageDlg('Erro ao lançar sangria!!!', mtWarning, [mbOK], 0);
    end;
  end;
  GravaTotaisCaixa;
end;

procedure TFrmCaixaDiario.ActLancamentoExecute(Sender: TObject);
begin
  inherited;
  //
  if DataCaixa.DataSet.FieldByName('DATA_ABERTURA').AsDateTime <> SVData then
  begin
    MessageDlg('Não é permitido efetuar lançamentos em data diferente da atual!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if not DmWorkCom.Dados_Caixa(SVData) then
  begin
    MessageDlg('Não há caixa aberto. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end
  else
  begin
    if DataCaixa.DataSet.FieldByName('FECHADO').AsString = 'S' then
    begin
      MessageDlg('O caixa já foi fechado!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
  // lança movimento
  AbreForm(TFrmMovCaixa,FrmMovCaixa);
  DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
  GravaTotaisCaixa;

end;

procedure TFrmCaixaDiario.ActFecharCaixaExecute(Sender: TObject);
var aValorAbre:String;
    aValor:Double;
begin
  inherited;
  //
  if DataCaixa.DataSet.FieldByName('FECHADO').AsString = 'S' then
  begin
    MessageDlg('O caixa já foi fechado!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  if MessageDlg('Confirma o fehamento do caixa do dia '+datetostr(DataCaixa.DataSet.FieldByName('DATA_ABERTURA').AsDateTime), mtConfirmation, [mbYes, mbNo], 0) = mryes then
  begin
    if InputQuery('Fechamento','Informe o valor:',aValorAbre) then
    begin
      try
        aValor := StrToFloat(aValorAbre);
        if not(DataCaixa.DataSet.State in [dsInsert,dsEdit]) then
        DataCaixa.DataSet.Edit;
        DataCaixa.DataSet.FieldByName('DATA_FECHAMENTO').AsDateTime  := now;
        DataCaixa.DataSet.FieldByName('HORA_FECHAMENTO').AsDateTime  := now;
        DataCaixa.DataSet.FieldByName('VALOR_FECHAMENTO').AsCurrency := aValor;
        DataCaixa.DataSet.FieldByName('FECHADO').AsString            := 'S';
        DataCaixa.DataSet.Post;
        Grava_Dados(DataCaixa.DataSet);
      except
        MessageDlg('Erro ao efetuar fechamento!!!', mtWarning, [mbOK], 0);
      end;
    end;
  end;

end;

procedure TFrmCaixaDiario.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmCaixaDiario.ActPesquisarExecute(Sender: TObject);
var aDataMov:String;
    Datade, Dataate, Horade, Horaate: string;
    rcx:boolean;
    aData,aDataF:TDateTime;
    ContItens, contCancelados, contpedidos, contcartoes, CodCaixa: Integer;
    ValorTroco: Double;
    idescricao: string[28];
    ipgto:string[11];
    recbto: string[6];
    totrecbto, totreceita, totdespesa, vlrgaveta,ped_valorTotal,ped_valor,ped_Desconto, ped_acrescimo, ped_ValorTroco, totoutros: currency;

    contreg, contfin, contcan, contorc, contcupons, contnfe: Integer;
    t0, t1, t2, t3, t4, t5, t6, t7, toreg, toorc,tocupons,tonfe, totcanc, totfin: currency;

begin
  inherited;
  try
    totfin:=0;
    toreg:=0;
    contreg:=0;
    contfin:=0;
    contcan:=0;
    totcanc:=0;
    toorc:=0;
    tocupons:=0;
    tonfe:=0;
    contorc:=0;
    contcupons:=0;
    contnfe:=0;
    contconfirmados:=0;
    contcancelados:=0;
    t0:= 0;
    t1:= 0;
    t2:= 0;
    t3:= 0;
    t4:= 0;
    t5:= 0;
    t6:= 0;
    t7:= 0;

    totrecbto:=0;
    vlrgaveta:=0;
    totreceita:=0;
    totdespesa:=0;
    contpedidos:=0;
    contcancelados:=0;
    ped_valorTotal:=0;
    ped_valor:=0;
    ped_Desconto:=0;
    ped_acrescimo:=0;
    ped_valorTroco:=0;
    totoutros:=0;
    contcartoes:=0;

     if Edit2.Text <> '' then
     begin
      if not DmWorkCom.Dados_CaixaID(StrToInt(Edit2.Text),false) then
      begin
        MessageDlg('Não foi encontrado movimento para o caixa informado!!!', mtWarning, [mbOK], 0);
        Abort;
      end;
      DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
      GravaTotaisCaixa;
     end
     else
     if Horac.Time <> Horax.Time then
     begin
      Datade:= FormatDateTime('DD/MM/YYYY', Datac.Date);
      Horade:= FormatDateTime('HH:mm:ss', Horac.Time);
      Dataate:= FormatDateTime('DD/MM/YYYY', Datax.Date);
      Horaate:= FormatDateTime('HH:mm:ss', Horax.Time);

      Datade:= Datade + ' ' + Horade;
      Dataate:= Dataate + ' ' + Horaate;
//      ShowMessage(DateToStr(Datac.DateTime));
      if not DmWorkCom.Dados_CaixaDeate(Datade, Dataate) then
      begin
        MessageDlg('Não foi encontrado movimento para a data informada!!!', mtWarning, [mbOK], 0);
        Abort;
      end;
      DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
      GravaTotaisCaixa;
     end
     else
     begin
     if Radiocx.ItemIndex = 1 then
        rcx:=false
     else
        rcx:=true;

        if not DmWorkCom.Dados_Caixa(Datac.Date,rcx) then
        begin
           MessageDlg('Não foi encontrado movimento para a data informada!!!', mtWarning, [mbOK], 0);
           Abort;
        end;
           DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
           GravaTotaisCaixa;
     end;

     CodCaixa:= DataCaixa.DataSet.FieldByname('ID').AsInteger;
     except
       MessageDlg('Erro de consulta. Verifique!!!', mtWarning, [mbOK], 0);
     end;

  DataCaixaMov.DataSet.First;
  while not DataCaixaMov.DataSet.Eof do
  begin
     if DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsInteger > 0 then
     begin
        if not DmWorkCom.Dados_Pedido(DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsInteger,0) then
               if not DmWorkCom.Dados_Pedido(DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsInteger) then
               begin
                 ShowMessage('Não encontrou o pedido ' + DataCaixaMov.DataSet.FieldByname('IDPEDIDO').AsString);

               end;
               contpedidos:=contpedidos + 1;
               if DmWorkCom.CdsPedidosCANCELADO.AsString = 'S' then
               begin
                  contcancelados:= contcancelados + 1;
               end
               else
               begin
               ped_valorTotal:= ped_valorTotal + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
               ped_valor:=ped_valor + DmWorkcom.CdsPedidosVALOR.AsCurrency ;
               ped_Desconto:=ped_Desconto + DmWorkcom.CdsPedidosDESCONTO.AsCurrency;
               ped_acrescimo:=ped_acrescimo + DmWorkcom.CdsPedidosACRESCIMO.AsCurrency;
               ped_valorTroco:=ped_valorTroco + DmWorkcom.CdsPedidosVALOR_TROCO.AsCurrency;
               end;

              if (DmWorkCom.CdsPedidosID.AsInteger > 0)
                 and(DmWorkCom.CdsPedidosCANCELADO.AsString = 'N')
                 and (DmWorkCom.CdsPedidosID_FORMAPAG.AsInteger > 2) then
                 begin
                     totoutros := totoutros + DmWorkCom.CdsPedidosVALOR_TOTAL.AsCurrency;
                     contcartoes:= contcartoes+1;
                 end;

     end
     else
     begin
         recbto:=DataCaixaMov.DataSet.FieldByName('HISTORICO').AsString;
         if recbto = 'RECBTO' then
            totrecbto:=totrecbto + DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency;

         if DataCaixaMov.DataSet.FieldByName('DC').AsString = 'C' then
            totreceita:=totreceita + DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency
         else
         if DataCaixaMov.DataSet.FieldByName('DC').AsString = 'D' then
            totdespesa:=totdespesa + DataCaixaMov.DataSet.FieldByName('VALOR').AsCurrency;
     end;
     DataCaixaMov.DataSet.Next;
  end;

Datac.DateTime:=dbHoraabre.DataSource.DataSet.FieldByName('HORA_ABERTURA').AsDateTime;
Horac.Time:=Datac.Time;

if dbHorafecha.DataSource.DataSet.FieldByName('HORA_FECHAMENTO').AsDateTime <  01/01/2018 then
begin
   Datax.DateTime:=now;
   Horax.Time:=now;
end
else
begin
   Datax.DateTime:=dbHorafecha.DataSource.DataSet.FieldByName('HORA_FECHAMENTO').AsDateTime;
   Horax.Time:=Datax.Time;
end;

    Datade:= FormatDateTime('DD/MM/YYYY', DmWorkCom.CdsCaixaHORA_ABERTURA.AsDateTime);
    Horade:= FormatDateTime('HH:mm:ss', DmWorkCom.CdsCaixaHORA_ABERTURA.AsDateTime);

if dbHorafecha.DataSource.DataSet.FieldByName('HORA_FECHAMENTO').AsDateTime <  01/01/2018 then
begin
   Dataate:=FormatDateTime('DD/MM/YYYY', now);
   Horaate:=FormatDateTime('HH:mm:ss', now);
end
else
begin
    Dataate:= FormatDateTime('DD/MM/YYYY', DmWorkCom.CdsCaixaHORA_FECHAMENTO.AsDateTime);
    Horaate:= FormatDateTime('HH:mm:ss', DmWorkCom.CdsCaixaHORA_FECHAMENTO.AsDateTime);
end;




    Datade:= Datade + ' ' + Horade;
    Dataate:= Dataate + ' ' + Horaate;




  if DmWorkCom.Dados_PedidoDeAte(Datade, Dataate, '','') then

  // if DmWorkCom.Dados_Pedido(StrToDateTime(DbHoraAbre.Text),StrToDateTime(DbHoraFecha.Text),'',1,true,Edit1.Text) then
//  if DmWorkCom.Dados_Pedido(aData, aData,'',1,true,'') then
  begin
  DmWorkCom.CdsPedidos.First;
  while not DmWorkCom.CdsPedidos.Eof do
  begin
                contreg:= contreg + 1;
                toreg:=toreg + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;

                if DmWorkcom.CdsPedidosCONFIRMADA.AsString = 'S' then
                begin
                   contfin:= contfin + 1;
                   totfin:=totfin + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                end;

                if DmWorkCom.CdsPedidosCANCELADO.AsString = 'S' then
                begin
                  contcan:= contcan + 1;
                  totcanc:= totcanc + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                end;

                  if DmWorkCom.Dados_PedidoFP(DmWorkCom.CdsPedidosID.AsInteger,false) then
                  begin
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 0 then
                      begin
                         t0:=t0 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                        end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 1 then
                      begin
                         t1:=t1 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                        end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 2 then
                      begin
                         t2:=t2 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 3 then
                      begin
                         t3:=t3 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 4 then
                      begin
                         t4:=t4 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 5 then
                      begin
                         t5:=t5 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;

                      end
                      else
                      begin
                         t6:=t6 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;

                      end;
                  end
                  else
                  begin
                         t7:=t7 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  end;

                  if ((DmWorkCom.CDSPedidosCOO.IsNull) or
                     (DmWorkCom.CDSPedidosCOO.AsInteger = 0))
                  and ((DmWorkCom.CDSPedidosnumero_doc.IsNull) or
                     (DmWorkCom.CDSPedidosnumero_doc.AsInteger = 0)) then
                  begin
                     contorc:= contorc+1;
                     toorc:= toorc + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  end
                  else
                  if (DmWorkCom.CDSPedidosCOO.AsInteger > 0)
                  and (DmWorkCom.CDSPedidosnumero_doc.IsNull) then
                  begin
                    contcupons:= contcupons+1;
                     tocupons:= tocupons + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  end
                  else
                  if (DmWorkCom.CDSPedidosnumero_doc.AsString <> '') then
                  begin
                    contnfe:= contnfe+1;
                     tonfe:= tonfe + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  end;

{
     if (DmWorkCom.CdsPedidosID.AsInteger > 0)
     and(DmWorkCom.CdsPedidosCANCELADO.AsString = 'N')
     and (DmWorkCom.CdsPedidosID_FORMAPAG.AsInteger > 2) then
     begin
         totoutros := totoutros + DmWorkCom.CdsPedidosVALOR_TOTAL.AsCurrency;
         contcartoes:= contcartoes+1;
     end;
}
     DmWorkCom.CdsPedidos.Next;
  end;


  end;

vlrgaveta:= ped_valorTotal + totreceita - totdespesa;


lbid.Caption := IntToStr(CodCaixa);
lbmov.Caption := DbDataMov.Text;
lbhoraab.Caption := DbHoraAbre.Text;
lbhorafe.Caption := DbHoraFecha.Text;
lbabertopor.Caption := ComboFunc.Text;
lbvalorab.Caption := 'R$ ' + FormatFloat('###0.00',StrToCurr(DbValorAbre.Text));
lbtotrb.Caption := 'R$ ' + FormatFloat('###0.00',DbTotalRec.Field.AsCurrency);
lbtotp.Caption := 'R$ ' + FormatFloat('###0.00',(ped_valorTotal));
lbtotdesc.Caption := 'R$ ' + FormatFloat('###0.00',(ped_Desconto));
lbtotacres.Caption := 'R$ ' + FormatFloat('###0.00',(ped_acrescimo));
lbtroco.Caption := 'R$ ' + FormatFloat('###0.00',(ped_valorTroco));
lbtotvb.Caption := 'R$ ' + FormatFloat('###0.00',((ped_valorTotal + ped_valorTroco )));
lbtotsup.Caption := 'R$ ' + FormatFloat('###0.00',(totreceita));
lbtotsang.Caption := 'R$ ' + FormatFloat('###0.00',(totdespesa));
lbqtp.Caption := FormatFloat('000',(contpedidos));
lbvendacar.Caption := 'R$ ' + FormatFloat('###0.00',(totoutros));
lbqtcar.Caption := FormatFloat('000',(contcartoes));
lbpedcan.Caption := 'R$ ' + FormatFloat('000',(contcancelados));
lbtotgav.Caption := 'R$ ' + FormatFloat('###0.00',(vlrgaveta));

lbdinheiro.Caption := 'R$ ' + FormatFloat('###0.00',(DmWorkCom.CdsCaixaVALOR_DINHEIRO.AsCurrency));
lbcartao.Caption := 'R$ ' + FormatFloat('###0.00',(DmWorkCom.CdsCaixaVALOR_CARTAO.AsCurrency));
lbcheque.Caption := 'R$ ' + FormatFloat('###0.00',(DmWorkCom.CdsCaixaVALOR_CHEQUE.AsCurrency));
lboutros.Caption := 'R$ ' + FormatFloat('###0.00',(DmWorkCom.CdsCaixaVALOR_OUTROS.AsCurrency));
lbtotglobal.Caption := 'R$ ' + FormatFloat('###0.00',(DmWorkCom.CdsCaixaVALOR_DINHEIRO.AsFloat +
DmWorkCom.CdsCaixaVALOR_CARTAO.AsFloat + DmWorkCom.CdsCaixaVALOR_CHEQUE.AsFloat
+ DmWorkCom.CdsCaixaVALOR_OUTROS.AsFloat));
lbdifcaixa.caption := 'R$ ' + FormatFloat('###0.00',(DbTotalRec.Field.AsCurrency - (DmWorkCom.CdsCaixaVALOR_DINHEIRO.AsFloat +
DmWorkCom.CdsCaixaVALOR_CARTAO.AsFloat + DmWorkCom.CdsCaixaVALOR_CHEQUE.AsFloat
+ DmWorkCom.CdsCaixaVALOR_OUTROS.AsFloat)));
lbrecbto.Caption := 'R$ ' + FormatFloat('###0.00',(totrecbto));


lbqtpedcan.Caption := FormatFloat('000',(contcan));
lbtotpedcan.Caption := 'R$ ' + FormatFloat('###0.00',(totcanc));
lbtotpedinh.Caption := 'R$ ' + FormatFloat('###0.00',(t0));
lbtotpedche.Caption := 'R$ ' + FormatFloat('###0.00',(t1));
lbtotpedcar.Caption := 'R$ ' + FormatFloat('###0.00',(t2));
lbtotpedprz.Caption := 'R$ ' + FormatFloat('###0.00',(t3));
lbtotpedcrn.Caption := 'R$ ' + FormatFloat('###0.00',(t4));
lbtotpedbol.Caption := 'R$ ' + FormatFloat('###0.00',(t5));
lbtotpeddup.Caption := 'R$ ' + FormatFloat('###0.00',(t6));
lbtotpedout.Caption := 'R$ ' + FormatFloat('###0.00',(t7));
lbqtorca.Caption := FormatFloat('000',(contorc));
lbtotorca.Caption := 'R$ ' + FormatFloat('###0.00',(toorc));
lbqtnotas.Caption := FormatFloat('000',(contnfe));
lbtotnotas.Caption := 'R$ ' + FormatFloat('###0.00',(tonfe));
lbqtecf.Caption := FormatFloat('000',(contcupons));
lbtotecf.Caption := 'R$ ' + FormatFloat('###0.00',(tocupons));
lbqtpedreg.Caption := FormatFloat('000',(contreg));
lbqtpedfin.Caption := FormatFloat('000',(contfin));
lbtotpedreg.Caption := 'R$ ' + FormatFloat('###0.00',(toreg));
lbtotpedfin.Caption := 'R$ ' + FormatFloat('###0.00',(totfin));

lbqtdifpc.Caption := FormatFloat('000',(contfin - contpedidos));
lbtopcbdo.Caption := 'R$ ' + FormatFloat('###0.00',(t3+t4+t5+t6+t7));
lbtotdifpc.Caption := 'R$ ' + FormatFloat('###0.00',(totfin- ped_valorTotal));
lbtotdcc.Caption := 'R$ ' + FormatFloat('###0.00',(t0+t1+t2));




//FABRICIO NOVO FIM
end;

procedure TFrmCaixaDiario.ActRecebimentoEecute(Sender: TObject);
begin
  inherited;
  //
  if DataCaixa.DataSet.FieldByName('DATA_ABERTURA').AsDateTime <> SVData then
  begin
    MessageDlg('Não é permitido efetuar lançamentos em data diferente da atual!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if not DmWorkCom.Dados_Caixa(SVData) then
  begin
    MessageDlg('Não há caixa aberto. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end
  else
  begin
    if DataCaixa.DataSet.FieldByName('FECHADO').AsString = 'S' then
    begin
      MessageDlg('O caixa já foi fechado!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
  //
  Application.CreateForm(TFrmCadContas,FrmCadContas);
  Application.CreateForm(TFrmCadastroCliente,FrmCadastroCliente);
  Application.CreateForm(TFrmClientes,FrmClientes);
  Application.CreateForm(TFrmSelEndereco,FrmSelEndereco);
  Application.CreateForm(TFrmContatosADC,FrmContatosADC);
  try
    DmWorkCom.sTipoConta := 0;
    FrmCadContas.GrpContato.Caption := ' Cliente ';
    FrmCadContas.ShowModal;
  finally
    FrmContatosADC.Destroy;
    FrmSelEndereco.Destroy;
    FrmCadContas.Destroy;
    FrmCadastroCliente.Destroy;
    FrmClientes.Destroy;
  end;
  DmWorkCom.Dados_Caixa(SVData);
  DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByname('ID').AsInteger);
  GravaTotaisCaixa;
end;

procedure TFrmCaixaDiario.FormShow(Sender: TObject);
begin
  inherited;
  Edit1.Text := '' ;
  Edit2.Text := '';
  Datac.Date := Now;
  Datax.Date := Now;
  DataFuncionario.DataSet := DmClientes.CdsFuncionarios;
  DataCaixa.DataSet       := DmWorkCom.CdsCaixa;
  DataCaixaMov.DataSet    := DmWorkCom.CdsCaixaMov;
  DmClientes.Dados_Funcionario;
  DmWorkCom.Dados_Caixa(SVData);
  DmWorkCom.Dados_CaixaMov(DataCaixa.DataSet.FieldByName('ID').AsInteger);
  if not CdsCaixaAux.Active then
     CdsCaixaAux.CreateDataSet;
  CdsCaixaAux.EmptyDataSet;
  CdsCaixaAux.Append;
  if DataCaixa.DataSet.RecordCount > 0 then
     GravaTotaisCaixa;
  GridCaixaMov.SetFocus;

Edit2.Text := DataCaixa.DataSet.FieldByName('ID').AsString;
lbid.Caption := '';
lbmov.Caption := '';
lbhoraab.Caption := '';
lbhorafe.Caption := '';
lbabertopor.Caption := '';
lbvalorab.Caption := '';
lbtotrb.Caption := '';
lbtotp.Caption := '';
lbtotdesc.Caption := '';
lbtotacres.Caption := '';
lbtroco.Caption := '';
lbtotvb.Caption := '';
lbtotsup.Caption := '';
lbtotsang.Caption := '';
lbqtp.Caption := '';
lbvendacar.Caption := '';
lbqtcar.Caption := '';
lbpedcan.Caption := '';
lbtotgav.Caption := '';

lbdinheiro.Caption := '';
lbcartao.Caption := '';
lbcheque.Caption := '';
lboutros.Caption := '';
lbtotglobal.Caption := '';
lbdifcaixa.caption := '';
lbRecbto.Caption := '';


lbqtpedcan.Caption := '';
lbtotpedcan.Caption := '';
lbtotpedinh.Caption := '';
lbtotpedche.Caption := '';
lbtotpedcar.Caption := '';
lbtotpedprz.Caption := '';
lbtotpedcrn.Caption := '';
lbtotpedbol.Caption := '';
lbtotpeddup.Caption := '';
lbtotpedout.Caption := '';
lbqtorca.Caption := '';
lbtotorca.Caption := '';
lbqtnotas.Caption := '';
lbtotnotas.Caption := '';
lbqtecf.Caption := '';
lbtotecf.Caption := '';
lbqtpedcan.Caption := '';
lbtotpedcan.Caption := '';
lbtotpedinh.Caption := '';
lbtotpedche.Caption := '';
lbtotpedcar.Caption := '';
lbtotpedprz.Caption := '';
lbtotpedcrn.Caption := '';
lbtotpedbol.Caption := '';
lbtotpeddup.Caption := '';
lbtotpedout.Caption := '';
lbqtorca.Caption := '';
lbtotorca.Caption := '';
lbqtnotas.Caption := '';
lbtotnotas.Caption := '';
lbqtecf.Caption := '';
lbtotecf.Caption := '';
lbqtpedreg.Caption := '';
lbqtpedfin.Caption := '';
lbtotpedreg.Caption := '';
lbtotpedfin.Caption := '';
lbtopcbdo.Caption := '';
lbqtdifpc.Caption := '';
lbtotdifpc.Caption := '';
lbtotdcc.Caption:='';



end;

procedure TFrmCaixaDiario.GravaTotaisCaixa;
var aValAbre : Double;
begin
  aValAbre := 0;
  if (DataCaixa.DataSet.RecordCount > 0) and
     (DataCaixa.DataSet.FieldByName('VALOR_ABERTURA').AsFloat > 0) then
     aValAbre := DataCaixa.DataSet.FieldByName('VALOR_ABERTURA').AsFloat;
//fabricio  CalculaTotaisCaixaMov(DataCaixa.DataSet.FieldByName('DATA_ABERTURA').AsDateTime);
     CalculaTotaisCaixaMovid(DataCaixa.DataSet.FieldByName('ID').AsInteger);

  if not(CdsCaixaAux.State in [dsInsert,dsEdit]) then
     CdsCaixaAux.Edit;
  CdsCaixaAuxTOTALDESPESAS.AsCurrency := sTotalDespesa;
  CdsCaixaAuxTOTALRECEITAS.AsCurrency := sTotalReceita;
  CdsCaixaAuxTOTALMOV.AsCurrency      := (aValAbre+sTotalReceita)-sTotalDespesa;
  CdsCaixaAux.Post;

end;

procedure TFrmCaixaDiario.ComboFuncKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCaixaDiario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataCaixa.DataSet.Close;
  DataCaixaMov.DataSet.Close;
  DataFuncionario.DataSet.Close
  
end;

end.
