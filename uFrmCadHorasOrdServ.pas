unit uFrmCadHorasOrdServ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList;

type
  TFrmCadHorasOrdServ = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBMemo4: TDBMemo;
    ComboFuncionario: TDBLookupComboBox;
    Panel1: TPanel;
    BtnExcluir: TBitBtn;
    BtnIncluir: TBitBtn;
    Btngravar: TBitBtn;
    BtnCancelar: TBitBtn;
    ActionList1: TActionList;
    ActIncluirHora: TAction;
    ActExcluirHora: TAction;
    ActGravaHora: TAction;
    ActCancelarHora: TAction;
    DataHoras: TDataSource;
    DataOrdServ: TDataSource;
    DataFuncionario: TDataSource;
    procedure ActIncluirHoraExecute(Sender: TObject);
    procedure ActExcluirHoraExecute(Sender: TObject);
    procedure ActGravaHoraExecute(Sender: TObject);
    procedure ActCancelarHoraExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataHorasStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure HabilitaBotoesOSHoras;
  public
    { Public declarations }
    sIDOS : Integer;
  end;

var
  FrmCadHorasOrdServ: TFrmCadHorasOrdServ;

implementation

{$R *.dfm}

uses uDmWorkCom, uLibrary, uDMClientes;

procedure TFrmCadHorasOrdServ.ActCancelarHoraExecute(Sender: TObject);
begin
  inherited;
  //
  if DataHoras.DataSet.RecordCount > 0 then
  begin
    if MessageDlg('Confirma cancelamento dos dados informados?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
       DataHoras.DataSet.Cancel;
    DmWorkCom.Dados_OSHoras(sIDOS);
  end;

end;

procedure TFrmCadHorasOrdServ.ActExcluirHoraExecute(Sender: TObject);
begin
  inherited;
  // verificações
  if DataOrdServ.DataSet.FieldByName('STATUS').AsInteger = 5 then
  begin
    MessageDlg('Não é permitido excluir lançamento de horas para OS fechada!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  if DataHoras.DataSet.RecordCount > 0 then
  begin
    if MessageDlg('Confirma exclusão deste lançamento?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
       DataHoras.DataSet.Delete;
    Grava_Dados(DataHoras.DataSet);
    DmWorkCom.Dados_OSHoras(sIDOS);
  end;

end;

procedure TFrmCadHorasOrdServ.ActGravaHoraExecute(Sender: TObject);
begin
  inherited;
  //
  if (DataHoras.DataSet.State in [dsInsert,dsEdit]) then
  begin
    Grava_Dados(DataHoras.DataSet);
    DmWorkCom.Dados_OSHoras(sIDOS);
    if (DataOrdServ.DataSet.FieldByName('DATA_INICIO').AsDateTime = 0) then
    begin
      DataOrdServ.DataSet.Edit;
      DataOrdServ.DataSet.FieldByName('DATA_INICIO').AsDateTime := DataHoras.DataSet.FieldByName('DATA_TRAB').AsDateTime;
      DataOrdServ.DataSet.FieldByName('HORA_INICIO').AsDateTime := DataHoras.DataSet.FieldByName('HORA_INICIO').AsDateTime;
      Grava_Dados(DataOrdServ.DataSet);
    end;

  end;

end;

procedure TFrmCadHorasOrdServ.ActIncluirHoraExecute(Sender: TObject);
begin
  inherited;
  // verificações
  if DataOrdServ.DataSet.RecordCount = 0 then
  begin
    MessageDlg('É necessário inserir uma OS antes de registrar os horarios de trabalho!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if DataOrdServ.DataSet.FieldByName('STATUS').AsInteger = 5 then
  begin
    MessageDlg('Não é permitido registrar horas para OS fechada!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  if not(DataHoras.DataSet.State in [dsInsert,dsEdit]) then
  begin
    DataHoras.DataSet.Append;
    ComboFuncionario.SetFocus;
  end
  else
    MessageDlg('É necessário gravar os dados!', mtWarning, [mbOK], 0);

end;

procedure TFrmCadHorasOrdServ.DataHorasStateChange(Sender: TObject);
begin
  inherited;
//  HabilitaBotoesOSHoras;

end;

procedure TFrmCadHorasOrdServ.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataFuncionario.DataSet.Close;

end;

procedure TFrmCadHorasOrdServ.FormShow(Sender: TObject);
begin
  DataOrdServ.DataSet := DmWorkCom.CdsOS;
  DataHoras.DataSet := DmWorkCom.CdsOSHoras;
  DataFuncionario.DataSet := DmClientes.CdsFuncionarios;
  inherited;
  DmWorkCom.Dados_OS(sIDOS);
  DmWorkCom.Dados_OSHoras(sIDOS);
  DmClientes.Dados_Funcionario;

end;

procedure TFrmCadHorasOrdServ.HabilitaBotoesOSHoras;
begin
  if DataHoras.DataSet.Active then
  begin
    BtnIncluir.Enabled  := true;
    BtnExcluir.Enabled  := true;
    Btngravar.Enabled   := false;
    BtnCancelar.Enabled := false;
    if (DataHoras.DataSet.State in [dsInsert,dsEdit]) then
    begin
      BtnIncluir.Enabled  := false;
      BtnExcluir.Enabled  := false;
      Btngravar.Enabled   := true;
      BtnCancelar.Enabled := true;
    end;
  end;

end;

end.
