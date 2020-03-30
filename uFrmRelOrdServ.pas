unit uFrmRelOrdServ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ExtCtrls, Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider,
  Data.DB, Data.SqlExpr;

type
  TFrmRelOrdServ = class(TFrmPadrao)
    GroupBox4: TGroupBox;
    RadioStatusR: TRadioGroup;
    GroupBox8: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    DataRi: TDateTimePicker;
    DataRf: TDateTimePicker;
    BitBtn9: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelOrdServ: TFrmRelOrdServ;

implementation

{$R *.dfm}

uses uLibrary, uDmConexao, uDmRelatorios, uDmWorkCom;

procedure TFrmRelOrdServ.BitBtn9Click(Sender: TObject);
begin
  inherited;
  try
    with DmRelatorios do
    begin
      CdsOrdServ.Close;
      CdsOrdServ.FetchParams;
      CdsOrdServ.Params.ParamByName('pDatai').AsDate := DataRi.Date;
      CdsOrdServ.Params.ParamByName('pDataf').AsDate := DataRf.Date;
      CdsOrdServ.Params.ParamByName('pStatus').AsInteger := RadioStatusR.ItemIndex;
      CdsOrdServ.Open;
      TFloatField(CdsOrdServ.FieldByName('VALOR_COBRADO')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
      TFloatField(CdsOrdServ.FieldByName('VALOR_PAGO')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
      if CdsOrdServ.RecordCount > 0 then
      begin
        // abre Dados das horas trabalhadas
        CdsHorasTrab.Close;
        CdsHorasTrab.Params.ParamByName('pIDOS').AsInteger := 0;
        CdsHorasTrab.Open;
        // Configura relatorio
        PassaPeriodoRelatorio(DataRi.Date,DataRf.Date);
        // abre o relatorio
        frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\OrdemServico.fr3');
        frxGeral.ShowReport();
      end
      else
        MessageDlg('Não foram encontrados dados para o relatório', mtWarning, [mbOK], 0);
    end;
  except
    on E:Exception do ShowMessage(E.Message);
  end;

end;

procedure TFrmRelOrdServ.FormShow(Sender: TObject);
begin
  inherited;
  DataRi.Date := PrimeiroDia(SVData);
  DataRf.Date := UltimoDia(SVData);

end;

end.
