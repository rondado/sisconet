unit uFrmCadOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, ComCtrls, ImgList, ExtCtrls,
  StdCtrls, DBCtrls, Mask, uFrameBotaoHorizontal, Buttons, Grids, DBGrids,
  System.ImageList, System.Actions, SHDocVw, Vcl.OleCtrls, pnfsConversao,
  System.Math;

type
  TFrmCadOS = class(TFrmCadPadrao)
    ImageList1: TImageList;
    PnCadOS: TPanel;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    FrameBotaoHorizontal1: TFrameBotaoHorizontal;
    DataFormaPagto: TDataSource;
    DataUF: TDataSource;
    ActLancHoras: TAction;
    ActConsultaCliente: TAction;
    ActFecharOS: TAction;
    ActLiberarOS: TAction;
    GroupBox3: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    ComboUF: TDBLookupComboBox;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    GrupoDados: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DbIdCliente: TDBEdit;
    Label10: TLabel;
    DBEdit7: TDBEdit;
    DBEdit9: TDBEdit;
    Label12: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DbNControle: TDBEdit;
    Label2: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    DBEdit11: TDBEdit;
    Label14: TLabel;
    DBEdit10: TDBEdit;
    Label13: TLabel;
    DBEdit8: TDBEdit;
    Label11: TLabel;
    Label20: TLabel;
    ComboFormaPag: TDBLookupComboBox;
    DBRadioGroup1: TDBRadioGroup;
    DbRadioStatus: TDBRadioGroup;
    Bevel1: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBEdit16: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit12: TDBEdit;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    DataHoras: TDataSource;
    BitBtn4: TBitBtn;
    ActEmitirNFSe: TAction;
    TbsDados: TTabSheet;
    GroupBox1: TGroupBox;
    MemoDados: TMemo;
    TbsResposta: TTabSheet;
    GroupBox2: TGroupBox;
    MemoResp: TMemo;
    TbsXMLResp: TTabSheet;
    GroupBox4: TGroupBox;
    WBResposta: TWebBrowser;
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure ActIncluirExecute(Sender: TObject);
    procedure DbIdClienteExit(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure ActConsultaClienteExecute(Sender: TObject);
    procedure ActFecharOSExecute(Sender: TObject);
    procedure ActLiberarOSExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActRelatorioExecute(Sender: TObject);
    procedure ActLancHorasExecute(Sender: TObject);
    procedure ActEmitirNFSeExecute(Sender: TObject);
  private
    { Private declarations }
    gControle : integer;
    procedure VerificaDados;
    procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);
    procedure AlimentaComponente(NumNFSe: String);
    function RoundTo5(Valor: Double; Casas: Integer): Double;
  public
    { Public declarations }
  end;

var
  FrmCadOS: TFrmCadOS;

implementation

Uses uLibrary,uDmWorkCom, uFrmClientes, uFrmRelOS, uDMClientes,
  uFrmCadHorasOrdServ, uFrmConsOrdServ, uFrmRelOrdServ, uDmAcBr;

{$R *.dfm}

procedure TFrmCadOS.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoHorizontal1,DataWork.DataSet);

end;

procedure TFrmCadOS.FormShow(Sender: TObject);
begin
  DataWork.DataSet        := DmWorkCom.CdsOS;
  DataHoras.DataSet       := DmWorkCom.CdsOSHoras;
  DataFormaPagto.DataSet  := DmWorkCom.CdsFormaPag;
  DataUF.DataSet          := DmClientes.CdsUF;
  inherited;
  DmWorkCom.Dados_OS(0);
  DmWorkCom.Dados_OSHoras(0);
  DmWorkCom.Dados_FormaPagto;
  DataUF.DataSet.Open;
  DmWorkCom.LerConfiguracaoNFSe;
  DmWorkCom.ConfiguraComponenteNFSe;
  //
  PageControl1.TabIndex := 0;
end;

procedure TFrmCadOS.LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);
begin
 MyMemo.Lines.SaveToFile(ExtractFileDir(application.ExeName)+'temp.xml');
 MyWebBrowser.Navigate(ExtractFileDir(application.ExeName)+'temp.xml');

end;

// Função criada para arredondar valores quando a n Casa for maior ou igual a 5
// pois a função RoundTo arredonda quando a n Casa for maior ou igual a 6
function TFrmCadOS.RoundTo5(Valor: Double; Casas: Integer): Double;
var xValor, xDecimais: String;
    p, nCasas: Integer;
    nValor: Double;
begin
 nValor := Valor;
 xValor := Trim(FloatToStr(Valor));
 p      := pos(',', xValor);
 if Casas < 0
  then nCasas := - Casas
  else nCasas := Casas;
 if p > 0
  then begin
   xDecimais := Copy(xValor, p + 1, length(xValor));
   if length(xDecimais) > nCasas
    then begin
     if xDecimais[nCasas + 1] >= '5'
      then SetRoundMode(rmUP)
      else SetRoundMode(rmNearest);
    end;
   nValor := RoundTo(Valor, Casas);
  end;
 Result := nValor;

end;

procedure TFrmCadOS.ActIncluirExecute(Sender: TObject);
begin
  if gControle = 0 then
  begin
    PageControl1.TabIndex := 0;
    inherited;
    DbNControle.SetFocus;
  end;
  
end;

procedure TFrmCadOS.DbIdClienteExit(Sender: TObject);
begin
  inherited;
  if (DbIdCliente.Text <> '') and (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    if DmClientes.Dados_Contato(StrToInt(DbIDCliente.Text)) then
       DmWorkCom.PreencheDadosCliente(1)
    else
    begin
      MessageDlg('Cliente não encontrado. Verifique!!!', mtWarning, [mbOK], 0);
      DbIDCliente.SetFocus;
      Abort;
    end;
  end
  else if (DbIDCliente.Text = '') and (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    ActConsultaClienteExecute(Sender);
    DbIDClienteExit(Sender);
  end

end;

procedure TFrmCadOS.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmCadOS.ActConsultaClienteExecute(Sender: TObject);
begin
  inherited;
  FrmClientes.sCodCli := 0;
  FrmClientes.sApenasConsulta := true;
  FrmClientes.ShowModal;
  if FrmClientes.sCodCli > 0 then
  begin
    if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
       DataWork.DataSet.Edit;
    DataWork.DataSet.FieldByName('ID_CONTATO').AsInteger := FrmClientes.sCodCli;
    if DmClientes.Dados_Contato(FrmClientes.sCodCli) then
       DmWorkCom.PreencheDadosCliente(1);
  end;

end;

procedure TFrmCadOS.ActEmitirNFSeExecute(Sender: TObject);
var vNumRPS, sNomeArq : String;
begin
  inherited;
 if not(InputQuery('Gerar e Enviar NFSe', 'Numero do RPS', vNumRPS)) then
    exit;

 DmAcBr.ACBrNFSe1.NotasFiscais.Clear;
 AlimentaComponente(vNumRPS);

 DmAcBr.ACBrNFSe1.Gerar(StrToInt(vNumRPS));
 sNomeArq := DmAcBr.ACBrNFSe1.NotasFiscais.Items[0].NomeArq;

 DmAcBr.ACBrNFSe1.NotasFiscais.Clear;
 DmAcBr.ACBrNFSe1.NotasFiscais.LoadFromFile(sNomeArq);
 if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
   DataWork.DataSet.Edit;
 DataWork.DataSet.FieldByName('CHAVE_NFSE').AsString := DmAcBr.ACBrNFSe1.NotasFiscais.Items[0].NFSe.InfID.ID;
 Grava_Dados(DataWork.DataSet);
 DmAcBr.ACBrNFSe1.NotasFiscais.Imprimir;

 MemoDados.Lines.Add('Arquivo Carregado de: '+DmAcBr.ACBrNFSe1.NotasFiscais.Items[0].NomeArq);
 MemoResp.Lines.LoadFromFile(DmAcBr.ACBrNFSe1.NotasFiscais.Items[0].NomeArq);
 LoadXML(MemoResp, WBResposta);

end;

procedure TFrmCadOS.ActFecharOSExecute(Sender: TObject);
var aValorConta : Double;
begin
  inherited;
  // verificações
  if DataHoras.DataSet.RecordCount = 0 then
  begin
    MessageDlg('É necessário cadastrar as horas trabalhadas!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if DataWork.DataSet.FieldByname('VALOR_COBRADO').AsFloat <= 0 then
  begin
    MessageDlg('É necessário informar o valor da Ordem de Serviço!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if DataWork.DataSet.FieldByname('STATUS').AsInteger = 5 then
  begin
    MessageDlg('Esta Ordem de Serviço já esta fechada. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if DataWork.DataSet.FieldByname('STATUS').AsInteger = 2 then
  begin
    MessageDlg('Esta Ordem de Serviço esta marcada como não aprovada. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  if MessageDlg('Confirma o fechamento da ordem de serviço?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
  begin
    // possiciona o ultimo lançamento de horas
    DataHoras.DataSet.Last;
    // grava fechamento no pedido
    if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
       DataWork.DataSet.Edit;
    DataWork.DataSet.FieldByName('STATUS').AsInteger := 5;
    DataWork.DataSet.FieldByName('DATA_FIM').AsDateTime := DataHoras.DataSet.FieldByName('DATA_TRAB').AsDateTime;
    DataWork.DataSet.FieldByName('HORA_FIM').AsDateTime := DataHoras.DataSet.FieldByName('HORA_FIM').AsDateTime;
    if DataWork.DataSet.FieldByname('VALOR_PAGO').AsFloat <= 0 then
       DataWork.DataSet.FieldByname('VALOR_PAGO').AsFloat := DataWork.DataSet.FieldByname('VALOR_COBRADO').AsFloat;
    // confirma os dados no banco de dados
    Grava_Dados(DataWork.DataSet);
    // gera formas de pagamento
    if (DataFormaPagto.DataSet.FieldByName('GERAR_CONTA').AsString = 'S') then
    begin
      aValorConta := DataWork.DataSet.FieldByName('VALOR_PAGO').AsFloat/
                     DataFormaPagto.DataSet.FieldByName('QUANT_PAGTOS').AsInteger;
      DmWorkCom.Gerar_Contas(0,
                             0,
                             DataWork.DataSet.FieldByName('ID').AsInteger,
                             DataWork.DataSet.FieldByName('ID_CONTATO').AsInteger,
                             DataFormaPagto.DataSet.FieldByName('QUANT_PAGTOS').AsInteger,
                             DataFormaPagto.DataSet.FieldByName('FORMA_PAGTO').AsString,
                             DataWork.DataSet.FieldByName('CONTATO').AsString,
                             '',
                             DataWork.DataSet.FieldByName('DATA_FIM').AsDateTime,
                             aValorConta);
    end;
    VerificaDados;
  end;

end;

procedure TFrmCadOS.ActLancHorasExecute(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.RecordCount = 0 then
  begin
    MessageDlg('É necessário inserir uma OS antes de lançar as horas trabalhadas!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  try
    Application.CreateForm(TFrmCadHorasOrdServ,FrmCadHorasOrdServ);
    FrmCadHorasOrdServ.sIDOS := DataWork.DataSet.FieldByName('ID').AsInteger;
    FrmCadHorasOrdServ.ShowModal;
  finally
    FreeAndNil(FrmCadHorasOrdServ);
  end;

end;

procedure TFrmCadOS.ActLiberarOSExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg('Confirma a liberação da ordem de serviço?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
  begin
    // retira fechamento no pedido
    if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
       DataWork.DataSet.Edit;
    DataWork.DataSet.FieldByName('STATUS').AsInteger := 4;
    Grava_Dados(DataWork.DataSet);
    // gera formas de pagamento
    if DataFormaPagto.DataSet.FieldByName('GERAR_CONTA').AsString = 'S' then
    begin
      Apaga_Contas(1,DataWork.DataSet.FieldByName('ID').AsInteger);
    end;
    VerificaDados;
    MessageDlg('Retirada do fechamento concluída com sucesso!!!', mtWarning, [mbOK], 0);
  end;


end;

procedure TFrmCadOS.ActPesquisarExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmConsOrdServ,FrmConsOrdServ);
    FrmConsOrdServ.ShowModal;
  finally
    FreeAndNil(FrmConsOrdServ);
  end;

end;

procedure TFrmCadOS.ActRelatorioExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmRelOrdServ,FrmRelOrdServ);
    FrmRelOrdServ.ShowModal;
  finally
    FreeAndNil(FrmRelOrdServ);
  end;
end;

procedure TFrmCadOS.AlimentaComponente(NumNFSe: String);
var ValorISS: Double;
    aItemListaServ, aCodTribMun : String;
begin
 aItemListaServ := InputBox('Itens da Lista de Serviço','Codigo', '14.01');
 aCodTribMun := InputBox('Código Tributação Municipio','Código','');
 if Trim(aCodTribMun) = '' then
 begin
   MessageDlg('É necessário informar o código da tributação no município.',mtWarning,[mbOK],0);
   Exit;
 end;
 //
 with DmAcBr.ACBrNFSe1 do
  begin
   NotasFiscais.NumeroLote:= FormatDateTime('ddmmhhss',Now);
   NotasFiscais.Transacao := True;

   with NotasFiscais.Add.NFSe do
    begin
     IdentificacaoRps.Numero := FormatFloat('#########0',DataWork.DataSet.FieldByName('N_CONTROLE').AsInteger);

     // Para o provedor ISS.NET em ambiente de Homologação mudar a série para '8'
     IdentificacaoRps.Serie := 'UNICA';

     // TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
     IdentificacaoRps.Tipo := trRPS;

     DataEmissao := Now;

     (*
     TnfseNaturezaOperacao = ( no1, no2, no3, no4, no5, no6, no7,
                               no50, no51, no52, no53, no54, no55, no56, no57, no58, no59,
                               no60, no61, no62, no63, no64, no65, no66, no67, no68, no69,
                               no70, no71, no72, no78, no79,
                               no101, no111, no121, no201, no301,
                               no501, no511, no541, no551, no601, no701 );
     *)
     NaturezaOperacao := no1;
//     NaturezaOperacao := no51;

     // TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP );
//     RegimeEspecialTributacao := retNenhum;
     RegimeEspecialTributacao := retEstimativa;

     // TnfseSimNao = ( snSim, snNao );
     OptanteSimplesNacional := snNao;

     // TnfseSimNao = ( snSim, snNao );
     IncentivadorCultural := snNao;

     // TnfseSimNao = ( snSim, snNao );
     // snSim = Ambiente de Produção
     // snNao = Ambiente de Homologação
     Producao := snNao;

     // TnfseStatusRPS = ( srNormal, srCancelado );
     Status := srNormal;

     // Somente Os provedores Betha, FISSLex e SimplISS permitem incluir no RPS
     // a TAG: OutrasInformacoes os demais essa TAG é gerada e preenchida pelo
     // WebService do provedor.
     OutrasInformacoes := 'Pagamento a Vista';

     // Usado quando o RPS for substituir outro
//     RpsSubstituido.Numero := FormatFloat('#########0', i);
//     RpsSubstituido.Serie  := 'UNICA';
     // TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
///     RpsSubstituido.Tipo   := trRPS;

     Servico.Valores.ValorServicos          := DataWork.DataSet.FieldByName('VALOR_PAGO').AsFloat;
     Servico.Valores.ValorDeducoes          := 0;
     Servico.Valores.ValorPis               := 0;
     Servico.Valores.ValorCofins            := 0;
     Servico.Valores.ValorInss              := 0;
     Servico.Valores.ValorIr                := 0;
     Servico.Valores.ValorCsll              := 0;

     // TnfseSituacaoTributaria = ( stRetencao, stNormal, stSubstituicao );
     // stRetencao = snSim
     // stNormal   = snNao

     // Neste exemplo não temos ISS Retido ( stNormal = Não )
     // Logo o valor do ISS Retido é igual a zero.
     Servico.Valores.IssRetido              := stNormal;
     Servico.Valores.ValorIssRetido         := 0;

     Servico.Valores.OutrasRetencoes        := 0;
     Servico.Valores.DescontoIncondicionado := 0;
     Servico.Valores.DescontoCondicionado   := 0;

     Servico.Valores.BaseCalculo := Servico.Valores.ValorServicos -
                                    Servico.Valores.ValorDeducoes -
                                    Servico.Valores.DescontoIncondicionado;
     // No caso do provedor Ginfes devemos informar a aliquota já dividida por 100
     // para outros provedores devemos informar por exemplo 3, mas ao fazer o calculo
     // do valor do ISS devemos dividir por 100
     Servico.Valores.Aliquota    := DmWorkCom.sAliqISS;

     // Valor do ISS calculado multiplicando-se a base de calculo pela aliquota
     ValorISS := Servico.Valores.BaseCalculo * Servico.Valores.Aliquota / 100;

     // A função RoundTo5 é usada para arredondar valores, sendo que o segundo
     // parametro se refere ao numero de casas decimais.
     // exemplos: RoundTo5(50.532, -2) ==> 50.53
     // exemplos: RoundTo5(50.535, -2) ==> 50.54
     // exemplos: RoundTo5(50.536, -2) ==> 50.54

     Servico.Valores.ValorIss := RoundTo5(ValorISS, -2);

     Servico.Valores.ValorLiquidoNfse := Servico.Valores.ValorServicos -
                                         Servico.Valores.ValorPis -
                                         Servico.Valores.ValorCofins -
                                         Servico.Valores.ValorInss -
                                         Servico.Valores.ValorIr -
                                         Servico.Valores.ValorCsll -
                                         Servico.Valores.OutrasRetencoes -
                                         Servico.Valores.ValorIssRetido -
                                         Servico.Valores.DescontoIncondicionado -
                                         Servico.Valores.DescontoCondicionado;

     // TnfseResponsavelRetencao = ( ptTomador, rtPrestador );
     Servico.ResponsavelRetencao := ptTomador;

     Servico.ItemListaServico    := aItemListaServ;

     // Para o provedor ISS.NET em ambiente de Homologação
     // o Codigo CNAE tem que ser '6511102'
     // Servico.CodigoCnae                := '123'; // Informação Opcional
     Servico.CodigoTributacaoMunicipio := aCodTribMun;
     Servico.Discriminacao             := DataWork.DataSet.FieldByName('CONSTATADO').AsString;

     // Para o provedor ISS.NET em ambiente de Homologação
     // o Codigo do Municipio tem que ser '999'
     Servico.CodigoMunicipio := DmWorkCom.CdsEmpresaCOD_MUNICIPIO.AsString;

     // Informar A Exigibilidade ISS para fintelISS [1/2/3/4/5/6/7]
     Servico.ExigibilidadeISS := exiExigivel;

     // Informar para Saatri
     Servico.CodigoPais := 1058; // Brasil
     Servico.MunicipioIncidencia := StrToIntDef(DmWorkCom.CdsEmpresaCOD_MUNICIPIO.AsString, 0);

    // Somente o provedor SimplISS permite infomar mais de 1 serviço
    with Servico.ItemServico.Add do
    begin
      Descricao     := DataWork.DataSet.FieldByName('REALIZADO').AsString;
      Quantidade    := 1;
      ValorUnitario := DataWork.DataSet.FieldByName('VALOR_PAGO').AsFloat;
    end;

     Prestador.Cnpj               := DmWorkCom.CdsEmpresaCNPJ_CPF.AsString;
     Prestador.InscricaoMunicipal := DmWorkCom.CdsEmpresaINSC_MUNIC.AsString;

     // Para o provedor ISSDigital deve-se informar também:
     Prestador.Senha        := DmWorkCom.sNFSeSenha;
     Prestador.FraseSecreta := DmWorkCom.sNFSeFrase;
     Prestador.cUF          := UFToInt(DmWorkCom.CdsEmpresaUF.AsString);

     PrestadorServico.Endereco.CodigoMunicipio := DmWorkCom.CdsEmpresaCOD_MUNICIPIO.AsString;
     PrestadorServico.RazaoSocial := DmWorkCom.CdsEmpresaRAZAO_SOCIAL.AsString;

     Tomador.IdentificacaoTomador.CpfCnpj            := DmClientes.CdsContatosCNPJ_CPF.AsString;
     Tomador.IdentificacaoTomador.InscricaoMunicipal := '';

     Tomador.RazaoSocial := DmClientes.CdsContatosNOME.AsString;

     Tomador.Endereco.Endereco        := DmClientes.CdsContatosENDERECO.AsString;
     Tomador.Endereco.Numero          := DmClientes.CdsContatosNUM_END.AsString;
     Tomador.Endereco.Complemento     := DmClientes.CdsContatosCOMPLEMENTO.AsString;
     Tomador.Endereco.Bairro          := DmClientes.CdsContatosBAIRRO_END.AsString;
     Tomador.Endereco.CodigoMunicipio := DmClientes.CdsContatosCODCIDADE.AsString;
     Tomador.Endereco.UF              := DmClientes.CdsContatosUF_END.AsString;
     Tomador.Endereco.CodigoPais      := 1058; // Brasil
     Tomador.Endereco.CEP             := DmClientes.CdsContatosCEP_END.AsString;
	 //Provedor Equiplano é obrigatório o pais e IE
     Tomador.Endereco.xPais           := 'BRASIL';
     Tomador.IdentificacaoTomador.InscricaoEstadual := DmClientes.CdsContatosINSC_RG.AsString;

     Tomador.Contato.Telefone := DmClientes.CdsContatosTELEFONE.AsString;
     Tomador.Contato.Email    := DmClientes.CdsContatosEMAIL.AsString;

     // Usado quando houver um intermediario na prestação do serviço
//     IntermediarioServico.RazaoSocial        := 'razao';
//     IntermediarioServico.CpfCnpj            := '00000000000';
//     IntermediarioServico.InscricaoMunicipal := '12547478';


     // Usado quando o serviço for uma obra
//     ConstrucaoCivil.CodigoObra := '88888';
//     ConstrucaoCivil.Art        := '433';

    end;

  end;

end;

procedure TFrmCadOS.VerificaDados;
begin
  GrupoDados.Enabled := true;
  if DataWork.DataSet.FieldByName('STATUS').AsInteger = 5 then
     GrupoDados.Enabled := false;
     
end;

procedure TFrmCadOS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    MessageDlg('É necessário confirmar ou cancelar os dados da OS!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  inherited;
  DataFormaPagto.DataSet.Close;
  DataWork.DataSet.Close;
  DataHoras.DataSet.Close;
  DataUF.DataSet.Close;

end;

procedure TFrmCadOS.DataWorkDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  DmWorkCom.Dados_OSHoras(DataWork.DataSet.FieldByName('ID').AsInteger);

end;

end.
