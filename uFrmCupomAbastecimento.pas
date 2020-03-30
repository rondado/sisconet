{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit uFrmCupomAbastecimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, StdCtrls, DB, ActnList, Buttons, Grids,
  DBGrids, FMTBcd, DBClient, Provider, SqlExpr, Menus, ComCtrls, uFuncoesPosto,
  ShellApi, jpeg, IniFiles, System.Actions;

type
  TFrmCupomAbastecimento = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    ActionList1: TActionList;
    ActAfericao: TAction;
    ActEncerrar: TAction;
    ActEmitirCupom: TAction;
    DataAbastecimentos: TDataSource;
    BitBtn4: TBitBtn;
    DBGrid1: TDBGrid;
    ActAtualizar: TAction;
    BitBtn5: TBitBtn;
    ActMenuFiscal: TAction;
    Timer1: TTimer;
    PnInforma: TPanel;
    BitBtn2: TBitBtn;
    BtnSemComunica: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActEmitirCupomExecute(Sender: TObject);
    procedure ActAfericaoExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure ActAtualizarExecute(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AtivaConexaoConcentrador;
    procedure BitBtn2Click(Sender: TObject);
    procedure BtnSemComunicaClick(Sender: TObject);
  private
    sConectado, sComunica, sPerdeConexao : Boolean;
    ListaAbastecimentos : TListView;
    PrecoAtual, QuantidadeAtual : String;
    procedure Abastecimento_companytec;
    function ErrorToString(Erro: Error): string;
    procedure Abastecimento_SoftPlus;
    function LerBicos: Integer;
    procedure InterceptaComandos;
    function Testa_Comunicacao_Automacao: Boolean;
    procedure VerificaPendenciasPosto;
    procedure VerificaBicosDesativados;
    { Private declarations }
  public
    ztot :integer;
    { Public declarations }
  end;

var
  FrmCupomAbastecimento: TFrmCupomAbastecimento;
  tr_automacao: TTransactionDesc;
  mcbc_identificador:string;
  ab:abast;
  Tensoes: array[0..20] of Char;
  DadosBico: array[0..4] of Char;
  DadosAbastecimento: array[0..90] of Char;
  DadosDisplay: array[0..19] of Char;

implementation

uses uDmWorkCom, uLibrary, uFrmMenuFiscal, uFuncoesPAFECF, uDmPosto,
  uDmAuxiliar, uFuncoesSoftPlus, untFuncoesPAF, uFrmProdPosto, uDmProdutos;

{$R *.dfm}

procedure TFrmCupomAbastecimento.FormShow(Sender: TObject);
begin
  inherited;
  DataAbastecimentos.DataSet := DmPosto.CdsAbastecimentos1;
  DmPosto.Dados_Abastecimentos1;
  // verifica se todos os bicos estão sem comunicação a menos de tempo determinado
  BtnSemComunica.Visible := false;
  if DmPosto.VerificaPerdaComunicacaoGeral then
     BtnSemComunica.Visible := true;
  //
  if DmPosto.Dados_ConfigPosto then
  begin
    mcbc_identificador := DmPosto.CdsConfigPosto.fieldbyname('CBC_IDENTIFICADOR').AsString;
    LerBicos;
  end
  else
  begin
    MessageDlg('É necessário inserir as configurações de posto!!!', mtWarning, [mbOK], 0);
    Application.Terminate;
  end;
  // abre tabela com dados da empresa
  if DmWorkCom.Dados_Empresa then
  begin
    DmWorkCom.CdsEmpresa.First;
    sIDEmpresa:=DmWorkCom.CdsEmpresa.FieldByName('ID').AsInteger;
    DmWorkCom.Dados_Config(sIDEmpresa);
    DmWorkCom.CarregaDadosEmpresa;
  end
  else
  begin
    MessageDlg('É necessário configurar os dados da empresa!!', mtError, [mbOK], 0);
    Application.Terminate;
  end;
  VerificaPendenciasPosto;
  AtivaConexaoConcentrador;
  DBGrid1.SetFocus;

end;

procedure TFrmCupomAbastecimento.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmCupomAbastecimento.FormCreate(Sender: TObject);
begin
  inherited;
  sAbastecimento.ID          := 0;
  sAbastecimento.Num_Bico    := '';
  sAbastecimento.Data        := 0;
  sAbastecimento.Hora        := 0;
  sAbastecimento.Encerrante  := 0;
  sAbastecimento.Litros      := 0;
  sAbastecimento.Preco_Unit  := 0;
  sAbastecimento.Valor_Total := 0;
  sAbastecimento.ID_Bico     := 0;
  sAbastecimento.ID_Bomba    := 0;
  sAbastecimento.ID_Tanque   := 0;
  sAbastecimento.Automatico  := '';
  sConectado := false;
  sPerdeConexao := true;
  ListaAbastecimentos := TListView.Create(Application);

end;

procedure TFrmCupomAbastecimento.ActEmitirCupomExecute(Sender: TObject);
var VolDescontinuidade, VolNotasDescontinuidade : Double;
    aMensagem : String;
begin
  inherited;
  try
    if DataAbastecimentos.DataSet.RecordCount > 0 then
    begin
      sPerdeConexao := false;
      if DmPosto.Dados_Bicos(DataAbastecimentos.DataSet.FieldByName('num_bico').AsString) then
      begin
        if DmPosto.CdsBicosATIVO.AsString = 'N' then
        begin
          // verifica se todos os bicos estão sem comunicação a menos de tempo determinado
          if not DmPosto.VerificaPerdaComunicacaoGeral then
          begin
            MessageDlg('O Bico não esta ativo. Verifique!',mtWarning,[mbOK],0);
            Abort;
          end;
        end;
      end;
      if DmPosto.Dados_Bicos_Perda(DataAbastecimentos.DataSet.FieldByname('NUM_BICO').AsString,'S',2) then
      begin
        MessageDlg('Existe descontinuidade registrada pra este bico. Verifique!',mtWarning,[mbOK],0);
        Abort;
      end;
      if DmPosto.VerificaBicoLiberadoEstoque(DataAbastecimentos.DataSet.FieldByname('NUM_BICO').AsString) then
      begin
        MessageDlg('Existe perda de estoque registrada pra este bico. Verifique!',mtWarning,[mbOK],0);
        Abort;
      end;
      if DataAbastecimentos.DataSet.RecordCount > 0 then
      begin
        if Confirmacao('Confirma a emissão do cupom deste abastecimento?') then
        begin
          with sAbastecimento do
          begin
            ID          := DataAbastecimentos.DataSet.FieldByname('ID').AsInteger;
            Num_Bico    := DataAbastecimentos.DataSet.FieldByname('NUM_BICO').AsString;
            Data        := DataAbastecimentos.DataSet.FieldByname('DATA').AsDateTime;
            Hora        := DataAbastecimentos.DataSet.FieldByname('HORA').AsDateTime;
            Encerrante  := DataAbastecimentos.DataSet.FieldByname('ENCERRANTE').AsFloat;
            Litros      := DataAbastecimentos.DataSet.FieldByname('LITROS').AsFloat;
            Preco_Unit  := DataAbastecimentos.DataSet.FieldByname('PRECO_UNIT').AsFloat;
            Valor_Total := DataAbastecimentos.DataSet.FieldByname('VALOR_TOTAL').AsFloat;
            Automatico  := DataAbastecimentos.DataSet.FieldByname('AUTOMATICO').AsString;
            NumeroDoc   := DataAbastecimentos.DataSet.FieldByname('NOTAFISCAL_NUM').AsString;
          end;
          Close;
        end;
      end;
    end;  
  except
    sPerdeConexao := true;
  end;

end;

procedure TFrmCupomAbastecimento.ActAfericaoExecute(Sender: TObject);
var aTotalAfericoes, aIDProd : Integer;
    aEstAtual,aNovoEstoque, aQuatLitros, aEncerranteAnterior : Double;
    aNumBico, aMensagem, AuxLitros : String;
begin
  inherited;
  if DataAbastecimentos.DataSet.RecordCount > 0 then
  begin
    if DmPosto.Dados_Bicos(DataAbastecimentos.DataSet.FieldByName('num_bico').AsString) then
    begin
      if DmPosto.CdsBicosATIVO.AsString = 'N' then
      begin
        // verifica se todos os bicos estão sem comunicação a menos de tempo determinado
        if not DmPosto.VerificaPerdaComunicacaoGeral then
        begin
          MessageDlg('O Bico não esta ativo. Verifique!',mtWarning,[mbOK],0);
          Abort;
        end;
      end;
    end;
    // verifica sem comunicação geral
    if DmPosto.VerificaPerdaComunicacaoGeral then
    begin
      aTotalAfericoes := DmPosto.RetornaTotalAfericoesBico(DataAbastecimentos.DataSet.FieldByName('num_bico').AsString);
      if aTotalAfericoes > 3 then
      begin
        MessageDlg('Já foram realizadas 3 aferições para esse bico. Verifique!',mtWarning,[mbOK],0);
        Abort;
      end;
    end;
    if DmPosto.Dados_Bicos_Perda(DataAbastecimentos.DataSet.FieldByname('NUM_BICO').AsString,'S',2) then
    begin
      MessageDlg('Existe descontinuidade registrada pra este bico. Verifique!',mtWarning,[mbOK],0);
      Abort;
    end;
    if DmPosto.VerificaBicoLiberadoEstoque(DataAbastecimentos.DataSet.FieldByname('NUM_BICO').AsString) then
    begin
      MessageDlg('Existe perda de estoque registrada pra este bico. Verifique!',mtWarning,[mbOK],0);
      Abort;
    end;
    //
    if Confirmacao('Confirma o envio do abastecimento para aferição?') then
    begin
      DmWorkCom.PAFECF.RelatorioAfericao(DataAbastecimentos.DataSet.FieldByName('idproduto').AsInteger,
                                         DataAbastecimentos.DataSet.FieldByName('num_bico').AsString,
                                         DataAbastecimentos.DataSet.FieldByName('descricao').AsString,
                                         DataAbastecimentos.DataSet.FieldByName('litros').AsFloat,
                                         (DataAbastecimentos.DataSet.FieldByName('encerrante').AsFloat-
                                          DataAbastecimentos.DataSet.FieldByName('litros').AsFloat),
                                         DataAbastecimentos.DataSet.FieldByName('encerrante').AsFloat);
      DmPosto.AlteraStatusAbastecimento(DataAbastecimentos.DataSet.FieldByname('ID').AsInteger,2,0,'');
      // Localiza o produto
      DmPosto.Dados_Bicos(DataAbastecimentos.DataSet.FieldByName('num_bico').AsString);
      DmPosto.Dados_Tanque(DmPosto.CdsBicos.FieldByName('ID_TANQUE').AsInteger);
      DmProdutos.Dados_MovimentoEst(dmposto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger);
      // baixa o estoque do combustivel
      aEstAtual := Retorna_EstoqueAtual(DmPosto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger);
      aNovoEstoque := aEstAtual + DataAbastecimentos.DataSet.FieldByName('litros').AsFloat;
      // grava tabela de produtos
      if not(DmProdutos.CdsProdutos.State in [dsInsert,dsEdit]) then
         DmProdutos.CdsProdutos.Edit;
      DmProdutos.CdsProdutos.FieldByName('ESTOQUE').AsFloat         := aNovoEstoque;
      DmProdutos.CdsProdutos.FieldByName('DATA_ESTOQUE').AsDateTime := SVData;
      DmProdutos.CdsProdutos.FieldByName('HORA_ESTOQUE').AsDateTime := SVHora;
      Grava_Dados(DmProdutos.CdsProdutos);
      // grava no produto
      Grava_MovEstoque(DmPosto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger,
                       aNovoEstoque);
      DmProdutos.Grava_EstoqueDia(DmPosto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger);
      // grava tabela de movimento de estoque
      DmProdutos.Grava_TabMovEst(1,DmPosto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger,
                                 DataAbastecimentos.DataSet.FieldByName('litros').AsFloat);

//      DmPosto.Dados_Abastecimentos1;
      ActAtualizarExecute(Sender);
    end;
  end;

end;

{
procedure TFrmCupomAbastecimento.ActAfericaoExecute(Sender: TObject);
var aTotalAfericoes : Integer;
begin
  inherited;
  if DataAbastecimentos.DataSet.RecordCount > 0 then
  begin
    if DmPosto.Dados_Bicos(DataAbastecimentos.DataSet.FieldByName('num_bico').AsString) then
    begin
      if DmPosto.CdsBicosATIVO.AsString = 'N' then
      begin
        MessageDlg('O Bico não esta ativo. Verifique!',mtWarning,[mbOK],0);
        Abort;
      end;
    end;
    // verifica sem comunicação geral
    DmPosto.Dados_Bicos;
    if DmPosto.VerificaPerdaComunicacaoGeral(DmPosto.CdsBicos.RecordCount) then
    begin
      aTotalAfericoes := DmPosto.RetornaTotalAfericoesBico(DataAbastecimentos.DataSet.FieldByName('num_bico').AsString);
      if aTotalAfericoes > 3 then
      begin
        MessageDlg('Já foram realizadas 3 aferições para esse bico. Verifique!',mtWarning,[mbOK],0);
        Abort;
      end;
    end;
    //
    if Confirmacao('Confirma o envio do abastecimento para aferição?') then
    begin
      DmWorkCom.PAFECF.RelatorioAfericao(DataAbastecimentos.DataSet.FieldByName('idproduto').AsInteger,
                                         DataAbastecimentos.DataSet.FieldByName('num_bico').AsString,
                                         DataAbastecimentos.DataSet.FieldByName('descricao').AsString,
                                         DataAbastecimentos.DataSet.FieldByName('litros').AsFloat,
                                         (DataAbastecimentos.DataSet.FieldByName('encerrante').AsFloat-
                                          DataAbastecimentos.DataSet.FieldByName('litros').AsFloat),
                                         DataAbastecimentos.DataSet.FieldByName('encerrante').AsFloat);
      DmPosto.AlteraStatusAbastecimento(DataAbastecimentos.DataSet.FieldByname('ID').AsInteger,2,0,'');
      DmPosto.Dados_Abastecimentos;
    end;
  end;

end;
}

procedure TFrmCupomAbastecimento.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  ActEmitirCupomExecute(Sender);
  
end;

procedure TFrmCupomAbastecimento.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
     ActEmitirCupomExecute(Sender);
  if (Key = #27) then
     ActEncerrarExecute(Sender);

end;

procedure TFrmCupomAbastecimento.ActAtualizarExecute(Sender: TObject);
begin
  inherited;
  DmPosto.Dados_Abastecimentos1;
  
end;

procedure TFrmCupomAbastecimento.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(DmPosto.CdsAbastecimentos1,DBGrid1,Column);
end;

procedure TFrmCupomAbastecimento.ActMenuFiscalExecute(Sender: TObject);
var aMensagem : String;
begin
  inherited;
  try
    Timer1.Enabled := false;
    if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
    begin
       DmWorkCom.PAFECF.sControleECFAtivo := 1;
    end
    else
    begin
      if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
      begin
        ShowMessage(aMensagem);
        DmWorkCom.PAFECF.sControleECFAtivo := 2;
      end;
    end;
    Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
    try
      FrmMenuFiscal.ShowModal;
    finally
      FrmMenuFiscal.Destroy;
    end;
  finally
    Timer1.Enabled := true;
  end;  
end;

procedure TFrmCupomAbastecimento.Timer1Timer(Sender: TObject);
var aEncerrante :Double;
    aNumBico : String;
begin
  inherited;
  try
    Timer1.Enabled := false;
    VerificaPendenciasPosto;
    // verifica situações de posto
    if DmPosto.CdsConfigPosto.fieldbyname('CONCENTRADOR').AsInteger = 0 then
    begin
      // companytec
      if (DmPosto.CdsConfigPosto.FieldByName('TIPO_CBC').AsInteger=1) then
      begin
        if sConectado then
        begin
          self.update;
          Abastecimento_companytec;  // ler os abastecimento da bombas.
        end
        else
        begin
          PnInforma.caption := 'Conectando...';
          Application.ProcessMessages;
          self.update;
          // abre a porta serial.
          if (DmPosto.CdsConfigPosto.fieldbyname('PORTA_CBC').AsInteger > 0) then
          begin
            if InicializaSerial(DmPosto.CdsConfigPosto.fieldbyname('PORTA_CBC').AsInteger) then
            begin
              sConectado        := true;
              sComunica         := true;
              PnInforma.Caption := 'PORTA:'+DmPosto.CdsConfigPosto.fieldbyname('PORTA_CBC').ASSTRING;
            end;
          end
          else // conexão via IP.
          begin
            if InicializaSocket(DmPosto.CdsConfigPosto.fieldbyname('IP_CBC').asstring) then
            begin
              sConectado        := true;
              sComunica         := true;
              PnInforma.Caption := 'IP:'+DmPosto.CdsConfigPosto.fieldbyname('IP_CBC').asstring;
            end;
          end;
          //
          if not sConectado then
          begin
            PnInforma.Caption := 'Perda de comunicação geral...';
            Application.ProcessMessages;
            if not DmPosto.VerificaComunicacaoBicos(True) then
               DmPosto.GravaPerdaComunicacaoBico(1,'',0);
            Timer1.Enabled := false;
            PnInforma.Color := clMaroon;
//            Sleep(3000);
//            AtivarDesativarComunicao1Click(Sender);
          end
          else
          begin
            PnInforma.Color := clGreen;
            if DmPosto.Dados_Bicos then
            begin
              while not DmPosto.CdsBicos.Eof do
              begin
                aNumBico := DmPosto.CdsBicosBICO_CONCENTRADOR.AsString;
                aEncerrante := DmPosto.RetornaEncBicoConcentrador(aNumBico);
                DmPosto.GravaPerdaComunicacaoBico(0,aNumBico,aEncerrante);
                DmPosto.CdsBicos.Next;
              end;
            end;
            Sleep(1000);
            // atualiza o preço na bomba
            ztot:=0;

            DmAuxiliar.QryAux.Close;
            DmAuxiliar.QryAux.SQL.Clear;
            DmAuxiliar.QryAux.SQL.Add('select b.bico_concentrador,p.preco_venda from');
            DmAuxiliar.QryAux.SQL.Add('produtos p, bicos_abastec b, tanques_abastec t');
            DmAuxiliar.QryAux.SQL.Add('where t.id_produto = p.id');
            DmAuxiliar.QryAux.SQL.Add('and b.id_tanque = t.id');
            DmAuxiliar.QryAux.SQL.Add('and p.combustivel = '+QuotedStr('S'));
            DmAuxiliar.QryAux.Open;

            while not DmAuxiliar.QryAux.Eof do
            begin
              inc(ztot);
              uFuncoesPosto.AlteraPreco(DmAuxiliar.QryAux.Fieldbyname('bico_concentrador').AsString,
                                        DmAuxiliar.QryAux.Fieldbyname('preco_venda').AsCurrency ,3);
              DmAuxiliar.QryAux.next;
            end;
          end;
        end;
      end;
    end
    else
    begin
      // SoftPlus
      if sConectado then
      begin
        self.update;
        Abastecimento_SoftPlus;  // ler os abastecimento da bombas.
      end
      else
      begin
        PnInforma.caption := 'Conectando...';
        Application.ProcessMessages;
        self.update;
        try
          if (InicializaCom(DmPosto.CdsConfigPosto.FieldByName('SPI_SERIAL').AsInteger,
                            pAnsiChar(DmPosto.CdsConfigPosto.FieldByName('SPI_HOST').AsString),
                            DmPosto.CdsConfigPosto.FieldByName('SPI_IP').AsInteger) = 0) and
             (StatusCom = 0) and
             (GetTensoes(Tensoes) = 0) then
          begin
            sConectado := true;
            sComunica  := true;
            SetLog(0);
          end
          else
          begin
            PnInforma.Caption := 'Erro ao iniciar comunicação.';
          end;
        except
            PnInforma.Caption := 'Erro ao iniciar comunicação.';
        end;
      end
    end;
  finally
    if sConectado then
       Timer1.Enabled := true;
  end;

end;

procedure TFrmCupomAbastecimento.Abastecimento_companytec;
var ab:abast;
    ab_id2:AbastFid2;
    aEncerrante, aEncerranteAnterior, aDifEncerrante,
    aSaldoProd, aPerdaProd : Double;
    aEncerrante_In, aEncerrante_Out : Double;
    xOk : Boolean;
    aNumBico : String;
begin
  DmPosto.Dados_Abastecimentos;
  DmPosto.Dados_AbastTemp;
  ztot :=0;
  aPerdaProd := 0;
  aSaldoProd := 0;
  aEncerrante_In := 0;
  aEncerrante_Out := 0;
  aDifEncerrante := 0;
  // verifica se a porta está aberta
  if sConectado then
  begin
    // Não estou utilizando o identificador da automação com o cartão.
    if (mcbc_identificador='N') then
    begin
      if not Testa_Comunicacao_Automacao then
      begin
        if sComunica then
        begin
          PnInforma.Color := clMaroon;
          DmPosto.GravaPerdaComunicacaoBico(1,'',0);
//          Mensagem('Foi identificado perda de comunicação geral. Verifique!','ATENCAO');
          PnInforma.Caption := 'Perda de comunicação geral...';
          Application.ProcessMessages;
          sComunica := false;
//          sConectado := false;
//          Timer1.Enabled := false;
        end;
      end
      else
      begin
        sComunica := true;
        PnInforma.Color := clGreen;
        ab:=uFuncoesPosto.LeAbastecimento;
        //
        if DmPosto.VerificaPerdaComunicacaoBicos then
        begin
          if DmPosto.Dados_Bicos then
          begin
            while not DmPosto.CdsBicos.Eof do
            begin
              aNumBico := DmPosto.CdsBicosBICO_CONCENTRADOR.AsString;
              aEncerrante := DmPosto.RetornaEncBicoConcentrador(aNumBico);
              DmPosto.GravaPerdaComunicacaoBico(0,aNumBico,aEncerrante);
              DmPosto.CdsBicos.Next;
            end;
          end;
        end;
      end;
      if sComunica then
      begin
        VerificaBicosDesativados;
      end;
      //
      if ab.value then
      begin
        xOk := true;
        if not DmPosto.VerificaRegistroSemComunicacao(ab.canal) then
        begin
          // Vericica Saldo combustivel
          aSaldoProd := VerificaSaldoProdutoPosto(ab.canal);
          if aSaldoProd < ab.total_litros then
          begin
            aPerdaProd := ab.total_litros - aSaldoProd;
            RestauraAplicativo('Abastec');
            // grava registro de perda de combustivel
            if not DmPosto.VerificaBicoLiberadoEstoque(ab.canal) then
               DmPosto.GravaPerdaCombustivel(ab.canal,aPerdaProd);
          end;
          // verifica se tem pendencia de descontinuidade
          if not DmPosto.Dados_Bicos_Perda(ab.canal,'S',2) then
          begin
            aEncerrante := ab.encerrante - ab.total_litros;   // 191,23
            aEncerrante := TruncaValor(aEncerrante,3);
            aEncerranteAnterior := DmWorkCom.PAFECF.RetornaUltimoEncerranteBico(ab.canal); // 96,33
            aEncerranteAnterior := TruncaValor(aEncerranteAnterior,3);

            // colocar a opção para verificar o cadastro de placa


            // captura a quebra de encerrante
//            DmPosto.Dados_Bicos(ab.canal);
//            if DmPosto.RetornaDadosDescontinuudade(aEncerrante_In,aEncerrante_Out,
//                                                   DmPosto.CdsBicosID.AsInteger,Now) then
//            begin
            {
              1525
            }
//            end;
            aDifEncerrante      := aEncerrante - aEncerranteAnterior; // EI (atual) - EF (anterior) = 191,230 - 96,33 = 94,900
            if (aDifEncerrante > 0) and (aDifEncerrante <= 2000) then
            begin
              // registra Descontinuidade de encerrante negativa caso não tenha registro 1300
              if not DmWorkCom.PAFECF.VerificaRegistro1320(ab.canal,StrToDate(ab.data)) then
              begin
                // registra Descontinuidade de encerrante positiva menor que 2000
                DmPosto.Dados_Bicos_Perda(ab.canal);
                DmPosto.AdicionaPerdaBico(ab.canal,'S',aDifEncerrante,aEncerranteAnterior,aEncerrante);
                Mensagem('Foi identificado descontinuidade do encerrante. Verifique!','ATENCAO');
                xOk := false;
              end;
            end;
            if aDifEncerrante < 0 then
            begin
              // registra Descontinuidade de encerrante negativa caso não tenha registro 1300
              if not DmWorkCom.PAFECF.VerificaRegistro1320(ab.canal,StrToDate(ab.data)) then
              begin
                DmPosto.Dados_Bicos_Perda(ab.canal);
                DmPosto.AdicionaPerdaBico(ab.canal,'S',aDifEncerrante,aEncerranteAnterior,aEncerrante);
                Mensagem('Foi identificado descontinuidade do encerrante. Verifique!','ATENCAO');
                xOk := false;
              end;
            end;
            if aDifEncerrante > 2000 then
            begin
              // registra Descontinuidade de encerrante negativa caso não tenha registro 1300
              if not DmWorkCom.PAFECF.VerificaRegistro1320(ab.canal,StrToDate(ab.data)) then
              begin
                // registra Descontinuidade de encerrante
                DmPosto.Dados_Bicos_Perda(ab.canal);
                DmPosto.AdicionaPerdaBico(ab.canal,'S',aDifEncerrante,aEncerranteAnterior,aEncerrante);
                Mensagem('Foi identificado descontinuidade do encerrante maior que 2000. Verifique!','ATENCAO');
                xOk := false;
              end;  
            end;
          end
          else xOk := false;
        end
        else xOk := false;
        // grava o pedido do abastecimento
        if xOk then
        begin
          DmPosto.RegistraAbastecimentos(ab.canal,
                                         ab.data,
                                         ab.hora,
                                         ab.encerrante,
                                         ab.total_litros,
                                         ab.PU,
                                         ab.total_dinheiro);
          // grava o encerrante no bico
          DmPosto.GravaEncerranteBico(ab.canal,ab.encerrante);
        end
        else
        begin
          if DmPosto.Dados_Bicos(ab.canal) then
          begin
            if DmPosto.CdsBicos.FieldByName('ATIVO').AsString = 'S' then
            begin
              DmPosto.RegistraAbastTemporario(ab.canal,
                                              ab.data,
                                              ab.hora,
                                              ab.encerrante,
                                              ab.total_litros,
                                              ab.PU,
                                              ab.total_dinheiro);
            end;
          end;  
        end;
      end;
    end
    else
    begin
      if not Testa_Comunicacao_Automacao then
      begin
        if sComunica then
        begin
          DmPosto.GravaPerdaComunicacaoBico(1,'',0);
          Mensagem('Foi identificado perda de comunicação geral. Verifique!','ATENCAO');
          sComunica := false;
        end;
      end
      else
      begin
        sComunica := true;
        ab_id2:=uFuncoesPosto.LeAbastecimentoFid2;
        DmPosto.GravaPerdaComunicacaoBico(0,ab_id2.canal,ab_id2.encerrante);
      end;
      // verifica bicos ativos
      if DmPosto.Dados_Bicos then
      begin
        while not DmPosto.CdsBicos.Eof do
        begin
          if DmPosto.CdsBicos.FieldByName('ATIVO').AsString = 'N' then
          begin
            if not DmPosto.VerificaRegistroSemComunicacao(DmPosto.CdsBicos.FieldByName('BICO_CONCENTRADOR').AsString) then
            begin
              DmPosto.GravaPerdaComunicacaoBico(1,DmPosto.CdsBicos.FieldByName('BICO_CONCENTRADOR').AsString,0);
              Mensagem('Foi identificado perda de comunicação do bico '+DmPosto.CdsBicos.FieldByName('BICO_CONCENTRADOR').AsString+'. Verifique!','ATENCAO');
            end;
          end
          else
          begin
            aEncerrante := DmWorkCom.PAFECF.RetornaUltimoEncerranteBico(DmPosto.CdsBicos.FieldByName('BICO_CONCENTRADOR').AsString);
            DmPosto.GravaPerdaComunicacaoBico(0,DmPosto.CdsBicos.FieldByName('BICO_CONCENTRADOR').AsString,aEncerrante);
          end;
          DmPosto.CdsBicos.Next;
        end;
      end;
      //
      if ab_id2.value then
      begin
        xOk := true;
        if not DmPosto.VerificaRegistroSemComunicacao(ab_id2.canal) then
        begin
          // Vericica Saldo combustivel
          aSaldoProd := VerificaSaldoProdutoPosto(ab_id2.canal);
          if aSaldoProd < ab_id2.total_litros then
          begin
            aPerdaProd := ab_id2.total_litros - aSaldoProd;
            RestauraAplicativo('Abastec');
            // grava registro de perda de combustivel
            if not DmPosto.VerificaBicoLiberadoEstoque(ab_id2.canal) then
               DmPosto.GravaPerdaCombustivel(ab_id2.canal,aPerdaProd);
          end;
          // verifica se tem pendencia de descontinuidade
          if not DmPosto.Dados_Bicos_Perda(ab_id2.canal,'S',2) then
          begin
            aEncerrante := ab_id2.encerrante - ab_id2.total_litros;   // 191,23
            aEncerrante := TruncaValor(aEncerrante,3);
            aEncerranteAnterior := DmWorkCom.PAFECF.RetornaUltimoEncerranteBico(ab_id2.canal); // 96,33
            aEncerranteAnterior := TruncaValor(aEncerranteAnterior,3);
            aDifEncerrante      := aEncerrante - aEncerranteAnterior; // EI (atual) - EF (anterior) = 191,230 - 96,33 = 94,900
            if (aDifEncerrante > 0) and (aDifEncerrante <= 2000) then
            begin
              // registra Descontinuidade de encerrante
              DmPosto.Dados_Bicos_Perda(ab_id2.canal);
              DmPosto.AdicionaPerdaBico(ab_id2.canal,'S',aDifEncerrante,aEncerranteAnterior,aEncerrante);
              Mensagem('Foi identificado descontinuidade do encerrante. Verifique!','ATENCAO');
              xOk := false;
            end;
            if aDifEncerrante < 0 then
            begin
              // registra Descontinuidade de encerrante negativa caso não tenha registro 1300
              if not DmWorkCom.PAFECF.VerificaRegistro1320(ab_id2.canal,StrToDate(ab_id2.data)) then
              begin
                DmPosto.Dados_Bicos_Perda(ab_id2.canal);
                DmPosto.AdicionaPerdaBico(ab_id2.canal,'S',aDifEncerrante,aEncerranteAnterior,aEncerrante);
                Mensagem('Foi identificado descontinuidade do encerrante. Verifique!','ATENCAO');
                xOk := false;
              end;
            end;
            if aDifEncerrante > 2000 then
            begin
              // registra Descontinuidade de encerrante
              DmPosto.Dados_Bicos_Perda(ab_id2.canal);
              DmPosto.AdicionaPerdaBico(ab_id2.canal,'S',aDifEncerrante,aEncerranteAnterior,aEncerrante);
              Mensagem('Foi identificado descontinuidade do encerrante maior que 2000. Verifique!','ATENCAO');
              xOk := false;
            end;
          end
          else xOk := false;
        end
        else xOk := false;
        // grava o pedido do abastecimento
        if xOk then
        begin
          DmPosto.RegistraAbastecimentos(ab_id2.canal,
                                         ab_id2.data,
                                         ab_id2.hora,
                                         ab_id2.encerrante,
                                         ab_id2.total_litros,
                                         ab_id2.PU,
                                         ab_id2.total_dinheiro);
          // grava o encerrante no bico
          DmPosto.GravaEncerranteBico(ab_id2.canal,ab_id2.encerrante);
        end
        else
        begin
          DmPosto.RegistraAbastTemporario(ab_id2.canal,
                                          ab_id2.data,
                                          ab_id2.hora,
                                          ab_id2.encerrante,
                                          ab_id2.total_litros,
                                          ab_id2.PU,
                                          ab_id2.total_dinheiro);
        end;

      end;


    end;
  end;
  Self.Update;

end;


procedure TFrmCupomAbastecimento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  // companytec
  if DmPosto.Dados_ConfigPosto then
  begin
    if (DmPosto.CdsConfigPosto.FieldByName('TIPO_CBC').AsInteger=1) then
    begin
      if (DmPosto.CdsConfigPosto.fieldbyname('PORTA_CBC').AsInteger >0) then
         FechaSerial
      else // estou fazendo a conectação via IP.
         FechaSocket;
    end;
  end
  else MessageDlg('É necessário inserir as configurações de posto!!!', mtWarning, [mbOK], 0);

end;

function TFrmCupomAbastecimento.ErrorToString(Erro:Error):string;
begin
    if Erro=ErroString then result:='ErroString' else
    if Erro=None then result:='Ok' else
    if Erro=ErroCodBico then result:='ErroCodBico' else
    if Erro=ErroCaracterModo then result:='ErroCaracterModo' else
    if Erro=ErroTimeout then result:='ErroTimeout' else
    if Erro=ErroResposta then result:='ErroResposta' else
    result:='ErroResposta';
end;

procedure TFrmCupomAbastecimento.Abastecimento_SoftPlus;
var
  Ind, Bico: Integer;
  DataHora, VirPU, VirLT, Preco, Volume, Total,
  Encerrante, Cliente, Operador, Turno, Veiculo, Odometro, Motorista : string;
begin
  DmPosto.Dados_Abastecimentos;
  // verifica se a porta está aberta
  if sConectado then
  begin
    if StatusCom = 0 then
    begin
      if CommBusy = 0 then
      begin
      	InterceptaComandos;
        Timer1.Enabled := false;
        // pecorre os bicos ativos
        for Ind := 0 to ListaAbastecimentos.Items.Count - 1 do
        begin
          try
            if Assigned(ListaAbastecimentos.Items[Ind]) then
            begin
              Bico := StrToInt(Copy(ListaAbastecimentos.Items[Ind].Caption, 1, 2));
              if GetStatusBico(Bico, DadosBico) = 0 then
              begin
                QuantidadeAtual := '00000000';
                PrecoAtual := '00000000';    //8 caracteres 5 + 2 decimais
                case DadosBico[0] of
                  'A':
                    begin
                      ListaAbastecimentos.Items[Ind].ImageIndex := 1;
                      if GetDisplay(Bico, DadosDisplay) = 0 then
                      begin
                      	QuantidadeAtual := Copy(DadosDisplay, 5, 8);
                        PrecoAtual := Copy(DadosDisplay, 13, 8);
                        ListaAbastecimentos.Items[Ind].Caption := Copy(ListaAbastecimentos.Items[Ind].Caption, 1, 2) + #13 +
                          FormatFloat(',0.000', StrToFloat(Copy(DadosDisplay, 5, 8)) / 1000);
                      end;
                    end;
                  'P': ListaAbastecimentos.Items[Ind].ImageIndex := 0;
                  'B': ListaAbastecimentos.Items[Ind].ImageIndex := 2;
                  'L': ListaAbastecimentos.Items[Ind].ImageIndex := 3;
                  'O', 'e': ListaAbastecimentos.Items[Ind].ImageIndex := 4;
                end;
//                AddBicoArquivoTexto(DadosBico[0], Bico, QuantidadeAtual, PrecoAtual);
              end;
              // caso tenha abastecimento
              if StrToInt(Copy(DadosBico, 2, 4)) > 0 then
              begin
                if GetAbastecimento(DadosAbastecimento) = 0 then
                begin
                  if (DadosAbastecimento[0] = 'o') and (DadosAbastecimento[5] <> 'A') then
                  begin
                    DataHora   := Copy(DadosAbastecimento, 19, 2) + '/' +
                      Copy(DadosAbastecimento, 21, 2) + '/' +
                      Copy(DadosAbastecimento, 23, 2) + ' ' +
                      Copy(DadosAbastecimento, 13, 2) + ':' +
                      Copy(DadosAbastecimento, 15, 2) + ':' +
                      Copy(DadosAbastecimento, 17, 2);
                    DataHora   := FormatDateTime('dd/mm/yyyy hh:nn:ss', StrToDateTime(DataHora));
                    VirPU      := Copy(DadosAbastecimento, 25, 1);
                    VirLT      := Copy(DadosAbastecimento, 26, 1);
                    Preco      := FormatFloatByDecimal(StrToFloat(Copy(DadosAbastecimento, 27, 4)), StrToIntDef(VirPU, 3));
                    Volume     := FormatFloatByDecimal(StrToFloat(Copy(DadosAbastecimento, 31, 8)), StrToIntDef(VirLT, 3));
                    Total      := FormatFloat(',0.00', StrToFloat(Copy(DadosAbastecimento, 39, 8)) / 100);
                    Encerrante := FormatFloat(',0.00', StrToFloat(Copy(DadosAbastecimento, 47, 8)) / 100);
                    Cliente    := Copy(DadosAbastecimento, 55, 8);
                    Operador   := Copy(DadosAbastecimento, 63, 8);
                    Turno      := Copy(DadosAbastecimento, 71, 1);
                    Veiculo    := Copy(DadosAbastecimento, 72, 8);
                    Odometro   := Copy(DadosAbastecimento, 80, 8);
                    Motorista  := Copy(DadosAbastecimento, 88, 4);
//                    SalvaArquivoAbastecimentos(DadosAbastecimento);
                    // Vericica Saldo combustivel
                    if sEstoqueNegativo = 'N' then
                    begin
                      if VerificaSaldoProdutoPosto(IntToStr(Bico)) < StrToFloat(Volume) then
                      begin
                         RestauraAplicativo('Abastec');
                         Mensagem('Saldo insuficiente para atender a venda.','ATENCAO');
                         Exit;
                      end;
                    end;
                    // grava o pedido do abastecimento
                    DmPosto.RegistraAbastecimentos(IntToStr(Bico),
                                                   DataHora,
                                                   DataHora,
                                                   StrToFloat(Encerrante),
                                                   StrToFloat(Volume),
                                                   StrToFloat(VirLT),
                                                   StrToFloat(Total));
                    // grava o encerrante no bico
                    DmPosto.GravaEncerranteBico(IntToStr(Bico),StrToFloat(Encerrante));
                    ApagaAbastecimento(StrToInt(Copy(DadosAbastecimento, 7, 4)));
                  end;
                end
                else
                begin
                  ApagaAbastecimento(StrToInt(Copy(DadosAbastecimento, 7, 4)))
                end;
              end;
            end;
          except
            //
          end;
        end;
      end;
    end;
    Sleep(1000);
    // atualiza o preço na bomba
    ztot:=0;

    DmAuxiliar.QryAux.Close;
    DmAuxiliar.QryAux.SQL.Clear;
    DmAuxiliar.QryAux.SQL.Add('select b.bico_concentrador,p.preco_venda from');
    DmAuxiliar.QryAux.SQL.Add('produtos p, bicos_abastec b, tanques_abastec t');
    DmAuxiliar.QryAux.SQL.Add('where t.id_produto = p.id');
    DmAuxiliar.QryAux.SQL.Add('and b.id_tanque = t.id');
    DmAuxiliar.QryAux.SQL.Add('and p.combustivel = '+QuotedStr('S'));
    DmAuxiliar.QryAux.Open;

    while not DmAuxiliar.QryAux.Eof do
    begin
      inc(ztot);
      uFuncoesSoftPlus.AlteraPreco(StrToInt(DmAuxiliar.QryAux.Fieldbyname('bico_concentrador').AsString),
                                   pAnsiChar(FormatFloat('0.000',DmAuxiliar.QryAux.Fieldbyname('preco_venda').AsCurrency)));
      DmAuxiliar.QryAux.next;
    end;
  end;
  Self.Update;

end;

function TFrmCupomAbastecimento.LerBicos: Integer;
var Bicos: TBicos;
    Ind: Integer;
begin
  try
    CriaMensAguarde('Aguarde lendo bicos...');
    ListaAbastecimentos.Items.Clear;
    Bicos := RetornaBicos;
    for Ind := 0 to Length(Bicos) - 1 do
    begin
      ListaAbastecimentos.Items.Add;
      ListaAbastecimentos.Items[Ind].Caption := IntToStrZero(Bicos[Ind]) + #13 + '0,000';
      ListaAbastecimentos.Items[Ind].ImageIndex := 0;
    end;
  finally
  	FechaMensAguarde;
    Result := Length(Bicos);
  end;

end;



procedure TFrmCupomAbastecimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if sPerdeConexao then
//     DmPosto.GravaPerdaComunicacaoBico(1,'',0);
  ListaAbastecimentos.Free;

end;

procedure TFrmCupomAbastecimento.InterceptaComandos;
var
  ArqHandle: Integer;
  NomeArq, Comando: string;
  TamanhoArq: Integer;
  Buffer: PChar;
  bico: Integer;
  Preco: String;
  nRead : Integer;
  TipoComando: char;
  cRet: string;
begin
  NomeArq := ExtractFilePath(ParamStr(0)) + 'comando.vwc';
  if FileExists(NomeArq) then
  begin
    try
      ArqHandle := FileOpen(NomeArq, fmOpenReadWrite);
      if ArqHandle < 0 then
        exit;
      TamanhoArq := FileSeek(ArqHandle, 0, 2);
      FileSeek(ArqHandle, 0, 0);
      GetMem(Buffer, TamanhoArq + 1);
      nRead := FileRead(ArqHandle, Buffer^, TamanhoArq);
      FileClose(ArqHandle);
      SysUtils.DeleteFile(NomeArq);

      // Inicilizações default
      cRet := 'e';
      TipoComando := Buffer[0];
      Comando := string(Buffer);
      bico := StrToInt(copy(Comando, 2, 2));
      if bico > 0 then
      begin
        // Analisa o Arquivo
        case TipoComando of
          // Troca de Preco
          'P':
            begin
              Preco := Copy(Comando, 4, 4);
              if AlteraPreco(Bico, PAnsiChar(Preco)) = 0 then
                cRet := 'o';
            end;
          // Liberacao de bico
          'L':
            begin
              if AutorizaAbastecimento(Bico) = 0 then
                cRet := 'o';
            end;
        end;
      end;
      // Devolve o arquivo de retorno
      NomeArq := ExtractFilePath(ParamStr(0)) + 'retorno.vwc';
      ArqHandle := FileCreate(NomeArq);
      cRet := LowerCase(string(TipoComando)) + Strzero(bico, 2) + cRet;
      if ArqHandle > 0 then
      begin
        FreeMem(Buffer);
        GetMem(Buffer, length(cRet) + 1);
        StrPCopy(Buffer, PChar(cRet));
        FileWrite(ArqHandle, Buffer^, Length(cRet) + 1);
        FileClose(ArqHandle);
      end
    finally
      FreeMem(Buffer);
    end;
  end;
end;


function TFrmCupomAbastecimento.Testa_Comunicacao_Automacao:Boolean;
begin
  try
    if DmPosto.CdsConfigPosto.fieldbyname('CONCENTRADOR').AsInteger = 0 then
    begin
      if (DmPosto.CdsConfigPosto.fieldbyname('PORTA_CBC').AsInteger > 0) then
         Result := Comunica
      else
         Result := SocketOpen;
    end;
  except
    Result := false;
  end;

end;


procedure TFrmCupomAbastecimento.AtivaConexaoConcentrador;
begin
  PnInforma.Color := clGray;
  if Timer1.Enabled then
  begin
    PnInforma.Color := clMaroon;
    timer1.enabled := false;
    PnInforma.Caption := 'Desconectado...';
//    DmPosto.GravaPerdaComunicacaoBico(1,'',0);
    Application.ProcessMessages;
  end
  else
  begin
    // abre a porta serial.
    if DmPosto.CdsConfigPosto.fieldbyname('CONCENTRADOR').AsInteger = 0 then
    begin
      if (DmPosto.CdsConfigPosto.fieldbyname('PORTA_CBC').AsInteger > 0) then
         uFuncoesPosto.FechaSerial
      else
         FechaSocket;
    end
    else
       uFuncoesSoftPlus.FinalizaCom;
    //
    timer1.enabled := true;
    PnInforma.Caption := 'Sem Conexão...';
    Application.ProcessMessages;
  end;

end;

procedure TFrmCupomAbastecimento.BitBtn2Click(Sender: TObject);
begin
  inherited;
  AtivaConexaoConcentrador;
  
end;

procedure TFrmCupomAbastecimento.VerificaPendenciasPosto;
begin
  // VERIFICA SE TEM PERDA DE COMUNICAÇÃO
  if DmPosto.VerificaComunicacaoBicos then
  begin
    DmWorkCom.PAFECF.RelatorioPerdaComunicacao(DmPosto.CdsBicoComunica);
  end;
  // verifica retorno de comunicação e imprimir
  if DmPosto.VerificaRetornoComunicacaoBico(False) then
  begin
    DmWorkCom.PAFECF.RelatorioRetornoComunicacao(DmPosto.CdsBicoComunica);
  end;
  // verifica perdas de combustivel
  if DmPosto.Dados_TanquePerda then
  begin
    DmWorkCom.PAFECF.RelatorioPerdaCombustive(DmPosto.CdsTanquePerda);
  end;

end;

procedure TFrmCupomAbastecimento.VerificaBicosDesativados;
var Q, Z : TSQLQuery;
    aEncerrante : Double;
begin
  Q := TSQLQuery.Create(nil);
  Z := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select * from bicos_abastec b');
    Q.SQL.Add('where b.ativo = '+QuotedStr('N'));
    Q.SQL.Add('and not (exists(select x.id from bico_comunica x');
    Q.SQL.Add('                where x.num_bico = b.bico_concentrador');
    Q.SQL.Add('                and x.fim is null))');
    Q.Open;
    if not Q.IsEmpty then
    begin
      while not Q.Eof do
      begin
        DmPosto.GravaPerdaComunicacaoBico(1,Q.FieldByName('BICO_CONCENTRADOR').AsString,0);
        Mensagem('Foi identificado perda de comunicação do bico '+Q.FieldByName('BICO_CONCENTRADOR').AsString+'. Verifique!','ATENCAO');
        Q.Next;
      end;
    end
    else
    begin
      Z.SQLConnection := ConexaoDados;
      Z.Close;
      Z.SQL.Clear;
      Z.SQL.Add('select * from bicos_abastec b');
      Z.SQL.Add('where b.ativo = '+QuotedStr('S'));
      Z.SQL.Add('and (exists(select x.id from bico_comunica x');
      Z.SQL.Add('            where x.num_bico = b.bico_concentrador');
      Z.SQL.Add('            and x.fim is null))');
      Z.Open;
      if not Z.IsEmpty then
      begin
        while not Z.Eof do
        begin
          aEncerrante := DmPosto.RetornaEncBicoConcentrador(Z.FieldByName('BICO_CONCENTRADOR').AsString);
          DmPosto.GravaPerdaComunicacaoBico(0,Z.FieldByName('BICO_CONCENTRADOR').AsString,aEncerrante);
          Z.Next;
        end;
      end;
    end;
    Q.Close;
    Z.Close;
  finally
    FreeAndNil(Q);
    FreeAndNil(Z);
  end;


end;

procedure TFrmCupomAbastecimento.BtnSemComunicaClick(Sender: TObject);
var aQuatLitros, aEncerranteAnterior : Double;
    aNumBico, aMensagem, AuxLitros : String;
    aIDProd : Integer;
begin
  inherited;
  // verifica se todos os bicos estão sem comunicação a menos de tempo determinado
  if not DmPosto.VerificaPermissaoImprimirCupomLivre(aMensagem) then
  begin
    MessageDlg(aMensagem,mtWarning,[mbOK],0);
    Exit;
  end
  else
  begin
    // seleciona o produto
    Application.CreateForm(TFrmProdPosto,FrmProdPosto);
    try
      FrmProdPosto.ShowModal;
      aIDProd  := FrmProdPosto.sIDProd;
    finally
      FreeAndNil(FrmProdPosto);
    end;
    // verifica se é para vincular a uma descontinuidade
    if aIDProd > 0 then
    begin
      if DmProdutos.Dados_Produto(aIDProd) then
      begin
        if DmProdutos.CdsProdutos.FieldByName('COMBUSTIVEL').AsString = 'S' then
        begin
          // captura a quantidade
          aQuatLitros := 0;
          AuxLitros := '0';
          if InputQuery('Volume do abastecimento','',AuxLitros) then
          begin
            try
              aQuatLitros := StrToFloat(AuxLitros);
            except
              On E:Exception do ShowMessage(E.Message);
            end;
          end
          else Exit;
          //
          DmPosto.Dados_Abastecimentos;
          aNumBico := DmWorkCom.RetornaBicoProduto(DmProdutos.CdsProdutos.FieldByName('ID').AsInteger);
          aEncerranteAnterior := DmWorkCom.PAFECF.RetornaUltimoEncerranteBico(aNumBico);
          aEncerranteAnterior := aEncerranteAnterior + aQuatLitros;
          DmPosto.RegistraAbastecimentos(aNumBico,
                                         FormatDateTime('dd/mm/yyyy',now),
                                         FormatDateTime('hh:mm:ss',now),
                                         aEncerranteAnterior,
                                         aQuatLitros,
                                         DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat,
                                         aQuatLitros*DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat,
                                         false,
                                         false);
          ActAtualizarExecute(Sender);
        end;
      end;
    end;
  end;

end;

{
procedure TFrmCupomAbastecimento.BitBtn7Click(Sender: TObject);
var aIDProd : Integer;
    aQuatLitros, aEncerranteAnterior : Double;
    aNumBico, aMensagem, AuxLitros : String;
begin
  inherited;
  // verifica se todos os bicos estão sem comunicação a menos de tempo determinado
  if not DmPosto.VerificaPermissaoImprimirCupomLivre(aMensagem) then
  begin
    MessageDlg(aMensagem,mtWarning,[mbOK],0);
    Exit;
  end
  else
  begin
    // seleciona o produto
    Application.CreateForm(TFrmProdPosto,FrmProdPosto);
    try
      FrmProdPosto.ShowModal;
      aIDProd  := FrmProdPosto.sIDProd;
    finally
      FreeAndNil(FrmProdPosto);
    end;
    // verifica se é para vincular a uma descontinuidade
    if aIDProd > 0 then
    begin
      if DmWorkCom.Dados_Produto(aIDProd) then
      begin
        if DmWorkCom.CdsProdutos.FieldByName('COMBUSTIVEL').AsString = 'S' then
        begin
          // captura a quantidade
          aQuatLitros := 0;
          AuxLitros := '0';
          if InputQuery('Volume do abastecimento','',AuxLitros) then
          begin
            try
              aQuatLitros := StrToFloat(AuxLitros);
            except
              On E:Exception do ShowMessage(E.Message);
            end;
          end
          else Exit;
          //
          DmPosto.Dados_Abastecimentos;
          aNumBico := DmWorkCom.RetornaBicoProduto(DmWorkCom.CdsProdutos.FieldByName('ID').AsInteger);
          aEncerranteAnterior := DmWorkCom.PAFECF.RetornaUltimoEncerranteBico(aNumBico);
          aEncerranteAnterior := aEncerranteAnterior + aQuatLitros;
          DmPosto.RegistraAbastecimentos(aNumBico,
                                         FormatDateTime('dd/mm/yyyy',now),
                                         FormatDateTime('hh:mm:ss',now),
                                         aEncerranteAnterior,
                                         aQuatLitros,
                                         DmWorkCom.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat,
                                         aQuatLitros*DmWorkCom.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat,
                                         false,
                                         false);
          ActAtualizarExecute(Sender);
        end;
      end;
    end;
  end;

end;
}
end.
