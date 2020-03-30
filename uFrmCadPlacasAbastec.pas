unit uFrmCadPlacasAbastec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, uFrameConfirmaCancela, ExtCtrls, Grids, DBGrids,
  Mask, StdCtrls, Buttons, Menus, FMTBcd, DB, DBClient, Provider, SqlExpr,
  DBCtrls, ActnList, System.Actions;

type
  TFrmCadPlacasAbastec = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    BtnConsultar: TBitBtn;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    PnDadosBasico: TPanel;
    Label8: TLabel;
    EdtMotivo: TEdit;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    QryPlacas: TSQLQuery;
    DspPlacas: TDataSetProvider;
    CdsPlacas: TClientDataSet;
    DsPlacas: TDataSource;
    Label3: TLabel;
    Label9: TLabel;
    EdtData: TMaskEdit;
    EdtHora: TMaskEdit;
    QryPlacasBICO_CONCENTRADOR: TStringField;
    QryPlacasDATA: TSQLTimeStampField;
    QryPlacasHORA: TSQLTimeStampField;
    QryPlacasCNPJ: TStringField;
    QryPlacasCPF: TStringField;
    QryPlacasENCERRANTE_OUT: TFloatField;
    QryPlacasENCERRANTE_IN: TFloatField;
    QryPlacasNUM_LACRE_OUT: TStringField;
    QryPlacasNUM_LACRE_IN: TStringField;
    QryPlacasMOTIVO: TStringField;
    CdsPlacasBICO_CONCENTRADOR: TStringField;
    CdsPlacasDATA: TSQLTimeStampField;
    CdsPlacasHORA: TSQLTimeStampField;
    CdsPlacasCNPJ: TStringField;
    CdsPlacasCPF: TStringField;
    CdsPlacasENCERRANTE_OUT: TFloatField;
    CdsPlacasENCERRANTE_IN: TFloatField;
    CdsPlacasNUM_LACRE_OUT: TStringField;
    CdsPlacasNUM_LACRE_IN: TStringField;
    CdsPlacasMOTIVO: TStringField;
    QryPlacasID: TIntegerField;
    CdsPlacasID: TIntegerField;
    CbxBombas: TDBLookupComboBox;
    CbxTanques: TDBLookupComboBox;
    DsBombas: TDataSource;
    DsTanques: TDataSource;
    Label10: TLabel;
    CbxBicos: TDBLookupComboBox;
    DsBicos: TDataSource;
    Label11: TLabel;
    EdtJustificativa2: TEdit;
    Label12: TLabel;
    EdtMedidas: TEdit;
    Panel2: TPanel;
    BtnRegistro: TBitBtn;
    ActionList1: TActionList;
    ActMenuFiscal: TAction;
    EdtJustificativa: TEdit;
    EdtJustificativa1: TEdit;
    EdtMedidas1: TEdit;
    EdtMedidas2: TEdit;
    Label13: TLabel;
    EdtEncFinal: TEdit;
    Label14: TLabel;
    EdtEncAtual: TEdit;
    EdtBico: TEdit;
    EdtBomba: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    EdtTanque: TEdit;
    BtnContigencia: TBitBtn;
    PnDadosTecnico: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    EdtCPF: TEdit;
    EdtCNPJ: TEdit;
    Label6: TLabel;
    EdtLacreOld: TEdit;
    EdtLacreNew: TEdit;
    Label7: TLabel;
    BtnCadPlaca: TBitBtn;
    procedure BtnConsultarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CbxBombasKeyPress(Sender: TObject; var Key: Char);
    procedure CbxTanquesExit(Sender: TObject);
    procedure BtnRegistroClick(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure BtnContigenciaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCadPlacaClick(Sender: TObject);
    procedure EdtEncFinalExit(Sender: TObject);
  private
    sIDPerda : Integer;
    sEF, sEI : Double;
    xPendente : Boolean;
    sData, sHora : TDateTime;
    procedure Registro1300(RegPlaca:Boolean);
    procedure CadTrocaPlaca;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPlacasAbastec: TFrmCadPlacasAbastec;

implementation

uses uDmConexao, uLibrary, uDmWorkCom, uFrmMenuFiscal, uDmPosto,
  uFrmDescontinuidade, Math, uFrmCadReg61, uDmAcBr, uDmProdutos;

{$R *.dfm}

procedure TFrmCadPlacasAbastec.BtnConsultarClick(Sender: TObject);
begin
  inherited;
  CdsPlacas.Close;
  CdsPlacas.Params.Clear;
  QryPlacas.Close;
  QryPlacas.SQL.Clear;
  QryPlacas.SQL.Add('select p.id,bi.bico_concentrador,p.data,p.hora,');
  QryPlacas.SQL.Add('       p.cnpj,p.cpf,p.encerrante_out,p.encerrante_in,');
  QryPlacas.SQL.Add('       p.num_lacre_out,p.num_lacre_in,p.motivo');
  QryPlacas.SQL.Add('from placas_abastec p');
  QryPlacas.SQL.Add('left outer join tanques_abastec t on p.id_tanque = t.id');
  QryPlacas.SQL.Add('left outer join bombas_abastec b on p.id_bomba = b.id');
  QryPlacas.SQL.Add('left outer join bicos_abastec bi on p.id_bico = bi.id');
  if CbxTanques.Text <> '' then
     QryPlacas.SQL.Add('where t.tanque_numero = '+CbxTanques.Text);
  if CbxBombas.Text <> '' then
  begin
    if CbxTanques.Text = '' then
       QryPlacas.SQL.Add('where b.bomba_numero = '+CbxBombas.Text)
    else
       QryPlacas.SQL.Add('and b.bomba_numero = '+CbxBombas.Text);
  end;
  QryPlacas.SQL.Add('order by p.data,p.hora desc');
  //
  CdsPlacas.FetchParams;
  CdsPlacas.Open;
  DsPlacas.DataSet := CdsPlacas;
  //
  if not CdsPlacas.IsEmpty then
     DBGrid1.SetFocus
  else
     CbxBombas.SetFocus;

end;

procedure TFrmCadPlacasAbastec.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  EdtCNPJ.Clear;
  EdtCPF.Clear;
  EdtLacreOld.Clear;
  EdtLacreNew.Clear;
  EdtMotivo.Clear;
  PnDadosBasico.Visible := false;
  CbxBombas.SetFocus;

end;

procedure TFrmCadPlacasAbastec.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  try
    // insere registros a partir dos bicos da bomba
    if not DmPosto.Gera_Registro_Manutencao_Bomba(sEF,
                                                  sEI,
                                                  DsBombas.DataSet.FieldByName('ID').AsInteger,
                                                  DsTanques.DataSet.FieldByName('ID').AsInteger,
                                                  DsBicos.DataSet.FieldByName('ID').AsInteger,
                                                  StrToDate(EdtData.Text),
                                                  StrToTime(EdtHora.Text),
                                                  EdtCNPJ.Text,
                                                  EdtCPF.Text,
                                                  EdtLacreOld.Text,
                                                  EdtLacreNew.Text,
                                                  EdtMotivo.Text,
                                                  '',
                                                  '',
                                                  EdtJustificativa.Text,
                                                  EdtJustificativa1.Text,
                                                  EdtJustificativa2.Text,
                                                  EdtMedidas.Text,
                                                  EdtMedidas1.Text,
                                                  EdtMedidas2.Text) then
    begin
      MessageDlg('Erro ao processar registro de bicos da bomba!', mtError, [mbOK], 0);
      Exit;
    end
    else
    begin
      // marca pendencia como resolvida
      DmPosto.Dados_Bicos_Perda(sIDPerda);
      if not(DmPosto.CdsBicoPerda.State in [dsInsert,dsEdit]) then
         DmPosto.CdsBicoPerda.Edit;
      DmPosto.CdsBicoPerda.FieldByName('PENDENTE').AsString := 'N';
      Grava_Dados(DmPosto.CdsBicoPerda);
      //
      DmWorkCom.PAFECF.RelatorioDescontinuidadeEncerrante(EdtBomba.Text,
                                                          EdtBico.Text,
                                                          EdtMotivo.Text,
                                                          EdtJustificativa.Text,
                                                          EdtJustificativa1.Text,
                                                          EdtJustificativa2.Text,
                                                          EdtMedidas.Text,
                                                          EdtMedidas1.Text,
                                                          EdtMedidas2.Text,
                                                          StrToDateTime(EdtData.Text),
                                                          StrToDateTime(EdtHora.Text),
                                                          sEI,sEF);
      // Emite os abastecimentos pendentes
      if not DmWorkCom.LocalizaEmiteAbastecPendente then
      begin
        MessageDlg('Erro ao emitir abastecimentos pendentes, entre em contato com o suporte!', mtWarning, [mbOK], 0);
        Exit;
      end;
      // vrifica e move os abastecimentos pendentes
      DmPosto.MoveAbastecimentosTemporarios(DmPosto.CdsBicoPerda.FieldByName('NUMBICO').AsString);
    end;
  finally
    // atuaiza a consultra de registro
    EdtCNPJ.Clear;
    EdtCPF.Clear;
    EdtLacreOld.Clear;
    EdtLacreNew.Clear;
    EdtMotivo.Clear;
    PnDadosBasico.Visible := false;
    DmPosto.Dados_Bomba;
    DmPosto.Dados_Tanque;
    CbxBombas.SetFocus;
  end;

end;

procedure TFrmCadPlacasAbastec.FormShow(Sender: TObject);
begin
  inherited;
  DsBombas.DataSet := DmPosto.CdsBombas;
  DsTanques.DataSet := DmPosto.CdsTanques;
  DsBicos.DataSet := DmPosto.CdsBicos;
  DmPosto.Dados_Bomba;
  DmPosto.Dados_Tanque;
  CbxBombas.SetFocus;
  
end;

procedure TFrmCadPlacasAbastec.CbxBombasKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCadPlacasAbastec.CbxTanquesExit(Sender: TObject);
begin
  inherited;
  if (CbxBombas.Text = '') or (CbxTanques.Text = '') then
  begin
    MessageDlg('É necessário selecionar o bomba e o tanque!',mtWarning,[mbOK],0);
    Exit;
  end;
  DmPosto.Dados_Bicos(DsBombas.DataSet.FieldByName('ID').AsInteger,
                      DsTanques.DataSet.FieldByName('ID').AsInteger);
end;

procedure TFrmCadPlacasAbastec.BtnRegistroClick(Sender: TObject);
begin
  inherited;
  Registro1300(false);
end;

procedure TFrmCadPlacasAbastec.ActMenuFiscalExecute(Sender: TObject);
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
   Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
   Try
      FrmMenuFiscal.ShowModal;
   Finally
      FrmMenuFiscal.Destroy;
   End;

end;

procedure TFrmCadPlacasAbastec.BtnContigenciaClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmCadReg61,FrmCadReg61);
    FrmCadReg61.sContigencia := true;
    FrmCadReg61.ShowModal;
  finally
    FreeAndNil(FrmCadReg61);
  end;

end;

procedure TFrmCadPlacasAbastec.FormCreate(Sender: TObject);
begin
  inherited;
  xPendente := false;
end;

procedure TFrmCadPlacasAbastec.Registro1300(RegPlaca:Boolean);
var aNumBico : String;
    VolDescontinuidade, VolNotasDescontinuidade : Double;
    VolAbastPendentes : Double;
    xDescontinuidade : Boolean;
begin
  try
    Application.CreateForm(TFrmDescontinuidade,FrmDescontinuidade);
    FrmDescontinuidade.sIDProd := 0;
    FrmDescontinuidade.ShowModal;
    sIDPerda := FrmDescontinuidade.sIDPerda;
  finally
    FreeAndNil(FrmDescontinuidade);
  end;
  // se tiver sido selecionado realiza o procedimento
  if sIDPerda > 0 then
  begin
    if not DmPosto.RetornaDadosBicoPerda(aNumBico,sEF,sEI,sData,sHora,sIDPerda) then
    begin
      MessageDlg('Erro ao selecionar os dados da descontinuidade!', mtWarning, [mbOK], 0);
      Exit;
    end;
    sEI := DmPosto.RetornaEncBicoConcentrador(aNumBico);
    sEI := TruncaValor(sEI,3);
    VolAbastPendentes := DmPosto.RetornaVolAbastPendente(aNumBico);
    VolAbastPendentes := TruncaValor(VolAbastPendentes,3);
    sEI := sEI - VolAbastPendentes;
    DmPosto.Dados_Bicos(aNumBico);
    DmPosto.Dados_Bomba(DsBicos.DataSet.FieldByName('ID_BOMBA').AsInteger);
    DmPosto.Dados_Tanque(DsBicos.DataSet.FieldByName('ID_TANQUE').AsInteger);
    DmProdutos.Dados_Produto(DmPosto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger);
    // Emite os abastecimentos pendentes
    if not xPendente then
    begin
      if not DmWorkCom.LocalizaEmiteAbastecPendente then
      begin
        MessageDlg('Erro ao emitir abastecimentos pendentes, entre em contato com o suporte!', mtWarning, [mbOK], 0);
        Exit;
      end
      else xPendente := true;
    end;
    // retorna o Total de notas emitidas para a pendencia
    DmPosto.Dados_Bicos_Perda(sIDPerda);
    VolNotasDescontinuidade := DmWorkCom.RetornaVolNotasDescontinuidade(sIDPerda);
    VolDescontinuidade := DmPosto.CdsBicoPerdaVOLUME.AsFloat - VolNotasDescontinuidade;
    xDescontinuidade := true;
    if VolDescontinuidade > 0 then
    begin
      xDescontinuidade := false;
      if Confirmacao('O volume de '+FormatFloat('0.000',VolDescontinuidade)+', é um abastecimento válido?') then
      begin
        // grava o pedido do abastecimento
        DmPosto.RegistraAbastecimentos(aNumBico,
                                       FormatDateTime('dd/mm/yyyy',DmPosto.CdsBicoPerdaDATA_MOVTO.AsDateTime),
                                       FormatDateTime('hh:mm:ss',DmPosto.CdsBicoPerdaHORA_MOVTO.AsDateTime),
                                       DmPosto.CdsBicoPerdaEA.AsFloat,
                                       VolDescontinuidade,
                                       DmProdutos.CdsProdutosPRECO_VENDA.AsFloat,
                                       TruncaValor((VolDescontinuidade*
                                                   DmProdutos.CdsProdutosPRECO_VENDA.AsFloat),
                                                   DmWorkCom.PAFECF.gDecimais),
                                       false,
                                       true);
        // marca pendencia como resolvida
        if not(DmPosto.CdsBicoPerda.State in [dsInsert,dsEdit]) then
           DmPosto.CdsBicoPerda.Edit;
        DmPosto.CdsBicoPerda.FieldByName('PENDENTE').AsString := 'N';
        Grava_Dados(DmPosto.CdsBicoPerda);
        // Emite os abastecimentos pendentes
        if not DmWorkCom.LocalizaEmiteAbastecPendente then
        begin
          MessageDlg('Erro ao emitir abastecimentos pendentes, entre em contato com o suporte!', mtWarning, [mbOK], 0);
          Exit;
        end;
        // vrifica e move os abastecimentos pendentes
        DmPosto.MoveAbastecimentosTemporarios(aNumBico);
      end
      else xDescontinuidade := true;
    end;
    // se não for abastecimento valido cadastro a descontinuidade
    if xDescontinuidade then
    begin
      // efetuar o processo de registro de manutenção de bombas
      if Confirmacao('Confirma o registro da descontinuidade do encerrante?') then
      begin
        EdtEncFinal.Text := FormatFloat('0.000',sEF);
        EdtEncAtual.Text := FormatFloat('0.000',sEI);
        EdtTanque.Text   := ZeroEsquerda(DmPosto.CdsTanquesTANQUE_NUMERO.AsString,2);
        EdtBomba.Text    := ZeroEsquerda(DmPosto.CdsBombasBOMBA_NUMERO.AsString,2);
        EdtBico.Text     := ZeroEsquerda(DmPosto.CdsBicosBICO_CONCENTRADOR.AsString,2);
        EdtData.Text     := FormatDateTime('dd/mm/yyyy',Now);
        EdtHora.Text     := FormatDateTime('hh:mm:ss',Now);
        // captura os dados padrão
        PnDadosBasico.Visible := true;
        PnDadosTecnico.Visible := false;
//        EdtEncFinal.Enabled := false;
        if RegPlaca then
        begin
          PnDadosTecnico.Visible := true;
          EdtCNPJ.SelectAll;
          EdtCNPJ.SetFocus;
        end
        else
        begin
          EdtMotivo.SelectAll;
          EdtMotivo.SetFocus;
        end
      end
      else
      begin
        if VolDescontinuidade > 0 then
        begin
          if Confirmacao('Deseja informar outras notas em contingência?') then
             BtnContigencia.Click;
        end;
      end;
    end;
  end;

end;

procedure TFrmCadPlacasAbastec.BtnCadPlacaClick(Sender: TObject);
begin
  inherited;
//  Registro1300(true);
  CadTrocaPlaca;
end;

procedure TFrmCadPlacasAbastec.CadTrocaPlaca;
var aNumBico : String;
begin
  // se tiver sido selecionado realiza o procedimento
  aNumBico := '';
  if InputQuery('Informe o bico','Num. do Bico:',aNumBico) then
  begin
    if not DmPosto.Dados_Bicos(aNumBico) then
    begin
      MessageDlg('Não foi encontrado o bico selecionado no cadastro!', mtWarning, [mbOK], 0);
      Exit;
    end;
  end;
  sEI := DmPosto.RetornaEncBicoConcentrador(aNumBico);
  sEI := TruncaValor(sEI,3);
  sEF := DmPosto.RetornaEncerranteFim(DmAcBr.ACBrECF1.DataMovimento,aNumBico);
  sEF := TruncaValor(sEF,3);
  if sEF <> sEI then
  begin
    DmPosto.Dados_Bicos(aNumBico);
    DmPosto.Dados_Bomba(DsBicos.DataSet.FieldByName('ID_BOMBA').AsInteger);
    DmPosto.Dados_Tanque(DsBicos.DataSet.FieldByName('ID_TANQUE').AsInteger);
    DmProdutos.Dados_Produto(DmPosto.CdsTanques.FieldByName('ID_PRODUTO').AsInteger);
    // Emite os abastecimentos pendentes
    if not DmWorkCom.LocalizaEmiteAbastecPendente then
    begin
      MessageDlg('Erro ao emitir abastecimentos pendentes, entre em contato com o suporte!', mtWarning, [mbOK], 0);
      Exit;
    end;
    // efetuar o processo de registro de manutenção de bombas
    if Confirmacao('Confirma o registro de manutenção de bombas?') then
    begin
      EdtEncFinal.Text := FormatFloat('0.000',sEF);
      EdtEncAtual.Text := FormatFloat('0.000',sEI);
      EdtTanque.Text   := ZeroEsquerda(DmPosto.CdsTanquesTANQUE_NUMERO.AsString,2);
      EdtBomba.Text    := ZeroEsquerda(DmPosto.CdsBombasBOMBA_NUMERO.AsString,2);
      EdtBico.Text     := ZeroEsquerda(DmPosto.CdsBicosBICO_CONCENTRADOR.AsString,2);
      EdtData.Text     := FormatDateTime('dd/mm/yyyy',Now);
      EdtHora.Text     := FormatDateTime('hh:mm:ss',Now);
      // captura os dados padrão
      PnDadosBasico.Visible := true;
      PnDadosTecnico.Visible := true;
//      EdtEncFinal.Enabled := true;
      EdtCNPJ.SelectAll;
      EdtCNPJ.SetFocus;
    end;
  end;
end;

procedure TFrmCadPlacasAbastec.EdtEncFinalExit(Sender: TObject);
begin
  inherited;
  try
    if (sEF = 0) and
       (StrToFloat(EdtEncFinal.Text) > 0) then
    sEF := StrToFloat(EdtEncFinal.Text);
  except
    on E:Exception do ShowMessage(E.Message);
  end;
end;

end.
