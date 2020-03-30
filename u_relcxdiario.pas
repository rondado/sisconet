unit u_relcxdiario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, QuickRpt, uDmWorkCom,
  QRCtrls, Datasnap.Provider, Data.DB, Datasnap.DBClient, Data.FMTBcd, ulibrary,
  Data.SqlExpr;

type
  Tfrmcxdiarios = class(TForm)
    QrcxDiarios: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    Qrldata: TQRLabel;
    Qrlpedido: TQRLabel;
    Qrlcliente: TQRLabel;
    Qrlreceita: TQRLabel;
    QRBand2: TQRBand;
    QrData: TQRDBText;
    QrPedido: TQRDBText;
    QrCliente: TQRDBText;
    QrReceita: TQRDBText;
    QrTipo: TQRDBText;
    Qrltipo: TQRLabel;
    QRBand3: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
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
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    cancelado: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    pgto: TQRLabel;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var Datade, Dataate, Horade, Horaate:String;
    aData, aDataF:TDateTime;
  ContItens, contCancelados, contpedidos, contcartoes, contconfirmados, contorc, contcupons, contnfe: Integer;
  ValorTroco: Double;
  t0, t1, t2, t3, t4, t5, t6, t7, toorc,tocupons,tonfe, totcanc,
  ped_valorTotal,ped_valor,ped_Desconto, ped_acrescimo, ped_ValorTroco, totoutros: currency;


  frmcxdiarios: Tfrmcxdiarios;



implementation

{$R *.dfm}

procedure Tfrmcxdiarios.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    totcanc:=0;
    toorc:=0;
    tocupons:=0;
    tonfe:=0;
    contorc:=0;
    contcupons:=0;
    contnfe:=0;
    contpedidos:=0;
    contcancelados:=0;
    ped_valorTotal:=0;
    ped_valor:=0;
    ped_Desconto:=0;
    ped_acrescimo:=0;
    ped_valorTroco:=0;
    totoutros:=0;
    contcartoes:=0;
    t0:= 0;
    t1:= 0;
    t2:= 0;
    t3:= 0;
    t4:= 0;
    t5:= 0;
    t6:= 0;
    t7:= 0;

end;

procedure Tfrmcxdiarios.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);

begin

                contpedidos:=contpedidos + 1;
                if DmWorkCom.CdsPedidosCANCELADO.AsString = 'S' then
                begin
                  contcancelados:= contcancelados + 1;
                  totcanc:= totcanc + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  cancelado.Caption:= 'Sim';
                  QrReceita.Font.Color:=clRed;
                end
                else
                begin
                  cancelado.Caption:= '';
                  QrReceita.Font.Color:= clWindowText;
                end;

                  ped_valorTotal:= ped_valorTotal + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  ped_valor:=ped_valor + DmWorkcom.CdsPedidosVALOR.AsCurrency ;
                  ped_Desconto:=ped_Desconto + DmWorkcom.CdsPedidosDESCONTO.AsCurrency;
                  ped_acrescimo:=ped_acrescimo + DmWorkcom.CdsPedidosACRESCIMO.AsCurrency;
                  ped_valorTroco:=ped_valorTroco + DmWorkcom.CdsPedidosVALOR_TROCO.AsCurrency;

                  if DmWorkCom.Dados_PedidoFP(DmWorkCom.CdsPedidosID.AsInteger,false) then
                  begin
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 0 then
                      begin
                         t0:=t0 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'Dinheiro'
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 1 then
                      begin
                         t1:=t1 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'Cheque'
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 2 then
                      begin
                         t2:=t2 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'Cartão'
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 3 then
                      begin
                         t3:=t3 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'A Prazo'
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 4 then
                      begin
                         t4:=t4 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'A Prazo'
                      end
                      else
                      if DmWorkCom.CDSPedidoFPTipo_Documento.AsInteger = 5 then
                      begin
                         t5:=t5 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'A Prazo'
                      end
                      else
                      begin
                         t6:=t6 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'Duplicata'
                      end;
                  end
                  else
                  begin
                         t7:=t7 + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                         pgto.Caption:= 'Outros'
                  end;

                  if ((DmWorkCom.CDSPedidosCOO.IsNull) or
                     (DmWorkCom.CDSPedidosCOO.AsInteger = 0))
                  and ((DmWorkCom.CDSPedidosnumero_doc.IsNull) or
                     (DmWorkCom.CDSPedidosnumero_doc.AsInteger = 0)) then
                  begin
                     contorc:= contorc+1;
                     toorc:= toorc + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  end
                  else
                  if (DmWorkCom.CDSPedidosCOO.AsInteger > 0)
                  and (DmWorkCom.CDSPedidosnumero_doc.IsNull) then
                  begin
                    contcupons:= contcupons+1;
                     tocupons:= tocupons + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  end
                  else
                  if (DmWorkCom.CDSPedidosnumero_doc.AsString <> '') then
                  begin
                    contnfe:= contnfe+1;
                     tonfe:= tonfe + DmWorkcom.CdsPedidosVALOR_TOTAL.AsCurrency;
                  end;
    DmWorkCom.Dados_PedidoItens(DmWorkCom.CdsPedidosID.AsInteger);

end;

procedure Tfrmcxdiarios.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
        FrmCxDiarios.QrLabel31.Caption:= AlinhaCampoValor(contpedidos,6,0);
        FrmCxDiarios.QrLabel32.Caption:= AlinhaCampoValor(contcancelados,6,0);
        FrmCxDiarios.QrLabel26.Caption:= AlinhaCampoValor(ped_valor,6,2);
        FrmCxDiarios.QrLabel27.Caption:= AlinhaCampoValor(ped_desconto,6,2);
        FrmCxDiarios.QrLabel28.Caption:= AlinhaCampoValor(ped_acrescimo,6,2);
        FrmCxDiarios.QrLabel29.Caption:= AlinhaCampoValor(ped_valortroco,6,2);
        FrmCxDiarios.QrLabel30.Caption:= AlinhaCampoValor(ped_valortotal,6,2);

        FrmCxDiarios.QrLabel18.Caption:= AlinhaCampoValor(t0,6,2);
        FrmCxDiarios.QrLabel19.Caption:= AlinhaCampoValor(t1,6,2);
        FrmCxDiarios.QrLabel20.Caption:= AlinhaCampoValor(t2,6,2);
        FrmCxDiarios.QrLabel21.Caption:= AlinhaCampoValor(t3,6,2);
        FrmCxDiarios.QrLabel22.Caption:= AlinhaCampoValor(t4,6,2);
        FrmCxDiarios.QrLabel23.Caption:= AlinhaCampoValor(t5,6,2);
        FrmCxDiarios.QrLabel24.Caption:= AlinhaCampoValor(t6,6,2);
        FrmCxDiarios.QrLabel25.Caption:= AlinhaCampoValor(t7,6,2);

        FrmCxDiarios.QrLabel34.Caption:= AlinhaCampoValor(contorc,6,0);
        FrmCxDiarios.QrLabel36.Caption:= AlinhaCampoValor(contcupons,6,0);
        FrmCxDiarios.QrLabel38.Caption:= AlinhaCampoValor(contnfe,6,0);

        FrmCxDiarios.QrLabel40.Caption:= AlinhaCampoValor(toorc,6,2);
        FrmCxDiarios.QrLabel42.Caption:= AlinhaCampoValor(tocupons,6,2);
        FrmCxDiarios.QrLabel44.Caption:= AlinhaCampoValor(tonfe,6,2);
        FrmCxDiarios.QrLabel46.Caption:= AlinhaCampoValor(totcanc,6,2);

end;

end.
