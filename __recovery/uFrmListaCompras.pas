unit uFrmListaCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ActnList, uFrameConfirmaCancela, StdCtrls, ComCtrls,
  ExtCtrls, FMTBcd, DB, SqlExpr, System.Actions;

type
  TFrmListaCompras = class(TFrmPadrao)
    GrpPeriodo: TGroupBox;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    ActionList1: TActionList;
    ActImprimir: TAction;
    ActEncerrar: TAction;
    ChConfirmados: TCheckBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    ChItens: TCheckBox;
    procedure ActImprimirExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure MontaSQLCompras;
  public
    { Public declarations }
  end;

var
  FrmListaCompras: TFrmListaCompras;

implementation

Uses uLibrary, uDmWorkCom, uDmRelatorios;

{$R *.dfm}

procedure TFrmListaCompras.ActImprimirExecute(Sender: TObject);
var aTipo:String;
begin
  inherited;
  MontaSQLCompras;
  DmRelatorios.PassaPeriodoRelatorio(Datai.Date,Dataf.Date);
  DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ListaCompras.fr3');
  DmRelatorios.frxGeral.ShowReport();


end;

procedure TFrmListaCompras.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmListaCompras.FormShow(Sender: TObject);
begin
  inherited;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);

end;


procedure TFrmListaCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DmRelatorios.CdsRelatorios.Close;

end;

procedure TFrmListaCompras.MontaSQLCompras;
begin
  with DmRelatorios do
  begin
    CdsRelatorios.Close;
    CdsRelatorios.Params.Clear;
    QryRelatorios.Close;
    QryRelatorios.SQL.Clear;
    QryRelatorios.SQL.Add('select c.id,c.nota,f.nome,c.data_compra,c.data_emissao,');
    QryRelatorios.SQL.Add('       c.valor_total,c.chave_nfe');
    QryRelatorios.SQL.Add('from compras c');
    QryRelatorios.SQL.Add('inner join contato f on c.idfornecedor = f.id');
    QryRelatorios.SQL.Add('where c.data_compra between :pDatai and :pDataf');
    QryRelatorios.SQL.Add('and c.confirmada = :pConfirmada');
    QryRelatorios.SQL.Add('and c.nota <> '+QuotedStr(''));
    CdsRelatorios.FetchParams;
    CdsRelatorios.Params.ParamByName('pDatai').AsDate := Datai.Date;
    CdsRelatorios.Params.ParamByName('pDataf').AsDate := Dataf.Date;
    if ChConfirmados.Checked then
       CdsRelatorios.Params.ParamByName('pConfirmada').AsString := 'S'
    else
       CdsRelatorios.Params.ParamByName('pConfirmada').AsString := 'S';
    CdsRelatorios.Open;
    TFloatField(CdsRelatorios.FieldByName('VALOR_TOTAL')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  end;

end;

end.

