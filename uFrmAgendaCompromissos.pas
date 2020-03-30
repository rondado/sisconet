unit uFrmAgendaCompromissos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, StdCtrls, DBCtrls, Mask,
  ExtCtrls, Grids, DBGrids, Buttons, ComCtrls, ActnList, DB, System.Actions;

type
  TFrmAgendaCompromissos = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DbCodigo: TDBEdit;
    DbData: TDBEdit;
    DbHora: TDBEdit;
    DbCompromisso: TDBEdit;
    DbDetalhe: TDBEdit;
    DbObservacao: TDBMemo;
    ChConcluido: TDBCheckBox;
    PnBotoes: TPanel;
    Frame: TFrameBotaoVertical;
    ComboFuncCad: TDBLookupComboBox;
    DataFuncionario: TDataSource;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GrpPeriodo: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    RadioTipo: TRadioGroup;
    BtnLocalizar: TBitBtn;
    BtnEncerrar: TBitBtn;
    GrpLocalizar: TGroupBox;
    ComboFuncionario: TDBLookupComboBox;
    RadioConcluido: TRadioGroup;
    DBGrid1: TDBGrid;
    DataFuncCad: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAgendaCompromissos: TFrmAgendaCompromissos;

implementation

Uses uLibrary, uDmWorkCom, uDMClientes;

{$R *.dfm}

procedure TFrmAgendaCompromissos.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet        := DmWorkCom.CdsAgenda;
  DataFuncCad.DataSet     := DmClientes.CdsFuncionarios;
  DataFuncionario.DataSet := DmClientes.CdsFuncionarios;
  DmWorkCom.Dados_Agenda(0,SVData,SVData,'N');
  DmClientes.Dados_Funcionario;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);
  PageControl1.TabIndex := 0;
  BtnLocalizarClick(Sender);

end;

procedure TFrmAgendaCompromissos.BtnLocalizarClick(Sender: TObject);
var aIDFunc:Integer;
    aConcluido:String;
begin
  inherited;
  aIDFunc := 0;
  aConcluido := '';
  if RadioTipo.ItemIndex = 1 then
     aIDFunc := DataFuncionario.DataSet.FieldByname('ID').AsInteger;
  if RadioConcluido.ItemIndex = 0 then
     aConcluido := 'S'
  else aConcluido := 'N';
  // efetua busca
  DmWorkCom.Dados_Agenda(aIDFunc,Datai.Date,Dataf.Date,aConcluido);
  DBGrid1.SetFocus;
  
end;

procedure TFrmAgendaCompromissos.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbData.SetFocus;

end;

procedure TFrmAgendaCompromissos.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);
  
end;

procedure TFrmAgendaCompromissos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataFuncionario.DataSet.Close;
  DataFuncCad.DataSet.Close;
  DataWork.DataSet.Close;

end;

end.
