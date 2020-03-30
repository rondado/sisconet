unit uFrmSPED;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ActnList, Buttons, StdCtrls, CheckLst, SqlExpr,
  DB, DBClient, DBCtrls, System.Actions;

type
  TFrmSPED = class(TForm)
    StatusBar1: TStatusBar;
    PnBotoes: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ActionList1: TActionList;
    ActGerarSPED: TAction;
    ActEncerrar: TAction;
    OpenDialog1: TOpenDialog;
    CdsInventario: TClientDataSet;
    CdsInventariocd_produto: TIntegerField;
    CdsInventariounidade: TStringField;
    CdsInventarioquantidade: TFloatField;
    CdsInventariovalor: TFloatField;
    CdsInventariototal: TFloatField;
    CdsUFST: TClientDataSet;
    CdsUFSTUF: TStringField;
    CdsUFSTCREDITO: TFloatField;
    CdsUFSTDEBITO: TFloatField;
    PageSPED: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    GroupBox4: TGroupBox;
    EdtCodEmp: TEdit;
    Panel2: TPanel;
    LbMensagem: TLabel;
    LbBlocos: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    PgSeleciona: TPageControl;
    TabSheet6: TTabSheet;
    GroupBox10: TGroupBox;
    Label1: TLabel;
    ListaBlocos: TCheckListBox;
    ChSTIPI: TCheckBox;
    TabSheet7: TTabSheet;
    GroupBox11: TGroupBox;
    Label9: TLabel;
    ListaBlocosPisCofins: TCheckListBox;
    TabSheet2: TTabSheet;
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    edBufLinhas: TEdit;
    edBufNotas: TEdit;
    edNotas: TEdit;
    GroupBox5: TGroupBox;
    SpeedButton3: TSpeedButton;
    EdtPath: TEdit;
    ChTruncado: TCheckBox;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet8: TTabSheet;
    GroupBox6: TGroupBox;
    Label5: TLabel;
    ComboVersao: TComboBox;
    Label2: TLabel;
    EdtCodRec: TEdit;
    RadioPerfil: TRadioGroup;
    RadioFinalidade: TRadioGroup;
    RadioIndicador: TRadioGroup;
    GroupBox7: TGroupBox;
    ComboVersaoPC: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    ComboSituacao: TComboBox;
    RadioTipoEsc: TRadioGroup;
    RadioNatureza: TRadioGroup;
    ComboIndicador: TComboBox;
    Label12: TLabel;
    Label17: TLabel;
    ComboEscrituracao: TComboBox;
    TabSheet9: TTabSheet;
    GroupBox9: TGroupBox;
    RadioIncidencia: TRadioGroup;
    RadioAproCred: TRadioGroup;
    RadioContrApur: TRadioGroup;
    RadioEscrApur: TRadioGroup;
    Label18: TLabel;
    EdtNumRecAnterior: TEdit;
    ChDespesasAcessorias: TCheckBox;
    ChEntradasEFD: TCheckBox;
    ChEntradasContr: TCheckBox;
    TabSheet10: TTabSheet;
    ChSPEDEfd: TCheckBox;
    ChSPEDContribuicao: TCheckBox;
    GrpDtInvent: TGroupBox;
    DataInvent: TDateTimePicker;
    ChBensConsumo: TCheckBox;
    procedure ActGerarSPEDExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure EdtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCodEmpExit(Sender: TObject);
    procedure PageSPEDChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListaBlocosClick(Sender: TObject);
    procedure ComboVersaoDropDown(Sender: TObject);
    procedure ComboVersaoExit(Sender: TObject);
    procedure ComboVersaoSelect(Sender: TObject);
  private
    { Private declarations }
    procedure SelecionaBlocos(pCheched:Boolean);
  public
    { Public declarations }
  end;

var
  FrmSPED: TFrmSPED;

implementation

uses uLibrary, uDmSPED,uFrmSenha,uDmAcBr;

{$R *.dfm}

procedure TFrmSPED.ActGerarSPEDExecute(Sender: TObject);
begin
  if PageSPED.TabIndex = 0 then
  begin
    ProgressBar1.Position := 0;
    ProgressBar2.Position := 0;
    ProgressBar1.Max := 0;
    ProgressBar2.Max := 8;
    LbMensagem.Caption := 'Em processamento';
    LbBlocos.Caption := 'Em processamento';
    Application.ProcessMessages;
    // verifica dados
    if EdtCodEmp.Text = '' then
    begin
      MessageDlg('É necessário selecionar a empresa!', mtInformation, [mbOK], 0);
      Abort;
    end;
    if (not(ListaBlocos.Checked[0])) or
       (not(ListaBlocos.Checked[7])) or
       (not(ListaBlocosPisCofins.Checked[0])) or
       (not(ListaBlocosPisCofins.Checked[7])) then
    begin
      MessageDlg('Os Blocos 0 e 9 são obrigatórios!',mtWarning,[mbok],0);
      Abort;
    end;
    //
    if not DmSPED.Dados_Contador(DmSPED.CdsEmpresa.FieldByName('IDCONTADOR').AsInteger) then
    begin
      if MessageDlg('É necessário cadastrar os dados do contador!'+#13+#10+
                    'Deseja prosseguir mesmo assim?', mtConfirmation, [mbYes,mbNo], 0) = mrno then
         Abort;
    end;
    // verifica tipo de arquivo
    if PgSeleciona.TabIndex = 0 then // EFD
    begin
      try
        DmSPED.oSpedEFD.sNotasEntrada := not ChEntradasEFD.Checked;
        DmSPED.oSpedEFD.sCNPJEmpresa  := DmSPED.CdsEmpresaCNPJ_CPF.AsString;
        DmSPED.oSpedEFD.sUFEmpresa    := DmSPED.CdsEmpresaUF.AsString;
        DmSPED.oSpedEFD.sProgressBar1 := ProgressBar1;
        DmSPED.oSpedEFD.sProgressBar2 := ProgressBar2;
        DmSPED.oSpedEFD.sLbMensagem   := LbMensagem;
        DmSPED.oSpedEFD.sLBBlocos     := LbBlocos;
        PnBotoes.Enabled := false;
        Screen.Cursor    := crHourGlass;
        // adiciona dados dos blocos no componente
        LbBlocos.Caption := 'Bloco 0';
        ProgressBar2.Position := 1;
        Application.ProcessMessages;
        if ListaBlocos.Checked[0] then
           DmSPED.oSpedEFD.DadosBloco_0(CdsInventario,
                                        CdsUFST,
                                        DmSPED.CdsEmpresa,
                                        DmSPED.CdsContabil,
                                        Datai.Date,
                                        Dataf.Date,
                                        EdtCodEmp.Text,
                                        ListaBlocos.Checked[4],
                                        ListaBlocos.Checked[5],
                                        DmSPED.sCOD_VER,
                                        DmSPED.sPERFIL,
                                        DmSPED.sINDICADOR,
                                        DmSPED.sCOD_FIN,
                                        ChBensConsumo.Checked,
                                        DataInvent.Date);
        LbBlocos.Caption := 'Bloco C';
        ProgressBar2.Position := 2;
        Application.ProcessMessages;
        if ListaBlocos.Checked[1] then
           DmSPED.oSpedEFD.DadosBloco_C(cdsUFST,
                                        edNotas.Text,
                                        edBufNotas.Text,
                                        EdtCodEmp.Text,
                                        Datai.Date,
                                        Dataf.Date,
                                        ChSTIPI.Checked,
                                        ChDespesasAcessorias.Checked,
                                        DmSPED.sPERFIL);
        LbBlocos.Caption := 'Bloco D';
        ProgressBar2.Position := 3;
        Application.ProcessMessages;
        if ListaBlocos.Checked[2] then
           DmSPED.oSpedEFD.DadosBloco_D;
        LbBlocos.Caption := 'Bloco E';
        ProgressBar2.Position := 4;
        Application.ProcessMessages;
        if ListaBlocos.Checked[3] then
           DmSPED.oSpedEFD.DadosBloco_E(cdsUFST,
                                        Datai.Date,
                                        Dataf.Date,
                                        EdtCodRec.Text,
                                        EdtCodEmp.Text,
                                        ChTruncado.Checked,
                                        DmSPED.sINDICADOR);
        LbBlocos.Caption := 'Bloco G';
        ProgressBar2.Position := 5;
        Application.ProcessMessages;
        if ListaBlocos.Checked[4] then
           DmSPED.oSpedEFD.DadosBloco_G(Datai.Date,Dataf.Date,EdtCodEmp.Text);
        LbBlocos.Caption := 'Bloco H';
        ProgressBar2.Position := 6;
        Application.ProcessMessages;
        DmSPED.oSpedEFD.DadosBloco_H(CdsInventario,ListaBlocos.Checked[5],Datai.Date,DataInvent.Date);
        LbBlocos.Caption := 'Bloco 1';
        ProgressBar2.Position := 7;
        Application.ProcessMessages;
        if ListaBlocos.Checked[6] then
           DmSPED.oSpedEFD.DadosBloco_1(Datai.Date,DataInvent.Date);
        LbBlocos.Caption := 'Bloco 9';
        ProgressBar2.Position := 8;
        Application.ProcessMessages;
        // informa dados
        DmAcBr.ACBrSPEDFiscal1.LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );
        DmAcBr.ACBrSpedFiscal1.DT_INI := Datai.Date;
        DmAcBr.ACBrSpedFiscal1.DT_FIN := Dataf.Date;
        // Informa o pata onde será salvo o arquivo TXT.
        DmAcBr.ACBrSpedFiscal1.Path    := EdtPath.Text;
        DmAcBr.ACBrSpedFiscal1.Arquivo := 'SPED_FISCAL'+FormatDateTime('mmmmm_yyyy',Now)+'.txt';
        // Método que gera o arquivo TXT.
        DmAcBr.ACBrSpedFiscal1.SaveFileTXT;
        // totaliza regisyros
        if ListaBlocos.Checked[7] then
           DmSPED.oSpedEFD.DadosBloco_9;
      finally
        Screen.Cursor    := crDefault;
        PnBotoes.Enabled := true;
        MessageDlg('Arquivo gerado com sucesso!',mtInformation,[mbOK],0);
      end;
    end
    else if PgSeleciona.TabIndex = 1 then // pis/cofins
    begin
      try
        DmSPED.oSpedEFD.sNotasEntrada := not ChEntradasContr.Checked;
        DmSPED.oSpedPC.sProgressBar1  := ProgressBar1;
        DmSPED.oSpedPC.sProgressBar2  := ProgressBar2;
        DmSPED.oSpedPC.sLbMensagem    := LbMensagem;
        DmSPED.oSpedPC.sLBBlocos      := LbBlocos;
        Screen.Cursor                 := crHourGlass;
        PnBotoes.Enabled              := false;
        // adiciona dados dos blocos no componente
        LbBlocos.Caption := 'Bloco 0';
        ProgressBar2.Position := 1;
        Application.ProcessMessages;
        if ListaBlocosPisCofins.Checked[0] then
           DmSPED.oSpedPC.DadosBlocoPC_0(DmSPED.CdsEmpresa,
                                         DmSPED.CdsContabil,
                                         Datai.Date,
                                         Dataf.Date,
                                         DmSPED.sCOD_VERPC,
                                         DmSPED.sSitEspecial,
                                         DmSPED.sIndicadorPC,
                                         DmSPED.sCOD_FIN,
                                         EdtNumRecAnterior.Text,
                                         EdtCodEmp.Text,
                                         DmSPED.sIncidencia,
                                         DmSPED.sAproCred,
                                         DmSPED.sContrApur,
                                         DmSPED.sEscrApur);
        LbBlocos.Caption := 'Bloco A';
        ProgressBar2.Position := 2;
        Application.ProcessMessages;
        if ListaBlocosPisCofins.Checked[1] then
           DmSPED.oSpedPC.DadosBlocoPC_A(DmSPED.CdsEmpresa,
                                         Datai.Date,
                                         Dataf.Date,
                                         StrToInt(EdtCodEmp.Text));
        LbBlocos.Caption := 'Bloco C';
        ProgressBar2.Position := 3;
        Application.ProcessMessages;
        if ListaBlocosPisCofins.Checked[2] then
           DmSPED.oSpedPC.DadosBlocoPC_C(DmSPED.CdsEmpresa,
                                         Datai.Date,
                                         Dataf.Date,
                                         StrToInt(EdtCodEmp.Text),
                                         DmSPED.sEscrApur,
                                         ChSTIPI.Checked);
        LbBlocos.Caption := 'Bloco D';
        ProgressBar2.Position := 4;
        Application.ProcessMessages;
        if ListaBlocosPisCofins.Checked[3] then
           DmSPED.oSpedPC.DadosBlocoPC_D;
        LbBlocos.Caption := 'Bloco F';
        ProgressBar2.Position := 5;
        Application.ProcessMessages;
        if ListaBlocosPisCofins.Checked[4] then
           DmSPED.oSpedPC.DadosBlocoPC_F(DmSPED.CdsEmpresa,
                                         Datai.Date,
                                         Dataf.Date,
                                         sIDEmpresa,
                                         DmSPED.sEscrApur);
        LbBlocos.Caption := 'Bloco M';
        ProgressBar2.Position := 6;
        Application.ProcessMessages;
        if ListaBlocosPisCofins.Checked[5] then
           DmSPED.oSpedPC.DadosBlocoPC_M;
        LbBlocos.Caption := 'Bloco 1';
        ProgressBar2.Position := 7;
        Application.ProcessMessages;
        if ListaBlocosPisCofins.Checked[6] then
           DmSPED.oSpedPC.DadosBlocoPC_1(Datai.Date,
                                         Dataf.Date,
                                         DmSPED.sEscrApur);
        LbBlocos.Caption := 'Bloco 9';
        ProgressBar2.Position := 8;
        Application.ProcessMessages;
        // informa dados
        DmAcBr.ACBrSPEDPisCofins1.LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );
        DmAcBr.ACBrSPEDPisCofins1.DT_INI := Datai.Date;
        DmAcBr.ACBrSPEDPisCofins1.DT_FIN := Dataf.Date;
        // Informa o pata onde será salvo o arquivo TXT.
        DmAcBr.ACBrSPEDPisCofins1.Path    := EdtPath.Text;
        DmAcBr.ACBrSPEDPisCofins1.Arquivo := 'SPED_PIS'+FormatDateTime('mmmm_yyyy',Now)+'.txt';
        // Método que gera o arquivo TXT.
        DmAcBr.ACBrSPEDPisCofins1.SaveFileTXT;
        // totaliza regisyros
        if ListaBlocosPisCofins.Checked[7] then
           DmSPED.oSpedPC.DadosBlocoPC_9;
      finally
        Screen.Cursor    := crDefault;
        PnBotoes.Enabled := true;
        MessageDlg('Arquivo gerado com sucesso!',mtInformation,[mbOK],0);
        EdtNumRecAnterior.Clear;
      end;
    end;
  end
  else if PageSPED.TabIndex = 1 then
  begin
    // SPED EFD
    DmSPED.sCOD_VER   := ComboVersao.ItemIndex;
    DmSPED.sPERFIL    := RadioPerfil.ItemIndex;
    DmSPED.sINDICADOR := RadioIndicador.ItemIndex;
    DmSPED.sCOD_FIN   := RadioFinalidade.ItemIndex;
    DmSPED.sBUF_LINHA := edBufLinhas.Text;
    DmSPED.sBUF_NOTA  := edBufNotas.Text;
    DmSPED.sNOTA      := edNotas.Text;
    DmSPED.sPATH      := EdtPath.Text;
    DmSPED.sCodRec    := EdtCodRec.Text;
    DmSPED.sTruncado  := ChTruncado.Checked;
    DmSPED.sExibeEFD  := ChSPEDEfd.Checked;
    DmSPED.sExibeCont := ChSPEDContribuicao.Checked;
    // SPED Pis/Cofins
    DmSPED.sCOD_VERPC      := ComboVersaoPC.ItemIndex;
    DmSPED.sSitEspecial    := ComboSituacao.ItemIndex;
    DmSPED.sIndicadorPC    := ComboIndicador.ItemIndex;
    DmSPED.sTpEscrituracao := RadioTipoEsc.ItemIndex;
    DmSPED.sEscrituracao   := ComboEscrituracao.ItemIndex;
    DmSPED.sNatureza       := RadioNatureza.ItemIndex;
    // Regime Apuração
    DmSPED.sIncidencia := RadioIncidencia.ItemIndex;
    DmSPED.sAproCred   := RadioAproCred.ItemIndex;
    DmSPED.sContrApur  := RadioContrApur.ItemIndex;
    DmSPED.sEscrApur   := RadioEscrApur.ItemIndex;
    //
    DmSPED.GravaIni;
    PageSPED.TabIndex := 0;
    PageSPEDChange(Sender);
    //
    TabSheet5.TabVisible := true;
    TabSheet6.TabVisible := true;
    if not DmSPED.sExibeEFD then
    begin
      TabSheet5.TabVisible := false;
      TabSheet6.TabVisible := false;
    end;
    //
    TabSheet7.TabVisible := true;
    TabSheet8.TabVisible := true;
    TabSheet9.TabVisible := true;
    if not DmSPED.sExibeCont then
    begin
      TabSheet7.TabVisible := false;
      TabSheet8.TabVisible := false;
      TabSheet9.TabVisible := false;
    end;
  end;
end;

procedure TFrmSPED.ComboVersaoDropDown(Sender: TObject);
begin
  ComboVersao.Width := 400;
end;

procedure TFrmSPED.ComboVersaoExit(Sender: TObject);
begin
  ComboVersao.Width := 113;
end;

procedure TFrmSPED.ComboVersaoSelect(Sender: TObject);
begin
  ComboVersao.Width := 113;
end;

procedure TFrmSPED.ActEncerrarExecute(Sender: TObject);
begin
  Close;

end;

procedure TFrmSPED.FormShow(Sender: TObject);
begin
  DmSPED.LeIni;
  ComboVersao.ItemIndex      := DmSPED.sCOD_VER;
  RadioPerfil.ItemIndex      := DmSPED.sPERFIL;
  RadioIndicador.ItemIndex   := DmSPED.sINDICADOR;
  RadioFinalidade.ItemIndex  := DmSPED.sCOD_FIN;
  edBufLinhas.Text           := DmSPED.sBUF_LINHA;
  edBufNotas.Text            := DmSPED.sBUF_NOTA;
  edNotas.Text               := DmSPED.sNOTA;
  EdtPath.Text               := DmSPED.sPATH;
  EdtCodRec.Text             := DmSPED.sCodRec;
  ChTruncado.Checked         := DmSPED.sTruncado;
  ChSPEDEfd.Checked          := DmSPED.sExibeEFD;
  ChSPEDContribuicao.Checked := DmSPED.sExibeCont;
  // dados do sped pis cofins
  ComboVersaoPC.ItemIndex     := DmSPED.sCOD_VERPC;
  ComboSituacao.ItemIndex     := DmSPED.sSitEspecial;
  ComboIndicador.ItemIndex    := DmSPED.sIndicadorPC;
  RadioTipoEsc.ItemIndex      := DmSPED.sTpEscrituracao;
  ComboEscrituracao.ItemIndex := DmSPED.sEscrituracao;
  RadioNatureza.ItemIndex     := DmSPED.sNatureza;
  // Regime Apuração
  RadioIncidencia.ItemIndex := DmSPED.sIncidencia;
  RadioAproCred.ItemIndex   := DmSPED.sAproCred;
  RadioContrApur.ItemIndex  := DmSPED.sContrApur;
  RadioEscrApur.ItemIndex   := DmSPED.sEscrApur;
  //
  PageSPED.TabIndex := 0;
  PgSeleciona.TabIndex := 0;
  PageControl1.TabIndex := 0;
  PageControl2.TabIndex := 0;
  //
  TabSheet5.TabVisible := true;
  TabSheet6.TabVisible := true;
  if not DmSPED.sExibeEFD then
  begin
    TabSheet5.TabVisible := false;
    TabSheet6.TabVisible := false;
  end;
  //
  TabSheet7.TabVisible := true;
  TabSheet8.TabVisible := true;
  TabSheet9.TabVisible := true;
  if not DmSPED.sExibeEFD then
  begin
    TabSheet7.TabVisible := false;
    TabSheet8.TabVisible := false;
    TabSheet9.TabVisible := false;
  end;
  //
  SelecionaBlocos(True);
  ListaBlocosClick(Sender);
  DataInvent.Date := PrimeiroDia(SVData);
  Datai.Date      := PrimeiroDia(SVData);
  Dataf.Date      := UltimoDia(SVData);
  EdtCodEmp.SetFocus;
  
end;

procedure TFrmSPED.SelecionaBlocos(pCheched: Boolean);
var i : Integer;
begin
  // EFD
  for i := 0 to ListaBlocos.items.count-1 do
  begin
     ListaBlocos.Checked[i] := pCheched;
  end;
  // pis/cofins
  for i := 0 to ListaBlocosPisCofins.items.count-1 do
  begin
     ListaBlocosPisCofins.Checked[i] := pCheched;
  end;

end;

procedure TFrmSPED.SpeedButton3Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdtPath.Text := ExtractFilePath(OpenDialog1.FileName);

end;

procedure TFrmSPED.EdtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  TabEnter(Self,Key);

end;

procedure TFrmSPED.EdtCodEmpExit(Sender: TObject);
var aux : Integer;
begin
  if EdtCodEmp.Text <> '' then
  begin
    try
      aux := StrToInt(EdtCodEmp.Text);
      if DmSPED.Dados_Empresa(aux) then
      begin
        StatusBar1.Panels.Items[0].Text := DmSPED.CdsEmpresa.FieldByname('FANTASIA').AsString;
      end;
    except
      MessageDlg('O Código da empresa informado é inválido!', mtError, [mbOK], 0);
      EdtCodEmp.Clear;
      EdtCodEmp.SetFocus;
      Abort;
    end;
  end;
end;

procedure TFrmSPED.PageSPEDChange(Sender: TObject);
begin
  if PageSPED.TabIndex = 0 then
     ActGerarSPED.Caption := 'F2 - Gerar Arquivo SPED'
  else if PageSPED.TabIndex = 1 then
     ActGerarSPED.Caption := 'F2 - Grava Configuração';
     
end;

procedure TFrmSPED.FormCreate(Sender: TObject);
begin
  if not CdsInventario.Active then
     CdsInventario.CreateDataSet;
  CdsInventario.EmptyDataSet;
  //
  if not CdsUFST.Active then
     CdsUFST.CreateDataSet;
  CdsUFST.EmptyDataSet;   

end;

{
function TFrmSPED.RetornaBaseCalculoICMSNota(pCodigo: Integer): Double;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select sum(saiprod.total_produto) as total from saiprod');
    Q.SQL.Add('where saiprod.cd_saida = :pCodigo');
    Q.SQL.Add('and saiprod.perc_icm > 0');
    Q.Params.ParamByName('pCodigo').AsInteger := pCodigo;
    Q.Open;
    Result := Q.FieldByname('total').AsFloat;
  finally
    FreeAndNil(Q);
  end;

end;
}

procedure TFrmSPED.ListaBlocosClick(Sender: TObject);
begin
  GrpDtInvent.Visible := false;
  if ListaBlocos.Checked[5] then
     GrpDtInvent.Visible := true;

end;

end.
