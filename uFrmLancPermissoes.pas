unit uFrmLancPermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, Grids, DBGrids, uFrameConfirmaCancela, StdCtrls,
  ActnList, Buttons, System.Actions, Vcl.DBCtrls, Vcl.ExtCtrls;

type
  TFrmLancPermissoes = class(TFrmPadrao)
    DataPermissoes: TDataSource;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    ActionList1: TActionList;
    ActConfirma: TAction;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure ActConfirmaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDPerfil:Integer;
  end;

var
  FrmLancPermissoes: TFrmLancPermissoes;

implementation

Uses uLibrary, uDmWorkCom, uDMClientes;

{$R *.dfm}

procedure TFrmLancPermissoes.FormShow(Sender: TObject);
begin
  inherited;
  DataPermissoes.DataSet := DmClientes.CdsUsuariosPermissoes;
  DmClientes.Dados_Permissoes(sIDPerfil);
  if DataPermissoes.DataSet.RecordCount = 0 then
     DmClientes.Insere_PermissoesPerfil(sIDPerfil);
  DataPermissoes.DataSet.Edit;
  
end;

procedure TFrmLancPermissoes.ActConfirmaExecute(Sender: TObject);
begin
  inherited;
  //
  if not(DataPermissoes.DataSet.State in [dsInsert,dsEdit]) then
     DataPermissoes.DataSet.Edit;
  DataPermissoes.DataSet.Post;
  Grava_Dados(DataPermissoes.DataSet);
  Close;

end;

end.
