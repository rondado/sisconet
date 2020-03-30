unit uFrmWSCep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MDICHILD, ImgList, ActnList, ComCtrls, StdCtrls, ExtCtrls,
  Buttons, InvokeRegistry, Rio, SOAPHTTPClient;

type
  TFrmWSCep = class(TForm)
    GroupBox1: TGroupBox;
    RadioOpcao: TRadioGroup;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Label1: TLabel;
    EdLocalizar: TEdit;
    BitBtn1: TBitBtn;
    PnUF: TPanel;
    Label2: TLabel;
    EdUF: TEdit;
    Label3: TLabel;
    EdNumRegistro: TEdit;
    HTTPRIO1: THTTPRIO;
    ActionList1: TActionList;
    ActBuscaCep: TAction;
    procedure ActSairExecute(Sender: TObject);
    procedure RadioOpcaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActBuscarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmWSCep: TFrmWSCep;

implementation
uses ICEP1;

{$R *.dfm}

procedure TFrmWSCep.ActSairExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmWSCep.RadioOpcaoClick(Sender: TObject);
begin
  inherited;
  PnUF.Visible := false;
  if RadioOpcao.ItemIndex = 1 then
     PnUF.Visible := true;
end;

procedure TFrmWSCep.FormShow(Sender: TObject);
begin
  inherited;
  RadioOpcaoClick(Sender);
end;

procedure TFrmWSCep.ActBuscarExecute(Sender: TObject);
begin
  inherited;

  case RadioOpcao.ItemIndex of
   0 : Memo1.Lines.Text := (HTTPRIO1 as ICEP).LogradourosPorCep(EdLocalizar.text);
   1 : Memo1.Lines.Text := (HTTPRIO1 as ICEP).LogradourosPorNome(EdLocalizar.Text,EdUF.Text,EdNumRegistro.Text);
  end;

end;

end.
