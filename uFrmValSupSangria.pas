unit uFrmValSupSangria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, DBClient, StdCtrls, uFrameConfirmaCancela,
  ExtCtrls, Mask, DBCtrls, ActnList;

type
  TFrmValSupSangria = class(TFrmPadrao)
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CdsValor: TClientDataSet;
    CdsValorVALOR: TFloatField;
    DBEdit1: TDBEdit;
    DataValor: TDataSource;
    ActionList1: TActionList;
    ActMenuFiscal: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    sValor : Double;
  end;

var
  FrmValSupSangria: TFrmValSupSangria;

implementation

uses uFrmMenuFiscal, uDmWorkCom;

{$R *.dfm}

procedure TFrmValSupSangria.FormCreate(Sender: TObject);
begin
  inherited;
  if not CdsValor.Active then
     CdsValor.CreateDataSet;
  CdsValor.EmptyDataSet;
  sValor := 0;
     
end;

procedure TFrmValSupSangria.FormShow(Sender: TObject);
begin
  inherited;
  CdsValor.Append;
  CdsValorVALOR.AsFloat := 0;
  DBEdit1.SelectAll;
  DBEdit1.SetFocus;
end;

procedure TFrmValSupSangria.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  sValor := 0;
  Close;

end;

procedure TFrmValSupSangria.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  sValor := CdsValorVALOR.AsFloat;
  Close;

end;

procedure TFrmValSupSangria.ActMenuFiscalExecute(Sender: TObject);
var aMensagem : String;
begin
  inherited;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
  begin
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  end
  else
  begin
    if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
    begin
      ShowMessage(aMensagem);
      DmWorkCom.PAFECF.sControleECFAtivo := 2;
    end;
  end;  
   Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
   Try
      FrmMenuFiscal.ShowModal;
   Finally
      FrmMenuFiscal.Destroy;
   End;

end;

procedure TFrmValSupSangria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CdsValor.Close;
  FreeAndNil(CdsValor);

end;

end.
