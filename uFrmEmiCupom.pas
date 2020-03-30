//fabricio incluir popmenu -lista de pedidos com shortcut=f1
//fabricio copiar o frmidenticacliente do velho
//fabricio alterar popmenu tecla de atalho f8(imprimir pedido Dav) para f12
//fabricio alterar popmenu tecla de atalho ctrl+alt+d (ativar/desativar desconto) para f8
//fabricio substituir o frmregistraacrescimodesconto

unit uFrmEmiCupom;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmPadrao, StdCtrls, ExtCtrls, ComCtrls, DB, ActnList, Menus,
  jpeg, SqlExpr, ACBrDevice, OleCtrls, SHDocVw, DBClient, pcnConversao, math,
  unitVidaLink, System.Actions, frxClass, frxDBSet, spin, winspool;  //fabricio math, winspool

type
  TFrmEmiCupom = class(TFrmPadrao)
    StatusBar1: TStatusBar;
    DataCupom: TDataSource;
    DataItensCupom: TDataSource;
    DataProduto: TDataSource;
    ActionList1: TActionList;
    ActIncluirCupom: TAction;
    ActIncluirItem: TAction;
    ActFechamentoCupom: TAction;
    ActCancelarCupom: TAction;
    ActCancelarItem: TAction;
    ActAcionarGaveta: TAction;
    PopupMenu1: TPopupMenu;
    IncluirCupomFiscal1: TMenuItem;
    FechamentoCupom1: TMenuItem;
    CancelarCupom1: TMenuItem;
    CancelarItem1: TMenuItem;
    AcionarGaveta1: TMenuItem;
    ActImprimirDAV: TAction;
    ImprimirPedidoDAV1: TMenuItem;
    Verificagerenciador1: TMenuItem;
    ActTEFAdm: TAction;
    ActVendaTEF: TAction;
    PnInforma: TLabel;
    EdtProduto: TEdit;
    ActEncerrar: TAction;
    EncerrarEmissodeCupom1: TMenuItem;
    ActLePesoBalanca: TAction;
    LPesoBalanca1: TMenuItem;
    ActConsultaProd: TAction;
    ConsultarProduto1: TMenuItem;
    DataPedidoFP: TDataSource;
    ActFecharMesa: TAction;
    RealizarFechamentodemesas1: TMenuItem;
    ActPrevenda: TAction;
    ActAbastecimento: TAction;
    EmitirAbastecimentos1: TMenuItem;
    DataFormaPag: TDataSource;
    Label5: TLabel;
    Acessarmenufiscal1: TMenuItem;
    ImgProduto: TImage;
    PnProduto: TLabel;
    AtivarDescontoAcrescimonoItem1: TMenuItem;
    DataNCM: TDataSource;
    Consultarpreodoproduto1: TMenuItem;
    Memo: TMemo;
    Label1: TLabel;
    EdtPreco: TLabel;
    EdtQuant: TLabel;
    Label2: TLabel;
    EdtTotalItem: TLabel;
    Label3: TLabel;
    EdtTotalCupom: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Label13: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    LbDav: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    TimerItens: TTimer;
    CdsListaProd: TClientDataSet;
    CdsListaProdcodigo: TStringField;
    CdsListaProdautomatico: TBooleanField;
    LbTroco: TLabel;
    ActMenuFiscal: TAction;
    OpesdeNFCe1: TMenuItem;
    Verificarostatusdoservio1: TMenuItem;
    Inutilizarnumerao1: TMenuItem;
    GerarArquivoPDV1: TMenuItem;
    OpenDialog1: TOpenDialog;
    EmitirCupomVidaLink1: TMenuItem;
    ActEmitirCupomVidaLink: TAction;
    ReenviarNFCecompendentes1: TMenuItem;
    Emitircupomfiscaldenotamanual1: TMenuItem;
    EmitirNFCeemcontingncia1: TMenuItem;
    Realizarrecargadeprpago1: TMenuItem;
    MemoXML: TMemo;
    EmitirEmailparadaNFCe1: TMenuItem;
    frxReport1: TfrxReport;
    frxDBPedido: TfrxDBDataset;
    frxDBItens: TfrxDBDataset;
    frxDBFormaPag: TfrxDBDataset;
    frxDBEmpresa: TfrxDBDataset;
    Label15: TLabel;
    lbdadoscaixaid: TLabel;
    ListadePedidos1: TMenuItem;
    ReemitirPedido1: TMenuItem;
    chkpreco: TCheckBox;
    AtivarDesativarNegociaodepreos1: TMenuItem;
    ReImprimirNFCe1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure ActIncluirItemExecute(Sender: TObject);
    procedure EdtProdutoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtProdutoEnter(Sender: TObject);
    procedure ActCancelarCupomExecute(Sender: TObject);
    procedure ActCancelarItemExecute(Sender: TObject);
    procedure ActFechamentoCupomExecute(Sender: TObject);
    procedure ActAcionarGavetaExecute(Sender: TObject);
    procedure ActImprimirDAVExecute(Sender: TObject);
    procedure ActTEFAdmExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure ActLePesoBalancaExecute(Sender: TObject);
    procedure ActConsultaProdExecute(Sender: TObject);
    procedure EdtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActFecharMesaExecute(Sender: TObject);
    procedure ActPrevendaExecute(Sender: TObject);
    procedure ActAbastecimentoExecute(Sender: TObject);
    procedure ActIncluirCupomExecute(Sender: TObject);
    procedure AtivarDescontoAcrescimonoItem1Click(Sender: TObject);
    procedure Consultarpreodoproduto1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerItensTimer(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure Verificarostatusdoservio1Click(Sender: TObject);
    procedure Inutilizarnumerao1Click(Sender: TObject);
    procedure GerarArquivoPDV1Click(Sender: TObject);
    procedure ActEmitirCupomVidaLinkExecute(Sender: TObject);
    procedure ReenviarNFCecompendentes1Click(Sender: TObject);
    procedure Emitircupomfiscaldenotamanual1Click(Sender: TObject);
    procedure EmitirNFCeemcontingncia1Click(Sender: TObject);
    procedure Realizarrecargadeprpago1Click(Sender: TObject);
    procedure EmitirEmailparadaNFCe1Click(Sender: TObject);
    procedure ListadePedidos1Click(Sender: TObject);
    procedure ReemitirPedido1Click(Sender: TObject);
    procedure AtivarDesativarNegociaodepreos1Click(Sender: TObject);
    procedure ReImprimirNFCe1Click(Sender: TObject);
  private
    { Private declarations }
    sNotaManual, sNotaEletronica : String;
    sDAV, sMesa, xAtivaDesconto, xFechamento : boolean;
    pPesoBalanca : Double;
    xValDesc, xValAcres : Double;
    xPercentual, JaHouveErroFechamento, xporqtde : Boolean; //fabricio incluir , xporqtde : Boolean;
    sTipoEmissao : Integer;
    procedure ExibeDadosItem;
    procedure TotalizaCupom(Zerado:Boolean=false);
    function RealizaVendaTEF(pTipo,pControle:Integer):Boolean;
    function ImprimeVendaTEF(pFormaPag,pCOO:String;pValor:Double;pControle:Integer):Boolean;
    function RetornaAliquotaProduto:String;
    procedure CancelaCupomFiscal(pTipoCancel,pIDUsuarioCanc:Integer);
    procedure CancelamentoNFCe(pIDUsuarioCanc:Integer);
    procedure CancelamentoSAT(pIDUsuarioCanc:Integer);
    procedure RecuperarCupomFiscalAberto(pID:Integer);
    procedure GravaFormasPagamentoNaoConfirmada(pID:Integer);
    procedure AtivaDesativaAction(Ativar:Boolean);
    function RetornaDadosCliente:Boolean;
    procedure VerificaNotaEmContingencia;
  public
    { Public declarations }
  end;

var
  FrmEmiCupom: TFrmEmiCupom;
//fabricio inicio
  ListaPedido: boolean;
  ppp: integer;
  Semidentifica: boolean;
  novopreco: string;
//fabricio fim

  //  procedure GravaQrCode(Path,Codigo:String); stdcall; external '_QrCode.dll';

implementation

Uses uDmWorkCom,uFuncoesPAFECF,uLibrary, StrUtils,uFrmFecharCupom,
  uFrmIdenticaCliente, uFrmProdutos, uDmAcBr, uFrmFechaMesa, ACBrECF,
  uFrmCupomAbastecimento, uFrmCupomDAVPV, uFrmRegistraDescAcres, uFrmMenuFiscal,
  uMensagem, uFrmMensageemProd, uFrmLiberacao, uFrmPrecoProduto, ACBrNFe,
  pcnRetConsReciNFe, uFrmAutorizaVidaLink, uFrmNFCePendente, uDMClientes,
  uFrmNFCeEmitida, ACBrNFeConfiguracoes, ACBrNFeNotasFiscais, pcnNFe,
  uDmAuxiliar, uDmPosto, ACBrDFeConfiguracoes, uFrmListaContigencia, uFrmPrincipalNFCe, //fabricio uFrmPrincipalNFCe
  ACBrSAT, uDmProdutos, uFrmRecargaPre, uFrmDadosPOS;

{$R *.dfm}

//fabricio incluir inicio
function tbKeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

//fabricio fim

procedure TFrmEmiCupom.FormShow(Sender: TObject);
var formMensagem: TFormMensagem;
    aCupom : Boolean;
    aEstado : TACBrECFEstado;
    Sistema : String;
begin
  inherited;
  try


    formMensagem := TFormMensagem.Create('Aguarde... inicializa a tela de emissão de cupom fiscal!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
//fabricio inicio incluir 2 labels na tela de vendas
    novopreco:= '0';
    ListaPedido:=false;
    sPAFNFCe:=1;
    SemIdentifica:=true;
    lbdadoscaixaid.Caption:= IntToStr(dadoscaixaid);
//fabricio fim

    // verifica opções DAV
  //  LbDav.Visible := false;
    ImprimirPedidoDAV1.Visible := false;
    ActImprimirDAV.Enabled := false;
    if DmWorkCom.PAFECF.gDAVPV then
    begin
      ActImprimirDAV.Enabled := true;
      ImprimirPedidoDAV1.Visible := true;
  //    LbDav.Visible := true;
    end;
    // bloqueia
    DmWorkCom.Dados_Empresa(sIDEmpresa);
    Emitircupomfiscaldenotamanual1.Visible := true;
    if (DmWorkCom.CdsEmpresa.FieldByName('PERFIL_PAFECF').AsString = 'Z') or
       (DmWorkCom.CdsEmpresa.FieldByName('PERFIL_PAFECF').AsString = 'Y') then
    begin
      Emitircupomfiscaldenotamanual1.Visible := false;
    end;
    // verifica opções Mesas
    ActFecharMesa.Enabled := false;
    RealizarFechamentodemesas1.Visible := false;
    if DmWorkCom.PAFECF.gRestaurante then
    begin
      ActFecharMesa.Enabled := true;
      RealizarFechamentodemesas1.Visible := true;
      // desabilita o DAV
      LbDav.Visible := false;
      ImprimirPedidoDAV1.Visible := false;
      ActImprimirDAV.Enabled := false;
    end;
    // verifica opções Posto
    ActAbastecimento.Enabled := false;
    EmitirAbastecimentos1.Visible := false;
    if DmWorkCom.PAFECF.gPosto then
    begin
      ActAbastecimento.Enabled := true;
      EmitirAbastecimentos1.Visible := true;
    end;
    // verifica se é paf-ecf
//    ActMenuFiscal.Enabled := false;
    Acessarmenufiscal1.Visible := false;
    OpesdeNFCe1.Visible := false;
    if sPAFNFCe = 0 then
    begin
//      ActMenuFiscal.Enabled      := true;
      Acessarmenufiscal1.Visible := true;
    end;
    // verifica se permite recarga de pré pago
    Realizarrecargadeprpago1.Visible := False;
    Realizarrecargadeprpago1.Enabled := False;
    if DmWorkCom.PAFECF.sTipoTef = 1 then
    begin
      Realizarrecargadeprpago1.Visible := True;
      Realizarrecargadeprpago1.Enabled := True;
    end;
    StatusBar1.Panels.Items[5].Text := 'MODO: Normal';
    DmWorkCom.PAFECF.Painel := PnInforma;
    DataCupom.DataSet       := DmWorkCom.CdsPedidos;
    DataItensCupom.DataSet  := DmWorkCom.CdsPedidoItens;
    DataProduto.DataSet     := DmProdutos.CdsProdutos;
    DataPedidoFP.DataSet    := DmWorkCom.CdsPedidoFP;
    DataFormaPag.DataSet    := DmWorkCom.CdsFormaPag;
    DataNCM.DataSet         := DmProdutos.CdsNCM;
    DmProdutos.Dados_Produto(0);
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoItens(0);
    DmWorkCom.Dados_PedidoFP(0);
    DmWorkCom.Dados_FormaPagto;
    DmProdutos.Dados_NCM;
    DmWorkCom.Dados_Config(sIDEmpresa);
    if sPAFNFCe = 1 then
    begin
      case DmWorkCom.sFormas of
        1: StatusBar1.Panels.Items[4].Text := 'MODO: Normal';
        2: StatusBar1.Panels.Items[4].Text := 'MODO: Contingência';
        3: StatusBar1.Panels.Items[4].Text := 'MODO: SCAN';
        4: StatusBar1.Panels.Items[4].Text := 'MODO: DPEC';
        5: StatusBar1.Panels.Items[4].Text := 'MODO: FSDA';
        6: StatusBar1.Panels.Items[4].Text := 'MODO: SVCAN';
        7: StatusBar1.Panels.Items[4].Text := 'MODO: SVCRS';
        8: StatusBar1.Panels.Items[4].Text := 'MODO: SVCSP';
        9: StatusBar1.Panels.Items[4].Text := 'MODO: OffLine';
      end;
      if DmWorkCom.sFormas <> 1 then
      begin
        MessageDlg('É importante ressaltar que a utilização de contingência off-line'+#13+#10+
                   'deve se restringir as situações de efetiva impossibilidade de'+#13+#10+
                   'autorização da NFC-e em tempo real, haja vista que pode vir a'+#13+#10+
                   'representar custos e riscos adicionais ao contribuinte.',mtWarning,[mbOK],0);
      end;
      OpesdeNFCe1.Visible := true;
      DmWorkCom.AtualizaConfigAcBr;
      // verifica se tem notas emitidas em continhência
      VerificaNotaEmContingencia;
    end
    else if sPAFNFCe = 2 then
    begin
      //
      DmWorkCom.AjustaACBrSAT;
      DmWorkCom.ConfiguraRedeSAT;
      DmWorkCom.PrepararImpressao;
      //
      DmAcBr.ACBrSAT1.Inicializado := not DmAcBr.ACBrSAT1.Inicializado;

      if DmAcBr.ACBrSAT1.Inicializado then
         StatusBar1.Panels.Items[4].Text := 'SAT Inicializado'
      else
         StatusBar1.Panels.Items[4].Text := 'SAT não Inicializado';
    end;
    sDAV := false;
    sMesa := false;
    xFechamento := false;
    Memo.Lines.Clear;
    if sPAFNFCe = 0 then
    begin
      aEstado := DmAcBr.ACBrECF1.Estado;
      if aEstado <> estLivre then
      begin
        if aEstado = estVenda then
        begin
          if DmWorkCom.Dados_Pedido(StrToInt(DmAcBr.ACBrECF1.NumCOO),1) then
          begin
            RecuperarCupomFiscalAberto(DataCupom.DataSet.FieldByName('ID').AsInteger);
            GravaFormasPagamentoNaoConfirmada(DataCupom.DataSet.FieldByName('ID').AsInteger);
          end
          else
          begin
            DmWorkCom.PAFECF.CancelaCupomECF;
            EdtProduto.SetFocus;
          end;
        end
        else
        begin
          if aEstado = estPagamento then
          begin
            DmWorkCom.PAFECF.CancelaCupomECF;
            if DmWorkCom.Dados_Pedido(StrToInt(DmAcBr.ACBrECF1.NumCOO),1) then
            begin
              if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
                 DataCupom.DataSet.Edit;
              DataCupom.DataSet.FieldByName('CANCELADO').AsString := 'S';
              Grava_Dados(DataCupom.DataSet);
              // se for abastecimento, retorna os mesmo para o status de pendente
              if (DmWorkCom.PAFECF.gPosto) and
                 (DataCupom.DataSet.FieldByName('ABASTECIMENTO').AsString = 'S') then
              begin
                 DmPosto.RetornaStatusAbastecCupom(DataCupom.DataSet.FieldByname('ID').AsInteger);
              end;
            end;
          end;
          // não fiscal
          if (DmAcBr.ACBrECF1.Estado = estRelatorio) or
             (DmAcBr.ACBrECF1.Estado = estNaoFiscal) then
          begin
            DmWorkCom.PAFECF.CancelarCupomNaoFiscal;
          end;
          // retorna o foco da aplicação
          EdtProduto.SetFocus;
        end;
      end;
    end
    else
    begin
      // retorna o foco da aplicação
      EdtProduto.SetFocus;
    end;
    DmWorkCom.Dados_Empresa(sIDEmpresa);
    TotalizaCupom(false);
    StatusBar1.Panels.Items[0].Text := 'Ultimo Documento: ';
    StatusBar1.Panels.Items[1].Text := 'Operador: '+DmWorkCom.PAFECF.gNomeOperador;
    StatusBar1.Panels.Items[2].Text := 'PDV: '+DmWorkCom.PAFECF.gCaixa;
    StatusBar1.Panels.Items[3].Text := 'Pressione Ctrl+Alt+M para o menu fiscal';
    if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundovenda.jpg') then
       ImgProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundovenda.jpg');
  finally
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
  end;
end;

procedure TFrmEmiCupom.ActIncluirItemExecute(Sender: TObject);
var AuxCodPro, aQuant,aCodigo, aMensagem : String;
    aPosicao : Integer;
    exe: extended; //fabricio novo - incluir
    aux, ValorTotalItem, ValorCargaFed, ValorCargaEst, ValorCargaMun : Double;
    aOK, aProdAutomatico, aProdOk, EhCodigoBalanca : Boolean;
begin
  inherited;
  AuxCodPro       := CdsListaProdcodigo.AsString;
  aProdAutomatico := CdsListaProdautomatico.AsBoolean;
  //
  if AuxCodPro = '' then
  begin
    MessageDlg('É necessário informar o código do produto!!!', mtWarning, [mbOK], 0);
    EdtProduto.SetFocus;
    Abort;
  end;
  // Verifica Edição da Tabela
  if (DataCupom.DataSet.State in [dsInsert,dsEdit]) then
     Grava_Dados(DataCupom.DataSet);
  // Verifica se tem cupom em aberto
  if DataCupom.DataSet.RecordCount = 0 then
  begin
    if not ActIncluirCupom.Execute then
    begin
      MessageDlg('Erro ao abrir o cupom fiscal. Verifique!', mtWarning, [mbOK], 0);
      EdtProduto.SetFocus;
      CdsListaProd.EmptyDataSet;
      Abort;
    end;
  end;
  // verifica se é cupom VIDALINK
  if DataCupom.DataSet.FieldByName('NAUTORIZA_VIDALINK').AsString <> '' then
  begin
    MessageDlg('Não é permitido inserir itens em cupom de autorização VidaLink!!!', mtWarning, [mbOK], 0);
    EdtProduto.SetFocus;
    Abort;
  end;
  //
  if DataCupom.DataSet.RecordCount > 0 then
  begin
    aOK := false;
    if sPAFNFCe = 0 then // paf-ecf
    begin
      if DmAcBr.ACBrECF1.Estado = estVenda then
      begin
        aOK := true;
      end
      else
        MessageDlg('Impressora não esta em modo de venda. Caso tenha cupom pendente proceda o cancelamento!', mtInformation, [mbOK], 0);
    end
    else aOK := true;
    // se estiver tudo ok
    if aOK then
    begin
      try
        aQuant := '1';
        if pPesoBalanca > 0 then
        begin
          aQuant := FormatFloat('0.000',TruncaValor(pPesoBalanca,3));
          StatusBar1.Panels.Items[2].Text := '';
          pPesoBalanca := 0;
        end;
        // efetua a leitura do código
        EhCodigoBalanca := false;
        if DmWorkCom.PAFECF.gNumDigito = 4 then
        begin
          if (Copy(AuxCodPro,1,1) = DmWorkCom.PAFECF.gDigito) and
             (pos('X',UpperCase(AuxCodPro)) = 0) and
             (Length(AuxCodPro) = 13) then
          begin
            aCodigo := ZeroEsquerda(copy(AuxCodPro,2,4),13);
            EhCodigoBalanca := true;
          end;
        end
        else if DmWorkCom.PAFECF.gNumDigito = 5 then
        begin
          if (Copy(AuxCodPro,1,1) = DmWorkCom.PAFECF.gDigito) and
             (pos('X',UpperCase(AuxCodPro)) = 0) and
             (Length(AuxCodPro) = 13) then
          begin
            aCodigo := ZeroEsquerda(copy(AuxCodPro,2,5),13);
            EhCodigoBalanca := true;
          end;
        end
        else if DmWorkCom.PAFECF.gNumDigito = 6 then
        begin
          if (Copy(AuxCodPro,1,1) = DmWorkCom.PAFECF.gDigito) and
             (pos('X',UpperCase(AuxCodPro)) = 0) and
             (Length(AuxCodPro) = 13) then
          begin
            aCodigo := ZeroEsquerda(copy(AuxCodPro,2,6),13);
            EhCodigoBalanca := true;
          end;
        end;
        // se não for codigo de balança, verifica se tem o X para quantidade
        if not EhCodigoBalanca then
        begin
          aPosicao := pos('X',UpperCase(AuxCodPro));
          if aPosicao = 1 then
          begin
            Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
            try
              FrmMensageemProd.PnMensagem.Caption := 'Código informado de forma incorreta. Verifique!';
              FrmMensageemProd.ShowModal;
            finally
              FreeAndNil(FrmMensageemProd);
              EdtProduto.SetFocus;
              Abort;
            end;
          end;
          if aPosicao > 1 then
          begin
            try
              aQuant := copy(AuxCodPro,1,aPosicao-1);
              aQuant := FormatFloat('0.000',TruncaValor(StrToFloat(aQuant),3));
            except
              Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
              try
                FrmMensageemProd.PnMensagem.Caption := 'Q quantidade informada para o produto é inválida!';
                FrmMensageemProd.ShowModal;
              finally
                FreeAndNil(FrmMensageemProd);
                EdtProduto.SetFocus;
                Abort;
              end;
            end;
          end;
          aCodigo := copy(AuxCodPro,aPosicao+1,length(AuxCodPro)-aPosicao);
        end;
        // verifica quantidade negativa
        if StrToFloat(aQuant) <= 0 then
        begin
          Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
          try
            FrmMensageemProd.PnMensagem.Caption := 'A quantidade não pode ser zero ou negativa!';
            FrmMensageemProd.ShowModal;
          finally
            FreeAndNil(FrmMensageemProd);
            EdtProduto.SetFocus;
            Abort;
          end;
        end;
        //
//        if Length(aCodigo) < 13 then
//           aCodigo := ZeroEsquerda(aCodigo,13);

//fabricio novo inicio
        if Length(aCodigo) <= 6  then
        begin
           aProdOk := DmProdutos.Dados_Produto(StrToInt(aCodigo));
           if not(aProdOk) then
              aProdOk := DmProdutos.Dados_Produto(aCodigo);
        end
        else
        begin
           aProdOk := DmProdutos.Dados_Produto(aCodigo);
           if not(aProdOk) then
              aProdOk := DmProdutos.Dados_Produto(StrToInt(aCodigo));
        end;

//fabricio novo fim
        if not(aProdOk) then
        begin
          Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
          try
            FrmMensageemProd.PnMensagem.Caption := 'Produto não cadastrado!';
            FrmMensageemProd.ShowModal;
          finally
            FreeAndNil(FrmMensageemProd);
            EdtProduto.SetFocus;
            Abort;
          end;
        end
        else
        begin
          // verifica imagem do produtoi
          if FileExists(ExtractFilePath(Application.ExeName)+'imagens\'+aCodigo+'.jpg') then
             ImgProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\'+aCodigo+'.jpg')
          else if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundovenda.jpg') then
             ImgProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundovenda.jpg');
          // se for codigo de balança, captura o peso
          if EhCodigoBalanca then
          begin
            aux     := StrToFloat(copy(AuxCodPro,8,5));
//fabricio inicio retirar esta linha            aux     := aux /100;
            exe  := SimpleRoundTo(aux/DataProduto.DataSet.FieldbyName('PRECO_VENDA').AsExtended/100, -3);

            aQuant:= FormatFloat('###.000.000', exe);
//fabricio fim - funcao simperoundto+exe
//            aQuant  := FormatFloat('0.000',TruncaValor(aux/DataProduto.DataSet.FieldbyName('PRECO_VENDA').AsFloat,3));
          end;
          // verifica se é combustivel e de origem automatica
          if (DmProdutos.CdsProdutos.FieldByName('COMBUSTIVEL').AsString = 'S') and
             (not aProdAutomatico) then
          begin
            Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
            try
              FrmMensageemProd.PnMensagem.Caption := 'Não é permitido vender combustível desta forma!';
              FrmMensageemProd.ShowModal;
            finally
              FreeAndNil(FrmMensageemProd);
              EdtProduto.SetFocus;
              Abort;
            end;
          end;
          //
          if not DmWorkCom.VerificaDadosProduto then
          begin
            Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
            try
              FrmMensageemProd.PnMensagem.Caption := 'Produto não pode ser vendido. verifique!';
              FrmMensageemProd.ShowModal;
            finally
              FreeAndNil(FrmMensageemProd);
              EdtProduto.SetFocus;
              Abort;
            end;
          end;
          // verifica quantidade fracionada compatível
          if (Frac(StrToFloat(aQuant)) <> 0) and
             (DataProduto.DataSet.FieldbyName('FRACIONADO').AsString = 'N') then
          begin
            Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
            try
              FrmMensageemProd.PnMensagem.Caption := 'Este produto não pode ser vendido com quantidade fracionada!';
              FrmMensageemProd.ShowModal;
            finally
              FreeAndNil(FrmMensageemProd);
              EdtProduto.SetFocus;
              Abort;
            end;
          end
        end;
        // verifica desconto
//fabricio novo valor inicio
        if chkpreco.Checked then
        begin
           novopreco:= CurrToStr(DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsCurrency * (1+StrToCurr(DmWorkCom.negocia)));
           InputQuery(DmProdutos.CdsProdutos.FieldByName('DESCRICAO').AsString+' à vista R$'+DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsString,'Informe o novo valor negociado! R$ ', novopreco);

            if StrToFloat(novopreco) > DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat  then
            begin
               xValAcres:= StrToFloat(novopreco) - DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat;
               xporqtde:=true;
            end
            else
            if StrToFloat(novopreco) < DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat  then
            begin
               xValDesc:= DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat - StrToFloat(novopreco);
               xporqtde:=true;
            end;
        end;
//fabricio novo valor fim

        if xAtivaDesconto then
        begin
          Application.CreateForm(TFrmRegistraDescAcres,FrmRegistraDescAcres);
          try
            FrmRegistraDescAcres.ShowModal;
            xValDesc  := FrmRegistraDescAcres.xValDesc;
            xValAcres := FrmRegistraDescAcres.xValAcres;
            xPercentual := FrmRegistraDescAcres.xPercentual;
//fabricio incluir linha abaixo
            xporqtde:= FrmRegistraDescAcres.xporqtde;
          finally
            FreeAndNil(FrmRegistraDescAcres);
          end;
        end;
        // localiza dados do NCM
        DmProdutos.Dados_NCM(DataProduto.DataSet.FieldByName('CODIGO_NCM').AsString,
                            DataProduto.DataSet.FieldByName('EXCECAO_NCM').AsInteger);
        // registra o item no banco de dados
        if not DmWorkCom.InsereItemCupom(StrToFloat(aQuant),
                                         xValAcres,
                                         xValDesc,
//fabricio tirar                                         xPercentual) then
//fabrici incluir abaixo
                                         xPercentual, xporqtde) then
        begin
          Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
          try
            FrmMensageemProd.PnMensagem.Caption := 'Erro ao incluir item no banco de dados. Verifique!';
            FrmMensageemProd.ShowModal;
          finally
            FreeAndNil(FrmMensageemProd);
            xValDesc  := 0;
            xValAcres := 0;
//fabricio novoinicio
            xpercentual:=false;
            xporqtde:=false;
//fabricio novofim
            xAtivaDesconto := false;
          end;
        end
        else
        begin
          // registra item
          if sPAFNFCe = 0 then  // paf-ecf
          begin
            try
              AtivaDesativaAction(false);
              if DmWorkCom.RegistraItemECF(aQuant) then
              begin
                ValorTotalItem := TruncaValor((((DataItensCupom.DataSet.FieldByName('QUANTIDADE').AsFloat*
                                              DataItensCupom.DataSet.FieldByName('VALOR').AsFloat)-
                                              DataItensCupom.DataSet.FieldByName('DESCONTO').AsFloat)+
                                              DataItensCupom.DataSet.FieldByName('ACRESCIMO').AsFloat),DmWorkCom.PAFECF.gDecimais);
                // calcula a carga a ser adicionada
                ValorCargaFed := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_NACIONAL').AsFloat) / 100);
                ValorCargaEst := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_ESTADUAL').AsFloat) / 100);
                ValorCargaMun := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_MUNICIPAL').AsFloat) / 100);
                // grava no pedido
                if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
                   DataCupom.DataSet.Edit;
                DataCupom.DataSet.FieldByName('valor_carga_trib').AsFloat := DataCupom.DataSet.FieldByName('valor_carga_trib').AsFloat + ValorCargaFed;
                DataCupom.DataSet.FieldByName('VAL_CARGA_FED').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_FED').AsFloat + ValorCargaFed;
                DataCupom.DataSet.FieldByName('VAL_CARGA_EST').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_EST').AsFloat + ValorCargaEst;
                DataCupom.DataSet.FieldByName('VAL_CARGA_MUN').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_MUN').AsFloat + ValorCargaMun;
                Grava_Dados(DataCupom.DataSet);
                //
                PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;

                ExibeDadosItem;
                TotalizaCupom;
                DmWorkCom.PAFECF.AtualizaINI(false);
              end
              else
              begin
                Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
                try
                  FrmMensageemProd.PnMensagem.Caption := 'Erro ao incluir item. Verifique!';
                  FrmMensageemProd.ShowModal;
                finally
                  FreeAndNil(FrmMensageemProd);
                  DmWorkCom.ApagaRegistroItem(DataItensCupom.DataSet.FieldByName('ID').AsInteger);
                  Dec(DmWorkCom.sNumItem);
                  DmWorkCom.Dados_PedidoItens(DataCupom.DataSet.FieldByname('ID').AsInteger);
                end;
              end;
            finally
              xValDesc  := 0;
              xValAcres := 0;
//fabricio novoinicio
            xpercentual:=false;
            xporqtde:=false;
//fabricio novofim
              xAtivaDesconto := false;
              AtivaDesativaAction(true);
            end;
          end
          else
          begin
            // nfce, sat ou NFrente
            try
              AtivaDesativaAction(false);
              ValorTotalItem := TruncaValor((((DataItensCupom.DataSet.FieldByName('QUANTIDADE').AsFloat*
                                            DataItensCupom.DataSet.FieldByName('VALOR').AsFloat)-
                                            DataItensCupom.DataSet.FieldByName('DESCONTO').AsFloat)+
                                            DataItensCupom.DataSet.FieldByName('ACRESCIMO').AsFloat),DmWorkCom.PAFECF.gDecimais);
              // calcula a carga a ser adicionada
              ValorCargaFed := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_NACIONAL').AsFloat) / 100);
              ValorCargaEst := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_ESTADUAL').AsFloat) / 100);
              ValorCargaMun := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_MUNICIPAL').AsFloat) / 100);
              // grava no pedido
              if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
                 DataCupom.DataSet.Edit;
              DataCupom.DataSet.FieldByName('valor_carga_trib').AsFloat := DataCupom.DataSet.FieldByName('valor_carga_trib').AsFloat + ValorCargaFed;
              DataCupom.DataSet.FieldByName('VAL_CARGA_FED').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_FED').AsFloat + ValorCargaFed;
              DataCupom.DataSet.FieldByName('VAL_CARGA_EST').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_EST').AsFloat + ValorCargaEst;
              DataCupom.DataSet.FieldByName('VAL_CARGA_MUN').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_MUN').AsFloat + ValorCargaMun;
              Grava_Dados(DataCupom.DataSet);
              //
              PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;
              ExibeDadosItem;
              TotalizaCupom;
              DmWorkCom.PAFECF.AtualizaINI(false);
            finally
              xValDesc  := 0;
              xValAcres := 0;
//fabricio novoinicio
            xpercentual:=false;
            xporqtde:=false;
//fabricio novofim

              xAtivaDesconto := false;
              AtivaDesativaAction(true);
            end;
          end;
        end;
        EdtProduto.SetFocus;
      except
        EdtProduto.SetFocus;
      end;
    end;
    EdtProduto.SetFocus;
  end;
end;

procedure TFrmEmiCupom.EdtProdutoExit(Sender: TObject);
var Aux : String;
begin
  inherited;
  if not xFechamento then
  begin
    try
      if EdtProduto.Text <> '' then
      begin
        Aux := EdtProduto.Text;
        EdtProduto.Clear;
        EdtProduto.ReadOnly := true;
        // inclui o item a lista de produtos a serem registrados
        CdsListaProd.Append;
        CdsListaProdcodigo.AsString := Aux;
        CdsListaProdautomatico.AsBoolean := false;
        CdsListaProd.Post;
        Aux := '';
      end;
    finally
      EdtProduto.ReadOnly := false;
      EdtProduto.Clear;
      EdtProduto.SetFocus;
    end;
  end;
end;

procedure TFrmEmiCupom.ExibeDadosItem;
var aux : String;
begin
  aux := ZeroEsquerda(IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger),3)+'  ';
  aux := aux + DataItensCupom.DataSet.FieldByName('EAN13').AsString+'  ';
  aux := aux + Copy(DataItensCupom.DataSet.FieldByname('DESCRICAO').AsString,1,29);
  Memo.Lines.Add(aux);
  aux := FormatFloat('0.000',DataItensCupom.DataSet.FieldByName('QUANTIDADE').AsFloat)+'     ';
  aux := aux + DataProduto.DataSet.FieldByName('UNIDADE').AsString+'  ';
  aux := aux + FormatFloat(DmWorkCom.PAFECF.gFormatoDec,DataItensCupom.DataSet.FieldByName('VALOR').AsFloat)+'  ';
  aux := aux + FormatFloat(DmWorkCom.PAFECF.gFormatoDec,TruncaValor(((DataItensCupom.DataSet.FieldByName('QUANTIDADE').AsFloat*
                                                 DataItensCupom.DataSet.FieldByName('VALOR').AsFloat)-
                                                 DataItensCupom.DataSet.FieldByName('DESCONTO').AsFloat)+
                                                 DataItensCupom.DataSet.FieldByName('ACRESCIMO').AsFloat,DmWorkCom.PAFECF.gDecimais))+'     ';

  aux := aux + '  ' + RetornaAliquotaProduto;
  Memo.Lines.Add(aux);
  if DataItensCupom.DataSet.FieldByName('DESCONTO').AsFloat > 0 then
  begin
    aux := 'Desconto no item '+ZeroEsquerda(IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger),3)+'    -'+
           FormatFloat('0.00',DataItensCupom.DataSet.FieldByName('DESCONTO').AsFloat);
    Memo.Lines.Add(aux);
  end;
  // acrescimo
  if DataItensCupom.DataSet.FieldByName('ACRESCIMO').AsFloat > 0 then
  begin
    aux := 'Acrescimo no item '+ZeroEsquerda(IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger),3)+'    +'+
           FormatFloat('0.00',DataItensCupom.DataSet.FieldByName('ACRESCIMO').AsFloat);
    Memo.Lines.Add(aux);
  end;

end;

procedure TFrmEmiCupom.TotalizaCupom;
begin
  if not(Zerado) then
  begin
    EdtPreco.Caption      := FormatFloat(DmWorkCom.PAFECF.gFormatoDec,DataItensCupom.DataSet.FieldByName('VALOR').AsFloat);
    EdtQuant.Caption      := FormatFloat('0.000',DataItensCupom.DataSet.FieldByName('QUANTIDADE').AsFloat);
    EdtTotalItem.Caption  := FormatFloat(DmWorkCom.PAFECF.gFormatoDec,TruncaValor(((DataItensCupom.DataSet.FieldByName('QUANTIDADE').AsFloat*
                                                               DataItensCupom.DataSet.FieldByName('VALOR').AsFloat)-
                                                               DataItensCupom.DataSet.FieldByName('DESCONTO').AsFloat)+
                                                               DataItensCupom.DataSet.FieldByName('ACRESCIMO').AsFloat,DmWorkCom.PAFECF.gDecimais));
    EdtTotalCupom.Caption := FormatFloat(DmWorkCom.PAFECF.gFormatoDec,DmWorkCom.RetornaTotalCupom(DataCupom.DataSet.FieldByname('ID').AsInteger));
  end
  else
  begin
    EdtPreco.Caption      := FormatFloat(DmWorkCom.PAFECF.gFormatoDec,0);
    EdtQuant.Caption      := FormatFloat('0.000',0);
    EdtTotalItem.Caption  := FormatFloat(DmWorkCom.PAFECF.gFormatoDec,0);
    EdtTotalCupom.Caption := FormatFloat(DmWorkCom.PAFECF.gFormatoDec,0);
  end;

//fabricio novo valor inicio
   novopreco:='0';
//fabricio novo fim
end;

procedure TFrmEmiCupom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   // verifica se tem notas emitidas em continhência
   VerificaNotaEmContingencia;
   //
   if sPAFNFCe = 0 then
   begin
     if DmAcBr.ACBrECF1.Estado = estVenda then
     begin
       MessageDlg('É necessário finalizar o cupom aberto!',mtWarning,[mbok],0);
       Abort;
     end;
   end;
   if (DataCupom.DataSet.RecordCount > 0) then
   begin
     if not Confirmacao('O lançamento em aberto será cancelado. Prosseguir?') then
     begin
       MessageDlg('Proceda o fechamento do lançamento!',mtWarning,[mbok],0);
       Abort;
     end;
     DataCupom.DataSet.Edit;
     DataCupom.DataSet.FieldByName('CANCELADO').AsString := 'S';
     Grava_Dados(DataCupom.DataSet);
   end;
   // fecha tabelas
   DataCupom.DataSet.Close;
   DataItensCupom.DataSet.Close;
   DataProduto.DataSet.Close;
   DataPedidoFP.DataSet.Close;
   DataFormaPag.DataSet.Close;
   CdsListaProd.Close;

end;

procedure TFrmEmiCupom.EdtProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmEmiCupom.EdtProdutoEnter(Sender: TObject);
begin
  inherited;
  EdtProduto.Clear;
  if DataCupom.DataSet.RecordCount = 0 then
  begin
    PnInforma.Caption := 'Caixa Livre';
    PnProduto.Caption := '';
    LbTroco.Caption   := '';
    sNotaManual := '';
    sNotaEletronica := '';
    //fabricio inicio
    ListaPedido:=false;
    sPAFNFCe:=1;

    //fabricio fim
    // se for posto abre a tela de abastecimento
    if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
       ActAbastecimentoExecute(Sender);
  end;
end;

procedure TFrmEmiCupom.ActCancelarCupomExecute(Sender: TObject);
var formMensagem: TFormMensagem;
    aMensagem : String;
    aOK : Boolean;
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  if sPAFNFCe = 0 then // paf-ecf
  begin
    try
      formMensagem := TFormMensagem.Create('Aguarde... Verificando estado da impressora!',550,150,clBlack,clSilver);
      formMensagem.mostrar;
      Refresh;
      aOK := DmWorkCom.PAFECF.VerificaImpressoraLigada;
    finally
      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
    end;
  end
  else aOK := true;  
  //
  if aOK then
  begin
    if sPAFNFCe = 0 then // paf-ecf
    begin
      if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
      begin
        ShowMessage(aMensagem);
        DmWorkCom.PAFECF.sControleECFAtivo := 2;
        Abort;
      end;
      //
      if (DmAcBr.ACBrECF1.Estado = estRelatorio) or
         (DmAcBr.ACBrECF1.Estado = estNaoFiscal) then
      begin
        if Confirmacao('Existe um gerencial aberto. Deseja fechar agora?') then
           DmWorkCom.PAFECF.FechaRelatorioGerencial;
      end;
    end;
    //
    Application.CreateForm(TFrmLiberacao,FrmLiberacao);
    try
      FrmLiberacao.ShowModal;
      if FrmLiberacao.sOk then
      begin
        if sPAFNFCe = 0 then // paf-ECF
           CancelaCupomFiscal(0,FrmLiberacao.sIDUsuario)
        else if sPAFNFCe = 1 then // NFCe
           CancelamentoNFCe(FrmLiberacao.sIDUsuario)
        else if sPAFNFCe = 2 then // SAT
           CancelamentoSAT(FrmLiberacao.sIDUsuario);
      end;
    finally
      FreeAndNil(FrmLiberacao);
    end;
  end
  else
  begin
    MessageDlg('A ECF esta desligada. Ligue-a antes de prosseguir!', mtInformation, [mbOK], 0);
  end;
end;

procedure TFrmEmiCupom.ActCancelarItemExecute(Sender: TObject);
var aNumItem : String;
    Numitem : Integer;
    ValorTotalItem, ValorCargaFed,ValorCargaEst,ValorCargaMun : Double;
    aOK : Boolean;
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  // verifica fila de impressão de produtos
  if not CdsListaProd.IsEmpty then
  begin
    Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
    try
      FrmMensageemProd.PnMensagem.Caption := 'Aguarde o registro de todos os itens!';
      FrmMensageemProd.ShowModal;
    finally
      FreeAndNil(FrmMensageemProd);
      EdtProduto.SetFocus;
      Abort;
    end;
  end;
  //
  Application.CreateForm(TFrmLiberacao,FrmLiberacao);
  try
    FrmLiberacao.ShowModal;
    if FrmLiberacao.sOk then
    begin
      if DataCupom.DataSet.RecordCount = 0 then
      begin
        MessageDlg('Não há documento em aberto no ECF!',mtWarning,[mbOK],0);
        EdtProduto.SetFocus;
        Abort;
      end;
      //
      if InputQuery('Cancelar Item','Numero do Item',aNumItem) then
      begin
        try
          Numitem := StrToInt(aNumItem);
        except
          MessageDlg('Numero do Item inválido!',mtWarning,[mbOK],0);
          EdtProduto.SetFocus;
          Abort;
        end;
        try
          AtivaDesativaAction(false);
          aNumItem := ZeroEsquerda(aNumItem,3);
          aOK := false;
          if sPAFNFCe = 0 then // pafecf
          begin
            if not DmWorkCom.PAFECF.CancelarItemCupom(aNumItem) then
            begin
              MessageDlg('Não foi possível cancelar o item!',mtWarning,[mbOK],0);
              EdtProduto.SetFocus;
              Abort;
            end
            else aOK := true;
          end
          else aOK := true;
          //
          if aOK then
          begin
            // se for abastecimento altera o status
            if DataCupom.DataSet.FieldByName('ABASTECIMENTO').AsString = 'S' then
               DmPosto.RetornaStatusAbastecCupom(DataCupom.DataSet.FieldByname('ID').AsInteger);
            //
            if DataItensCupom.DataSet.Locate('NUM_ITEM',Numitem,[]) then
            begin
              if not(DataItensCupom.DataSet.State in [dsInsert,dsEdit]) then
                 DataItensCupom.DataSet.Edit;
              DataItensCupom.DataSet.FieldByName('CANCELADO').AsString := 'S';
              Grava_Dados(DataItensCupom.DataSet);
              // localiza o produto no cadastro
              if DmProdutos.Dados_Produto(DataItensCupom.DataSet.FieldByName('IDPRODUTO').AsInteger) then
              begin
                // localiza dados do NCM
                DmProdutos.Dados_NCM(DataProduto.DataSet.FieldByName('CODIGO_NCM').AsString,
                                    DataProduto.DataSet.FieldByName('EXCECAO_NCM').AsInteger);
                // calcula o valor do item
                ValorTotalItem := TruncaValor((((DataItensCupom.DataSet.FieldByName('QUANTIDADE').AsFloat*
                                              DataItensCupom.DataSet.FieldByName('VALOR').AsFloat)-
                                              DataItensCupom.DataSet.FieldByName('DESCONTO').AsFloat)+
                                              DataItensCupom.DataSet.FieldByName('ACRESCIMO').AsFloat),DmWorkCom.PAFECF.gDecimais);
                // calcula a carga a ser removido
                ValorCargaFed := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_NACIONAL').AsFloat) / 100);
                ValorCargaEst := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_ESTADUAL').AsFloat) / 100);
                ValorCargaMun := ((ValorTotalItem * DataNCM.DataSet.FieldByName('ALIQ_MUNICIPAL').AsFloat) / 100);
                // grava no pedido
                if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
                   DataCupom.DataSet.Edit;
                DataCupom.DataSet.FieldByName('valor_carga_trib').AsFloat := DataCupom.DataSet.FieldByName('valor_carga_trib').AsFloat - ValorCargaFed;
                DataCupom.DataSet.FieldByName('VAL_CARGA_FED').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_FED').AsFloat + ValorCargaFed;
                DataCupom.DataSet.FieldByName('VAL_CARGA_EST').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_EST').AsFloat + ValorCargaEst;
                DataCupom.DataSet.FieldByName('VAL_CARGA_MUN').AsFloat := DataCupom.DataSet.FieldByName('VAL_CARGA_MUN').AsFloat + ValorCargaMun;
                Grava_Dados(DataCupom.DataSet);
              end;
              //
              Memo.Lines.Add('Item cancelado: '+aNumItem);
              TotalizaCupom;
              DmWorkCom.PAFECF.AtualizaINI(false);
              EdtProduto.SetFocus;
            end;
          end;
        finally
          AtivaDesativaAction(true);
        end;
      end;
    end;
  finally
    FreeAndNil(FrmLiberacao);
  end;
end;

procedure TFrmEmiCupom.ActFechamentoCupomExecute(Sender: TObject);
var Tipo, ValorDesc, FormaPag, aMensagem, aCodMinasLegal : String;
    aCodCupomMania, aNumLote : String;
    aNumMesa, aTipoCartao, aTEFConfirmado : String;
    formMensagem: TFormMensagem;
    aContingenciaOff : Boolean;
    aTEF, aOK, JaAdicionouDesconto : Boolean;
    aCartoes, aControle, aContadorFP, aContadorTEF : Integer;
    ValorPago, lValorTEF, lDesconto, aValorConta,PercCarga : Double;
    aChaveNfe,aProcolo,aRecibo,aNomeArq,aStatus, Auto, defineimp : String;
    //fabricio inclui defineimp como string
    aDtAutori, aHrAutori : TDateTime;
    Handle: THandle; //fabricio
begin
  inherited;
  if DataCupom.DataSet.IsEmpty then
  begin
    Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
    try
      FrmMensageemProd.PnMensagem.Caption := 'Não há registro para o fechamento!';
      FrmMensageemProd.ShowModal;
    finally
      FreeAndNil(FrmMensageemProd);
      EdtProduto.SetFocus;
      Abort;
    end;
  end;
  if DataItensCupom.DataSet.IsEmpty then
  begin
    Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
    try
      FrmMensageemProd.PnMensagem.Caption := 'É necessário inserir itens antes do fechamento!';
      FrmMensageemProd.ShowModal;
    finally
      FreeAndNil(FrmMensageemProd);
      EdtProduto.SetFocus;
      Abort;
    end;
  end;
  // verifica fila de impressão de produtos
  if not CdsListaProd.IsEmpty then
  begin
    Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
    try
      FrmMensageemProd.PnMensagem.Caption := 'Aguarde o registro de todos os itens!';
      FrmMensageemProd.ShowModal;
    finally
      FreeAndNil(FrmMensageemProd);
      EdtProduto.SetFocus;
      Abort;
    end;
  end;
  TimerItens.Enabled := false;
  // se estiver habilitado para verificar a ECF
  if sPAFNFCe = 0 then
  begin
    if DmWorkCom.PAFECF.gVerEstadoECF then
    begin
      try
        formMensagem := TFormMensagem.Create('Aguarde... Verificando estado atual da ECFl!',550,150,clBlack,clSilver);
        formMensagem.mostrar;
        Refresh;
        //
        if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
        begin
          MessageDlg('Impressora desligada ou sem comunicação. verifique!',mtWarning,[mbOK],0);
          xFechamento := false;
          TimerItens.Enabled := true;
          Abort;
        end;
        if DmAcBr.ACBrECF1.Estado = estPagamento then
        begin
          MessageDlg('O Cupom deverá ser cancelado!',mtWarning,[mbOK],0);
          xFechamento := false;
          TimerItens.Enabled := true;
          Abort;
        end;
      finally
        FormMensagem.destruir;
      end;
    end;
  end;
  // inicia o procedimento
  lDesconto := 0;
  aTEF      := false;
  aContadorTEF := 0;
  aOK       := true;
  JaAdicionouDesconto := false;

  aOK := false;
  if sPAFNFCe = 0 then // paf-ecf
  begin
    if DmAcBr.ACBrECF1.Estado = estVenda then
       aOK := True; 
  end
  else aOK := true;
  //
  if aOK then
  begin
    Application.CreateForm(TFrmFecharCupom,FrmFecharCupom);
    try
      FrmFecharCupom.ShowModal;
      if FrmFecharCupom.sOK then
      begin
        try
          LbTroco.Caption := 'Valor do troco: R$'+FormatFloat('0.00',FrmFecharCupom.sTroco);
          xFechamento := true;
          AtivaDesativaAction(false);
          aContadorFP := 1;
          aCartoes := RetornaNumCartoesFechamento(DataCupom.DataSet.FieldByName('ID').AsInteger);
          DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
          while not DataPedidoFP.DataSet.Eof do
          begin
            // verifica forma de pagamento
            aTEF := false;
            if (DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger = 1) or
               (DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger = 2) and
               (DataPedidoFP.DataSet.FieldByname('CONFIRMADO').AsString = 'N')then
            begin
              if DataPedidoFP.DataSet.FieldByname('VINCULAR').AsString = 'S' then
              begin
                if DmWorkCom.PAFECF.gCartoes > 0 then
                begin
                  // realiza venda TEF
                  Memo.SetFocus;
                  aTEF := false;
                  while not aTEF do
                  begin
                    Inc(aContadorTEF);
                    if not RealizaVendaTEF(DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger,aContadorTEF) then
                    begin
                      if not Confirmacao('Erro ao realizar TEF. Tentar novamente?') then
                      begin
                        EdtProduto.SetFocus;
                        AtivaDesativaAction(true);
                        xFechamento := false;
                        Abort;
                      end;
                      Dec(aContadorTEF);
                    end
                    else
                    begin
                      aTEF := true;
                      aTEFConfirmado := 'N';
                      // verifica tipo de cartão
                      aTipoCartao := 'CREDITO';
                      if DmWorkCom.PAFECF.sTipoTef in [0,2]  then // Tef Discado
                      begin
                        if StrToInt(DmWorkCom.PAFECF.gCodTrans) in [20,21,22,23,24,25] then
                           aTipoCartao := 'DEBITO';
                      end
                      else
                      begin
                        if StrToInt(DmWorkCom.PAFECF.gCodTrans) in [32,33,34,36,38,42] then
                           aTipoCartao := 'DEBITO';
                      end;
                      // caso seja TEF discado e multiplos, confirma o primeiro
                      if (DmWorkCom.PAFECF.sTipoTef in [0,2]) and (aCartoes > aContadorTEF) then
                      begin
                        DmWorkCom.PAFECF.ConfirmaTransacao(aContadorTEF,'');
                        aTEFConfirmado := 'S';
                      end;
                      // grava informações do TEF
                      if not(DataPedidoFP.DataSet.State in [dsInsert,dsEdit]) then
                         DataPedidoFP.DataSet.Edit;
                      DataPedidoFP.DataSet.FieldByName('TIPO_TEF').AsString      := aTipoCartao;
                      DataPedidoFP.DataSet.FieldByName('NOME_REDE').AsString     := DmWorkCom.PAFECF.gNomeRede;
                      DataPedidoFP.DataSet.FieldByName('NSU_DOC').AsString       := DmWorkCom.PAFECF.gNSU;
                      DataPedidoFP.DataSet.FieldByName('PARCELAS_TEF').AsInteger := DmWorkCom.PAFECF.gParcelas;
                      DataPedidoFP.DataSet.FieldByName('CONFIRMADO').AsString    := aTEFConfirmado;
                      // grava valores do TEF no registro
                      if DmWorkCom.PAFECF.gVrOriginalTEF > 0 then
                      begin
                        DataPedidoFP.DataSet.Edit;
                        DataPedidoFP.DataSet.FieldByName('TROCO').AsFloat    := DmWorkCom.PAFECF.gVrSaqueTEF;
                        DataPedidoFP.DataSet.FieldByName('DESCONTO').AsFloat := DmWorkCom.PAFECF.gVrDescontoTEF;
                        lDesconto := lDesconto + DmWorkCom.PAFECF.gVrDescontoTEF;
                      end;
                      Grava_Dados(DataPedidoFP.DataSet);
                    end;
                  end;
                end;
              end
              else
              begin
                if DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger = 2 then
                begin
                  Application.CreateForm(TFrmDadosPOS,FrmDadosPOS);
                  try
                    FrmDadosPOS.ShowModal;
                    if FrmDadosPOS.sOK then
                    begin
                      case FrmDadosPOS.CbxTipoOperacao.ItemIndex of
                        0: aTipoCartao := 'CREDITO';
                        1: aTipoCartao := 'DEBITO';
                      end;
                      // grava informações do TEF
                      if not(DataPedidoFP.DataSet.State in [dsInsert,dsEdit]) then
                         DataPedidoFP.DataSet.Edit;
                      DataPedidoFP.DataSet.FieldByName('TIPO_TEF').AsString   := aTipoCartao;
                      DataPedidoFP.DataSet.FieldByName('NOME_REDE').AsString  := FrmDadosPOS.CbxBandeiras.Text;
                      DataPedidoFP.DataSet.FieldByName('NSU_DOC').AsString    := FrmDadosPOS.EdtNSU.Text;
                      DataPedidoFP.DataSet.FieldByName('CONFIRMADO').AsString := 'S';
                      DataPedidoFP.DataSet.FieldByName('TROCO').AsFloat       := 0;
                      DataPedidoFP.DataSet.FieldByName('DESCONTO').AsFloat    := 0;
                      Grava_Dados(DataPedidoFP.DataSet);
                    end
                    else
                    begin
                      MessageDlg('Abortado pelo usuário. Tente novamente!',mtWarning,[mbOK],0);
                      EdtProduto.SetFocus;
                      AtivaDesativaAction(true);
                      Abort;
                    end;
                  finally
                    FreeAndNil(FrmDadosPOS);
                  end;
                end;
              end;
            end;
            DataPedidoFP.DataSet.Next;
          end;
          // caso ja tenha sito tentado o fechamento anteriormente o sistema confirma a situação da ECF
          if JaHouveErroFechamento then
          begin
            DmWorkCom.PAFECF.ExibeMensagem(0,'Verificando situação da ECF. Aguarde...');
            DmWorkCom.PAFECF.VerificaImpressoraLigada;
          end;
          //
          if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
             BlockInput(true);
          aOk := True;
          // verifica tipo de sistema
          if sPAFNFCe = 0 then // paf-ecf
          begin
            aControle := 1;
            while aControle < 4 do
            begin
              DmWorkCom.PAFECF.ExibeMensagem(0,'imprimindo o fechamento do cupom!');
              // inicia o fechamento
              if (aOK) and (aControle = 1) then
              begin
                DmWorkCom.PAFECF.ExibeMensagem(0,'Subtotaliza o cupom fiscal!');
                ValorDesc := FormatFloat('0.00',0);
                Tipo := 'D';
                if DataCupom.DataSet.FieldByname('DESCONTO').AsFloat > 0 then
                begin
                  if not JaAdicionouDesconto then
                  begin
                    lDesconto := lDesconto + DataCupom.DataSet.FieldByname('DESCONTO').AsFloat;
                    JaAdicionouDesconto := true;
                  end;
                end;
                //
                if lDesconto > 0 then
                   ValorDesc :=  FormatFloat('0.00',(lDesconto*-1));
                // verifica acrescimo
                if DataCupom.DataSet.FieldByname('ACRESCIMO').AsFloat > 0 then
                begin
                  ValorDesc := FormatFloat('0.00',DataCupom.DataSet.FieldByname('ACRESCIMO').AsFloat);
                  Tipo := 'A';
                end;
                // verifica impressora ligada
  //              if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
  //                 aOK := false
  //              else
                aOK := DmWorkCom.PAFECF.IniciaFechamentoCupom(Tipo,ValorDesc);
                if aOK then
                   aControle := 2;
              end;
              // efetuar forma de pagamento
              if (aOK) and (aControle = 2) then
              begin
                DmWorkCom.PAFECF.ExibeMensagem(0,'Registra formas de pagamento!');
                DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
                while not DataPedidoFP.DataSet.Eof do
                begin
                  DmWorkCom.PAFECF.ExibeMensagem(1,'Registrando '+ DataPedidoFP.DataSet.FieldByname('Descricao').AsString);
                  if DataPedidoFP.DataSet.RecNo = aContadorFP then
                  begin
                    // verifica forma de pagamento
                    case DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger of
                      0 : FormaPag := DmWorkCom.PAFECF.gDINHEIRO;
                      1 : FormaPag := DmWorkCom.PAFECF.gCHEQUE;
                      2 : FormaPag := DmWorkCom.PAFECF.gCARTAO;
                      3 : FormaPag := DmWorkCom.PAFECF.gNP;
                      4 : FormaPag := DmWorkCom.PAFECF.gCARNE;
                      5 : FormaPag := DmWorkCom.PAFECF.gBOLETO;
                      6 : FormaPag := DmWorkCom.PAFECF.gOUTROS;
                    end;
                    if  DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger = 2 then
                    begin
                      ValorPago := TruncaValor((DataPedidoFP.DataSet.FieldByname('VALOR').AsFloat+
                                                DataPedidoFP.DataSet.FieldByname('TROCO').AsFloat)-
                                                DataPedidoFP.DataSet.FieldByname('DESCONTO').AsFloat, DmWorkCom.PAFECF.gDecimais);
                    end
                    else
                    begin
                      ValorPago := TruncaValor(DataPedidoFP.DataSet.FieldByname('VALOR').AsFloat,DmWorkCom.PAFECF.gDecimais);
                    end;
                    if aOK then
                    begin
    //                  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
    //                     aOK := false
    //                  else
                       aOK := DmWorkCom.PAFECF.RegistraFormaPagtoCupom(FormaPag,ValorPago);
                       if aOK then
                       begin
                         inc(aContadorFP);
                         DmWorkCom.GravaRegistroA2(SVData,
                                                   DataPedidoFP.DataSet.FieldByname('DESCRICAO').AsString,
                                                   1,(DataPedidoFP.DataSet.FieldByname('VALOR').AsFloat-DataPedidoFP.DataSet.FieldByname('TROCO').AsFloat));
                       end
                       else
                          Break;
                    end;
                  end;
                  DataPedidoFP.DataSet.Next;
                end;
                if aOK then
                   aControle := 3
              end;
              // termina fechamento
              if (aOK) and (aControle = 3) then
              begin
                DmWorkCom.PAFECF.ExibeMensagem(0,'Conclui o fechamento do cupom!');
                DmWorkCom.Dados_Pedido(DataCupom.DataSet.FieldByname('ID').AsInteger);
//                aMensagem := DmWorkCom.PAFECF.gMD5+#13+#10;
                // verifica se é DAV
                if sDAV then
                begin
                  if DataCupom.DataSet.FieldByname('NUMPV').AsString = '' then
                  begin
                    DmWorkCom.Dados_PedidoClassificacao(1,DmWorkCom.CdsPedidosID_CLASSIFICACAO.AsInteger);
                    if DmWorkCom.CdsPedidoClassTIPO.AsInteger <> 4 then
                       aMensagem := aMensagem + 'DAV'+DmWorkCom.CdsPedidosNUMDAV.AsString+' '
                    else
                       aMensagem := aMensagem + 'DAV-OS No.: '+DmWorkCom.CdsPedidosNUMDAV.AsString+' ';
                  end
                  else
                     aMensagem := aMensagem + 'PV'+DmWorkCom.CdsPedidosNUMPV.AsString;
                  aMensagem := aMensagem+#13+#10;
                end;
                // verifica se é nota manual
                if Trim(sNotaManual) <> '' then
                begin
                  aMensagem := aMensagem + 'NF: '+sNotaManual+#13+#10;
                end;
                // verifica se é nota manual
                if Trim(sNotaEletronica) <> '' then
                begin
                  aMensagem := aMensagem + 'NF: '+sNotaEletronica+#13+#10;
                end;
                // verifica se é vidalink
                if DmWorkCom.CdsPedidos.FieldByName('NAUTORIZA_VIDALINK').AsString <> '' then
                begin
                  aMensagem := aMensagem + 'Autorização No.: '+DmWorkCom.CdsPedidosNAUTORIZA_VIDALINK.AsString+#13+#10;
                end;
                // verifica se é mesa
                if DataCupom.DataSet.FieldByName('ID_MESA').AsInteger > 0 then
                begin
                  if DataCupom.DataSet.FieldByName('CER').AsInteger > 0 then
                  begin
                    aMensagem := aMensagem + 'ECF: '+DmWorkCom.PAFECF.gCaixa+' - Conferência de Mesa - '+
                                             'CER nº '+ZeroEsquerda(DataCupom.DataSet.FieldByName('CER').AsString,4)+' - COO nº '+
                                             ZeroEsquerda(DataCupom.DataSet.FieldByName('COO_CONF_MESA').AsString,6)+#13+#10;
                  end
                  else
                  begin
                    aNumMesa := RetornaNumeroMesa(DataCupom.DataSet.FieldByName('ID_MESA').AsInteger);
                    aMensagem := 'Consumo da Mesa '+aNumMesa+' – SEM EMISSÃO DE CONFERÊNCIA DE MESA'+#13+#10;
                  end;
                end;
                // verifica se é Abastecimento
                if DataCupom.DataSet.FieldByName('ABASTECIMENTO').AsString = 'S' then
                begin
                  sCdsInfoCupomPosto.EmptyDataSet;
                  RetornaInformacaoAbastecimeneto(sCdsInfoCupomPosto,
                                                  DataCupom.DataSet.FieldByName('ID').AsInteger,
                                                  false);
                  sCdsInfoCupomPosto.First;
                  while not sCdsInfoCupomPosto.Eof do
                  begin
                    Auto := '';
                    if sCdsInfoCupomPosto.FieldByName('AUTO').AsString = 'S' then
                       Auto := 'A';
                    //#CF:B'+Bico+'EI'+FormatFloat('0.000',ei)+' EF'+FormatFloat('0.000',ei)+' V'+FormatFloat('0.000',EF-EI)+#13+#10;
                    aMensagem := aMensagem +'#CF:B'+sCdsInfoCupomPosto.FieldByName('Bico').AsString+' '+
                                            'EI'+ZeroEsquerda(FormatFloat('0.000',sCdsInfoCupomPosto.FieldByName('EI').AsFloat),11)+' '+
                                            'EF'+ZeroEsquerda(FormatFloat('0.000',sCdsInfoCupomPosto.FieldByName('EF').AsFloat),11)+' '+
                                            'V'+FormatFloat('0.000',sCdsInfoCupomPosto.FieldByName('EF').AsFloat-sCdsInfoCupomPosto.FieldByName('EI').AsFloat)+Auto+#13+#10;
                    sCdsInfoCupomPosto.Next;
                  end;
                end;
                // calcula o percentual de carga
                PercCarga := ((DataCupom.DataSet.FieldByname('VALOR_CARGA_TRIB').AsFloat * 100) /
                               DataCupom.DataSet.FieldByname('VALOR_TOTAL').AsFloat);
                // verifica opção de Minas Legal
                if DmWorkCom.CdsEmpresaUF.AsString = 'MG' then
                begin
                  // 99999999ddmmaaaa8888888
                  aCodMinasLegal := Copy(FiltraNumero(DmWorkCom.CdsEmpresaCNPJ_CPF.AsString),1,8);
                  aCodMinasLegal := aCodMinasLegal + FormatDateTime('DDMMYYYY',DataCupom.DataSet.FieldByName('DATA_ENTREGA').AsDateTime);
                  aCodMinasLegal := aCodMinasLegal + FloatToStr(TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,0));
                  aMensagem := aMensagem + 'MINAS LEGAL: '+aCodMinasLegal+#13+#10;
                end;
                // verifica opção de Minas Legal
{                if DmWorkCom.CdsEmpresaUF.AsString = 'RJ' then
                begin
                  aCodCupomMania := Copy(FiltraNumero(DmWorkCom.CdsEmpresaINSCRICAO_RG.AsString),1,8);
                  aCodCupomMania := aCodCupomMania + FormatDateTime('DDMMYYYY',DataCupom.DataSet.FieldByName('DATA_ENTREGA').AsDateTime);
                  aCodCupomMania := aCodCupomMania + ZeroEsquerda(IntToStr(DataCupom.DataSet.FieldByName('COO').AsInteger),6);
                  aCodCupomMania := aCodCupomMania + ZeroEsquerda(IntToStr(StrToInt(DmAcBr.ACBrECF1.NumECF)),3);
                  aMensagem := aMensagem + 'CUPOM MANIA, CONCORRA A PREMIOS'+#13+#10;
                  aMensagem := aMensagem + 'ENVIE SMS P/6789: '+aCodCupomMania+#13+#10;
                end; }
                if DmWorkCom.CdsEmpresaUF.AsString = 'DF' then
                begin
                  aMensagem := aMensagem + 'ESTABELECIMENTO INCLUIDO NO PROGRAMA DE'+#13+#10;
                  aMensagem := aMensagem + 'CONCESSAO DE CREDITOS - LEI Nº 4.159/08'+#13+#10;
                  aMensagem := aMensagem + 'NOTA LEGAL: ICMS: '+FormatFloat('0.00',PercCarga)+#13+#10;
                end;
                if DmWorkCom.CdsEmpresaUF.AsString = 'PB' then
                begin
                  aCodCupomMania := Copy(FiltraNumero(DmWorkCom.CdsEmpresaCNPJ_CPF.AsString),1,14)+' ';
                  aCodCupomMania := aCodCupomMania + FormatDateTime('DDMMYYYY',DataCupom.DataSet.FieldByName('DATA_ENTREGA').AsDateTime)+' ';
                  aCodCupomMania := aCodCupomMania + FiltraNumero(FormatFloat('0.00',DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat))+' ';
                  aCodCupomMania := aCodCupomMania + FiltraNumero(DataCupom.DataSet.FieldByName('CNPJ_CPF').AsString);
                  aMensagem := aMensagem + 'PARAIBA LEGAL - RECEITA CIDADÃ'+#13+#10;
                  aMensagem := aMensagem + 'TORPEDO PREMIADO: '+aCodCupomMania+#13+#10;
                end;
                if DmWorkCom.CdsPedidosPLACA_VEIC.AsString <> '' then
                begin
                   aMensagem := aMensagem + 'Placa: '+DmWorkCom.CdsPedidosPLACA_VEIC.AsString+' - '+
                                            'Hodometro: '+DmWorkCom.CdsPedidosODOMETRO.AsString+#13+#10;
                end;
                // exibe carga tributaria
                aMensagem := aMensagem + 'Val Aprox trib. Fed. R$'+
                                          FormatFloat(DmWorkCom.PAFECF.gMascaraDec,DataCupom.DataSet.FieldByname('VAL_CARGA_FED').AsFloat)+
                                          ' Est. R$'+
                                          FormatFloat(DmWorkCom.PAFECF.gMascaraDec,DataCupom.DataSet.FieldByname('VAL_CARGA_EST').AsFloat)+
                                          ' Mun. R$'+
                                          FormatFloat(DmWorkCom.PAFECF.gMascaraDec,DataCupom.DataSet.FieldByname('VAL_CARGA_MUN').AsFloat)+
                                          ' Fonte IBPT'+#13+#10;
                aMensagem := aMensagem+'Obrigado! Volte sempre!!!';
                //
                if aOK then
                begin
                  aOK := DmWorkCom.PAFECF.TerminaFechamentoCupom(aMensagem);
                  if aOK then
                     aControle := 4;
                end;
              end;
              // verifica se impressora esta ligada
              if aControle = 0 then
                 aControle := 4;
              if (aOK) and (aControle = 4)  then
              begin
                // verifica impressora ligada
                if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
                begin
                  aOK := false;
                  aControle := 0;
                end
                else
                begin
                  aOK := true;
                  aControle := 4;
                end;
              end;
              //
              if not aOK then
              begin
                if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
                   BlockInput(false);
                JaHouveErroFechamento := true;
                if not Confirmacao('Impressora não responde, deseja tentar novamente') then
                begin
                  // Resolve pendencia do TEF
                  DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger,true);
                  DmWorkCom.PAFECF.VerificaResolvePendenciaTEF(DmWorkCom.CdsPedidoFP);
                  DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
                  if DmWorkCom.PAFECF.VerificaImpressoraLigada then
                  begin
                    if DmAcBr.ACBrECF1.Estado = estPagamento then
                       CancelaCupomFiscal(1,0)
                  end
                  else
                  begin
                    PnInforma.Caption := 'Ligue a impressora para fechar o cupom!';
                  end;
                  AtivaDesativaAction(true);
                  EdtProduto.SetFocus;
                  xFechamento := false;
                  Exit;
                end
                else
                begin
                  if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
                     BlockInput(true);
                  DmWorkCom.PAFECF.ExibeMensagem(3,'Aguarde... Preparando para iniciar nova tentativa!');
                  //
                  aOK := false;
                  if DmWorkCom.PAFECF.VerificaImpressoraLigada then
                     aOK := true;
                end;
              end;
            end;
          end
          else if sPAFNFCe = 1 then // nfce
          begin
            BlockInput(false);

            // gera e emite a NFCe


            aContingenciaOff := false;
if not ListaPedido then //fabricio lista
            DmWorkCom.PAFECF.ExibeMensagem(0,'Gerando arquivo XML. Aguarde...');
            DmWorkCom.VerificaRateiaDescontoNota(DataCupom.DataSet.FieldByName('ID').AsInteger);
            if DmWorkCom.GerarNFe(DataCupom.DataSet.FieldByName('ID').AsInteger,false,true) then
            begin
              // processo de validação
              try
                // comandos para assinar arquivo XML
if not ListaPedido then //fabricio lista
                DmAcBr.ACBrNFe1.NotasFiscais.Assinar;
                DmAcBr.ACBrNFe1.NotasFiscais.Items[0].GravarXML;
                // grava o arquivo XML
if not ListaPedido then //fabricio lista
                DmWorkCom.PAFECF.ExibeMensagem(0,'Gravando XML no banco de dadoos. Aguarde...');
                DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
                // executa validação do arquivo
if not ListaPedido then //fabricio lista
                DmWorkCom.PAFECF.ExibeMensagem(0,'Validando a NFCe. Aguarde...');
if not ListaPedido then //fabricio lista
                DmAcBr.ACBrNFe1.NotasFiscais.Validar;
              except
                on E : Exception do
                begin
                  ShowMessage(E.Message);
                  aOK := false;
                end;
              end;
              // processo de envio
              if aOK then
              begin
                try
                  // define o lote
                  aNumLote := FormatDateTime('hhmm',now);
                  // enviar ao portal
if not ListaPedido then //fabricio lista
                  DmWorkCom.PAFECF.ExibeMensagem(0,'Enviando a NFCe. Aguarde...');
if not ListaPedido then //fabricio lista
                  if DmAcBr.ACBrNFe1.Enviar(aNumLote,False) then
                  begin
                    aChaveNfe := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;
                    aProcolo  := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt;
                    aDtAutori := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].dhRecbto;
                    aHrAutori := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].dhRecbto;
                    aRecibo   := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec;
                    aNomeArq  := DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NomeArq;
                    aStatus   := IntToStr(DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat);
                    // atualiza o XML
                    DmAcBr.ACBrNFe1.NotasFiscais.Items[0].GravarXML;
                    DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                              DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
                  listapedido:=false; //fabricio
                  end
                  else aContingenciaOff := true;
                except
                  on E : Exception do
                  begin
                    ShowMessage(E.Message);
                    aContingenciaOff := true;
                  listapedido:=false; //fabricio
                  end;
                end;
                // Se tiver erro na emissão emite em contingencia
                if aContingenciaOff then
                begin
                  try
                  listapedido:=false; //fabricio
                    // apaga o arquivo XML anterior
                    if FileExists(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NomeArq) then
                    begin
                      Sleep(1000);
                      DeleteFile(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NomeArq);
                    end;
                    DmAcBr.ACBrNFe1.NotasFiscais.Clear;
                    DmWorkCom.PAFECF.ExibeMensagem(0,'Gerando novo arquivo XML de contingência. Aguarde...');
                    if DmWorkCom.GerarNFe(DataCupom.DataSet.FieldByName('ID').AsInteger,false,true,true) then
                    begin
//fabricio inicio
                      if DmWorkCom.CdsEmpresaUF.AsString = 'MS' then
                      begin
                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dhCont := Now;
                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.xJust := 'FALHA TECNICA - FALTA DE CONEXÃO INTERNET';
                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cUF := UFtoCUF(DmWorkCom.CdsEmpresaUF.AsString);
                      end;

                      listapedido:=false;
//fabricio fim





                      // comandos para gerar arquivo XML
                      DmAcBr.ACBrNFe1.NotasFiscais.Assinar;
                      DmAcBr.ACBrNFe1.NotasFiscais.Items[0].GravarXML;
                      // executa validação do arquivo
                      DmWorkCom.PAFECF.ExibeMensagem(0,'Validando novamente a NFCe. Aguarde...');
                      DmAcBr.ACBrNFe1.NotasFiscais.Validar;
                      // CAPTURA os dados
                      aChaveNfe := DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
                      aProcolo  := 'CONT.OFFLINE';
                      aRecibo   := 'CONT.OFFLINE';
                      // imprime a NFCe
//                      DmAcBr.ACBrNFe1.NotasFiscais.Imprimir;
                      DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                                DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
                    end;
                  except
                    on E : Exception do
                    begin
                      ShowMessage(E.Message);
                      aOK := false;
                    end;
                  end;
                end;
                // grava chave NFe
//fabricio inicio
//fabricio aqui
//if ListaPedido then //fablista
//DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;//fablista

if listapedido          then // NFrente
begin
try
  if DmWorkCom.nomecupom <> '' then
  begin
     if DmWorkCom.imprimec = 'S' then
     begin
        DmWorkCom.ImprimirComprovanteNFrente(DataCupom.DataSet.FieldByname('ID').AsInteger);
        if DmWorkCom.duasvias = 'S' then
           DmWorkCom.ImprimirComprovanteNFrente(DataCupom.DataSet.FieldByname('ID').AsInteger);
     end;
  end;
except
on E:Exception do ShowMessage(E.Message);
end;
  sPAFNFCe:=1;
end;
listapedido:=false;
sPAFNFCe:=1;




//fabricio fim


                try
                  if (aChaveNfe <> '') and (aRecibo <> '') then
                  begin
                    if not aContingenciaOff then
                    begin
                      DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                                    aProcolo,
                                                    aRecibo,
                                                    aNumLote,
                                                    aNomeArq,
                                                    aStatus,
                                                    DmWorkCom.sFormas,
                                                    DataCupom.DataSet.FieldByName('ID').AsInteger,
                                                    aDtAutori,
                                                    aHrAutori);
                    end
                    else
                    begin
                      DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                                    aProcolo,
                                                    aRecibo,
                                                    aNumLote,
                                                    aNomeArq,
                                                    aStatus,
                                                    9,
                                                    DataCupom.DataSet.FieldByName('ID').AsInteger,
                                                    aDtAutori,
                                                    aHrAutori);
                    end;
                    // imprime na ECF caso esteja configurado
                    if (sPAFNFCe = 1) and (DmWorkCom.sGerencal_NFCe = 'S') then
                    begin
                      DmWorkCom.PAFECF.ExibeMensagem(0,'Emitindo o Gerencial da NFCe. Aguarde...');
                      DmWorkCom.EmitereGerecialNFCe(DataCupom.DataSet.FieldByName('ID').AsInteger,'QrCod_temp.bmp');
                    end
                    else if (sPAFNFCe = 1) and (DmWorkCom.sGerencal_NFCe = 'N') then
                    begin
//fabricio tirar                       DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;

//fabricio inicio novo
                    defineimp := DmWorkCom.CdsConfig.FieldByName('IMPRESSORA').AsString;
                    if defineimp <> '' then
//                          DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= false;
//                          DmAcbr.ACBrNFeDANFCeFortes1.Impressora := defineimp;
//                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;

                    begin
                       if OpenPrinter(PChar(defineimp), Handle, nil) then
                       begin
                          DmAcbr.ACBrNFeDANFCeFortes1.Impressora := defineimp;
                          DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= false;
                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;
                       end
                       else
                       begin
                          DmAcbr.ACBrNFeDANFCeFortes1.Impressora := defineimp;
                          DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= true;
                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;
                       end;
                    end
                    else
                    begin
                       DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= true;
                       DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;
                    end;

//fabricio fim

                    end;
                  end
                  else
                  begin
                    if sPAFNFCe = 0 then
                       DmWorkCom.EmiteNFePendenteAutomatica(DataCupom.DataSet.FieldByName('ID').AsInteger);
                  end;
                except
                  on E : Exception do
                  begin
                    ShowMessage(E.Message);
                    if sPAFNFCe = 0 then
                    begin
                      if not DmWorkCom.EmiteNFePendenteAutomatica(DataCupom.DataSet.FieldByName('ID').AsInteger) then
                         aOK := false;
                    end
                    else aOK := false;
                  end;
                end;
              end;
            end
            else aOK := false;
          end
          else if sPAFNFCe = 2 then
          begin
            BlockInput(false);
            if DmWorkCom.GerarSAT(DataCupom.DataSet.FieldByname('ID').AsInteger) then
            begin
              DmAcBr.ACBrSAT1.CFe.GerarXML;
              DmAcBr.ACBrSAT1.EnviarDadosVenda;
              if DmAcBr.ACBrSAT1.Resposta.codigoDeRetorno = 6000 then
              begin
                aOK := true;
                DmAcBr.ACBrSAT1.CFe.GerarXML;
                // grava os dados na tabela pedido
                DmWorkCom.Grava_DadosSAT(DataCupom.DataSet.FieldByname('ID').AsInteger,
                                         DmAcBr.ACBrSAT1.CFe.infCFe.ID,
                                         DmAcBr.ACBrSAT1.Resposta.codigoSEFAZ,
                                         DmAcBr.ACBrSAT1.Resposta.numeroSessao);
                // grava o XML na tabela
                DmWorkCom.GravaArquivoXML(DmAcBr.ACBrSAT1.CFe.infCFe.ID,
                                          DmAcBr.ACBrSAT1.Resposta.RetornoStr);
                //
                try
                  if DmWorkCom.sSAT_EXT_RESUMIDO = 'S' then
                     DmAcBr.ACBrSAT1.ImprimirExtratoResumido
                  else
                     DmAcBr.ACBrSAT1.ImprimirExtrato;
                except
                  on E:Exception do ShowMessage(E.Message);
                end;
              end
              else
              begin
                ShowMessage('Messagem do retorno: '+DmAcBr.ACBrSAT1.Resposta.mensagemRetorno+#13+#10+
                            'Mensagem da seFaz: '+DmAcBr.ACBrSAT1.Resposta.mensagemSEFAZ);
                aOK := false;
              end;
            end;
          end
          else if sPAFNFCe = 3 then // NFrente
          begin
            try
              BlockInput(false);
//              DmWorkCom.ImprimirComprovanteNFrente(DataCupom.DataSet.FieldByname('ID').AsInteger);
//fabricio novo tirar              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\PedidoTermica.fr3');
//fabricio novo tirar              frxReport1.ShowReport;

//fabricio inicio  novo
if listapedido          then // NFrente
begin
try
  if DmWorkCom.nomecupom <> '' then
  begin
     if DmWorkCom.imprimec = 'S' then
     begin
        DmWorkCom.ImprimirComprovanteNFrente(DataCupom.DataSet.FieldByname('ID').AsInteger);
        if DmWorkCom.duasvias = 'S' then
           DmWorkCom.ImprimirComprovanteNFrente(DataCupom.DataSet.FieldByname('ID').AsInteger);
     end;
  end;
except
on E:Exception do ShowMessage(E.Message);
end;
  sPAFNFCe:=1;
end;
listapedido:=false;
sPAFNFCe:=1;


//fabricio fim novo






            except
              on E:Exception do ShowMessage(E.Message);
            end;
          end;
          DmWorkCom.PAFECF.ExibeMensagem(0,'Concluindo o fechamento. Aguarde...');
          // realiza os procedimentos finais do fechamento
          if (aOK) then
          begin
            // marca como confirmado
            if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
               DataCupom.DataSet.Edit;
            if DmWorkCom.sGerencal_NFCe = 'S' then
            begin
              if DataCupom.DataSet.FieldByName('COO').AsInteger = 0 then
                 DataCupom.DataSet.FieldByName('COO').AsInteger := StrToInt(DmAcBr.ACBrECF1.NumCOO);
            end;
            DataCupom.DataSet.FieldByName('confirmada').AsString := 'S';
            if sPAFNFCe = 0 then
               DataCupom.DataSet.FieldByName('MODELO').AsString := '2D'
            else if sPAFNFCe = 1 then
               DataCupom.DataSet.FieldByName('MODELO').AsString := '65'
            else if sPAFNFCe = 2 then
               DataCupom.DataSet.FieldByName('MODELO').AsString := '59'
            else if sPAFNFCe = 3 then
               DataCupom.DataSet.FieldByName('MODELO').AsString := 'XX';
            // se for abastecimento altera o status
            if DataCupom.DataSet.FieldByName('ABASTECIMENTO').AsString = 'S' then
               DataCupom.DataSet.FieldByName('STATUS_ABASTEC').AsInteger := 4;
            Grava_Dados(DataCupom.DataSet);
             // se for fechamento de mesa indica como fechada
            if DataCupom.DataSet.FieldByName('ID_MESA').AsInteger > 0 then
               AlteraStatusMesa(DataCupom.DataSet.FieldByname('ID_MESA').AsInteger,3);
            // Baixa estoque e gera contas a receber
            if DmWorkCom.Dados_PedidoClassificacao(1,DataCupom.DataSet.FieldByName('ID_CLASSIFICACAO').AsInteger) then
            begin
              // baixa estoque
              if DmWorkCom.CdsPedidoClass.FieldByName('BAIXAR_ESTOQUE').AsString = 'S' then
                 DmWorkCom.Movimenta_Estoque(0,DataItensCupom.DataSet);
            end;
            // gera documentos a receber
            DmWorkCom.Dados_FormaPagto;
            DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
            while not DataPedidoFP.DataSet.Eof do
            begin
              if DmWorkCom.CdsFormaPag.Locate('ID',DataPedidoFP.DataSet.FieldByName('ID_FORMAPAG_CUPOM').AsInteger,[]) then
              begin
                if (DmWorkCom.CdsFormaPag.FieldByName('GERAR_CONTA').AsString = 'S') then
                begin
                  aValorConta := DataPedidoFP.DataSet.FieldByName('VALOR').AsFloat/
                                 DmWorkCom.CdsFormaPag.FieldByName('QUANT_PAGTOS').AsInteger;
                  DmWorkCom.Gerar_Contas(0,
                                         DataCupom.DataSet.FieldByName('ID').AsInteger,
                                         0,
                                         DataCupom.DataSet.FieldByName('IDCLIENTE').AsInteger,
                                         DmWorkCom.CdsFormaPag.FieldByName('QUANT_PAGTOS').AsInteger,
                                         DmWorkCom.CdsFormaPag.FieldByName('FORMA_PAGTO').AsString,
                                         DataCupom.DataSet.FieldByName('CLIENTE').AsString,
                                         '',
                                         DataCupom.DataSet.FieldByName('DATA_PEDIDO').AsDateTime,
                                         aValorConta);
                end;
                // grava registro de movimento no caixa
                if (DataFormaPag.DataSet.FieldByName('MOVIMENO_CAIXA').AsString = 'S') then
                begin
//fabricio coloquei o de baixo                  if DmWorkCom.Dados_Caixa(SVData) then
                  if DmWorkCom.Dados_Caixaid(dadoscaixaid,true) then
                  lbdadoscaixaid.Caption:=intToStr(dadoscaixaid);
                  begin
                    DmWorkCom.Dados_CaixaMov(0);
                    DmWorkCom.CdsCaixaMov.Append;
                    DmWorkCom.CdsCaixaMov.FieldByName('HISTORICO').AsString :=
//fabricio tirar esta linha                    'EMISSAO DE CUPOM FISCAL No: '+DmAcBr.ACBrECF1.NumCOO;
                    'CUPOM FISCAL:' + DmAcBr.ACBrECF1.NumCOO + 'PEDIDO:' + DataCupom.DataSet.FieldByName('ID').AsString;
//fabricio inserir esta linha acima
                    DmWorkCom.CdsCaixaMov.FieldByName('ORIGEM').AsString    := 'MOVIMENTO';
                    DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString        := 'C';
//fabricio tirar                    DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := DataPedidoFP.DataSet.FieldByName('VALOR').AsFloat;
//fabricio insere a linha abaixo
                    DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsCurrency   := DataPedidoFP.DataSet.FieldByName('VALOR').AsFloat - DataPedidoFP.DataSet.FieldByName('TROCO').AsFloat; //FABRICIO - ACRESCIDO O TROCO NO CALCULO

                    DmWorkCom.CdsCaixaMov.FieldByName('IDPEDIDO').AsInteger := DataCupom.DataSet.FieldByName('ID').AsInteger;
//fabricio insere a linha abaixo
                    DmWorkCom.CdsCaixaMov.FieldByName('DATA_MOV').AsDateTime := now;

                    Grava_Dados(DmWorkCom.CdsCaixaMov);
                  end;
                end;
              end;
              DataPedidoFP.DataSet.Next;
            end;
            // ajustar MD5 do registro
            DmWorkCom.AjustarMD5Pedido(DataCupom.DataSet.FieldByName('ID').AsInteger);
            // Imprime Cupom TEF
            aContadorTEF := 0;
            if DmWorkCom.PAFECF.gCartoes > 0 then
            begin
              DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
              while not DataPedidoFP.DataSet.Eof do
              begin
                // verifica forma de pagamento
                lValorTEF := (DataPedidoFP.DataSet.FieldByname('VALOR').AsFloat+
                              DataPedidoFP.DataSet.FieldByname('TROCO').AsFloat)-
                              DataPedidoFP.DataSet.FieldByname('DESCONTO').AsFloat;
                //
                case DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger of
                  1 : begin
                        Inc(aContadorTEF);
                        if DataPedidoFP.DataSet.FieldByname('VINCULAR').AsString = 'S' then
                           aOK := ImprimeVendaTEF(DmWorkCom.PAFECF.gCHEQUE,DmAcBr.ACBrECF1.NumCOO,lValorTEF,aContadorTEF);
                      end;
                  2 : begin
                        Inc(aContadorTEF);
                        if DataPedidoFP.DataSet.FieldByname('VINCULAR').AsString = 'S' then
                           aOK := ImprimeVendaTEF(DmWorkCom.PAFECF.gCARTAO,DmAcBr.ACBrECF1.NumCOO,lValorTEF,aContadorTEF);
                      end;
                end;
                if not aOK then
                   Break;
                DataPedidoFP.DataSet.Next;
              end;
              if not aOK then
              begin
                // Verifica transações TEF pendente
                DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger,true);
                DmWorkCom.PAFECF.VerificaResolvePendenciaTEF(DmWorkCom.CdsPedidoFP,True);
                DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
              end
              else
              begin
                Sleep(1000);
                for aControle:=1 to aCartoes do
                begin
                  DmWorkCom.PAFECF.ApagaArquivosTEF(aControle);
                  Sleep(1000);
                  DeleteFile(DmWorkCom.PAFECF.ArqTemp);
                end;
              end;
            end;
            // imprime vinculado para formas de pagamento boleto ou carnet
            DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
            while not DataPedidoFP.DataSet.Eof do
            begin
              if (DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger = 3) or
                 (DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger = 4) or
                 (DataPedidoFP.DataSet.FieldByname('TIPO_DOCUMENTO').AsInteger = 5) then
              begin
                if DataPedidoFP.DataSet.FieldByname('VINCULAR').AsString = 'S' then
                begin
                  if sPAFNFCe = 0 then // paf-ecf
                  begin
                    DmWorkCom.PAFECF.EmiteGerencialVendaPrazo(DataCupom.DataSet.FieldByName('DATA_PEDIDO').AsDateTime,
                                                              DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,
                                                              DataCupom.DataSet.FieldByName('CLIENTE').AsString);
                  end
                  else
                  begin
//fabricio novo promissoria
                    DmWorkCom.PAFECF.EmiteGerencialVendaPrazoNFCe(DataCupom.DataSet.FieldByName('DATA_PEDIDO').AsDateTime,
                                                              DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,
                                                              DataCupom.DataSet.FieldByName('CLIENTE').AsString);
                  end;
                end;
              end;
              DataPedidoFP.DataSet.Next;
            end;
            // imprime vinculado para processo do vidalink
            if DmWorkCom.CdsPedidos.FieldByName('NAUTORIZA_VIDALINK').AsString <> '' then
            begin
              // realiza a confirmação
              if not DmAuxiliar.PBMVidaLink1.ConfirmaVenda(DmAcBr.ACBrECF1.NumECF,
                                                          DmAcBr.ACBrECF1.NumCOO,
                                                          DmWorkCom.CdsPedidos.FieldByName('NAUTORIZA_VIDALINK').AsString) then
              begin
                 MessageDlg('Erro ao confirmar a autorização!',mtWarning,[mbOK],0);
                 aOK := false;;
              end
              else
              begin
                lValorTEF := DmWorkCom.RetornaReembolsoVidaLink(DataCupom.DataSet.FieldByname('ID').AsInteger);
                // emite o cupom vinculado
                if sPAFNFCe = 0 then // paf-ecf
                begin
                  DmWorkCom.PAFECF.EmiteGerencialVidaLink(DmAuxiliar.PBMVidaLink1.Solicitacao.ComprovanteVinculado.Text,
                                                          DmAcBr.ACBrECF1.NumCOO,
                                                          DmWorkCom.PAFECF.gCONVENIO,
                                                          lValorTEF);
                end
                else
                begin
                  DmWorkCom.PAFECF.EmiteGerencialVidaLinkNFCe(DmAuxiliar.PBMVidaLink1.Solicitacao.ComprovanteVinculado.Text,
                                                          DmAcBr.ACBrECF1.NumCOO,
                                                          DmWorkCom.PAFECF.gCONVENIO,
                                                          lValorTEF);
                end;
              end;
            end;
          end;
          //
          if not aOK then
          begin
            if sPAFNFCe = 0 then
            begin
              MessageDlg('O Cupom fiscal será cancelado!', mtError, [mbOK], 0);
              if DmWorkCom.PAFECF.VerificaImpressoraLigada then
                 CancelaCupomFiscal(1,0)
              else
                 MessageDlg('Não foi possível cancelar o cupom. ECF esta desligado!', mtWarning, [mbOK], 0);
             xFechamento := false;
            end
            else if sPAFNFCe = 1 then
            begin
              if not aOK then
              begin
                Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
                try
                  FrmMensageemProd.PnMensagem.Caption := 'Erro ao emitir a NFCe. Use a opção de pendentes!';
                  FrmMensageemProd.ShowModal;
                finally
                  FreeAndNil(FrmMensageemProd);
                end;
              end;
            end
            else if sPAFNFCe = 2 then
            begin
              if not aOK then
              begin
                Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
                try
                  FrmMensageemProd.PnMensagem.Caption := 'Erro ao emitir o SAT. Use a opção de pendentes!';
                  FrmMensageemProd.ShowModal;
                finally
                  FreeAndNil(FrmMensageemProd);
                end;
              end;
            end
            else if sPAFNFCe = 3 then
            begin
              if not aOK then
              begin
                Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
                try
                  FrmMensageemProd.PnMensagem.Caption := 'Erro ao emitir o comprovante!';
                  FrmMensageemProd.ShowModal;
                finally
                  FreeAndNil(FrmMensageemProd);
                end;
              end;
            end;
          end;
          // fecha cupom na tabela
          if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
             BlockInput(false);
          AtivaDesativaAction(true);
          // verifica se cupom esta resolvido
//          if DmAcBr.ACBrECF1.Estado = estLivre then
          begin
            DmWorkCom.Dados_Pedido(0);
            DmWorkCom.Dados_PedidoItens(0);
            sDAV := false;
            sMesa := false;
            TotalizaCupom;
            Memo.Lines.Clear;
            PnInforma.Caption := 'Caixa Livre';
            PnProduto.Caption := '';
            LbTroco.Caption   := '';
            sNotaManual := '';
            sNotaEletronica := '';
            if FileExists(ExtractFilePath(Application.ExeName)+'fundovenda.jpg') then
               ImgProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'fundovenda.jpg');
            // se for posto abre a tela de abastecimento
            if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
            begin
              ActAbastecimentoExecute(Sender);
            end
            else
            begin
              if DmWorkCom.PAFECF.gTXTAutomatico then
                 ActImprimirDAVExecute(Sender);
            end;
            // verifica se tem notas emitidas em continhência
            VerificaNotaEmContingencia;
          end;
          xFechamento := false;
          EdtProduto.SetFocus;
        except
        end;
      end;
    finally
      xFechamento := false;
      TimerItens.Enabled := true;
      FrmFecharCupom.Free;
    end;
  end
  else MessageDlg('Não há cupom aberto na impressora!',mtWarning,[mbOK],0);;

end;

procedure TFrmEmiCupom.ActAcionarGavetaExecute(Sender: TObject);
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  DmWorkCom.PAFECF.AbreGavetaDinheiro

end;

procedure TFrmEmiCupom.ActImprimirDAVExecute(Sender: TObject);
var aNumItem, aMensagem : string;
    aCodMinasLegal, aCodCupomMania : String;
    PercCarga : Double;
begin
  inherited;
  if sPAFNFCe = 0 then
  begin
    if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
    begin
      ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
      exit;
    end;
    //
    if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
    begin
      ShowMessage(aMensagem);
      DmWorkCom.PAFECF.sControleECFAtivo := 2;
      Exit;
    end;
  end;  
  Application.CreateForm(TFrmCupomDAVPV,FrmCupomDAVPV);
  try
    FrmCupomDAVPV.sIDPedido := 0;
    FrmCupomDAVPV.ShowModal;
    if FrmCupomDAVPV.sIDPedido > 0 then
    begin
      DmWorkCom.Dados_Pedido(FrmCupomDAVPV.sIDPedido);
      DmWorkCom.Dados_PedidoItens(FrmCupomDAVPV.sIDPedido);
      if DataCupom.DataSet.RecordCount > 0 then
      begin
        if (DataCupom.DataSet.FieldByName('COO').AsInteger = 0) and
           (DataCupom.DataSet.FieldByName('Confirmada').AsString = 'S') and
           (DataCupom.DataSet.FieldByName('Cancelado').AsString = 'N') then
        begin
          // captura os dados do cliente
          DmClientes.Dados_Contato(DataCupom.DataSet.FieldByName('IDCLIENTE').AsInteger);
          with ClienteCupom do
          begin
            ID          := DataCupom.DataSet.FieldByName('IDCLIENTE').AsInteger;
            Cliente     := DmWorkCom.CdsPedidos.FieldByname('CLIENTE').AsString;
            Endereco    := DmWorkCom.CdsPedidos.FieldByname('END_ENTREGA').AsString;
            Numero      := DmWorkCom.CdsPedidos.FieldByname('NUM_END_ENTREGA').AsString;
            Complemento := DmWorkCom.CdsPedidos.FieldByname('COMPL_END_ENTREGA').AsString;
            Bairro      := DmWorkCom.CdsPedidos.FieldByname('BAIRRO_END_ENTREGA').AsString;
            Cidade      := DmWorkCom.CdsPedidos.FieldByname('CID_END_ENTREGA').AsString;
            Cep         := DmWorkCom.CdsPedidos.FieldByname('CEP_END_ENTREGA').AsString;
            UF          := DmWorkCom.CdsPedidos.FieldByname('UF_END_ENTREGA').AsString;
            CPF         := DmWorkCom.CdsPedidos.FieldByname('CNPJCPF').AsString;
            Identidade  := DmWorkCom.CdsPedidos.FieldByname('INSCEST').AsString;
            Placa       := '';
            Odometro    := '';
          end;
{
          DmClientes.Dados_Contato(DataCupom.DataSet.FieldByName('IDCLIENTE').AsInteger);
          with ClienteCupom do
          begin
            ID          := DataCupom.DataSet.FieldByName('IDCLIENTE').AsInteger;
            Cliente     := DmClientes.CdsContatos.FieldByname('NOME').AsString;
            Endereco    := DmClientes.CdsContatos.FieldByname('END_ENTREGA').AsString;
            Numero      := DmClientes.CdsContatos.FieldByname('NUM_END_ENTREGA').AsString;
            Complemento := DmClientes.CdsContatos.FieldByname('COMPL_ENT').AsString;
            Bairro      := DmClientes.CdsContatos.FieldByname('BAIRRO_END_ENTREGA').AsString;
            Cidade      := DmClientes.CdsContatos.FieldByname('CID_END_ENTREGA').AsString;
            Cep         := DmClientes.CdsContatos.FieldByname('CEP_END_ENTREGA').AsString;
            UF          := DmClientes.CdsContatos.FieldByname('UF_END_ENT').AsString;
            CPF         := DmClientes.CdsContatos.FieldByname('CNPJ_CPF').AsString;
            Identidade  := DmClientes.CdsContatos.FieldByname('INSC_RG').AsString;
            Placa       := '';
            Odometro    := '';
          end;
}
          sDAV := true;
          ActIncluirCupomExecute(Sender);
          if DmWorkCom.PAFECF.sControleECFAtivo = 0 then
          begin
            DataItensCupom.DataSet.First;
            while not DataItensCupom.DataSet.Eof do
            begin
              DataItensCupom.DataSet.Edit;
              Grava_Dados(DataItensCupom.DataSet);
              // inclui o item na impressora fiscal
              DmProdutos.Dados_Produto(DataItensCupom.DataSet.FieldByName('ean13').AsString);
              if sPAFNFCe = 0 then  // paf-ecf
              begin
                if DmWorkCom.RegistraItemECF(FloatToStr(DataItensCupom.DataSet.FieldByName('Quantidade').AsFloat)) then
                begin
                  PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;
                  ExibeDadosItem;
                  TotalizaCupom;
                  DmWorkCom.PAFECF.AtualizaINI(false);
                  // verifica Item Cancelado
                  if DataItensCupom.DataSet.FieldByName('CANCELADO').AsString = 'S' then
                  begin
                    aNumItem := IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger);
                    aNumItem := ZeroEsquerda(aNumItem,3);
                    DmWorkCom.PAFECF.CancelarItemCupom(aNumItem);
                    Memo.Lines.Add('Item cancelado: '+aNumItem);
                  end;
                end
                else
                begin
                  messagedlg('Erro ao incluir item. Verifique!',mtWarning,[mbOK],0);
                  MessageDlg('O cupom fiscal será cancelado!', mtWarning, [mbOK], 0);
                  ActCancelarCupomExecute(Sender);
                  Break;
                end;
              end
              else
              begin
                PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;
                ExibeDadosItem;
                TotalizaCupom;
                DmWorkCom.PAFECF.AtualizaINI(false);
                // verifica Item Cancelado
                if DataItensCupom.DataSet.FieldByName('CANCELADO').AsString = 'S' then
                begin
                  aNumItem := IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger);
                  aNumItem := ZeroEsquerda(aNumItem,3);
                  DmWorkCom.PAFECF.CancelarItemCupom(aNumItem);
                  Memo.Lines.Add('Item cancelado: '+aNumItem);
                end;
              end;
              // proximo registro
              DataItensCupom.DataSet.Next;
            end;
            // cancela pre-venda em caso de selecionado opção
            if FrmCupomDAVPV.sCancelado then
            begin
              // Registra forma de pagamento
              DataPedidoFP.DataSet.Append;
              DataPedidoFP.DataSet.FieldByName('TIPO_DOCUMENTO').AsInteger    := 0;
              DataPedidoFP.DataSet.FieldByName('DESCRICAO').AsString          := 'Dinheiro';
              DataPedidoFP.DataSet.FieldByName('VALOR').AsFloat               := DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat;
              DataPedidoFP.DataSet.FieldByName('TROCO').AsFloat               := 0;
              DataPedidoFP.DataSet.FieldByName('ID_FORMAPAG_CUPOM').AsInteger := DataCupom.DataSet.FieldByName('ID_FORMAPAG').AsInteger;
              Grava_Dados(DataPedidoFP.DataSet);
              // realiza o fechamento do cupom fiscal
              DmWorkCom.PAFECF.IniciaFechamentoCupom('D','0,00');
              DmWorkCom.PAFECF.RegistraFormaPagtoCupom(DmWorkCom.PAFECF.gDINHEIRO,
                                                       TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,DmWorkCom.PAFECF.gDecimais));
  //            aMensagem := DmWorkCom.PAFECF.gMD5+#13+#10;
              aMensagem := '';
              aMensagem := aMensagem + 'PV'+DmWorkCom.CdsPedidosNUMPV.AsString;
              aMensagem := aMensagem+#13+#10;
              // calcula o percentual de carga
              PercCarga := ((DataCupom.DataSet.FieldByname('VALOR_CARGA_TRIB').AsFloat * 100) /
                             DataCupom.DataSet.FieldByname('VALOR_TOTAL').AsFloat);
              // verifica opção de Minas Legal
              if DmWorkCom.CdsEmpresaUF.AsString = 'MG' then
              begin
                // 99999999ddmmaaaa8888888
                aCodMinasLegal := Copy(FiltraNumero(DmWorkCom.CdsEmpresaCNPJ_CPF.AsString),1,8);
                aCodMinasLegal := aCodMinasLegal + FormatDateTime('DDMMYYYY',DataCupom.DataSet.FieldByName('DATA_ENTREGA').AsDateTime);
                aCodMinasLegal := aCodMinasLegal + FloatToStr(TruncaValor(DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat,0));
                aMensagem := aMensagem + 'MINAS LEGAL: '+aCodMinasLegal+#13+#10;
              end;
              // verifica opção de Minas Legal
  {            if DmWorkCom.CdsEmpresaUF.AsString = 'RJ' then
              begin
                aCodCupomMania := Copy(FiltraNumero(DmWorkCom.CdsEmpresaINSCRICAO_RG.AsString),1,8);
                aCodCupomMania := aCodCupomMania + FormatDateTime('DDMMYYYY',DataCupom.DataSet.FieldByName('DATA_ENTREGA').AsDateTime);
                aCodCupomMania := aCodCupomMania + ZeroEsquerda(IntToStr(DataCupom.DataSet.FieldByName('COO').AsInteger),6);
                aCodCupomMania := aCodCupomMania + ZeroEsquerda(IntToStr(StrToInt(DmAcBr.ACBrECF1.NumECF)),3);
                aMensagem := aMensagem + 'CUPOM MANIA, CONCORRA A PREMIOS'+#13+#10;
                aMensagem := aMensagem + 'ENVIE SMS P/6789: '+aCodCupomMania+#13+#10;
              end; }
              if DmWorkCom.CdsEmpresaUF.AsString = 'DF' then
              begin
                aMensagem := aMensagem + 'ESTABELECIMENTO INCLUIDO NO PROGRAMA DE'+#13+#10;
                aMensagem := aMensagem + 'CONCESSAO DE CREDITOS - LEI Nº 4.159/08'+#13+#10;
                aMensagem := aMensagem + 'NOTA LEGAL: ICMS: '+FormatFloat('0.00',PercCarga)+#13+#10;
              end;
              if DmWorkCom.CdsEmpresaUF.AsString = 'PB' then
              begin
                aCodCupomMania := Copy(FiltraNumero(DmWorkCom.CdsEmpresaCNPJ_CPF.AsString),1,14)+' ';
                aCodCupomMania := aCodCupomMania + FormatDateTime('DDMMYYYY',DataCupom.DataSet.FieldByName('DATA_ENTREGA').AsDateTime)+' ';
                aCodCupomMania := aCodCupomMania + FiltraNumero(FormatFloat('0.00',DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsFloat))+' ';
                aCodCupomMania := aCodCupomMania + FiltraNumero(DataCupom.DataSet.FieldByName('CNPJ_CPF').AsString);
                aMensagem := aMensagem + 'PARAIBA LEGAL - RECEITA CIDADÃ'+#13+#10;
                aMensagem := aMensagem + 'TORPEDO PREMIADO: '+aCodCupomMania+#13+#10;
              end;
              // exibe carga tributaria
              aMensagem := aMensagem + 'Val Aprox trib. Fed. R$'+
                                        FormatFloat(DmWorkCom.PAFECF.gMascaraDec,DataCupom.DataSet.FieldByname('VAL_CARGA_FED').AsFloat)+
                                        ' Est. R$'+
                                        FormatFloat(DmWorkCom.PAFECF.gMascaraDec,DataCupom.DataSet.FieldByname('VAL_CARGA_EST').AsFloat)+
                                        ' Mun. R$'+
                                        FormatFloat(DmWorkCom.PAFECF.gMascaraDec,DataCupom.DataSet.FieldByname('VAL_CARGA_MUN').AsFloat)+
                                        ' Fonte IBPT'+#13+#10;
              DmWorkCom.PAFECF.TerminaFechamentoCupom(aMensagem);
              // cancelar a pre-venda
              CancelaCupomFiscal(1,0);
            end;
          end
          else
          begin
            DmWorkCom.Dados_Pedido(0);
            DmWorkCom.Dados_PedidoItens(0);
            DmWorkCom.Dados_PedidoFP(0);
          end;
        end
        else
        begin
          MessageDlg('Este pedido não pode ser impresso!!!', mtWarning, [mbOK], 0);
          DmWorkCom.Dados_Pedido(0);
          DmWorkCom.Dados_PedidoItens(0);
          sDAV := false;
          sMesa := false;
          Abort;
        end;
      end;
    end
    else
    begin
      DmWorkCom.Dados_Pedido(0);
      DmWorkCom.Dados_PedidoItens(0);
      DmWorkCom.Dados_PedidoFP(0);
    end;
  finally
    FreeAndNil(FrmCupomDAVPV);
  end;

end;

procedure TFrmEmiCupom.ActTEFAdmExecute(Sender: TObject);
var Aprovado, Impresso, EhCheque, aControlePAF_NFCe : Boolean;
    Mensagem : String;
    aVias : Integer;
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
  begin
    MessageDlg('ECF Desligada! Ligue-a e tente novamente!', mtInformation, [mbOK], 0);
    Exit;
  end;
  //
  if DmAcBr.ACBrECF1.Estado = estLivre then
  begin
    Impresso := false;
    DmWorkCom.PAFECF.ApagaArquivosTEF(1);
    // captura informação da bandeira
    DmWorkCom.PAFECF.CarregarDadosPathTEF;
    // verifica gerenciador padrão
    if not DmWorkCom.PAFECF.VerificaGerenciadorPadrao then
    begin
      DmWorkCom.PAFECF.RestauraAplicativo;
      ShowMessage('Gerenciador padrão desativado e será ativado automaticamente!');
      DmWorkCom.PAFECF.AbreGerenciadorPadrao;
      if not DmWorkCom.PAFECF.VerificaGerenciadorPadrao then
      begin
        MessageDlg('Erro ao ativar o GP automaticamente. Proceda a ativação manual e tente novamente!',mtWarning,[mbOK],0);
        Exit;
      end;
    end;
    DmWorkCom.PAFECF.FuncaoAdministrativaTEF;
    Mensagem := '';
    DmWorkCom.PAFECF.AnalizaArquivoRetorno(Aprovado,Mensagem,EhCheque,1);
    DmWorkCom.PAFECF.RestauraAplicativo;
    // define numero de vias
    aVias := 2;
    if not DmWorkCom.PAFECF.sTEFViaUnica then
       aVias := 1;
    if not DmWorkCom.PAFECF.gPossuiCampo29 then
       aVias := 1;
    //
    if not Aprovado then
    begin
      DmWorkCom.PAFECF.ApagaArquivosTEF(1);
      DmWorkCom.PAFECF.RestauraAplicativo;
      ShowMessage(Mensagem);
    end
    else
    begin
      // trava o teclado
      if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
         BlockInput(true);
      // exibe a mensagem
      if DmWorkCom.PAFECF.gQuantLinhas > 0 then
      begin
        DmWorkCom.PAFECF.ExibeMensagem(5,Mensagem);
        while not Impresso do
        begin
          // verifica o tipo de sistema
          if sPAFNFCe = 0 then // paf-ecf
             aControlePAF_NFCe := DmWorkCom.PAFECF.ImprimeTransacaoTEF(1,aVias,1,'0','0',0)
          else
             aControlePAF_NFCe := DmWorkCom.PAFECF.ImprimeTransacaoTEFNFCe(1,aVias,1,'0','0',0);
          //
          if not aControlePAF_NFCe then
          begin
            if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
               BlockInput(false);
            if Confirmacao('Impressora não responde. Tentar novamente? ') then
            begin
              if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
                 BlockInput(true);
              DmWorkCom.PAFECF.VerificaImpressoraLigada;
              DmWorkCom.PAFECF.FechaCupomNaoFiscalECF;
              Impresso := false;
            end
            else
            begin
              if DmWorkCom.PAFECF.sTipoTEF in [0,2] then // tef discado
              begin
                 BlockInput(false);
                 DmWorkCom.PAFECF.NaoConfirmaTransacao(1,'');
                 Impresso := true;
              end
              else
              begin
                DmWorkCom.PAFECF.ConfirmaTransacao(1,'');
                MessageDlg('Transação TEF confirmada. Favor reimprimir a ultima transação!', mtInformation, [mbOK], 0);
              end;
              DmWorkCom.PAFECF.ApagaArquivosTEF(1);
              DmWorkCom.PAFECF.ApagaArquivosTemporariosTEF;
              DeleteFile(DmWorkCom.PAFECF.ArqTemp);
            end;
          end
          else
          begin
            if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
               BlockInput(false);
            DmWorkCom.PAFECF.ConfirmaTransacao(1,'');
            DmWorkCom.PAFECF.ApagaArquivosTEF(1);
            DmWorkCom.PAFECF.ApagaArquivosTemporariosTEF;
            DeleteFile(DmWorkCom.PAFECF.ArqTemp);
            Impresso := true;
          end;
        end;
      end
      else
      begin
        if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
           BlockInput(false);
        DmWorkCom.PAFECF.ConfirmaTransacao(1,'');
        DmWorkCom.PAFECF.ApagaArquivosTEF(1);
        ShowMessage(Mensagem);
      end;
      //
      if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
         BlockInput(false);
    end;
    EdtProduto.SetFocus;
    PnInforma.Caption := 'Caixa Livre';
    PnProduto.Caption := '';
    LbTroco.Caption   := '';
    sNotaManual := '';
    sNotaEletronica := '';
    // se for posto abre a tela de abastecimento
    if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
       ActAbastecimentoExecute(Sender);
  end
  else
  begin
    if DmAcBr.ACBrECF1.Estado = estVenda then
    begin
      MessageDlg('Existe um cupom fiscal aberto e deverá se cancelado!', mtWarning, [mbOK], 0)
    end
    else if DmAcBr.ACBrECF1.Estado = estRelatorio then
    begin
      MessageDlg('Existe um gerencial em aberto e será fechado!', mtWarning, [mbOK], 0);
      DmWorkCom.PAFECF.FechaRelatorioGerencial;
    end
    else if DmAcBr.ACBrECF1.Estado = estNaoFiscal then
    begin
      MessageDlg('Existe um vinculado em aberto e será fechado!', mtWarning, [mbOK], 0);
      DmWorkCom.PAFECF.FechaRelatorioGerencial;
    end
    else
    begin
      MessageDlg('ECF não esta em modo livre. Verifique situação!', mtWarning, [mbOK], 0);
    end;
    // verifica se cupom esta resolvido
    if DmAcBr.ACBrECF1.Estado = estLivre then
    begin
      DmWorkCom.Dados_Pedido(0);
      DmWorkCom.Dados_PedidoItens(0);
      sDAV := false;
      sMesa := false;
      TotalizaCupom;
      Memo.Lines.Clear;
      PnInforma.Caption := 'Caixa Livre';
      PnProduto.Caption := '';
      LbTroco.Caption   := '';
      sNotaManual := '';
      sNotaEletronica := '';
      if FileExists(ExtractFilePath(Application.ExeName)+'fundovenda.jpg') then
         ImgProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'fundovenda.jpg');
      // se for posto abre a tela de abastecimento
      if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
         ActAbastecimentoExecute(Sender);
    end;
    EdtProduto.SetFocus;
  end;
    
end;

procedure TFrmEmiCupom.Realizarrecargadeprpago1Click(Sender: TObject);
begin
  inherited;
  AbreForm(TFrmRecargaPre,FrmRecargaPre);
end;

function TFrmEmiCupom.RealizaVendaTEF(pTipo,pControle:Integer): Boolean;
var Aprovado, EhCheque : Boolean;
    Mensagem : String;
begin
  inherited;
  Result := false;
  DmWorkCom.PAFECF.ApagaArquivosTEF(pControle);
  // captura informação da bandeira
  DmWorkCom.PAFECF.CarregarDadosPathTEF;
  // verifica gerenciador padrão
  if not DmWorkCom.PAFECF.VerificaGerenciadorPadrao then
  begin
    DmWorkCom.PAFECF.RestauraAplicativo;
    ShowMessage('Gerenciador padrão desativado e será ativado automaticamente!');
    DmWorkCom.PAFECF.AbreGerenciadorPadrao;
    if not DmWorkCom.PAFECF.VerificaGerenciadorPadrao then
    begin
      MessageDlg('Erro ao ativar o GP automaticamente. Proceda a ativação manual!',mtWarning,[mbOK],0);
      Result := false;
      Exit;
    end
  end;
  DmWorkCom.PAFECF.gValor       := FormatFloat('0.00',DataPedidoFP.DataSet.FieldByName('VALOR').AsFloat);
  DmWorkCom.PAFECF.gValor       := FiltraNumero(DmWorkCom.PAFECF.gValor);
  DmWorkCom.PAFECF.gNumeroCupom := ZeroEsquerda(IntToStr(DataCupom.DataSet.FieldByName('COO').AsInteger),6);
  DmWorkCom.PAFECF.FuncaoVendaTEF(pTipo);
  Sleep(2000);
  Mensagem := '';
  DmWorkCom.PAFECF.AnalizaArquivoRetorno(Aprovado,Mensagem,EhCheque,pControle);
  DmWorkCom.PAFECF.RestauraAplicativo;
  if not Aprovado then
  begin
    DmWorkCom.PAFECF.ApagaArquivosTEF(pControle);
    ShowMessage(Mensagem);
  end
  else
  begin
    if (EhCheque) and (DmWorkCom.PAFECF.sTipoTef = 1) then
    begin
      DmWorkCom.PAFECF.ExibeMensagem(0,Mensagem);
      MessageDlg('Operação concluida com sucesso!', mtInformation, [mbOK], 0);
    end
    else
    begin
      DmWorkCom.PAFECF.ExibeMensagem(5,Mensagem);
    end;
    Result := true;
  end;
  EdtProduto.SetFocus;

end;

function TFrmEmiCupom.ImprimeVendaTEF(pFormaPag,pCOO:String;pValor:Double;
  pControle:Integer): Boolean;
var Aprovado, Impresso, ConfirmaTransacao : Boolean;
    aVias, aTipoRel, aCartoes : Integer;
    aControlePAF_NFCe : Boolean;
begin
  aVias := 2;
  if not DmWorkCom.PAFECF.sTEFViaUnica then
     aVias := 1;
  if not DmWorkCom.PAFECF.gPossuiCampo29 then
     aVias := 1;
  //
  aTipoRel := 0;
  Result   := false;
  Impresso := false;
  aCartoes := RetornaNumCartoesFechamento(DataCupom.DataSet.FieldByName('ID').AsInteger);
  while not Impresso do
  begin
    // pTipoRel = 0 - Comprovante de Credito
    //            1 - Relatorio Gerencial
    if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
       BlockInput(true);
    // verifica o tipo de sistema
    if sPAFNFCe = 0 then // paf-ecf
       aControlePAF_NFCe := DmWorkCom.PAFECF.ImprimeTransacaoTEF(aTipoRel,aVias,pControle,pFormaPag,DmWorkCom.PAFECF.gNumeroCupom,pValor)
    else
       aControlePAF_NFCe := DmWorkCom.PAFECF.ImprimeTransacaoTEFNFCe(aTipoRel,aVias,pControle,pFormaPag,DmWorkCom.PAFECF.gNumeroCupom,pValor);
    //
    if not aControlePAF_NFCe then
    begin
      if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
         BlockInput(false);
      if Confirmacao('Impressora não responde. Tentar novamente?') then
      begin
        if DmWorkCom.PAFECF.sTipoTEF in [0,2] then
           BlockInput(true);
        if sPAFNFCe = 0 then // paf-ecf
           DmWorkCom.PAFECF.FechaCupomNaoFiscalECF;
        aTipoRel := 1;
        Impresso := false;
      end
      else
      begin
        Sleep(2000);
        Impresso := true;
      end;
    end
    else
    begin
      BlockInput(false);
      Sleep(2000);
      ConfirmaTransacao := true;
      if (DmWorkCom.PAFECF.sTipoTef in [0,2]) and (aCartoes > pControle) then
      begin
        ConfirmaTransacao := false;
      end;
      // realiza a confirmação
      if ConfirmaTransacao then
         DmWorkCom.PAFECF.ConfirmaTransacao(pControle,'');
      Result   := true;
      Impresso := true;
    end;
  end;

end;

function TFrmEmiCupom.RetornaAliquotaProduto: String;
begin
  Result := '';
  if (DataProduto.DataSet.FieldByName('tributacao').AsInteger = 2) or
     (DataProduto.DataSet.FieldByName('tributacao').AsInteger = 4) then
  begin
    Result := FormatFloat('0.00',DataProduto.DataSet.FieldByName('aliquota_icms').AsFloat);
    Result := 'T '+ZeroEsquerda(Result,5);
  end;

//fabricio inicio
{
  else if DataProduto.DataSet.FieldByName('tributacao').AsInteger = 1 then
     Result := 'F              0,00'
  else if DataProduto.DataSet.FieldByName('tributacao').AsInteger = 0 then
     Result := 'I              0,00'
  else if DataProduto.DataSet.FieldByName('tributacao').AsInteger = 3 then
     Result := 'N              0,00';
}
     //fabricio fim
end;

procedure TFrmEmiCupom.CancelaCupomFiscal(pTipoCancel,pIDUsuarioCanc:Integer);
var aControle : Boolean;
begin
  if sPAFNFCe = 0 then
  begin
    // localiza o ultimo registro de cupom
    if DataCupom.DataSet.RecordCount = 0 then
    begin
      if DmWorkCom.Dados_Pedido(RetornaUltimoCupomEmitido(DmWorkCom.PAFECF.gCaixa),1) then
      begin
        if DataCupom.DataSet.FieldByName('CANCELADO').AsString = 'S' then
        begin
          MessageDlg('Ultimo cupom já esta cancelado!!!', mtWarning, [mbOK], 0);
          Abort;
        end;
      end;
    end;
  end
  else
  begin
    if DataCupom.DataSet.RecordCount = 0 then
    begin
      MessageDlg('Para cancelamento de documentos emitidos use a opção de NFCe!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
  // pTipoCancel = 0 - Perguntar Antes
  //               1 - Cancela Direto
  aControle := false;
  if pTipoCancel = 0 then
  begin
    if Confirmacao('Confirma o Cancelamento do documento?') then
       aControle := true;
  end
  else
  begin
    aControle := true;
  end;
  //
  if aControle then
  begin
    try
      // se tiver produtos na lista cancela todos
      if not CdsListaProd.IsEmpty then
         CdsListaProd.EmptyDataSet;
      // desativa os controles de tela   
      AtivaDesativaAction(false);
      // enviar comando para cancelar cupom no ECF
      if sPAFNFCe = 0 then
      begin
        if not DmWorkCom.PAFECF.CancelaCupomECF then
        begin
          MessageDlg('Não foi possível cancelar o cupom!',mtWarning,[mbOK],0);
          Abort;
        end;
      end;  
      // grava dados do cancelamento
      if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
         DataCupom.DataSet.Edit;
      DataCupom.DataSet.FieldByName('IDUSUARIOCANC').AsInteger  := pIDUsuarioCanc;
      DataCupom.DataSet.FieldByName('STATUS_ABASTEC').AsInteger := 0;
      DataCupom.DataSet.FieldByName('CANCELADO').AsString       := 'S';
      if (sNotaManual <> '') or (sNotaEletronica <> '') then
      begin
        DataCupom.DataSet.FieldByName('NUMERO_DOC').AsString := '';
        DataCupom.DataSet.FieldByName('NOTAMANUAL').AsString := 'N';
      end;
      Grava_Dados(DataCupom.DataSet);
      // retorna produtos para o estoque
      if DataCupom.DataSet.FieldByName('CONFIRMADA').AsString = 'S' then
      begin
        DmWorkCom.Dados_PedidoItens(DataCupom.DataSet.FieldByName('ID').AsInteger);
        DmWorkCom.Movimenta_Estoque(1,DataItensCupom.DataSet);
      end;
      // se tiver forma de pagamento abate o valor no registro A2
      DmWorkCom.Dados_PedidoFP(DataCupom.DataSet.FieldByName('ID').AsInteger);
      while not DataPedidoFP.DataSet.Eof do
      begin
        DmWorkCom.GravaRegistroA2(SVData,
                                  DataPedidoFP.DataSet.FieldByname('DESCRICAO').AsString,
                                  1,(DataPedidoFP.DataSet.FieldByname('VALOR').AsFloat-DataPedidoFP.DataSet.FieldByname('TROCO').AsFloat),
                                  false);
        DataPedidoFP.DataSet.Next;
      end;
      // se for abastecimento altera o status
      if DataCupom.DataSet.FieldByName('ABASTECIMENTO').AsString = 'S' then
         DmPosto.RetornaStatusAbastecCupom(DataCupom.DataSet.FieldByname('ID').AsInteger);
    finally
      //
      AtivaDesativaAction(true);
      DmWorkCom.Dados_Pedido(0);
      DmWorkCom.Dados_PedidoItens(0);
      DmWorkCom.Dados_PedidoFP(0);
      sDAV := false;
      sMesa := false;
      Memo.Lines.Clear;
      TotalizaCupom;
      DmWorkCom.PAFECF.AtualizaINI(false);
      PnInforma.Caption := 'Caixa Livre';
      PnProduto.Caption := '';
      LbTroco.Caption   := '';
      sNotaManual := '';
      sNotaEletronica := '';
      if FileExists(ExtractFilePath(Application.ExeName)+'fundovenda.jpg') then
         ImgProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'fundovenda.jpg');
      // se for posto abre a tela de abastecimento
      if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
      begin
        ActAbastecimento.Execute;
      end
      else
      begin
        if DmWorkCom.PAFECF.gTXTAutomatico then
           ActImprimirDAV.Execute;
      end;
    end;
  end;
  EdtProduto.SetFocus;

end;

procedure TFrmEmiCupom.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmEmiCupom.ActLePesoBalancaExecute(Sender: TObject);
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  pPesoBalanca := 0;
  if DmWorkCom.PAFECF.gModeloBal > 0 then
  begin
    if DmWorkCom.PAFECF.AtivarBalancaCaixa then
    begin
      pPesoBalanca := DmWorkCom.PAFECF.CapturarPesoBalanca;
      if pPesoBalanca <= 0 then
      begin
        MessageDlg('Erro ao capturar peso da balança. Verifique!', mtError, [mbOK], 0);
        pPesoBalanca := 0;
      end
      else
      begin
         StatusBar1.Panels.Items[2].Text := 'O peso capturado da balança é: '+FormatFloat('0.000',TruncaValor(pPesoBalanca,3));
      end;
      DmWorkCom.PAFECF.FinalizaLeitura;
    end
    else
    begin
      MessageDlg('Erro ao inicializar a balança. Verifique a configuração!!!', mtError, [mbOK], 0);
      Abort;
    end;
  end
  else
  begin
    MessageDlg('Não há balança configurada no sistema. Verifique1', mtWarning, [mbOK], 0);
    Abort;
  end;

end;

procedure TFrmEmiCupom.ActConsultaProdExecute(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmProdutos,FrmProdutos);
  try
    FrmProdutos.sIDProd := 0;
    FrmProdutos.sPermitirCombustivel := false;
    FrmProdutos.sApenasConsulta := true;
    if DmWorkCom.PAFECF.gPosto then
       FrmProdutos.sPermitirCombustivel := true;
    FrmProdutos.ShowModal;
    if (FrmProdutos.sIDProd > 0) and (DmWorkCom.PAFECF.sControleECFAtivo = 0) then
    begin
      if DmProdutos.Dados_Produto(FrmProdutos.sIDProd) then
         EdtProduto.Text := EdtProduto.Text+DmProdutos.CdsProdutos.FieldByname('EAN13').AsString;
      EdtProdutoExit(Sender);
    end;
  finally
    FrmProdutos.Free;
  end;

end;

procedure TFrmEmiCupom.EdtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var ConfExec : Integer;
begin
   IF Key = Vk_Escape Then
   Begin

   ConfExec := Application.MessageBox('Deseja realmente sair da Tela de Venda ?','Atenção',
   MB_YESNO+MB_DEFBUTTON2+MB_ICONQUESTION);

      IF ConfExec = IDNo Then
      abort;

      IF ConfExec = IDYes Then
      Close;

   End;
end;

procedure TFrmEmiCupom.RecuperarCupomFiscalAberto(pID: Integer);
var aNumItem : String;
begin
  DmWorkCom.Dados_Pedido(pID);
  DmWorkCom.Dados_PedidoItens(pID);
  if DataCupom.DataSet.RecordCount > 0 then
  begin
    DataItensCupom.DataSet.First;
    while not DataItensCupom.DataSet.Eof do
    begin
      DmWorkCom.sNumItem := DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger;
      // inclui o item na impressora fiscal
      DmProdutos.Dados_Produto(DataItensCupom.DataSet.FieldByName('ean13').AsString);
      PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;
      ExibeDadosItem;
      TotalizaCupom;
      DmWorkCom.PAFECF.AtualizaINI(false);
      // verifica Item Cancelado
      if DataItensCupom.DataSet.FieldByName('CANCELADO').AsString = 'S' then
      begin
        aNumItem := IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger);
        aNumItem := ZeroEsquerda(aNumItem,3);
        DmWorkCom.PAFECF.CancelarItemCupom(aNumItem);
        Memo.Lines.Add('Item cancelado: '+aNumItem);
      end;
      // proximo registro
      DataItensCupom.DataSet.Next;
    end;
  end;

end;

procedure TFrmEmiCupom.ActFecharMesaExecute(Sender: TObject);
var aNumItem, aMensagem : String;
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  //fabricio inicio
  {
  if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
  begin
    ShowMessage(aMensagem);
    DmWorkCom.PAFECF.sControleECFAtivo := 2;
    Abort;
  end;
}
  Application.CreateForm(TFrmFechaMesa,FrmFechaMesa);
  try
    FrmFechaMesa.sIDPedido := 0;
    FrmFechaMesa.ShowModal;
    if FrmFechaMesa.sIDPedido > 0 then
    begin
      // emite cupom fiscal da mesa
      DmWorkCom.Dados_Pedido(FrmFechaMesa.sIDPedido);
      DmWorkCom.Dados_PedidoItens(FrmFechaMesa.sIDPedido);
      if DataCupom.DataSet.RecordCount > 0 then
      begin
        if DataCupom.DataSet.FieldByName('COO').AsInteger = 0 then
        begin
          // captura os dados do cliente
          DmClientes.Dados_Contato(DataCupom.DataSet.FieldByName('IDCLIENTE').AsInteger);
          with ClienteCupom do
          begin
            ID          := DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger;
            Cliente     := DmClientes.CdsContatos.FieldByname('NOME').AsString;
            Endereco    := DmClientes.CdsContatos.FieldByname('END_ENTREGA').AsString;
            Numero      := DmClientes.CdsContatos.FieldByname('NUM_END_ENTREGA').AsString;
            Complemento := DmClientes.CdsContatos.FieldByname('COMPL_ENT').AsString;
            Bairro      := DmClientes.CdsContatos.FieldByname('BAIRRO_END_ENTREGA').AsString;
            Cidade      := DmClientes.CdsContatos.FieldByname('CID_END_ENTREGA').AsString;
            Cep         := DmClientes.CdsContatos.FieldByname('CEP_END_ENTREGA').AsString;
            UF          := DmClientes.CdsContatos.FieldByname('UF_END_ENT').AsString;
            CPF         := DmClientes.CdsContatos.FieldByname('CNPJ_CPF').AsString;
            Identidade  := DmClientes.CdsContatos.FieldByname('INSC_RG').AsString;
            Placa       := '';
            Odometro    := '';
          end;
          sMesa := true;
          ActIncluirCupomExecute(Sender);
          DataItensCupom.DataSet.First;
          while not DataItensCupom.DataSet.Eof do
          begin
            // inclui o item na impressora fiscal
            DmProdutos.Dados_Produto(DataItensCupom.DataSet.FieldByName('IDPRODUTO').AsInteger);
            if sPAFNFCe = 0 then // paf-ecf
            begin
              if DmWorkCom.RegistraItemECF(FloatToStr(DataItensCupom.DataSet.FieldByName('Quantidade').AsFloat)) then
              begin
                PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;
                ExibeDadosItem;
                TotalizaCupom;
                DmWorkCom.PAFECF.AtualizaINI(false);
                // verifica Item Cancelado
                if DataItensCupom.DataSet.FieldByName('CANCELADO').AsString = 'S' then
                begin
                  aNumItem := IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger);
                  aNumItem := ZeroEsquerda(aNumItem,3);
                  DmWorkCom.PAFECF.CancelarItemCupom(aNumItem);
                  Memo.Lines.Add('Item cancelado: '+aNumItem);
                end;
              end
              else
              begin
                messagedlg('Erro ao incluir item. Verifique!',mtWarning,[mbOK],0);
                MessageDlg('O cupom fiscal será cancelado!', mtWarning, [mbOK], 0);
                ActCancelarCupomExecute(Sender);
                Break;
              end;
            end
            else
            begin
              PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;
              ExibeDadosItem;
              TotalizaCupom;
              DmWorkCom.PAFECF.AtualizaINI(false);
              // verifica Item Cancelado
              if DataItensCupom.DataSet.FieldByName('CANCELADO').AsString = 'S' then
              begin
                aNumItem := IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger);
                aNumItem := ZeroEsquerda(aNumItem,3);
                DmWorkCom.PAFECF.CancelarItemCupom(aNumItem);
                Memo.Lines.Add('Item cancelado: '+aNumItem);
              end;
            end;
            // proximo registro
            DataItensCupom.DataSet.Next;
          end;
          if DataCupom.DataSet.FieldByName('valor_total').AsFloat = 0 then
          begin
            if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
               DataCupom.DataSet.Edit;
            DataCupom.DataSet.FieldByName('CONFIRMADA').AsString := 'S';
            Grava_Dados(DataCupom.DataSet);
            AlteraStatusMesa(DataCupom.DataSet.FieldByname('ID_MESA').AsInteger,2);
            CancelaCupomFiscal(1,0);
          end;
        end
        else
        begin
          MessageDlg('Este pedido não pode ser impresso!!!', mtWarning, [mbOK], 0);
          DmWorkCom.Dados_Pedido(0);
          DmWorkCom.Dados_PedidoItens(0);
          Abort;
        end;
      end;
    end;
  finally
    FreeAndNil(FrmFechaMesa);
  end;

end;

procedure TFrmEmiCupom.AtivaDesativaAction(Ativar: Boolean);
begin
  ActIncluirCupom.Enabled    := Ativar;
  ActIncluirItem.Enabled     := Ativar;
  ActFechamentoCupom.Enabled := Ativar;
  ActCancelarCupom.Enabled   := Ativar;
  ActCancelarItem.Enabled    := Ativar;
  ActAcionarGaveta.Enabled   := Ativar;
  ActImprimirDAV.Enabled     := Ativar;
  ActTEFAdm.Enabled          := Ativar;
  ActEncerrar.Enabled        := Ativar;
  ActVendaTEF.Enabled        := Ativar;
  ActLePesoBalanca.Enabled   := Ativar;
  ActConsultaProd.Enabled    := Ativar;
  ActFecharMesa.Enabled      := Ativar;
  ActPrevenda.Enabled        := Ativar;
  ActAbastecimento.Enabled   := Ativar;

end;

procedure TFrmEmiCupom.ActPrevendaExecute(Sender: TObject);
begin
  inherited;
  //
  
end;

procedure TFrmEmiCupom.ActAbastecimentoExecute(Sender: TObject);
var aux, aNumItem, aMensagem : String;
    aTotalAbastc : Integer;
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  //
  if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
  begin
    ShowMessage(aMensagem);
    DmWorkCom.PAFECF.sControleECFAtivo := 2;
    Exit;
  end;
  // verifica quantidade de abastecimentos já registrados
  aTotalAbastc := DmWorkCom.PAFECF.RetornaTotalAbastcimentoCupom(DataCupom.DataSet.FieldByName('ID').AsInteger);
  if aTotalAbastc >= DmWorkCom.PAFECF.gAbastCupom then
  begin
    Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
    try
      FrmMensageemProd.PnMensagem.Caption := 'Total de abastecimentos permitidos já atingido!';
      FrmMensageemProd.ShowModal;
    finally
      FreeAndNil(FrmMensageemProd);
      EdtProduto.SetFocus;
      Abort;
    end;
  end
  else
  begin
    Application.CreateForm(TFrmCupomAbastecimento,FrmCupomAbastecimento);
    try
      FrmCupomAbastecimento.ShowModal;
      if sAbastecimento.ID > 0 then
      begin
        // definie o numero da NFe caso tenha
        sNotaEletronica := sAbastecimento.NumeroDoc;
        // localiza dados necessários
        DmPosto.Dados_Bicos(sAbastecimento.Num_Bico);
        DmPosto.Dados_Bomba(DmPosto.CdsBicos.FieldByName('ID_BOMBA').AsInteger);
        DmPosto.Dados_Tanque(DmPosto.CdsBicos.FieldByName('ID_TANQUE').AsInteger);
        DmProdutos.Dados_Produto(DmPosto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger);
        // grava os dados no registro
        sAbastecimento.ID_Bico   := DmPosto.CdsBicos.FieldByName('ID').AsInteger;
        sAbastecimento.ID_Bomba  := DmPosto.CdsBicos.FieldByName('ID_BOMBA').AsInteger;
        sAbastecimento.ID_Tanque := DmPosto.CdsBicos.FieldByName('ID_TANQUE').AsInteger;
        // monta o codigo
        aux := FormatFloat('0.000',sAbastecimento.Litros)+'x'+DataProduto.DataSet.FieldByName('EAN13').AsString;
        // inclui o item a lista de produtos a serem registrados
        CdsListaProd.Append;
        CdsListaProdcodigo.AsString := Aux;
        CdsListaProdautomatico.AsBoolean := true;
        CdsListaProd.Post;
      end;
    finally
      FreeAndNil(FrmCupomAbastecimento);
    end;
  end;

end;

procedure TFrmEmiCupom.ActIncluirCupomExecute(Sender: TObject);
var aMensagem : String;
    aProcessa : Boolean;
    formMensagem: TFormMensagem;
    aOK : Boolean;
    key: char;
begin
  inherited;
//fabricio

 if tbKeyIsDown(VK_F2) then
 begin
    Semidentifica:=false;

    if RetornaDadosCliente then
    begin
      if DmClientes.Dados_Contato(ClienteCupom.ID) then
      begin
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


   if (DataCupom.DataSet.RecordCount > 0) then
   Begin
//fabricio ver zqui

   End
   else
   begin
      try
        AtivaDesativaAction(false);
        if DmWorkCom.IncluirCupomExecute(aMensagem,sDAV) then
        begin
          if sNotaManual <> '' then
          begin
            if not(DataCupom.DataSet.State in [dsinsert,dsedit]) then
               DataCupom.DataSet.Edit;
            DataCupom.DataSet.FieldByName('NUMERO_DOC').AsString := sNotaManual ;
            DataCupom.DataSet.FieldByName('NOTAMANUAL').AsString := 'S';
            Grava_Dados(DataCupom.DataSet);
          end;
          if sNotaEletronica <> '' then
          begin
            if not(DataCupom.DataSet.State in [dsinsert,dsedit]) then
               DataCupom.DataSet.Edit;
            DataCupom.DataSet.FieldByName('NUMERO_DOC').AsString := sNotaEletronica;
            Grava_Dados(DataCupom.DataSet);
          end;


          StatusBar1.Panels.Items[0].Text := 'Ultimo Cupom: '+ZeroEsquerda(IntToStr(DmWorkCom.PAFECF.gCOO),6);
          Memo.Lines.Clear;
          TotalizaCupom;
          PnInforma.Caption := 'Caixa Ocupado!';
          PnProduto.Caption := '';
          xValDesc  := 0;
          xValAcres := 0;
//fabricio novoinicio
            xpercentual:=false;
            xporqtde:=false;
//fabricio novofim


          xAtivaDesconto := false;
          JaHouveErroFechamento := false;
        end;
      finally
        AtivaDesativaAction(true);



   end;
  end
 end
  else
  begin

//  Semidentifica:=false;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  if sPAFNFCe = 0 then
  begin
    try
      formMensagem := TFormMensagem.Create('Aguarde... verificando situação da ECF!',550,150,clWhite,clSilver);
      formMensagem.mostrar;
      Refresh;
      aOK := DmWorkCom.PAFECF.VerificaImpressoraLigada;
    finally
      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
    end;
    // se estiver ligada
    if aOK then
    begin
      if (not sDAV) and (not sMesa) then
      begin
        if (DmAcBr.ACBrECF1.Estado = estVenda) or (DataCupom.DataSet.RecordCount > 0) then
        begin
          MessageDlg('Já existe um documento fiscal em aberto. Verifique!', mtWarning, [mbOK], 0);
          Exit;
        end;
      end;
    end
    else
    begin
      if CdsListaProd.RecordCount > 0 then
      begin
        if CdsListaProd.State in [dsinsert,dsedit] then
           CdsListaProd.Post;
        CdsListaProd.EmptyDataSet;
      end;
    end;
  end
  else aOK := true;
  //
  if aOK then
  begin
    aProcessa := false;
    if sDAV then
       aProcessa := true
    else
    begin
      if RetornaDadosCliente then
         aProcessa := true;
    end;
    // processa a abertura do cupom
    if aProcessa then
    begin
      try
        AtivaDesativaAction(false);
        if DmWorkCom.IncluirCupomExecute(aMensagem,sDAV) then
        begin
          if sNotaManual <> '' then
          begin
            if not(DataCupom.DataSet.State in [dsinsert,dsedit]) then
               DataCupom.DataSet.Edit;
            DataCupom.DataSet.FieldByName('NUMERO_DOC').AsString := sNotaManual ;
            DataCupom.DataSet.FieldByName('NOTAMANUAL').AsString := 'S';
            Grava_Dados(DataCupom.DataSet);
          end;
          if sNotaEletronica <> '' then
          begin
            if not(DataCupom.DataSet.State in [dsinsert,dsedit]) then
               DataCupom.DataSet.Edit;
            DataCupom.DataSet.FieldByName('NUMERO_DOC').AsString := sNotaEletronica;
            Grava_Dados(DataCupom.DataSet);
          end;


          StatusBar1.Panels.Items[0].Text := 'Ultimo Cupom: '+ZeroEsquerda(IntToStr(DmWorkCom.PAFECF.gCOO),6);
          Memo.Lines.Clear;
          TotalizaCupom;
          PnInforma.Caption := 'Caixa Ocupado!';
          PnProduto.Caption := '';
          xValDesc  := 0;
          xValAcres := 0;
//fabricio novoinicio
            xpercentual:=false;
            xporqtde:=false;
//fabricio novofim


          xAtivaDesconto := false;
          JaHouveErroFechamento := false;
        end
        else
        begin
          DmWorkCom.PAFECF.sControleECFAtivo := 1;
          if CdsListaProd.RecordCount > 0 then
          begin
            if CdsListaProd.State in [dsinsert,dsedit] then
               CdsListaProd.Post;
            CdsListaProd.EmptyDataSet;
          end;
          Exit;
        end;
      finally
        AtivaDesativaAction(true);
      end;
    end;
  end
  else
  begin
    DmWorkCom.PAFECF.sControleECFAtivo := 1;
    MessageDlg('ECF não esta em linha ou desligada. verifique!', mtWarning, [mbOK], 0);
    Exit;
  end;
 end;
end;

procedure TFrmEmiCupom.AtivarDesativarNegociaodepreos1Click(Sender: TObject);
begin
  inherited;
  if chkpreco.Checked then
     chkpreco.Checked:=false
  else
     chkpreco.Checked:=true;

end;

procedure TFrmEmiCupom.AtivarDescontoAcrescimonoItem1Click(
  Sender: TObject);
begin
  inherited;
  if DataCupom.DataSet.RecordCount = 0 then
  begin
    ShowMessage('É necessário abrir o cupom para ativar o desconto no item!');
    Exit;
  end;
  xAtivaDesconto := True;

end;

procedure TFrmEmiCupom.Consultarpreodoproduto1Click(Sender: TObject);
begin
  inherited;
  AbreForm(TFrmPrecoProduto,FrmPrecoProduto);
  
end;

procedure TFrmEmiCupom.FormCreate(Sender: TObject);
begin
  inherited;
    // carregar imagem de fundo
//  if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundocupom.jpg') then
//     Image.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundocupom.jpg');
  if not CdsListaProd.Active then
     CdsListaProd.CreateDataSet;
  CdsListaProd.EmptyDataSet;

end;

procedure TFrmEmiCupom.GravaFormasPagamentoNaoConfirmada(pID: Integer);
begin
  DmWorkCom.Dados_PedidoFP(pID);
  while not DataPedidoFP.DataSet.Eof do
  begin
    DataPedidoFP.DataSet.Edit;
    DataPedidoFP.DataSet.FieldByName('CONFIRMADO').AsString := 'N';
    Grava_Dados(DataPedidoFP.DataSet);
    DataPedidoFP.DataSet.Next;
  end;
  DmWorkCom.Dados_PedidoFP(pID);

end;

function TFrmEmiCupom.RetornaDadosCliente:Boolean;
begin
  Application.CreateForm(TfrmIdenticaCliente,frmIdenticaCliente);
  try
//fabricio inicio


    if Semidentifica then
    begin
//       frmIdenticaCliente.ShowModal;
//       frmidenticaCliente.Close;

        FrmIdenticaCliente.DataUF.DataSet    := DmClientes.CdsUF;
        FrmIdenticaCliente.DataUF.DataSet.Open;
//        FrmIdenticaCliente.LimpaDadosCliente;

  DmWorkCom.PreencheClientPadraoRegistro;
  //
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
  FrmIdenticaCliente.FrameConfirmaCancela1.BtnConfirmar.Click;
  Result := FrmIdenticaCliente.sOK;
    end
    else
    begin
       frmIdenticaCliente.ShowModal;
       Result := FrmIdenticaCliente.sOK;
    end;
//fabricio fim
  finally
    frmIdenticaCliente.Destroy;
  end;
  Semidentifica:=true;
end;

procedure TFrmEmiCupom.TimerItensTimer(Sender: TObject);
begin
  inherited;
  TimerItens.Enabled := false;
  try
    with CdsListaProd do
    begin
//      Refresh;
      if not IsEmpty then
      begin
        First;
        ActIncluirItemExecute(Sender);
        First;
        Delete;
        Sleep(500);
      end;
    end;
  finally
    TimerItens.Enabled := true;
  end;

end;

procedure TFrmEmiCupom.ActMenuFiscalExecute(Sender: TObject);
var aMensagem : String;
begin
  inherited;
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
  //
  if DmAcBr.ACBrECF1.Estado = estLivre then
  begin
    Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
    Try
       FrmMenuFiscal.ShowModal;
    Finally
       FrmMenuFiscal.Destroy;
    End;
  end;
end;

procedure TFrmEmiCupom.Verificarostatusdoservio1Click(Sender: TObject);
var formMensagem: TFormMensagem;
    auxbool : Boolean;
begin
  inherited;
  try
    formMensagem := TFormMensagem.Create('Aguarde... Verificando Status do serviço!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    auxbool := DmAcBr.ACBrNFe1.Configuracoes.WebServices.Visualizar;
    DmAcBr.ACBrNFe1.Configuracoes.WebServices.Visualizar := True;
    DmAcBr.ACBrNFe1.WebServices.StatusServico.Executar;
    DmAcBr.ACBrNFe1.Configuracoes.WebServices.Visualizar := auxbool;
  finally
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
  end;

end;

procedure TFrmEmiCupom.Inutilizarnumerao1Click(Sender: TObject);
var Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
begin
  inherited;
  try
    if not(InputQuery('WebServices Inutilização ', 'Ano',    Ano)) then
       exit;
    if not(InputQuery('WebServices Inutilização ', 'Modelo', Modelo)) then
       exit;
    if not(InputQuery('WebServices Inutilização ', 'Serie',  Serie)) then
       exit;
    if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroInicial)) then
       exit;
    if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroFinal)) then
       exit;
    if not(InputQuery('WebServices Inutilização ', 'Justificativa', Justificativa)) then
       exit;
    DmAcBr.ACBrNFe1.WebServices.Inutiliza(DmWorkCom.CdsEmpresaCNPJ_CPF.AsString, Justificativa, StrToInt(Ano), StrToInt(Modelo), StrToInt(Serie), StrToInt(NumeroInicial), StrToInt(NumeroFinal));
  except
    on E : Exception do ShowMessage(E.Message);
  end;

end;

procedure TFrmEmiCupom.ListadePedidos1Click(Sender: TObject);
begin
  inherited;
//fabricio
  ListaPedido:=true;
  sPAFNFCe:=3;
  ActFechamentoCupomExecute(Nil);

  //fabricio

end;

procedure TFrmEmiCupom.GerarArquivoPDV1Click(Sender: TObject);
begin
  inherited;
  if DataCupom.DataSet.RecordCount = 0 then
  begin
    OpenDialog1.Title := 'Selecione a NFE';
    OpenDialog1.DefaultExt := '*-nfe.XML';
    OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir := DmAcBr.ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
    DmAcBr.ACBrNFe1.NotasFiscais.Clear;
    if OpenDialog1.Execute then
       DmAcBr.ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    DmAcBr.ACBrNFe1.NotasFiscais.ImprimirPDF;
  end;
end;

procedure TFrmEmiCupom.ActEmitirCupomVidaLinkExecute(Sender: TObject);
var aNumItem, aMensagem : String;
begin
  inherited;
  if DmWorkCom.PAFECF.sControleECFAtivo > 0 then
  begin
    ShowMessage('Sistema bloqueado. Tenter entrar novamente!');
    exit;
  end;
  //
  if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
  begin
    ShowMessage(aMensagem);
    DmWorkCom.PAFECF.sControleECFAtivo := 2;
    Exit;
  end;
  //
  if (DataCupom.DataSet.RecordCount > 0) or
     (DmAcBr.ACBrECF1.Estado <> estLivre) then
  begin
    MessageDlg('É necessário fechar ou cancelar o cupom em aberto '+#13+#10+
               'antes de prosseguiur com esta operação!',mtWarning,[mbOK],0);
    EdtProduto.SetFocus;
    Abort;
  end;
  //
  Application.CreateForm(TFrmAutorizaVidaLink,FrmAutorizaVidaLink);
  try
    FrmAutorizaVidaLink.ShowModal;
    if FrmAutorizaVidaLink.sIDPedido > 0 then
    begin
      // emite o cupom fiscal
      DmWorkCom.Dados_Pedido(FrmAutorizaVidaLink.sIDPedido);
      DmWorkCom.Dados_PedidoItens(FrmAutorizaVidaLink.sIDPedido);
      if DataCupom.DataSet.RecordCount > 0 then
      begin
        if DataCupom.DataSet.FieldByName('COO').AsInteger = 0 then
        begin
          sDAV := true;
          ActIncluirCupomExecute(Sender);
          sDAV := false;
          DataItensCupom.DataSet.First;
          while not DataItensCupom.DataSet.Eof do
          begin
            // inclui o item na impressora fiscal
            DmProdutos.Dados_Produto(DataItensCupom.DataSet.FieldByName('IDPRODUTO').AsInteger);
            if DmWorkCom.RegistraItemECF(FloatToStr(DataItensCupom.DataSet.FieldByName('Quantidade').AsFloat)) then
            begin
              PnProduto.Caption := DataItensCupom.DataSet.FieldByName('descricao').AsString;
              ExibeDadosItem;
              TotalizaCupom;
              DmWorkCom.PAFECF.AtualizaINI(false);
              // verifica Item Cancelado
              if DataItensCupom.DataSet.FieldByName('CANCELADO').AsString = 'S' then
              begin
                aNumItem := IntToStr(DataItensCupom.DataSet.FieldByName('NUM_ITEM').AsInteger);
                aNumItem := ZeroEsquerda(aNumItem,3);
                DmWorkCom.PAFECF.CancelarItemCupom(aNumItem);
                Memo.Lines.Add('Item cancelado: '+aNumItem);
              end;
            end
            else
            begin
              messagedlg('Erro ao incluir item. Verifique!',mtWarning,[mbOK],0);
              MessageDlg('O cupom fiscal será cancelado!', mtWarning, [mbOK], 0);
              ActCancelarCupomExecute(Sender);
              Break;
            end;
            // proximo registro
            DataItensCupom.DataSet.Next;
          end;
        end
        else
        begin
          MessageDlg('Este pedido não pode ser impresso!!!', mtWarning, [mbOK], 0);
          DmWorkCom.Dados_Pedido(0);
          DmWorkCom.Dados_PedidoItens(0);
          Abort;
        end;
      end;
    end;
  finally
    FreeAndNil(FrmAutorizaVidaLink);
  end;

end;

procedure TFrmEmiCupom.ReemitirPedido1Click(Sender: TObject);
var
nuped: string;
begin
  inherited;
if InputQuery('Pesquisa','Informe o número do Pedido: ',nuped) then
try
DmWorkCom.ImprimirComprovanteNFrente(StrToInt(nuped));
except
on E:Exception do ShowMessage(E.Message);
end;


end;

procedure TFrmEmiCupom.ReenviarNFCecompendentes1Click(Sender: TObject);
begin
  inherited;
  if DataCupom.DataSet.RecordCount > 0 then
  begin
    MessageDlg('Existe um registro em aberto. Resolva antes de prosseguir!',mtWarning,[mbOK],0);
    EdtProduto.SetFocus;
    Abort;
  end;
  Application.CreateForm(TFrmNFCePendente,FrmNFCePendente);
  try
    FrmNFCePendente.sIDPedido := 0;
    FrmNFCePendente.ShowModal;
    if FrmNFCePendente.sIDPedido > 0 then
    begin
      if DmWorkCom.Dados_Pedido(FrmNFCePendente.sIDPedido) then
      begin
        RecuperarCupomFiscalAberto(DataCupom.DataSet.FieldByName('ID').AsInteger);
        GravaFormasPagamentoNaoConfirmada(DataCupom.DataSet.FieldByName('ID').AsInteger);
      end;
    end;
  finally
    FreeAndNil(FrmNFCePendente);
  end;
end;
//fabricio novo inicio reimprimir submenu do popmenu
procedure TFrmEmiCupom.ReImprimirNFCe1Click(Sender: TObject);
var defineimp : String;
    Handle: THandle; //fabricio
begin
  inherited;
  Application.CreateForm(TFrmNFCeEmitida,FrmNFCeEmitida);
  try
    FrmNFCeEmitida.sIDPedido := 0;
    FrmNFCeEmitida.ShowModal;
    if FrmNFCeEmitida.sIDPedido > 0 then
    begin
      if DmWorkCom.Dados_Pedido(FrmNFCeEmitida.sIDPedido) then
      begin
        if Confirmacao('Confirma a Reimpressão do pedido '+ IntToStr(FrmNFCeEmitida.sIDPedido)+ ' da NFCe Chave Nº: '+#13+#10+
                       DmWorkCom.CdsPedidosCHAVE_NFE.AsString) then
        begin
          // carrega o arquivo XML
          DmAcBr.ACBrNFe1.NotasFiscais.Clear;
          if DmWorkCom.LocalizaXMLBanco(MemoXML,DmWorkCom.CdsPedidosCHAVE_NFE.AsString) then
          begin
            DmAcBr.ACBrNFe1.NotasFiscais.Clear;
            DmAcBr.ACBrNFe1.NotasFiscais.LoadFromString(MemoXML.Text);
          end;
          //




                    defineimp := DmWorkCom.CdsConfig.FieldByName('IMPRESSORA').AsString;
                    if defineimp <> '' then
//                          DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= false;
//                          DmAcbr.ACBrNFeDANFCeFortes1.Impressora := defineimp;
//                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;

                    begin
                       if OpenPrinter(PChar(defineimp), Handle, nil) then
                       begin
                          DmAcbr.ACBrNFeDANFCeFortes1.Impressora := defineimp;
                          DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= false;
                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;
                       end
                       else
                       begin
                          DmAcbr.ACBrNFeDANFCeFortes1.Impressora := defineimp;
                          DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= true;
                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;
                       end;
                    end
                    else
                    begin
                       DmAcBr.ACBrNFeDANFCeFortes1.MostrarPreview:= true;
                       DmAcBr.ACBrNFe1.NotasFiscais.Items[0].Imprimir;
                    end;
        end
      end;
    end;
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoFP(0);
    DmWorkCom.Dados_PedidoItens(0);
  finally
    FreeAndNil(FrmNFCeEmitida);
  end;
end;

//fabricio novo fim

procedure TFrmEmiCupom.CancelamentoNFCe(pIDUsuarioCanc: Integer);
var idLote,vJustificativa, vChaveNFe, vProtocolo, vCNPJ : String;
begin
  inherited;
  if DataCupom.DataSet.RecordCount > 0 then
  begin
    if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
       DataCupom.DataSet.Edit;
    DataCupom.DataSet.FieldByName('IDUSUARIOCANC').AsInteger := pIDUsuarioCanc;
    DataCupom.DataSet.FieldByName('CANCELADO').AsString := 'S';
    Grava_Dados(DataCupom.DataSet);
    // limpa registro
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoFP(0);
    DmWorkCom.Dados_PedidoItens(0);
    TotalizaCupom;
    Memo.Lines.Clear;
    PnInforma.Caption := 'Caixa Livre';
    PnProduto.Caption := '';
    LbTroco.Caption   := '';
    sNotaManual := '';
    sNotaEletronica := '';
    // se for posto abre a tela de abastecimento
    if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
    begin
      ActAbastecimento.Execute;
    end
    else
    begin
      if DmWorkCom.PAFECF.gTXTAutomatico then
         ActImprimirDAV.Execute;
    end;
  end
  else
  begin
    Application.CreateForm(TFrmNFCeEmitida,FrmNFCeEmitida);
    try
      FrmNFCeEmitida.sIDPedido := 0;
      FrmNFCeEmitida.ShowModal;
      if FrmNFCeEmitida.sIDPedido > 0 then
      begin
        if DmWorkCom.Dados_Pedido(FrmNFCeEmitida.sIDPedido) then
        begin
          if Confirmacao('Confirma o cancelamento da NFCe Chave Nº: '+#13+#10+
                         DmWorkCom.CdsPedidosCHAVE_NFE.AsString) then
          begin
            vChaveNFe  := DmWorkCom.CdsPedidosCHAVE_NFE.AsString;
            vProtocolo := DmWorkCom.CdsPedidosPROTOCOLO_NFE.AsString;
            vCNPJ      := copy(vChaveNFe,7,14);
            idLote := FormatDateTime('mmss',now);
            vJustificativa := 'DESISTENCIA DO CLIENTE';
            //
            DmWorkCom.PAFECF.ExibeMensagem(0,'Cancelando a NFCe. Aguarde...');
            DmAcBr.ACBrNFe1.NotasFiscais.Clear;
            if DmWorkCom.LocalizaXMLBanco(MemoXML,DmWorkCom.CdsPedidosCHAVE_NFE.AsString) then
            begin
              DmAcBr.ACBrNFe1.NotasFiscais.LoadFromString(MemoXML.Text);
            end;
            DmAcBr.ACBrNFe1.EventoNFe.Evento.Clear;
            with DmAcBr.ACBrNFe1.EventoNFe.Evento.Add do
            begin
              if DmWorkCom.sAmbiente = 0 then
                 InfEvento.tpAmb := taProducao
              else
                 InfEvento.tpAmb := taHomologacao;
              infEvento.chNFe           := vChaveNFe;
              infEvento.CNPJ            := vCNPJ;
              InfEvento.cOrgao          := UFtoCUF(DmWorkCom.CdsEmpresaUF.AsString);
              infEvento.dhEvento        := now;
              infEvento.tpEvento        := teCancelamento;
              infEvento.detEvento.xJust := vJustificativa;
              infEvento.detEvento.nProt := vProtocolo;
            end;
            // Envia o comando
            try
              DmAcBr.ACBrNFe1.EnviarEvento(StrToInt(idLote));
              DmWorkCom.Grava_CancelamentoNFCe(vChaveNFe,
                                               IntToStr(DmAcBr.ACBrNFe1.WebServices.EnvEvento.cStat));
              ShowMessage('Cancelamento da NFC-e ok, favor cancelar o Pedido '+IntToStr(FrmNFCeEmitida.sIDPedido)+' no Gestor do Sistema para ajustar o estoque');
              DmWorkCom.Dados_Pedido(0);
              DmWorkCom.Dados_PedidoFP(0);
              DmWorkCom.Dados_PedidoItens(0);
              PnInforma.Caption := 'Caixa Livre';
              sNotaManual := '';
              sNotaEletronica := '';
              // se for posto abre a tela de abastecimento
              if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
              begin
                ActAbastecimento.Execute;
              end
              else
              begin
                if DmWorkCom.PAFECF.gTXTAutomatico then
                   ActImprimirDAV.Execute;
              end;
            except
               on e : exception do showmessage(e.message);
            end;
          end
        end;
      end;
      DmWorkCom.Dados_Pedido(0);
      DmWorkCom.Dados_PedidoFP(0);
      DmWorkCom.Dados_PedidoItens(0);
    finally
      FreeAndNil(FrmNFCeEmitida);
    end;
  end;

end;

procedure TFrmEmiCupom.Emitircupomfiscaldenotamanual1Click(
  Sender: TObject);
begin
  inherited;
  sNotaManual := '';
  if InputQuery('Registro de nota manual','Nº da Nota:',sNotaManual) then
  begin
    if Trim(sNotaManual) = '' then
    begin
      MessageDlg('É necessário informar um numero!',mtWarning,[mbOK],0);
      sNotaManual := '';
      Abort;
    end;
    if FiltraNumero(sNotaManual) = '' then
    begin
      MessageDlg('O número informado não é valido. Verifique!',mtWarning,[mbOK],0);
      sNotaManual := '';
      Abort;
    end;
    if DmWorkCom.VerificaNotaManualEmitida(sNotaManual) then
    begin
      MessageDlg('O nota informada já esta emitida. Verifique!',mtWarning,[mbOK],0);
      sNotaManual := '';
      Abort;
    end;
    ActIncluirCupomExecute(Sender);
  end;
end;

procedure TFrmEmiCupom.EmitirEmailparadaNFCe1Click(Sender: TObject);
var Email : String;
begin
  inherited;
  Application.CreateForm(TFrmNFCeEmitida,FrmNFCeEmitida);
  try
    FrmNFCeEmitida.sIDPedido := 0;
    FrmNFCeEmitida.ShowModal;
    if FrmNFCeEmitida.sIDPedido > 0 then
    begin
      if DmWorkCom.Dados_Pedido(FrmNFCeEmitida.sIDPedido) then
      begin
        if Confirmacao('Confirma o envio do email da NFCe Chave Nº: '+#13+#10+
                       DmWorkCom.CdsPedidosCHAVE_NFE.AsString) then
        begin
          // carrega o arquivo XML
          DmAcBr.ACBrNFe1.NotasFiscais.Clear;
          if DmWorkCom.LocalizaXMLBanco(MemoXML,DmWorkCom.CdsPedidosCHAVE_NFE.AsString) then
          begin
            DmAcBr.ACBrNFe1.NotasFiscais.Clear;
            DmAcBr.ACBrNFe1.NotasFiscais.LoadFromString(MemoXML.Text);
          end;
          //
          Email := InputBox('Envio de E-mail','Informe o email a ser enviado:','');
          if Trim(Email) <> '' then
          begin
            if not ValidaEmail(Email) then
            begin
              MessageDlg('O email informado é inválido!!!', mtWarning, [mbOK], 0);
              Exit;
            end;
            DmWorkCom.EnviarEmailNFCe(Email,DmWorkCom.CdsPedidosCHAVE_NFE.AsString);
          end;
        end
      end;
    end;
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoFP(0);
    DmWorkCom.Dados_PedidoItens(0);
  finally
    FreeAndNil(FrmNFCeEmitida);
  end;
end;

procedure TFrmEmiCupom.VerificaNotaEmContingencia;
begin
  if (sPAFNFCe = 1) and (DmWorkCom.sFormas = 1) then
  begin
    if DmWorkCom.VerificaNFeContingencia then
    begin
      Application.CreateForm(TFrmMensageemProd,FrmMensageemProd);
      try
        FrmMensageemProd.PnMensagem.Caption := 'Existe notas emitidas em contingência pendente de envio!';
        FrmMensageemProd.ShowModal;
      finally
        FreeAndNil(FrmMensageemProd);
      end;
    end;
  end;

end;

procedure TFrmEmiCupom.EmitirNFCeemcontingncia1Click(Sender: TObject);
begin
  inherited;
  if DmWorkCom.sFormas = 1 then
  begin
    try
      Application.CreateForm(TFrmListaContigencia,FrmListaContigencia);
      FrmListaContigencia.ShowModal;
      DmWorkCom.Dados_Pedido(0);
      DmWorkCom.Dados_PedidoItens(0);
      DmWorkCom.Dados_PedidoFP(0);
    finally
      FreeAndNil(FrmListaContigencia);
    end;
  end;

end;

procedure TFrmEmiCupom.CancelamentoSAT(pIDUsuarioCanc: Integer);
var aIDPedido : Integer;
begin
  if DataCupom.DataSet.RecordCount > 0 then
  begin
    if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
       DataCupom.DataSet.Edit;
    DataCupom.DataSet.FieldByName('IDUSUARIOCANC').AsInteger := pIDUsuarioCanc;
    DataCupom.DataSet.FieldByName('CANCELADO').AsString := 'S';
    Grava_Dados(DataCupom.DataSet);
    // limpa registro
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoFP(0);
    DmWorkCom.Dados_PedidoItens(0);
    TotalizaCupom;
    Memo.Lines.Clear;
    PnInforma.Caption := 'Caixa Livre';
    PnProduto.Caption := '';
    LbTroco.Caption   := '';
    sNotaManual := '';
    sNotaEletronica := '';
    // se for posto abre a tela de abastecimento
    if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
    begin
      ActAbastecimento.Execute;
    end
    else
    begin
      if DmWorkCom.PAFECF.gTXTAutomatico then
         ActImprimirDAV.Execute;
    end;
  end
  else
  begin
    if Confirmacao('Confirma o cancelamento da ultima venda?') then
    begin
      DmWorkCom.PAFECF.ExibeMensagem(0,'Cancelando a venda SAT. Aguarde...');
      // Envia o comando
      try
        aIDPedido := DmWorkCom.RetornaUltimaVenda;
        if DmWorkCom.Dados_Pedido(aIDPedido) then
        begin
          if DataCupom.DataSet.FieldByName('CANCELADO').AsString = 'N' then
          begin
            DmAcBr.ACBrSAT1.CancelarUltimaVenda;
            // grava dados do cancelamento
            if not(DataCupom.DataSet.State in [dsInsert,dsEdit]) then
               DataCupom.DataSet.Edit;
            DataCupom.DataSet.FieldByName('IDUSUARIOCANC').AsInteger  := pIDUsuarioCanc;
            DataCupom.DataSet.FieldByName('STATUS_ABASTEC').AsInteger := 0;
            DataCupom.DataSet.FieldByName('CANCELADO').AsString       := 'S';
            Grava_Dados(DataCupom.DataSet);
            // retorna produtos para o estoque
            if DataCupom.DataSet.FieldByName('CONFIRMADA').AsString = 'S' then
            begin
              DmWorkCom.Dados_PedidoItens(DataCupom.DataSet.FieldByName('ID').AsInteger);
              DmWorkCom.Movimenta_Estoque(1,DataItensCupom.DataSet);
            end;
          end
          else MessageDlg('A última venda já esta cancelada.',mtWarning,[mbOK],0);
        end;
        DmWorkCom.Dados_Pedido(0);
        DmWorkCom.Dados_PedidoFP(0);
        DmWorkCom.Dados_PedidoItens(0);
        PnInforma.Caption := 'Caixa Livre';
//fabricioinicio
        ListaPedido:=false;
//fabriciofim

        sNotaManual := '';
        sNotaEletronica := '';
        // se for posto abre a tela de abastecimento
        if (DmWorkCom.sPostoAutomatico = 'S') and (sPAFNFCe = 0) then
        begin
          ActAbastecimento.Execute;
        end
        else
        begin
          if DmWorkCom.PAFECF.gTXTAutomatico then
             ActImprimirDAV.Execute;
        end;
      except
         on e : exception do showmessage(e.message);
      end;
    end;
    DmWorkCom.Dados_Pedido(0);
    DmWorkCom.Dados_PedidoFP(0);
    DmWorkCom.Dados_PedidoItens(0);
  end;

end;

end.
