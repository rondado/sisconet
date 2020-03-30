unit uFrmMovFinanceiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, uFrameConfirmaCancela, ExtCtrls, StdCtrls, ActnList,
  ComCtrls, FMTBcd, DB, SqlExpr, System.Actions, Datasnap.DBClient,
  Datasnap.Provider, frxClass, frxDBSet;

type
  TFrmMovFinanceiro = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    ActionList1: TActionList;
    ActCancelar: TAction;
    ActConfirmar: TAction;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    QryMovto: TSQLQuery;
    frxReport1: TfrxReport;
    frxDbMovto: TfrxDBDataset;
    DspMovimento: TDataSetProvider;
    CdsMovto: TClientDataSet;
    DataMovto: TDataSource;
    CdsMovtoDESCRICAO: TStringField;
    CdsMovtoVALOR: TFloatField;
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMovFinanceiro: TFrmMovFinanceiro;

implementation

Uses uLibrary, uDmConexao, uDmRelatorios, uDmWorkCom;

{$R *.dfm}

procedure TFrmMovFinanceiro.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  close;

end;

procedure TFrmMovFinanceiro.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  CdsMovto.Close;
  CdsMovto.Params.Clear;
  QryMovto.Close;
  QryMovto.SQL.Clear;
  QryMovto.SQL.Add('select * from proc_resultado_financeiro(:pDatai,:pDataf)');
  CdsMovto.FetchParams;
  CdsMovto.Params.ParamByName('pDatai').AsDate := Datai.Date;
  CdsMovto.Params.ParamByName('pDataf').AsDate := Dataf.Date;
  CdsMovto.Open;
  TFloatField(CdsMovto.FieldByName('VALOR')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  // verifica dados
  if CdsMovto.IsEmpty then
  begin
    MessageDlg('Não foram encontrados dados no período!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\MovtoFinanceiro.fr3');
  frxReport1.ShowReport;

end;

procedure TFrmMovFinanceiro.FormShow(Sender: TObject);
begin
  inherited;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);
  Datai.SetFocus;
end;


end.

