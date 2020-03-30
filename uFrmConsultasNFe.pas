unit uFrmConsultasNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, Buttons, StdCtrls, ExtCtrls, ComCtrls, ACBrNFe,
  ACBrNFeWebServices;

type
  TFrmConsultasNFe = class(TFrmPadrao)
    RadioTipo: TRadioGroup;
    GrpArquivo: TGroupBox;
    EdtArquivo: TEdit;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    GrpRecibo: TGroupBox;
    EdtRecibo: TEdit;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    procedure SpeedButton1Click(Sender: TObject);
    procedure RadioTipoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsultasNFe: TFrmConsultasNFe;

implementation

uses uDmAcBr, uDmWorkCom;

{$R *.dfm}

procedure TFrmConsultasNFe.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  EdtArquivo.Text := OpenDialog1.FileName;
  
end;

procedure TFrmConsultasNFe.RadioTipoClick(Sender: TObject);
begin
  inherited;
  GrpArquivo.Visible := false;
  GrpRecibo.Visible  := false;
  if RadioTipo.ItemIndex = 0 then // Consultar carregamento XML
     GrpArquivo.Visible := true
  else if RadioTipo.ItemIndex = 1 then
     GrpRecibo.Visible := true;
     
end;

procedure TFrmConsultasNFe.FormShow(Sender: TObject);
begin
  inherited;
  DmWorkCom.AtualizaConfigAcBr;
  RadioTipoClick(Sender);
  
end;

procedure TFrmConsultasNFe.BitBtn1Click(Sender: TObject);
begin
  inherited;
  DmAcBr.ACBrNFe1.NotasFiscais.Clear;
  if RadioTipo.ItemIndex = 0 then
  begin
    if EdtArquivo.Text = '' then
    begin
      ShowMessage('É necessário selecionar o arquivo XML!');
      Abort;
    end;
    DmAcBr.ACBrNFe1.NotasFiscais.LoadFromFile(EdtArquivo.Text);
    DmAcBr.ACBrNFe1.Consultar;
    Memo1.Lines.Text := UTF8Encode(DmAcBr.ACBrNFe1.WebServices.Consulta.RetWS);
  end
  else if RadioTipo.ItemIndex = 1 then
  begin
    if EdtRecibo.Text = '' then
    begin
      ShowMessage('É necessário informar o numero do recibo!');
      Abort;
    end;
    DmAcBr.ACBrNFe1.WebServices.Recibo.Recibo := EdtRecibo.Text;
    DmAcBr.ACBrNFe1.WebServices.Retorno.Executar;
    Memo1.Lines.Text := UTF8Encode(DmAcBr.ACBrNFe1.WebServices.Consulta.RetWS);
  end;

end;

end.
