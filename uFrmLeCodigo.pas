unit uFrmLeCodigo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmLeCodigo = class(TForm)
    GroupBox1: TGroupBox;
    EdtCodigo: TEdit;
    Label1: TLabel;
    procedure EdtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLeCodigo: TFrmLeCodigo;

implementation

{$R *.dfm}

procedure TFrmLeCodigo.EdtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    if Length(Trim(EdtCodigo.Text)) < 30 then
    begin
      ShowMessage('Código inválido!');
      EdtCodigo.SetFocus;
      Exit;
    end;
    Close;
  end;
  if key = VK_ESCAPE then
  begin
    EdtCodigo.Text := '';
    Close;
  end;
end;

end.
