unit uFrmSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFrmSenha = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EdtSenha: TEdit;
    Image1: TImage;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure EdtSenhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sOK : Boolean;
  end;

var
  FrmSenha: TFrmSenha;

implementation

uses uLibrary, uDmSPED;

{$R *.dfm}

procedure TFrmSenha.FormCreate(Sender: TObject);
begin
  sOK := false;

end;

procedure TFrmSenha.EdtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if Criptografa(EdtSenha.Text,10) <> DmSPED.sSenhaAcesso then
    begin
      MessageDlg('Senha não confere. Verifique!', mtError, [mbOK], 0);
      EdtSenha.SelectAll;
      EdtSenha.SetFocus;
      Abort;
    end;
    sOK := true;
    Close;
  end;
  if (key = #27) then
  begin
    sOK := false;
    Close;
  end;

end;

end.
