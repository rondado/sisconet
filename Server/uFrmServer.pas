unit uFrmServer;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmServer = class(TForm)
    GrpPorta: TGroupBox;
    EdtPorta: TEdit;
    BtnIniciar: TBitBtn;
    procedure BtnIniciarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmServer: TFrmServer;

implementation

{$R *.dfm}

uses ServerContainerUnit1;

procedure TFrmServer.BtnIniciarClick(Sender: TObject);
begin
  if btnIniciar.Caption = 'Iniciar' then
  begin
    ServerContainer1.DSTCPServerTransport1.Port := StrToInt(EdtPorta.Text);
    ServerContainer1.DSServer1.Start;
    if ServerContainer1.DSServer1.Started then
    begin
      BtnIniciar.Kind := bkCancel;
      btnIniciar.Caption := 'Parar';
    end;
  end else
  begin
    ServerContainer1.DSServer1.Stop;
    if not ServerContainer1.DSServer1.Started then
    begin
      BtnIniciar.Kind := bkAll;
      btnIniciar.Caption := 'Iniciar';
    end;
  end;

end;

procedure TFrmServer.FormCreate(Sender: TObject);
begin
  BtnIniciar.Kind := bkAll;
  btnIniciar.Caption := 'Iniciar';

end;

end.

