unit uFrmFechaCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, DBClient, StdCtrls, uFrameConfirmaCancela,
  ExtCtrls, Mask, DBCtrls, ActnList, System.Actions;

type
  TFrmFechaCaixa = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    CdsFechamento: TClientDataSet;
    DataFechamento: TDataSource;
    Label1: TLabel;
    DbDinheiro: TDBEdit;
    Label2: TLabel;
    DbCartao: TDBEdit;
    Label3: TLabel;
    DbCheque: TDBEdit;
    Label4: TLabel;
    DbOutros: TDBEdit;
    CdsFechamentoDINHEIRO: TCurrencyField;
    CdsFechamentoCARTAO: TCurrencyField;
    CdsFechamentoCHEQUE: TCurrencyField;
    CdsFechamentoOUTROS: TCurrencyField;
    ActionList1: TActionList;
    ActMenuFiscal: TAction;
    Edit1: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Label10: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Edit7: TEdit;
    Label13: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Edit8: TEdit;
    Label14: TLabel;
    Edit4: TEdit;
    Label8: TLabel;
    Edit9: TEdit;
    Label15: TLabel;
    Edit5: TEdit;
    Label9: TLabel;
    Edit10: TEdit;
    Label16: TLabel;
    Button1: TButton;
    Label29: TLabel;
    Label18: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DbDinheiroKeyPress(Sender: TObject; var Key: Char);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    idcx: integer;
    { Private declarations }
  public
    { Public declarations }
    sDinheiro, sCartao, sCheque, sOutros : Double;
  end;

var
  FrmFechaCaixa: TFrmFechaCaixa;

implementation

uses uLibrary, uFrmMenuFiscal, uDmWorkCom;

{$R *.dfm}

procedure TFrmFechaCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  if not CdsFechamento.Active then
     CdsFechamento.CreateDataSet;
  CdsFechamento.EmptyDataSet;
  CdsFechamento.Append;
  CdsFechamentoDINHEIRO.AsFloat := 0;
  CdsFechamentoCARTAO.AsFloat := 0;
  CdsFechamentoCHEQUE.AsFloat := 0;
  CdsFechamentoOUTROS.AsFloat := 0;
  sDinheiro := 0;
  sCartao   := 0;
  sCheque   := 0;
  sOutros   := 0;

end;

procedure TFrmFechaCaixa.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  sDinheiro := 0;
  sCartao   := 0;
  sCheque   := 0;
  sOutros   := 0;
  Close;

end;

procedure TFrmFechaCaixa.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);

begin
  inherited;
  sDinheiro := CdsFechamentoDINHEIRO.AsFloat;
  sCartao   := CdsFechamentoCARTAO.AsFloat;
  sCheque   := CdsFechamentoCHEQUE.AsFloat;
  sOutros   := CdsFechamentoOUTROS.AsFloat;
  Close;

end;

procedure TFrmFechaCaixa.FormShow(Sender: TObject);
begin
  inherited;
    edit1.SelectAll;
    edit1.SetFocus;
//  DbDinheiro.SelectAll;
//  DbDinheiro.SetFocus;

end;

procedure TFrmFechaCaixa.Button1Click(Sender: TObject);
begin
  inherited;
Label18.Caption:= CurrToStr((StrToCurr(Edit1.Text) *    1) + (StrToCurr(Edit2.Text) *  0.5) +
                           (StrToCurr(Edit3.Text) * 0.25) + (StrToCurr(Edit4.Text) * 0.10) +
                           (StrToCurr(Edit5.Text) * 0.05)+  (StrToCurr(Edit6.Text) *   50)  +
                           (StrToCurr(Edit7.Text) *   20) + (StrToCurr(Edit8.Text) *   10)  +
                           (StrToCurr(Edit9.Text) *    5) + (StrToCurr(Edit10.Text) *   2));

//                            StrToCurr(DbCheque.Text) + StrToCurr(DbCartao.Text)+StrToCurr(DbOutros.Text));

DataFechamento.DataSet.FieldByName('DINHEIRO').AsCurrency:= StrToCurr(label18.Caption);
//DbDinheiro.Text:= label18.Caption;
//Label18.Caption:= 'R$ ' + FormatFloat('###0.00',StrToCurr(Label18.Caption));
DbDinheiro.SelectAll;
DbDinheiro.SetFocus;

end;

procedure TFrmFechaCaixa.DbDinheiroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

procedure TFrmFechaCaixa.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
if (Key = #13) or (key =#09) then begin
   SelectNext(TWincontrol(Sender),True,True);
   Key:=#0;

end;

end;

procedure TFrmFechaCaixa.ActMenuFiscalExecute(Sender: TObject);
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

end.
