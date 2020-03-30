//fabricio novo alterado a exigencia da bandeira e da transacao
unit uFrmDadosPOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, ExtCtrls, Buttons, DB, DBCtrls;

type
  TFrmDadosPOS = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    EdtNSU: TEdit;
    Panel1: TPanel;
    BtnOk: TBitBtn;
    GroupBox3: TGroupBox;
    CbxTipoOperacao: TComboBox;
    Databandeira: TDataSource;
    CbxBandeiras: TDBLookupComboBox;
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CbxTipoOperacaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sOK : Boolean;
  end;

var
  FrmDadosPOS: TFrmDadosPOS;

implementation

uses uLibrary, uDmWorkCom;

{$R *.dfm}

procedure TFrmDadosPOS.BtnOkClick(Sender: TObject);
begin
  inherited;
  if (CbxBandeiras.Text = '') then
  begin
//    MessageDlg('É necessário informar a bandeira e o Número da transação!',mtWarning,[mbOK],0);
//    CbxBandeiras.SetFocus;
//    Exit;
//      CbxBandeiras.
  end;

  if   EdtNsu.Text ='' then
       EdtNsu.Text:='999';

  sOK := true;
  Close;
end;

procedure TFrmDadosPOS.FormShow(Sender: TObject);
begin
  inherited;
  Databandeira.DataSet := DmWorkCom.CdsBandeiras;
  DmWorkCom.Dados_Bandeiras;
  CbxTipoOperacao.SetFocus;
end;

procedure TFrmDadosPOS.CbxTipoOperacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    sOK := false;
    Close;
  end;
  TabEnter(Self,Key);

end;

procedure TFrmDadosPOS.FormCreate(Sender: TObject);
begin
  inherited;
  sOK := false;
end;

end.
