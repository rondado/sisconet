unit uFrmMensageemProd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFrmMensageemProd = class(TForm)
    PnMensagem: TPanel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMensageemProd: TFrmMensageemProd;

implementation

{$R *.dfm}

procedure TFrmMensageemProd.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
     Close;
     
end;

end.
