unit uFrmRegistraDescAcres;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, Mask, ExtCtrls, Buttons, ActnList,
  System.Actions;

type
  TFrmRegistraDescAcres = class(TFrmPadrao)
    RadioAplicar: TRadioGroup;
    GrpValor: TGroupBox;
    EdtValor: TMaskEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioTipo: TRadioGroup;
    ActionList1: TActionList;
    ActMenuFiscal: TAction;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EdtValorExit(Sender: TObject);
    procedure RadioTipoClick(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure EdtValorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    xValDesc, xValAcres : Double;
    xPercentual : Boolean;
    xporqtde:boolean;
  end;

var
  FrmRegistraDescAcres: TFrmRegistraDescAcres;

implementation

uses uFrmMenuFiscal, uDmWorkCom;

{$R *.dfm}

procedure TFrmRegistraDescAcres.FormCreate(Sender: TObject);
begin
  inherited;
  xValDesc  := 0;
  xValAcres := 0;
  xPercentual := false;

end;

procedure TFrmRegistraDescAcres.FormShow(Sender: TObject);
begin
  inherited;
  EdtValor.Text := '0,00';
  EdtValor.SetFocus;
  EdtValor.SelectAll;

end;

procedure TFrmRegistraDescAcres.BitBtn2Click(Sender: TObject);
begin
  inherited;
  xValDesc  := 0;
  xValAcres := 0;
  Close;
  
end;

procedure TFrmRegistraDescAcres.BitBtn1Click(Sender: TObject);
begin
  inherited;
  xValDesc  := 0;
  xValAcres := 0;
  //
  xPercentual := false;
  if RadioTipo.ItemIndex = 1 then
     xPercentual := true;
  //
  if RadioAplicar.ItemIndex = 0 then
     xValAcres := StrToFloat(EdtValor.Text)
  else if RadioAplicar.ItemIndex = 1 then
     xValDesc := StrToFloat(EdtValor.Text);
  Close;

  if checkbox1.Checked then
     xporqtde :=true
  else
     xporqtde :=false;




end;

procedure TFrmRegistraDescAcres.EdtValorExit(Sender: TObject);
var AuxValor : Double;
begin
  inherited;
  try
    AuxValor := StrToFloat(EdtValor.Text);
    if AuxValor < 0 then
    begin
      ShowMessage('O valor não pode ser negativo!');
      EdtValor.SetFocus;
      EdtValor.SelectAll;
      Exit;
    end;
  except
    ShowMessage('Valor inválido!');
  end;
  
end;

procedure TFrmRegistraDescAcres.EdtValorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
     bitbtn1.Click;
end;

procedure TFrmRegistraDescAcres.RadioTipoClick(Sender: TObject);
begin
  inherited;
  GrpValor.Caption := ' Valor ';
  if RadioTipo.ItemIndex = 1 then
     GrpValor.Caption := ' Percentual ';
     
end;

procedure TFrmRegistraDescAcres.ActMenuFiscalExecute(Sender: TObject);
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
