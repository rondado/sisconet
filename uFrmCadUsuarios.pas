unit uFrmCadUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, StdCtrls, ComCtrls, Mask, DBCtrls,
  Grids, DBGrids, uFrameBotaoVertical, ExtCtrls, Buttons, System.Actions;

type
  TFrmCadUsuarios = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DbID: TDBEdit;
    Label2: TLabel;
    DbUsuario: TDBEdit;
    Label4: TLabel;
    DbSenha: TDBEdit;
    Panel1: TPanel;
    Frame: TFrameBotaoVertical;
    DbChAtivo: TDBCheckBox;
    DBGrid1: TDBGrid;
    ActCadPerfil: TAction;
    Label5: TLabel;
    EdtConfSenha: TEdit;
    DataPefil: TDataSource;
    Label3: TLabel;
    ComboPerfil: TDBLookupComboBox;
    SbtCadPerfil: TSpeedButton;
    DataFuncionario: TDataSource;
    Label6: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActIncluirExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure SbtCadPerfilClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadUsuarios: TFrmCadUsuarios;

implementation

Uses uLibrary, uDmWorkCom, uFrmCadPerfil, uDMClientes;

{$R *.dfm}

procedure TFrmCadUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet  := DmClientes.CdsUsuarios;
  DataPefil.DataSet := DmClientes.CdsUsuariosPerfil;
  DataFuncionario.DataSet := DmClientes.CdsFuncionarios;
  DmClientes.Dados_Usuarios;
  DmClientes.Dados_Perfil;
  DmClientes.Dados_Funcionario;
  PageControl1.TabIndex := 0;

end;

procedure TFrmCadUsuarios.SbtCadPerfilClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmCadPerfil,FrmCadPerfil);
  try
    FrmCadPerfil.ShowModal;
    DmClientes.Dados_Perfil;
  finally
    FrmCadPerfil.Destroy;
  end;

end;

procedure TFrmCadUsuarios.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCadUsuarios.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);

end;

procedure TFrmCadUsuarios.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbUsuario.SetFocus;

end;

procedure TFrmCadUsuarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
   
end;

procedure TFrmCadUsuarios.ActConfirmarExecute(Sender: TObject);
begin
  if EdtConfSenha.Text = '' then
  begin
    MessageDlg('É necessário efetuar a confirmação da senha!!!', mtWarning, [mbOK], 0);
    EdtConfSenha.SetFocus;
    Abort;
  end
  else
  begin
    if DataWork.DataSet.FieldByName('SENHA').AsString <> EdtConfSenha.Text then
    begin
      MessageDlg('Senha não confere com a confirmação. Digite Novamente!!!', mtWarning, [mbOK], 0);
      DbSenha.SetFocus;
      Abort;
    end;
  end;
  inherited;

end;

end.
