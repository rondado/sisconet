unit uFrmSelImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.StdCtrls,
  uFrameConfirmaCancela;

type
  TFrmSelImpressao = class(TFrmPadrao)
    RdTipoImpressao: TRadioGroup;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    procedure FormCreate(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sTipoImpressao : Integer;
  end;

var
  FrmSelImpressao: TFrmSelImpressao;

implementation

{$R *.dfm}

uses uLibrary;

procedure TFrmSelImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  sTipoImpressao := -1;
end;

procedure TFrmSelImpressao.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  sTipoImpressao := -1;
  Close;
end;

procedure TFrmSelImpressao.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  if Confirmacao('Confirma a impressão?') then
  begin
    sTipoImpressao := RdTipoImpressao.ItemIndex;
    Close;
  end;
end;

end.
