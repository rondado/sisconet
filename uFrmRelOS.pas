unit uFrmRelOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, QuickRpt, ExtCtrls, QRCtrls, FMTBcd, SqlExpr, DBClient,
  Provider;

type
  TFrmRelOS = class(TForm)
    QrRelOS: TQuickRep;
    QRBand1: TQRBand;
    QRBandDetalhe: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QrPeriodo: TQRLabel;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRGroup1: TQRGroup;
    QRBandRodape: TQRBand;
    QrLbGrupo: TQRLabel;
    QRLabel10: TQRLabel;
    QryRelOS: TSQLQuery;
    QRLabel3: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel12: TQRLabel;
    DspRelOS: TDataSetProvider;
    CdsRelOS: TClientDataSet;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText11: TQRDBText;
    QryRelOSN_CONTROLE: TStringField;
    QryRelOSDATA_OS: TSQLTimeStampField;
    QryRelOSDATA_TRAB: TSQLTimeStampField;
    QryRelOSHORA_INICIO: TSQLTimeStampField;
    QryRelOSHORA_FIM: TSQLTimeStampField;
    QryRelOSTEMPO_GASTO: TSQLTimeStampField;
    QryRelOSNOME: TStringField;
    QryRelOSCONTATO: TStringField;
    QryRelOSID_CONTATO: TIntegerField;
    QryRelOSVALOR_COBRADO: TFloatField;
    QryRelOSDESCONTO: TFloatField;
    QryRelOSACRESCIMO: TFloatField;
    QryRelOSOUTROS: TFloatField;
    QryRelOSVALOR_PAGO: TFloatField;
    QryRelOSSTATUS: TIntegerField;
    CdsRelOSN_CONTROLE: TStringField;
    CdsRelOSDATA_OS: TSQLTimeStampField;
    CdsRelOSDATA_TRAB: TSQLTimeStampField;
    CdsRelOSHORA_INICIO: TSQLTimeStampField;
    CdsRelOSHORA_FIM: TSQLTimeStampField;
    CdsRelOSTEMPO_GASTO: TSQLTimeStampField;
    CdsRelOSNOME: TStringField;
    CdsRelOSCONTATO: TStringField;
    CdsRelOSID_CONTATO: TIntegerField;
    CdsRelOSVALOR_COBRADO: TFloatField;
    CdsRelOSDESCONTO: TFloatField;
    CdsRelOSACRESCIMO: TFloatField;
    CdsRelOSOUTROS: TFloatField;
    CdsRelOSVALOR_PAGO: TFloatField;
    CdsRelOSSTATUS: TIntegerField;
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QrVrCobradoPrint(sender: TObject; var Value: String);
    procedure QrDescontoPrint(sender: TObject; var Value: String);
    procedure QrAcrescimoPrint(sender: TObject; var Value: String);
    procedure QrVrPagoPrint(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure QRLabel5Print(sender: TObject; var Value: String);
  private
    { Private declarations }
    gIDCliente : Integer;
    gTotalGrupo : Double;
  public
    { Public declarations }
  end;

var
  FrmRelOS: TFrmRelOS;

implementation

Uses uLibrary, uDmConexao;

{$R *.dfm}

procedure TFrmRelOS.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrLbGrupo.Caption := ZeroEsquerda(IntToStr(CdsRelOSID_CONTATO.Value),5)+' - '+CdsRelOSCONTATO.Value;
  if CdsRelOSID_CONTATO.Value <> gIDCliente then
  begin
    gTotalGrupo := 0;
    gIDCliente  := CdsRelOSID_CONTATO.Value;
  end;
  // soma total do grupo
  gTotalGrupo := gTotalGrupo + CdsRelOSVALOR_PAGO.AsFloat;

end;

procedure TFrmRelOS.FormCreate(Sender: TObject);
begin
  gTotalGrupo := 0;
  gIDCliente  := 0;
  CdsRelOSVALOR_COBRADO.DisplayFormat := '###,###,###,##0.00';
  CdsRelOSDESCONTO.DisplayFormat      := '###,###,###,##0.00';
  CdsRelOSACRESCIMO.DisplayFormat     := '###,###,###,##0.00';
  CdsRelOSOUTROS.DisplayFormat        := '###,###,###,##0.00';
  CdsRelOSVALOR_PAGO.DisplayFormat    := '###,###,###,##0.00';
  CdsRelOSDATA_OS.DisplayFormat                := 'dd/mm/yyyy';
  CdsRelOS.FieldByName('DATA_OS').EditMask     := '!99/99/0000;1; ';
  CdsRelOSDATA_TRAB.DisplayFormat              := 'dd/mm/yyyy';
  CdsRelOS.FieldByName('DATA_TRAB').EditMask   := '!99/99/0000;1; ';
  CdsRelOSHORA_INICIO.DisplayFormat            := 'hh:mm';
  CdsRelOS.FieldByName('HORA_INICIO').EditMask := '!90:00;1;';
  CdsRelOSHORA_FIM.DisplayFormat               := 'hh:mm';
  CdsRelOS.FieldByName('HORA_FIM').EditMask    := '!90:00;1;';
  CdsRelOSTEMPO_GASTO.DisplayFormat            := 'hh:mm';
  CdsRelOS.FieldByName('TEMPO_GASTO').EditMask := '!90:00;1;';

end;

procedure TFrmRelOS.QrVrCobradoPrint(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelOS.QrDescontoPrint(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelOS.QrAcrescimoPrint(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelOS.QrVrPagoPrint(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelOS.QRExpr1Print(sender: TObject; var Value: String);
var valor:double;
begin
  valor := strtofloat(value);
  value := format('%m',[valor]);

end;

procedure TFrmRelOS.QRLabel5Print(sender: TObject; var Value: String);
begin
  value := format('%m',[gTotalGrupo]);

end;

end.
