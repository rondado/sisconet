unit uQrRelComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, QuickRpt;

type
  TRelComissao = class(TFrmPadrao)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RelComissao: TRelComissao;

implementation

{$R *.dfm}

end.
