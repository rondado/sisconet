unit uRelQuita44Col;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, RLRichText;

type
  TFRelQuita44Col = class(TForm)
    RlQuitacao: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    LbLocalData: TRLLabel;
    LbTexto: TRLMemo;
    RLBand2: TRLBand;
    LbRazao: TRLLabel;
    LbEndereco: TRLLabel;
    LbCidadeUF: TRLLabel;
    LbCNPJ: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelQuita44Col: TFRelQuita44Col;

implementation

{$R *.dfm}

end.
