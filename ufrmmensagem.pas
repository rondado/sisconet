unit ufrmmensagem;
 
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFrmMensagem = class(TForm)
    Panel3: TPanel;
    PanelMens: TPanel;
    Panel2: TPanel;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure CriaMensAguarde(const Mens: string);
    class procedure FechaMensAguarde;
  end;

var
  FrmMensagem: TFrmMensagem;

implementation

{$R *.dfm}

{ Tfrmmensagem }

class procedure TFrmMensagem.CriaMensAguarde(const Mens: string);
begin
  Screen.Cursor := crHourGlass;

  if not Assigned(FrmMensagem) then
  	FrmMensagem := TFrmMensagem.Create(application);

  FrmMensagem.PanelMens.Caption := Mens;
  FrmMensagem.Show;
  FrmMensagem.Update;
  Application.ProcessMessages;
end;

class procedure TFrmMensagem.FechaMensAguarde;
begin
  if assigned(FrmMensagem) then
  begin
    Screen.Cursor := crDefault;
    FreeAndNil(FrmMensagem);
  end;
end;

end.

