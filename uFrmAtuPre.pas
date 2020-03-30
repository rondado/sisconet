unit uFrmAtuPre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmAtuPre = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbpreantigo: TLabel;
    lbmargem: TLabel;
    lbprenovo: TLabel;
    Label7: TLabel;
    edpreusado: TEdit;
    Label4: TLabel;
    lbprecompra: TLabel;
    lbdescricao: TLabel;
    lbean13: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edpreusadoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAtuPre: TFrmAtuPre;

implementation

{$R *.dfm}

procedure TFrmAtuPre.edpreusadoKeyPress(Sender: TObject; var Key: Char);
begin
if (key = #13) or (key = #27) then
begin
   if StrToCurr(edpreusado.Text) > 0  then
   begin
   close;
   end
   else
   begin
      ShowMessage('Valor inválido');
      edpreusado.SetFocus;
   end;
end;


end;

procedure TFrmAtuPre.FormShow(Sender: TObject);
begin
edpreusado.SetFocus;
end;

end.
