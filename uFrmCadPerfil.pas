unit uFrmCadPerfil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, uFrameBotaoVertical, ExtCtrls,
  StdCtrls, ComCtrls, DBCtrls, Mask, Grids, DBGrids, Buttons, System.Actions;

type
  TFrmCadPerfil = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Frame: TFrameBotaoVertical;
    Label1: TLabel;
    DbID: TDBEdit;
    Label2: TLabel;
    DbDescricao: TDBEdit;
    DbChAtivo: TDBCheckBox;
    DBGrid1: TDBGrid;
    BtnPermissoes: TBitBtn;
    ActPermissoes: TAction;
    procedure FormShow(Sender: TObject);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActPermissoesExecute(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPerfil: TFrmCadPerfil;

implementation

Uses uLibrary, uDmWorkCom, uFrmLancPermissoes, uDMClientes;

{$R *.dfm}

procedure TFrmCadPerfil.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet := DmClientes.CdsUsuariosPerfil;
  PageControl1.TabIndex := 0;

end;

procedure TFrmCadPerfil.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmCadPerfil.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  // verifica se tem as permissões do perfil
  if not VerificaPermissoesCadastrada(DataWork.DataSet.FieldByName('ID').AsInteger) then
  begin
    // adciona permissoes
    DmClientes.Insere_PermissoesPerfil(DataWork.DataSet.FieldByName('ID').AsInteger);
  end;

end;

procedure TFrmCadPerfil.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbDescricao.SetFocus;

end;

procedure TFrmCadPerfil.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet
  );
end;

procedure TFrmCadPerfil.ActPermissoesExecute(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.State in [dsInsert,dsEdit] then
  begin
    DataWork.DataSet.Post;
    Grava_Dados(DataWork.DataSet);
  end;
  Application.CreateForm(TFrmLancPermissoes,FrmLancPermissoes);
  try
    FrmLancPermissoes.sIDPerfil := DataWork.DataSet.FieldByName('ID').AsInteger;
    FrmLancPermissoes.ShowModal;
  finally
    FrmLancPermissoes.Destroy;
  end;

end;

end.
