unit uFrmSintegra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, ActnList, uFrameConfirmaCancela, ComCtrls,
  ExtCtrls, Buttons, DB, DBClient, FMTBcd, SqlExpr, System.Actions;

type
  TFrmSintegra = class(TFrmPadrao)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    ActionList1: TActionList;
    GroupBox1: TGroupBox;
    ActGerar: TAction;
    ActEncerrar: TAction;
    OpenDialog1: TOpenDialog;
    Ch10: TCheckBox;
    Ch11: TCheckBox;
    Ch50: TCheckBox;
    Ch51: TCheckBox;
    Ch53: TCheckBox;
    Ch54: TCheckBox;
    Ch55: TCheckBox;
    Ch56: TCheckBox;
    Ch57: TCheckBox;
    Ch60m: TCheckBox;
    Ch61: TCheckBox;
    Ch70: TCheckBox;
    Ch71: TCheckBox;
    Ch74: TCheckBox;
    Ch75: TCheckBox;
    Ch76: TCheckBox;
    Ch77: TCheckBox;
    Ch85: TCheckBox;
    Ch86: TCheckBox;
    Ch90: TCheckBox;
    Ch60a: TCheckBox;
    Ch60d: TCheckBox;
    Ch60i: TCheckBox;
    Ch61r: TCheckBox;
    Ch60r: TCheckBox;
    GroupBox2: TGroupBox;
    SpeedButton1: TSpeedButton;
    EdtPath: TEdit;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    GroupBox4: TGroupBox;
    ComboEstrutura: TComboBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    ComboNatureza: TComboBox;
    ComboFinalidade: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ActGerarExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CdsRegistrosNewRecord(DataSet: TDataSet);
    procedure Ch60dClick(Sender: TObject);
    procedure Ch60iClick(Sender: TObject);
    procedure Ch60rClick(Sender: TObject);
    procedure Ch60mClick(Sender: TObject);
    procedure Ch60aClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSintegra: TFrmSintegra;

implementation

uses uLibrary,uDmWorkCom, uDmAuxiliar;

{$R *.dfm}

procedure TFrmSintegra.FormShow(Sender: TObject);
var aDataBase : TDateTime;
begin
  inherited;
  aDataBase := SVData-30;
  DmWorkCom.Dados_Empresa(sIDEmpresa);
  Datai.Date := PrimeiroDia(aDataBase);
  Dataf.Date := UltimoDia(aDataBase);

end;

procedure TFrmSintegra.ActGerarExecute(Sender: TObject);
begin
  inherited;
  if EdtPath.Text = '' then
  begin
    MessageDlg('É necessário selecionar a pasta de gravação do arquivo!', mtWarning, [mbOK], 0);
    Abort;
  end;
  // verifica regisrto 60
  if not Ch60m.Checked then
  begin
    MessageDlg('O registro 60 mestre é obrigatório!!!', mtError, [mbOK], 0);
    Abort;
  end;
  // verifica registro 60M
  if (not Ch60a.Checked) and (Ch60m.Checked) then
     Ch60a.Checked := true;
  // zera contadores de registros
  DmAuxiliar.CdsRegistros.EmptyDataSet;
  DmWorkCom.sTotalReg := 0;
  // verifica se existe arquivo
  if FileExists(EdtPath.Text) then
     DeleteFile(EdtPath.Text);
  // cria o arquivo
  try
    AssignFile(DmWorkCom.sArquivo,EdtPath.Text);
    Rewrite(DmWorkCom.sArquivo);
    // registro 10 - obrigatorio
    if Ch10.Checked then
       DmWorkCom.ProcessaRegistro10(Datai.Date,
                                    Dataf.Date,
                                    copy(ComboEstrutura.Text,1,1),
                                    copy(ComboNatureza.Text,1,1),
                                    copy(ComboFinalidade.Text,1,1));
    // registro 11 - obrigatorio
    if Ch11.Checked then
       DmWorkCom.ProcessaRegistro11;
    // bloco de registro 60
    if Ch60m.Checked then
       DmWorkCom.ProcessaRegistro60m(Datai.Date,Dataf.Date,Ch60d.Checked,Ch60i.Checked,Ch60r.Checked);
    // bloco de regisrto 61
    if Ch61.Checked then
    begin
      DmWorkCom.ProcessaRegistro61(Datai.Date,Dataf.Date);
      if Ch61r.Checked then
         DmWorkCom.ProcessaRegistro61r(Datai.Date,Dataf.Date);
    end;
    // registro 75 - obrigatorio se estiver marcado o 60D ou 60I ou 61
    if Ch75.Checked then
       DmWorkCom.ProcessaRegistro75(Datai.Date,Dataf.Date);
    // registro 90 - obrigatorio
    if Ch90.Checked then
       DmWorkCom.ProcessaRegistro90;
    // fecha o arquivo
    CloseFile(DmWorkCom.sArquivo);
    MessageDlg('Arquivo gravado com sucesso!!!', mtInformation, [mbOK], 0);
  except
    MessageDlg('Erro ao gravar o arquivo. verifique!', mtError, [mbOK], 0);
  end;

end;

procedure TFrmSintegra.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  close;

end;

procedure TFrmSintegra.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  EdtPath.Text := OpenDialog1.FileName;

end;

procedure TFrmSintegra.CdsRegistrosNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('total').AsInteger := 0;

end;

procedure TFrmSintegra.Ch60dClick(Sender: TObject);
begin
  inherited;
  if Ch60d.Checked then
     Ch75.Checked := true;
end;

procedure TFrmSintegra.Ch60iClick(Sender: TObject);
begin
  inherited;
  if Ch60d.Checked then
     Ch75.Checked := true;

end;

procedure TFrmSintegra.Ch60rClick(Sender: TObject);
begin
  inherited;
  if Ch60d.Checked then
     Ch75.Checked := true;

end;

procedure TFrmSintegra.Ch60mClick(Sender: TObject);
begin
  inherited;
  Ch60a.Checked := false;
  if Ch60m.Checked then
     Ch60a.Checked := true;

end;

procedure TFrmSintegra.Ch60aClick(Sender: TObject);
begin
  inherited;
  if not Ch60a.Checked then
     Ch60m.Checked := false;

end;

end.
