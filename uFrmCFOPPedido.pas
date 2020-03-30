unit uFrmCFOPPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB;

type
  TFrmCFOPPedido = class(TForm)
    EdCST: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdCFOP: TEdit;
    procedure EdValor_ICMSKeyPress(Sender: TObject; var Key: Char);
    procedure EdCSTKeyPress(Sender: TObject; var Key: Char);
    procedure EdCFOPKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCFOPPedido: TFrmCFOPPedido;

implementation

uses
uDmworkCom;


{$R *.dfm}

procedure TFrmCFOPPedido.EdCFOPKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   close;
end;

procedure TFrmCFOPPedido.EdCSTKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   edcfop.SetFocus;
end;

procedure TFrmCFOPPedido.EdValor_ICMSKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
     close;
end;

procedure TFrmCFOPPedido.FormShow(Sender: TObject);
begin
edCst.SetFocus;
end;

end.
