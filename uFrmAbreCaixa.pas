unit uFrmAbreCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, uFrameConfirmaCancela, ExtCtrls, StdCtrls, Mask,
  DBCtrls, ActnList, System.Actions;

type
  TFrmAbreCaixa = class(TFrmPadrao)
    DataCaixa: TDataSource;
    DataFuncionario: TDataSource;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboFuncionario: TDBLookupComboBox;
    DbValor: TDBEdit;
    ActionList1: TActionList;
    ActMenuFiscal: TAction;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label29: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button1: TButton;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    procedure FormShow(Sender: TObject);
    procedure ComboFuncionarioKeyPress(Sender: TObject; var Key: Char);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sValor : Double;
  end;

var
  FrmAbreCaixa: TFrmAbreCaixa;

implementation

uses uLibrary,uDmWorkCom, uFuncoesPAFECF, uFrmMenuFiscal, uDMClientes;

{$R *.dfm}

procedure TFrmAbreCaixa.FormShow(Sender: TObject);
begin
  inherited;
  DataCaixa.DataSet       := DmWorkCom.CdsCaixa;
  DataFuncionario.DataSet := DmClientes.CdsFuncionarios;
  sValor := 0;
  DataCaixa.DataSet.Append;
  DataCaixa.DataSet.FieldByName('CAIXA').AsString       := DmWorkCom.PAFECF.gCaixa;
  DataCaixa.DataSet.FieldByName('NUMSERIEFAB').AsString := DmWorkCom.PAFECF.gSerial;
  DataCaixa.DataSet.FieldByName('IDOPERADOR').AsInteger := DmWorkCom.PAFECF.gIDOperador;
  ComboFuncionario.SetFocus;
  
end;

procedure TFrmAbreCaixa.Button1Click(Sender: TObject);
begin
  inherited;
Label8.Caption:= CurrToStr((StrToCurr(Edit1.Text) *    1) + (StrToCurr(Edit2.Text) *  0.5) +
                           (StrToCurr(Edit3.Text) * 0.25) + (StrToCurr(Edit4.Text) * 0.10) +
                           (StrToCurr(Edit5.Text) * 0.05)+  (StrToCurr(Edit6.Text) *   50)  +
                           (StrToCurr(Edit7.Text) *   20) + (StrToCurr(Edit8.Text) *   10)  +
                           (StrToCurr(Edit9.Text) *    5) + (StrToCurr(Edit10.Text) *   2) +
                            StrToCurr(Edit11.Text) + StrToCurr(Edit12.Text));

DmWorkCom.CdsCaixaVALOR_ABERTURA.AsCurrency:= StrToCurr(label8.Caption);
//DbValor.Text:= label8.Caption;
Label8.Caption:= 'R$ ' + FormatFloat('###0.00',StrToCurr(Label8.Caption));
dbValor.SelectAll;
dbvalor.SetFocus;

end;

procedure TFrmAbreCaixa.ComboFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmAbreCaixa.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
if (Key = #13) or (key =#09) then begin
   SelectNext(TWincontrol(Sender),True,True);
   Key:=#0;

end;
end;

procedure TFrmAbreCaixa.FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if ComboFuncionario.Text = '' then
  begin
    MessageDlg('É necessário selefionar o funcinário!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
//fabricio novo
  DmWorkCom.CdsCaixaHORA_ABERTURA.AsDateTime:=now;
  if confirmacao ('Deseja imprimir a abertura de caixa?') then
     DmWorkCom.PAFECF.EmiteGerencialSSuprimentoNFCe(DmWorkCom.PAFECF.gCaixa,
                                                         DmWorkCom.PAFECF.gOperador,
                                                         now,FrmAbrecaixa.DataCaixa.DataSet.FieldByname('VALOR_ABERTURA').AsFloat);

  DataCaixa.DataSet.Post;
  Grava_Dados(DataCaixa.DataSet);
  sValor := DataCaixa.DataSet.FieldByname('VALOR_ABERTURA').AsFloat;
  Close;

end;

procedure TFrmAbreCaixa.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  DataCaixa.DataSet.Cancel;
  Grava_Dados(DataCaixa.DataSet);
  Close;

end;

procedure TFrmAbreCaixa.ActMenuFiscalExecute(Sender: TObject);
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
