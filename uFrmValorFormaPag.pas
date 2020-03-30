unit uFrmValorFormaPag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, Mask, DBCtrls, uFrameConfirmaCancela,
  ExtCtrls, DB, DBClient;

type
  TFrmValorFormaPag = class(TFrmPadrao)
    CdsValor: TClientDataSet;
    DataValor: TDataSource;
    CdsValorValor: TFloatField;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    LbTroco: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sOK : Boolean;
    sValor : Double;
  end;

var
  FrmValorFormaPag: TFrmValorFormaPag;

implementation

uses uLibrary, uFrmFecharCupom, uDmWorkCom;

{$R *.dfm}

procedure TFrmValorFormaPag.FormShow(Sender: TObject);
begin
  inherited;
  sOK := false;
  CdsValor.Append;
  CdsValorValor.AsFloat := FrmFecharCupom.CdsTotalPagoRESTANTE.AsFloat;
  DBEdit1.SetFocus;
  DBEdit1.SelectAll;

end;

procedure TFrmValorFormaPag.FormCreate(Sender: TObject);
begin
  inherited;
  if not CdsValor.Active then
     CdsValor.CreateDataSet;
  CdsValor.EmptyDataSet;
  CdsValor.Open;
  TFloatField(CdsValor.FieldByName('Valor')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;

end;

procedure TFrmValorFormaPag.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  CdsValor.Cancel;
  sValor := 0;
  sOK := false;
  Close;

end;

procedure TFrmValorFormaPag.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  if CdsValor.State in [dsInsert,dsEdit] then
     CdsValor.Post;
  if CdsValorValor.AsFloat <= 0 then
  begin
    MessageDlg('É necessário informar um valor!', mtWarning, [mbOK], 0);
    Abort;
  end;
  sValor := CdsValorValor.AsFloat;
  sOK := true;
  Close;

end;

procedure TFrmValorFormaPag.DBEdit1Exit(Sender: TObject);
var
troc: currency;//fabricio

begin
  inherited;
//fabricio
  troc:= StrToCurr(DbEdit1.Text) -
  FrmFecharCupom.DataCupom.DataSet.FieldByName('VALOR_TOTAL').AsCurrency;
  LbTroco.Caption:= 'R$ '+ FormatFloat('0.00',troc);

end;

procedure TFrmValorFormaPag.DBEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

end.
