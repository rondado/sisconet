unit uFrmLiberacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, Mask, ExtCtrls, Vcl.Imaging.jpeg;

type
  TFrmLiberacao = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    EdtUsuario: TMaskEdit;
    EdtSenha: TMaskEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure EdtUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sOk : Boolean;
    sIDUsuario : Integer;
  end;

var
  FrmLiberacao: TFrmLiberacao;

implementation

uses uLibrary, uDmWorkCom, DB, uDMClientes;

{$R *.dfm}

procedure TFrmLiberacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #27) then
  begin
    sOk := false;
    sIDUsuario := 0;
    Close;
  end;
end;

procedure TFrmLiberacao.FormCreate(Sender: TObject);
begin
  inherited;
  sOk := false;
  sIDUsuario := 0;

end;

procedure TFrmLiberacao.EdtUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmLiberacao.EdtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
  begin
    if not DmClientes.Dados_Usuarios(UpperCase(EdtUsuario.Text)) then
    begin
      MessageDlg('Usuário não encontrado. Tente novamente!', mtWarning, [mbOK], 0);
      EdtUsuario.SelectAll;
      EdtUsuario.SetFocus;
      Exit;
    end
    else
    begin
      // verifica a senha informada
      if Criptografa(DmClientes.CdsUsuariosSENHA.AsString,10) <> EdtSenha.Text then
      begin
        MessageDlg('Senha Inválida. Tente novamente!', mtWarning, [mbOK], 0);
        EdtSenha.SelectAll;
        EdtSenha.SetFocus;
        Exit;
      end;
      // verifica se o usuário é administrador
      if DmClientes.CdsUsuariosTIPO_USUARIO.AsInteger > 1 then
      begin
        MessageDlg('A liberação deve ser realizada por um administrador ou supervisor!', mtWarning, [mbOK], 0);
        sOk := false;
        sIDUsuario := 0;
        Close;
      end
      else
      begin
        sOk := true;
        sIDUsuario := DmClientes.CdsUsuariosID.AsInteger;
        Close;
      end;
    end;
  end;
end;

procedure TFrmLiberacao.FormShow(Sender: TObject);
begin
  inherited;
  EdtUsuario.SetFocus;
  
end;

end.
