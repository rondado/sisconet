unit uFrmCadPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, System.Actions;

type
  TFrmCadPadrao = class(TForm)
    DataWork: TDataSource;
    ActionList1: TActionList;
    ActIncluir: TAction;
    ActExcluir: TAction;
    ActConfirmar: TAction;
    ActCancelar: TAction;
    ActPesquisar: TAction;
    ActRelatorio: TAction;
    ActEncerrar: TAction;
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPadrao: TFrmCadPadrao;

implementation

Uses uLibrary, uDmWorkCom;

{$R *.dfm}

procedure TFrmCadPadrao.ActIncluirExecute(Sender: TObject);
begin
  if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
     DataWork.DataSet.Append;

end;

procedure TFrmCadPadrao.ActExcluirExecute(Sender: TObject);
begin
  if Confirmacao('Confirma a exclusão deste registro?') then
  begin
    if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
       DataWork.DataSet.Delete;
    Grava_Dados(DataWork.DataSet);
  end;
  
end;

procedure TFrmCadPadrao.ActConfirmarExecute(Sender: TObject);
begin
  if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
     DataWork.DataSet.Post;
  Grava_Dados(DataWork.DataSet);
end;

procedure TFrmCadPadrao.ActCancelarExecute(Sender: TObject);
begin
  if Confirmacao('Confirma o cancelamento dos dados informados?') then
  begin
    if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
       DataWork.DataSet.Cancel;
    Grava_Dados(DataWork.DataSet);
  end;

end;

procedure TFrmCadPadrao.ActEncerrarExecute(Sender: TObject);
begin
  Close;

end;

procedure TFrmCadPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    MessageDlg('É necessário confirmar ou cancelar os dados da OS!!!', mtWarning, [mbOK], 0);
    Abort;
  end;

end;

end.
