unit uFrmNfeReferencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmNfeReferencia = class(TForm)
    Lbchave: TLabel;
  private
    { Private declarations }
  public
  chave: string;
    { Public declarations }
  end;

var
  FrmNfeReferencia: TFrmNfeReferencia;

implementation

{$R *.dfm}

end.
