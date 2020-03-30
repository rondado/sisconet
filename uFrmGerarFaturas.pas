unit uFrmGerarFaturas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uFrmPadrao, Vcl.StdCtrls, Vcl.ExtCtrls, Datasnap.Provider, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBCtrls, ACBrBoleto, frxClass, frxDBSet, Data.FMTBcd,
  Data.SqlExpr;

type
  TFrmGerarFaturas = class(TFrmPadrao)
    DsContas: TDataSource;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    EdtLocalizar: TEdit;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    Label1: TLabel;
    à: TLabel;
    BtnLocalizar: TBitBtn;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    CbxBanco: TDBLookupComboBox;
    Dsbancos: TDataSource;
    BtnAdicionar: TBitBtn;
    BtnImprimir: TBitBtn;
    BtnRemessa: TBitBtn;
    BtnRetorno: TBitBtn;
    OpenDialog1: TOpenDialog;
    DsClientes: TDataSource;
    CbxLayout: TComboBox;
    Label9: TLabel;
    Label2: TLabel;
    BtnQuitarManual: TBitBtn;
    BtnQuitarLeitor: TBitBtn;
    Rdopcao1: TRadioGroup;
    Rdopcao2: TRadioGroup;
    ChVencidas: TCheckBox;
    ChTipoData: TCheckBox;
    BtnRelatorio: TBitBtn;
    frxReport1: TfrxReport;
    frxDBCobranca: TfrxDBDataset;
    frxDBEmpresa: TfrxDBDataset;
    DsEmpresa: TDataSource;
    DspContas: TDataSetProvider;
    CdsContas: TClientDataSet;
    CdsContasID: TIntegerField;
    CdsContasIDCONTATO: TIntegerField;
    CdsContasDATA_LANC: TSQLTimeStampField;
    CdsContasORIGEM: TIntegerField;
    CdsContasIDPEDIDO: TIntegerField;
    CdsContasTIPO: TIntegerField;
    CdsContasNUMCONTA: TStringField;
    CdsContasSERIE: TIntegerField;
    CdsContasDATA_VENC: TSQLTimeStampField;
    CdsContasDATA_QUIT: TSQLTimeStampField;
    CdsContasVALOR_CONTA: TFloatField;
    CdsContasVALOR_DESCONTO: TFloatField;
    CdsContasVALOR_ACRESCIMO: TFloatField;
    CdsContasVALOR_QUITATO: TFloatField;
    CdsContasSTATUS: TIntegerField;
    CdsContasCONTATO: TStringField;
    CdsContasDOC_CONTATO: TStringField;
    CdsContasJUROS: TFloatField;
    CdsContasMULTA: TFloatField;
    CdsContasIDOS: TIntegerField;
    CdsContasIDEMPRESA: TIntegerField;
    CdsContasIDCTAVINCULADA: TIntegerField;
    CdsContasNOSSO_NUMERO: TStringField;
    CdsContasBOLETO_IMPRESSO: TStringField;
    CdsContasREMESSA_ENVIADA: TStringField;
    CdsContasPARCELAS: TIntegerField;
    CdsContasCNPJ_CPF: TStringField;
    CdsContasENDERECO: TStringField;
    CdsContasNUM_END: TStringField;
    CdsContasBAIRRO_END: TStringField;
    CdsContasCIDADE_END: TStringField;
    CdsContasUF_END: TStringField;
    CdsContasCEP_END: TStringField;
    SQLContas: TSQLDataSet;
    CdsContasIDFORMA_PAGTO: TIntegerField;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnRemessaClick(Sender: TObject);
    procedure BtnRetornoClick(Sender: TObject);
    procedure CbxBancoClick(Sender: TObject);
    procedure CbxBancoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CbxLayoutChange(Sender: TObject);
    procedure BtnQuitarManualClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BtnQuitarLeitorClick(Sender: TObject);
    procedure Rdopcao1Click(Sender: TObject);
    procedure BtnRelatorioClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    xDigitos : Integer;
    procedure AbreDadosCobranca;
    procedure InsereConta(IDCliente,Parcelas,DiasVenc,NossoNum:Integer;NumDoc:String;ValorParc:Double);
    function InsereContaComponente(Impressao:Boolean):Boolean;
    function InsereContaUnicaComponente(Impressao:Boolean):Boolean;
    procedure ConfiguraComponenteAcBr(LayoutBoleto:Integer);
    procedure ImprimirReciboQuitado(ValorPago:Double);
    procedure DesabilitaBotoes;

  public
    { Public declarations }
  end;

var
  FrmGerarFaturas: TFrmGerarFaturas;

implementation

{$R *.dfm}

uses uLibrary, uDmAcbr, uFrmDadosCobranca, uRelQuita44Col,
  uFrmLeCodigo, uDmWorkCom, uDMClientes, uDmConexao, unImpro;

procedure TFrmGerarFaturas.AbreDadosCobranca;
var Comando : String;
begin
  if not ChTipoData.Checked then
  begin
    Comando := 'select c.*,x.cnpj_cpf,x.endereco,x.num_end,x.bairro_end, '+
               '       x.cidade_end,x.uf_end,x.cep_end '+
               'from contas c '+
               'inner join contato x on c.idcontato = x.id '+
               'where c.data_lanc between ' +QuotedStr(FormatDateTime('dd.mm.yyyy',Datai.Date))+' and '+
                                              QuotedStr(FormatDateTime('dd.mm.yyyy',Dataf.Date))+' '+
               'and c.contato like '+QuotedStr(UpperCase(EdtLocalizar.Text)+'%')+' ';
  end
  else
  begin
    Comando := 'select c.*,x.cnpj_cpf,x.endereco,x.num_end,x.bairro_end, '+
               '       x.cidade_end,x.uf_end,x.cep_end '+
               'from contas c '+
               'inner join contato x on c.idcontato = x.id '+
               'where c.data_venc between ' +QuotedStr(FormatDateTime('dd.mm.yyyy',Datai.Date))+' and '+
                                              QuotedStr(FormatDateTime('dd.mm.yyyy',Dataf.Date))+' '+
               'and c.contato like '+QuotedStr(UpperCase(EdtLocalizar.Text)+'%')+' ';
  end;
  case Rdopcao1.ItemIndex of
    0: Comando := Comando + 'and c.valor_quitato <= 0 ';
    1: Comando := Comando + 'and c.valor_quitato > 0 ';
  end;
  case Rdopcao2.ItemIndex of
    0: Comando := Comando + 'and c.boleto_impresso = '+QuotedStr('S')+' ';
    1: Comando := Comando + 'and c.remessa_enviada = '+QuotedStr('S')+' ';
  end;
  if ChVencidas.Checked then
     Comando := Comando + 'and c.data_venc <= current_date';
  //
  with CdsContas do
  begin
    Close;
    CommandText := Comando;
    Open;
  end;
  DBGrid1.SetFocus;

end;

procedure TFrmGerarFaturas.BitBtn1Click(Sender: TObject);
Var
comando: string;
begin
  inherited;

  Comando := 'select c.*,x.cnpj_cpf,x.endereco,x.num_end,x.bairro_end, '+
               '       x.cidade_end,x.uf_end,x.cep_end '+
               'from contas c '+
               'inner join contato x on c.idcontato = x.id '+
               'where c.numconta =  ' + CdsContasNUMCONTA.AsString;

with CdsContas do
  begin
    Close;
    CommandText := Comando;
    Open;
  end;


  if not CdsContas.IsEmpty then
  begin
{
    CdsContas.First;
    while not CdsContas.Eof do
    begin
      CdsContas.Next;
    end;
}
      if Confirmacao ('Deseja Imprimir sem a confirmação de um avalista?') then
      begin
      frmImpro.QRLabel5.Enabled:=false;
      frmImpro.QRLabel7.Enabled:=false;
      frmImpro.QRLabel6.Enabled:=false;
      frmImpro.QRLabel8.Enabled:=false;
      frmImpro.QRLabel41.Enabled:=false;
      frmImpro.QRLabel10.Enabled:=false;
      frmImpro.QRLabel9.Enabled:=false;
      frmImpro.QRLabel12.Enabled:=false;
      frmImpro.QRLabel13.Enabled:=false;
      end
      else
      begin
      frmImpro.QRLabel5.Enabled:=true;
      frmImpro.QRLabel7.Enabled:=true;
      frmImpro.QRLabel6.Enabled:=true;
      frmImpro.QRLabel8.Enabled:=true;
      frmImpro.QRLabel41.Enabled:=true;
      frmImpro.QRLabel10.Enabled:=true;
      frmImpro.QRLabel9.Enabled:=true;
      frmImpro.QRLabel12.Enabled:=true;
      frmImpro.QRLabel13.Enabled:=true;

      end;


      frmImpro.QuickRep1.Preview;

  end;
AbreDadosCobranca;
end;

procedure TFrmGerarFaturas.BtnAdicionarClick(Sender: TObject);
begin
  inherited;
  if CbxBanco.Text = '' then
  begin
    MessageDlg('É necessário selecionar o banco!',mtWarning,[mbOK],0);
    Exit;
  end;
  // selecionar o cliente
  try
    Application.CreateForm(TFrmDadosCobranca,FrmDadosCobranca);
    with FrmDadosCobranca do
    begin
      ShowModal;
      if sIDCliente > 0 then
      begin
        // processa a geração das cobranças
        InsereConta(sIDCliente,
                    StrToInt(EdtParcelas.Text),
                    StrToInt(EdtDiaVenc.Text),
                    Dsbancos.DataSet.FieldByName('NOSSO_NUMERO').AsInteger,
                    EdtNumDoc.Text,
                    sValorParc);
      end;
      AbreDadosCobranca;
    end;

  finally
    FreeAndNil(FrmDadosCobranca);
  end;

end;

procedure TFrmGerarFaturas.BtnImprimirClick(Sender: TObject);
var aOK : Boolean;
begin
  inherited;
  if CbxBanco.Text = '' then
  begin
    MessageDlg('É necessário selecionar o banco!',mtWarning,[mbOK],0);
    Exit;
  end;
  //
  if not CdsContas.IsEmpty then
  begin
    aOK := false;
    if Confirmacao('Deseja imprimir apenas o boleto selecionado?') then
       aOK := InsereContaUnicaComponente(True)
    else
       aOK := InsereContaComponente(True);
    //
    if aOK then
    begin
      try
        DmAcbr.ACBrBoleto1.Imprimir;
      except
        on E:Exception do
        begin
          MessageDlg(E.Message,mtWarning,[mbOK],0);
        end;
      end;
    end;
  end;
end;

procedure TFrmGerarFaturas.BtnQuitarLeitorClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmLeCodigo,FrmLeCodigo);
    FrmLeCodigo.ShowModal;
    if Trim(FrmLeCodigo.EdtCodigo.Text) <> '' then
    begin

    end;
  finally
    FreeAndNil(FrmLeCodigo);
  end;
end;

procedure TFrmGerarFaturas.BtnQuitarManualClick(Sender: TObject);
var aValorPago : Double;
    auxValor : String;
begin
  inherited;
  if not CdsContas.IsEmpty then
  begin
    if CdsContas.FieldByName('VALOR_QUITATO').AsFloat > 0 then
    begin
      ShowMessage('O documento selecionado já esta quitado!!');
      Exit;
    end;
    auxValor := '';
    if InputQuery('Quitação de documentos','Valor pago',auxValor) then
    begin
      try
        aValorPago := StrToFloat(auxValor);
        if aValorPago <= 0 then
        begin
          ShowMessage('O valor precisa ser maior que zero!');
          Exit;
        end;
      except
        ShowMessage('O Valor informádo é inválido!');
        Exit;
      end;
    end;
    //
    if Confirmacao('Confirma a quitação do documento '+CdsContas.FieldByName('NUMCONTA').AsString+'/'+
                                                       CdsContas.FieldByName('SERIE').AsString+' de '+#13+#10+
                                                       CdsContas.FieldByName('CONTATO').AsString+'?') then
    begin
      DmWorkCom.GravaQuitacaoDocumento(CdsContas.FieldByName('ID').AsInteger,aValorPago);
      ImprimirReciboQuitado(aValorPago);
      AbreDadosCobranca;

    end;
  end;

end;

procedure TFrmGerarFaturas.BtnRelatorioClick(Sender: TObject);
begin
  inherited;
  if not CdsContas.IsEmpty then
  begin
    frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\Faturas.fr3');
    frxReport1.ShowReport;
  end;

end;

procedure TFrmGerarFaturas.BtnRemessaClick(Sender: TObject);
var ContadorRemessa : Integer;
begin
  inherited;
  if CbxBanco.Text = '' then
  begin
    MessageDlg('É necessário selecionar o banco!',mtWarning,[mbOK],0);
    Exit;
  end;
  //
  if not CdsContas.IsEmpty then
  begin
    if Confirmacao('Confirma a geração da remessa dos documentos listados?') then
    begin
      if InsereContaComponente(False) then
      begin
        try
          // captura o contador de remessa e gera a mesma
          ContadorRemessa := DmWorkCom.sCONT_REMESSA;
          Inc(ContadorRemessa);
          DmAcbr.ACBrBoleto1.GerarRemessa(ContadorRemessa);
          // Atualiza o contador de remesa na tabela de configuração
          DmWorkCom.GravaContadorRemessa(ContadorRemessa);
        except
          MessageDlg('Erro ao gerar arquivo de remessa. Verifique!',mtWarning,[mbOK],0);
        end;
      end;
    end;
  end;
end;

procedure TFrmGerarFaturas.BtnRetornoClick(Sender: TObject);
var i : Integer;
begin
  inherited;
  if CbxBanco.Text = '' then
  begin
    MessageDlg('É necessário selecionar o banco!',mtWarning,[mbOK],0);
    Exit;
  end;
  //
  if not CdsContas.IsEmpty then
  begin
    if OpenDialog1.Execute then
    begin
      if FileExists(OpenDialog1.FileName) then
      begin
        DmAcbr.ACBrBoleto1.ListadeBoletos.Clear;
        DmAcbr.ACBrBoleto1.DirArqRetorno := ExtractFilePath(OpenDialog1.FileName);
        DmAcbr.ACBrBoleto1.NomeArqRetorno := ExtractFileName(OpenDialog1.FileName);
        DmAcbr.ACBrBoleto1.LerRetorno;
        for i := 0 to DmAcbr.ACBrBoleto1.ListadeBoletos.Count-1 do
        begin
          if DmAcbr.ACBrBoleto1.ListadeBoletos.Objects[i].ValorRecebido > 0 then
          begin
            // Grava a Quitação da conta
            DmWorkCom.GravaQuitacaoConta(DmAcbr.ACBrBoleto1.ListadeBoletos.Objects[i].DataBaixa,
                                         DmAcbr.ACBrBoleto1.ListadeBoletos.Objects[i].ValorRecebido,
                                         DmAcbr.ACBrBoleto1.ListadeBoletos.Objects[i].NossoNumero);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmGerarFaturas.CbxBancoClick(Sender: TObject);
begin
  inherited;
  ConfiguraComponenteAcBr(CbxLayout.ItemIndex);
end;

procedure TFrmGerarFaturas.CbxBancoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    ConfiguraComponenteAcBr(CbxLayout.ItemIndex);
end;

procedure TFrmGerarFaturas.CbxLayoutChange(Sender: TObject);
begin
  inherited;
  ConfiguraComponenteAcBr(CbxLayout.ItemIndex);

end;

procedure TFrmGerarFaturas.ConfiguraComponenteAcBr(LayoutBoleto:Integer);
begin
  with DmAcbr.ACBrBoleto1 do
  begin
    ACBrBoletoFC.DirLogo  := DmWorkCom.sPATH_LOGOTIPO;
    ACBrBoletoFC.Filtro   := fiNenhum;
    case LayoutBoleto of
      0: ACBrBoletoFC.LayOut := lPadrao;
      1: ACBrBoletoFC.LayOut := lCarne;
      2: ACBrBoletoFC.LayOut := lFatura;
      3: ACBrBoletoFC.LayOut := lPadraoEntrega;
    end;
    if Dsbancos.DataSet.FieldByName('LAYOUT_REMESSA').AsString = 'c240' then
       LayoutRemessa      := c240
    else if Dsbancos.DataSet.FieldByName('LAYOUT_REMESSA').AsString = 'c400' then
       LayoutRemessa      := c400;
    case Dsbancos.DataSet.FieldByName('TIPO_COBRANCA').AsInteger of
       0: Banco.TipoCobranca := cobNenhum;
       1: Banco.TipoCobranca := cobBancoDoBrasil;
       2: Banco.TipoCobranca := cobSantander;
       3: Banco.TipoCobranca := cobCaixaEconomica;
       4: Banco.TipoCobranca := cobCaixaSicob;
       5: Banco.TipoCobranca := cobBradesco;
       6: Banco.TipoCobranca := cobItau;
       7: Banco.TipoCobranca := cobBancoMercantil;
       8: Banco.TipoCobranca := cobSicred;
       9: Banco.TipoCobranca := cobBancoob;
      10: Banco.TipoCobranca := cobBanrisul;
      11: Banco.TipoCobranca := cobBanestes;
      12: Banco.TipoCobranca := cobHSBC;
      13: Banco.TipoCobranca := cobBancoDoNordeste;
      14: Banco.TipoCobranca := cobBRB;
      15: Banco.TipoCobranca := cobBicBanco;
      16: Banco.TipoCobranca := cobBradescoSICOOB;
      17: Banco.TipoCobranca := cobBancoSafra;
      18: Banco.TipoCobranca := cobSafraBradesco;
      19: Banco.TipoCobranca := cobBancoCECRED;
    end;
    Cedente.Nome          := Dsbancos.DataSet.FieldByName('CEDENTE').AsString;
    Cedente.CNPJCPF       := DmWorkCom.CdsEmpresa.FieldByName('CNPJ_CPF').AsString;
    Cedente.CodigoCedente := Dsbancos.DataSet.FieldByName('COD_CEDENTE').AsString;
    Cedente.Agencia       := Dsbancos.DataSet.FieldByName('NUMERO_AGENCIA').AsString;
    Cedente.AgenciaDigito := Dsbancos.DataSet.FieldByName('DIGITO_AGENCIA').AsString;
    Cedente.Conta         := Dsbancos.DataSet.FieldByName('NUMERO_CONTA').AsString;
    Cedente.ContaDigito   := Dsbancos.DataSet.FieldByName('DIGITO_CONTA').AsString;
    Cedente.UF            := Dsbancos.DataSet.FieldByName('UF_AGENCIA').AsString;
    DirArqRemessa         := ExtractFilePath(DmWorkCom.sPATH_REMESSA);
    NomeArqRemessa        := ExtractFileName(FormatDateTime('DDMMYYYYHHMMSS',Now)+'.TXT');
    xDigitos := Banco.TamanhoMaximoNossoNum;
  end;

end;

procedure TFrmGerarFaturas.DBGrid1DrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  DBGrid1.Canvas.Brush.Color:= clWhite;
  DBGrid1.Canvas.Font.Color:= clBlack;
  if DBGrid1.SelectedRows.CurrentRowSelected then
  begin
    DBGrid1.Canvas.Brush.Color:= clYellow;
  end;
  if CdsContas.FieldByName('DATA_VENC').AsDateTime < Now then
  begin
     DBGrid1.Canvas.Font.Color:= clRed;
  end;
  if CdsContas.FieldByName('VALOR_QUITATO').AsFloat > 0 then
  begin
     DBGrid1.Canvas.Font.Color:= clGreen;
  end;
  //
  DBGrid1.Canvas.FillRect(Rect);
  DBGrid1.DefaultDrawDataCell(Rect, DBGrid1.columns[datacol].field, State);
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);


end;

procedure TFrmGerarFaturas.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_INSERT then
  begin
  end;
  if Key = VK_RETURN then
  begin
  end;
  if Key = VK_DELETE then
  begin
    if CdsContas.FieldByName('VALOR_QUITATO').AsFloat > 0 then
    begin
      ShowMessage('O documento selecionado já esta quitado!!');
      Exit;
    end;
    //
    if Confirmacao('Confirma a exclusão da cobrança selecionado?') then
    begin
      if DmWorkCom.Dados_Contas(CdsContas.FieldByName('ID').AsInteger) then
      begin
        DmWorkCom.CdsContas.Delete;
        Grava_Dados(DmWorkCom.CdsContas);
        AbreDadosCobranca;
      end;
    end;
  end;

end;

procedure TFrmGerarFaturas.DesabilitaBotoes;
begin
  BtnAdicionar.Enabled := true;
  BtnImprimir.Enabled := true;
  BtnRemessa.Enabled := true;
  BtnRetorno.Enabled := true;
  BtnQuitarManual.Enabled := true;
  BtnQuitarLeitor.Enabled := true;
  if sNivelUsuario = 2 then // intermediario
  begin
    BtnAdicionar.Enabled := false;
  end;
  if sNivelUsuario = 3 then // basico
  begin
    BtnAdicionar.Enabled := false;
    BtnRemessa.Enabled := false;
    BtnRetorno.Enabled := false;
    BtnQuitarManual.Enabled := false;
  end;

end;

procedure TFrmGerarFaturas.EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
     AbreDadosCobranca;
end;

procedure TFrmGerarFaturas.FormShow(Sender: TObject);
begin
  inherited;
  Dsbancos.DataSet := DmWorkCom.CdsBancos;
  DmWorkCom.Dados_Banco;
  DsClientes.DataSet := DmClientes.CdsContatos;
  DsEmpresa.DataSet := DmWorkCom.CdsEmpresa;
  DmWorkCom.Dados_Empresa(sIDEmpresa);
  DsContas.DataSet := CdsContas;
  DesabilitaBotoes;
  Datai.Date := Now;
  Dataf.Date := Now;
  AbreDadosCobranca;

end;

procedure TFrmGerarFaturas.ImprimirReciboQuitado(ValorPago:Double);
var aTexto : String;
begin
  DmAcbr.ACBrExtenso1.Valor := ValorPago;
  aTexto := 'Recebemos de '+CdsContas.FieldByName('CONTATO').AsString+', a importância de R$'+
            FormatFloat('0.00',ValorPago)+' '+DmAcbr.ACBrExtenso1.Texto+
            ', referente a quitação do documento Nº '+CdsContas.FieldByName('NUMCONTA').AsString+
            ' parcela '+CdsContas.FieldByName('SERIE').AsString+', com vencimento em '+
            FormatDateTime('dd/mm/yyyy', CdsContas.FieldByName('DATA_VENC').AsDateTime)+'.';
  //
  try
    DmWorkCom.Dados_Empresa(sIDEmpresa);
    Application.CreateForm(TFRelQuita44Col,FRelQuita44Col);
    FRelQuita44Col.LbTexto.Lines.Clear;
    FRelQuita44Col.LbTexto.Lines.Add(aTexto);
    FRelQuita44Col.LbRazao.Caption := DmWorkCom.CdsEmpresaRAZAO_SOCIAL.AsString;
    FRelQuita44Col.LbEndereco.Caption := Trim(DmWorkCom.CdsEmpresaENDERECO.AsString)+','+
                                         DmWorkCom.CdsEmpresaNUMERO.AsString+'-'+
                                         Trim(DmWorkCom.CdsEmpresaBAIRRO.AsString);
    FRelQuita44Col.LbCidadeUF.Caption := Trim(DmWorkCom.CdsEmpresaCIDADE.AsString)+'-'+DmWorkCom.CdsEmpresaUF.AsString;
    FRelQuita44Col.LbCNPJ.Caption := 'CNPJ: '+DmWorkCom.CdsEmpresaCNPJ_CPF.AsString;
    FRelQuita44Col.LbLocalData.Caption := Trim(DmWorkCom.CdsEmpresaCIDADE.AsString)+', '+FormatDateTime('dd/mmm/yyyy',Now);
    FRelQuita44Col.RlQuitacao.Prepare;
//    FRelQuita44Col.RlQuitacao.Preview;
    FRelQuita44Col.RlQuitacao.Print;
  finally
    FreeAndNil(FRelQuita44Col);
  end;

end;

procedure TFrmGerarFaturas.InsereConta(IDCliente,Parcelas,DiasVenc,NossoNum:Integer;
  NumDoc:String;ValorParc:Double);
var ContParcelas, ContNossoNum : Integer;
    DataVenc : TDateTime;
    Dia,Mes,Ano : Word;
    Cliente, Endereco, Numero, Complemento, Bairro, Cidade, Cep,
    UF, Cnpj_cpf, Inscricao_rg : String;
begin
  // captura os dados do cliente
  if DmClientes.Dados_Contato(IDCliente) then
  begin
    Cliente      := DmClientes.CdsContatosNOME.AsString;
    Endereco     := DmClientes.CdsContatosENDERECO.AsString;
    Numero       := DmClientes.CdsContatosNUM_END.AsString;
    Complemento  := DmClientes.CdsContatosCOMPL_ENT.AsString;
    Bairro       := DmClientes.CdsContatosBAIRRO_END.AsString;
    Cidade       := DmClientes.CdsContatosCIDADE_END.AsString;
    Cep          := DmClientes.CdsContatosCEP_END.AsString;
    UF           := DmClientes.CdsContatosUF_END.AsString;
    Cnpj_cpf     := DmClientes.CdsContatosCNPJ_CPF.AsString;
    Inscricao_rg := DmClientes.CdsContatosINSC_RG.AsString;
  end;
  // prepara a data
  DecodeDate(now,ano,mes,dia);
  dia := DiasVenc;
  // gera as contas
  ContNossoNum := NossoNum;
  for ContParcelas := 1 to Parcelas do
  begin
    Mes := Mes + 1;
    if Mes > 12 then
    begin
      Ano := Ano + 1;
      Mes := 1;
    end;
    DataVenc := EncodeDate(Ano,Mes,Dia);
    ContNossoNum := ContNossoNum + 1;
    //
    DmWorkCom.Dados_Contas(0);
    with DmWorkCom.CdsContas do
    begin
      Append;
      FieldByName('IDCONTATO').AsInteger      := IDCliente;
      FieldByName('TIPO').AsInteger           := 0;
      FieldByName('NUMCONTA').AsString        := NumDoc;
      FieldByName('SERIE').AsInteger          := ContParcelas;
      FieldByName('DATA_VENC').AsDateTime     := DataVenc;
      FieldByName('VALOR_CONTA').AsFloat      := ValorParc;
      FieldByName('VALOR_DESCONTO').AsFloat   := 0;
      FieldByName('VALOR_ACRESCIMO').AsFloat  := 0;
      FieldByName('VALOR_QUITATO').AsFloat    := 0;
      FieldByName('CONTATO').AsString         := Cliente;
      FieldByName('DOC_CONTATO').AsString     := Cnpj_cpf;
      FieldByName('JUROS').AsFloat            := 0;
      FieldByName('MULTA').AsFloat            := 0;
      FieldByName('IDEMPRESA').AsInteger      := sIDEmpresa;
      FieldByName('NOSSO_NUMERO').AsString    := ZeroEsquerda(IntToStr(ContNossoNum),xDigitos);
      FieldByName('PARCELAS').AsInteger       := Parcelas;
      FieldByName('BOLETO_IMPRESSO').AsString := 'N';
      FieldByName('REMESSA_ENVIADA').AsString := 'N';
    end;
    Grava_Dados(DmWorkCom.CdsContas);
  end;
  // atualiza Nosso Numero no Cad Banco
  DmWorkCom.GravaNossoNumBanco(Dsbancos.DataSet.FieldByName('ID').AsInteger,ContNossoNum);

end;

function TFrmGerarFaturas.InsereContaComponente(Impressao:Boolean):Boolean;
var Titulo : TACBrTitulo;
    Adicionar : Boolean;
begin
  Result := true;
  try
    DmAcbr.ACBrBoleto1.ListadeBoletos.Clear;
    CdsContas.First;
    while not CdsContas.Eof do
    begin
      Adicionar := false;
      if not Impressao  then
      begin
        if Trim(CdsContas.FieldByName('REMESSA_ENVIADA').AsString) = 'N' then
           Adicionar := true;
      end
      else Adicionar := true;
      //
      if Adicionar then
      begin
        Titulo := DmAcbr.ACBrBoleto1.CriarTituloNaLista;
        with Titulo do
        begin
          Vencimento        := CdsContas.FieldByName('DATA_VENC').AsDateTime;
          DataDocumento     := CdsContas.FieldByName('DATA_LANC').AsDateTime;
          NumeroDocumento   := CdsContas.FieldByName('NUMCONTA').AsString;
          EspecieDoc        := DmWorkCom.sESPECIE;

          if DmWorkCom.sACEITE = 'SIM' then
             Aceite := atSim
          else
             Aceite := atNao;
          DataProcessamento := Now;
          NossoNumero       := CdsContas.FieldByName('NOSSO_NUMERO').AsString;
          Carteira          := Trim(DmWorkCom.sCARTEIRA);
          ValorDocumento    := CdsContas.FieldByName('VALOR_CONTA').AsFloat;
          Sacado.NomeSacado := CdsContas.FieldByName('CONTATO').AsString;
          Sacado.CNPJCPF    := CdsContas.FieldByName('CNPJ_CPF').AsString;
          Sacado.Logradouro := CdsContas.FieldByName('ENDERECO').AsString;
          Sacado.Numero     := CdsContas.FieldByName('NUM_END').AsString;
          Sacado.Bairro     := CdsContas.FieldByName('BAIRRO_END').AsString;
          Sacado.Cidade     := CdsContas.FieldByName('CIDADE_END').AsString;
          Sacado.UF         := CdsContas.FieldByName('UF_END').AsString;
          Sacado.CEP        := CdsContas.FieldByName('CEP_END').AsString;
          ValorAbatimento   := 0;
          LocalPagamento    := DmWorkCom.sLOCAL_PAGTO;
          ValorMoraJuros    := 0;
          ValorDesconto     := 0;
          ValorAbatimento   := 0;
          DataMoraJuros     := 0;
          DataDesconto      := 0;
          DataAbatimento    := 0;
          DataProtesto      := CdsContas.FieldByName('DATA_VENC').AsDateTime + DmWorkCom.sDIAS_PROTESTO;
          PercentualMulta   := 0;
          Mensagem.Text     := DmWorkCom.sMENSAGEM;
          OcorrenciaOriginal.Tipo := toRemessaBaixar;
          Instrucao1        := trim(DmWorkCom.sINSTRUCAO_1);
          Instrucao2        := trim(DmWorkCom.sINSTRUCAO_2);
          TotalParcelas     := CdsContas.FieldByName('PARCELAS').AsInteger;;
          Parcela           := CdsContas.FieldByName('SERIE').AsInteger;
        end;
        // grava cobrança como impresso
        if Impressao then
        begin
          DmWorkCom.GravaCobrancaImpressa(CdsContas.FieldByName('ID').AsInteger);
        end
        else
        begin
          DmWorkCom.GravaCobrancaRemessa(CdsContas.FieldByName('ID').AsInteger);
        end;
      end;
      CdsContas.Next;
    end;
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
      Result := false;
    end;
  end;

end;

function TFrmGerarFaturas.InsereContaUnicaComponente(
  Impressao: Boolean): Boolean;
var Titulo : TACBrTitulo;
    Adicionar : Boolean;
begin
  Result := true;
  try
    DmAcbr.ACBrBoleto1.ListadeBoletos.Clear;
    Adicionar := false;
    if not Impressao  then
    begin
      if Trim(CdsContas.FieldByName('REMESSA_ENVIADA').AsString) = 'N' then
         Adicionar := true;
    end
    else Adicionar := true;
    //
    if Adicionar then
    begin
      Titulo := DmAcbr.ACBrBoleto1.CriarTituloNaLista;
      with Titulo do
      begin
        Vencimento        := CdsContas.FieldByName('DATA_VENC').AsDateTime;
        DataDocumento     := CdsContas.FieldByName('DATA_LANC').AsDateTime;
        NumeroDocumento   := CdsContas.FieldByName('NUMCONTA').AsString;
        EspecieDoc        := DmWorkCom.sESPECIE;

        if DmWorkCom.sACEITE = 'SIM' then
           Aceite := atSim
        else
           Aceite := atNao;
        DataProcessamento := Now;
        NossoNumero       := CdsContas.FieldByName('NOSSO_NUMERO').AsString;
        Carteira          := Trim(DmWorkCom.sCARTEIRA);
        ValorDocumento    := CdsContas.FieldByName('VALOR_CONTA').AsFloat;
        Sacado.NomeSacado := CdsContas.FieldByName('CONTATO').AsString;
        Sacado.CNPJCPF    := CdsContas.FieldByName('CNPJ_CPF').AsString;
        Sacado.Logradouro := CdsContas.FieldByName('ENDERECO').AsString;
        Sacado.Numero     := CdsContas.FieldByName('NUM_END').AsString;
        Sacado.Bairro     := CdsContas.FieldByName('BAIRRO_END').AsString;
        Sacado.Cidade     := CdsContas.FieldByName('CIDADE_END').AsString;
        Sacado.UF         := CdsContas.FieldByName('UF_END').AsString;
        Sacado.CEP        := CdsContas.FieldByName('CEP_END').AsString;
        ValorAbatimento   := 0;
        LocalPagamento    := DmWorkCom.sLOCAL_PAGTO;
        ValorMoraJuros    := 0;
        ValorDesconto     := 0;
        ValorAbatimento   := 0;
        DataMoraJuros     := 0;
        DataDesconto      := 0;
        DataAbatimento    := 0;
        DataProtesto      := CdsContas.FieldByName('DATA_VENC').AsDateTime + DmWorkCom.sDIAS_PROTESTO;
        PercentualMulta   := 0;
        Mensagem.Text     := DmWorkCom.sMENSAGEM;
        OcorrenciaOriginal.Tipo := toRemessaBaixar;
        Instrucao1        := trim(DmWorkCom.sINSTRUCAO_1);
        Instrucao2        := trim(DmWorkCom.sINSTRUCAO_2);
        TotalParcelas     := CdsContas.FieldByName('PARCELAS').AsInteger;;
        Parcela           := CdsContas.FieldByName('SERIE').AsInteger;
      end;
      // grava cobrança como impresso
      if Impressao then
      begin
        DmWorkCom.GravaCobrancaImpressa(CdsContas.FieldByName('ID').AsInteger);
      end
      else
      begin
        DmWorkCom.GravaCobrancaRemessa(CdsContas.FieldByName('ID').AsInteger);
      end;
    end;
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
      Result := false;
    end;
  end;

end;


procedure TFrmGerarFaturas.Rdopcao1Click(Sender: TObject);
begin
  inherited;
  ChVencidas.Enabled := false;
  ChVencidas.Checked := false;
  if Rdopcao1.ItemIndex = 0 then
  begin
    ChVencidas.Enabled := true;
//    ChVencidas.Checked := true;
  end;
end;

procedure TFrmGerarFaturas.BtnLocalizarClick(Sender: TObject);
begin
  inherited;
  AbreDadosCobranca;

end;

end.
