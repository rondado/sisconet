unit uFrmRelcaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB;

type
  TFrmRelcaixa = class(TForm)
    QrCaixa: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LbCaixa: TQRLabel;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    DataCaixa: TDataSource;
    QRLabel6: TQRLabel;
    LbCredito: TQRLabel;
    LbDebito: TQRLabel;
    LbSaldo: TQRLabel;
    QrLbentrada: TQRLabel;
    QrLbSaida: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText3: TQRDBText;
    procedure FormShow(Sender: TObject);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrLbentradaPrint(sender: TObject; var Value: String);
    procedure QrLbSaidaPrint(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure LbCreditoPrint(sender: TObject; var Value: String);
    procedure LbDebitoPrint(sender: TObject; var Value: String);
    procedure LbSaldoPrint(sender: TObject; var Value: String);
  private
    { Private declarations }
    sValEnt, svalSai : double;
  public
    { Public declarations }
  end;

var
  FrmRelcaixa: TFrmRelcaixa;

implementation

uses uLibrary,uDmWorkCom;

{$R *.dfm}

procedure TFrmRelcaixa.FormShow(Sender: TObject);
begin
  DataCaixa.DataSet := DmWorkCom.CdsCaixaMov;
  
end;

procedure TFrmRelcaixa.QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString = 'D' then
  begin
    sValEnt := 0;
    svalSai := DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsFloat;
  end
  else if DmWorkCom.CdsCaixaMov.FieldByName('DC').AsString = 'C' then
  begin
    sValEnt := DmWorkCom.CdsCaixaMov.FieldByName('VALOR').AsFloat;
    svalSai := 0;
  end;
end;

procedure TFrmRelcaixa.QrLbentradaPrint(sender: TObject;
  var Value: String);
begin
  Value := '';
  if sValEnt > 0 then
     value := format('%m',[sValEnt]);

end;

procedure TFrmRelcaixa.QrLbSaidaPrint(sender: TObject; var Value: String);
begin
  Value := '';
  if svalSai > 0 then
     value := format('%m',[svalSai]);

end;

procedure TFrmRelcaixa.QRDBText3Print(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelcaixa.LbCreditoPrint(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelcaixa.LbDebitoPrint(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelcaixa.LbSaldoPrint(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

end.
