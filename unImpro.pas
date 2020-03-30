unit unImpro;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, extens, DateUtils,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Db, jpeg;


type
  TfrmImpro = class(TForm)
    QuickRep1 : TQuickRep;
    QRBand2: TQRBand;
    QRLabel11: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel43: TQRLabel;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRSysData1: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
  end;

var
  frmImpro: TfrmImpro;

implementation

{$R *.DFM}

uses
ufrmGerarFaturas, math, uDmWorkcom; //fabricio tudo novo a unit

{
function dataextenso(mdt:tdatetime):string;
  var
//NoDia : Integer;
//DiaDaSemana : array [1..7] of String;
Meses : array [1..12] of String;
Dia, Mes, Ano : Word;
ndia,nano :int64;
tdia,tano: string;

//dataext: string;
begin
{ Dias da Semana
DiaDasemana [1]:= 'Domingo';
DiaDasemana [2]:= 'Segunda-feira';
DiaDasemana [3]:= 'Terça-feira';
DiaDasemana [4]:= 'Quarta-feira';
DiaDasemana [5]:= 'Quinta-feira';
DiaDasemana [6]:= 'Sexta-feira';
DiaDasemana [7]:= 'Sábado';
//
Meses [1]:= 'janeiro';
Meses [2]:= 'fevereiro';
Meses [3]:= 'março';
Meses [4]:= 'abril';
Meses [5]:= 'maio';
Meses [6]:= 'junho';
Meses [7]:= 'julho';
Meses [8]:= 'agosto';
Meses [9]:= 'setembro';
Meses [10]:= 'outubro';
Meses [11]:= 'novembro';
Meses [12]:= 'dezembro';
//ndia,nano :int64;
//tdia,tano: string;
DecodeDate (mdt, Ano, Mes, Dia);
//NoDia:= DayOfWeek (Now);

 ndia:=(dia) ;
 tdia:= numeroporExtensomasculino(ndia);
 nano:=(ano);
 tano:= numeroporextensomasculino(nano);
 venc:= inttostr(dia) + ' de '+ Meses [Mes] + ' de ' + inttostr(ano);
 result:= 'Aos ' + tDia + ' dias do mes de ' + Meses [Mes]+ ' do ano de ' + tAno;
//aos vinte e dois dias do mes de maio do ano de dois mil e quatro,
end;

}

procedure TfrmImpro.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);


begin
QrLabel3.caption :=(FormatDateTime('dddddd',QrDbText15.DataSet.FieldByName('DATA_VENC').AsDateTime));
QrLabel4.Caption:= extenso(QrDbText18.DataSet.FieldByName('VALOR_CONTA').AsCurrency);

end;

end.
