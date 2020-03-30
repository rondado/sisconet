unit unovobarras2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQuickReport2 = class(TQuickRep)
    DetailBand1: TQRBand;
    descricao: TQRLabel;
    valor: TQRLabel;
    Codbarras: TQRLabel;
  private

  public

  end;

var
  QuickReport2: TQuickReport2;

implementation

uses UDM, DB, unovobarras;

{$R *.DFM}


end.
