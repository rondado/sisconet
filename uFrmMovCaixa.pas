unit uFrmMovCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, StdCtrls, Mask, DBCtrls, uFrameConfirmaCancela,
  ExtCtrls;

type
  TFrmMovCaixa = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    Label1: TLabel;
    DbHistorico: TDBEdit;
    DataCaixaMov: TDataSource;
    Label2: TLabel;
    DbOrigem: TDBEdit;
    Label4: TLabel;
    DbValor: TDBEdit;
    RadioDC: TDBRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure DbHistoricoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMovCaixa: TFrmMovCaixa;

implementation

uses uLibrary, uDmWorkCom;

{$R *.dfm}

procedure TFrmMovCaixa.FormShow(Sender: TObject);
begin
  inherited;
  DataCaixaMov.DataSet := DmWorkCom.CdsCaixaMov;
  DataCaixaMov.DataSet.Append;

end;

procedure TFrmMovCaixa.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  if (DataCaixaMov.DataSet.FieldByName('DC').IsNull) or
     (DataCaixaMov.DataSet.FieldByName('DC').AsString = '') then
  begin
    MessageDlg('É necessário informar se é Debito ou Credito!!!', mtWarning, [mbOK], 0);
    RadioDC.SetFocus;
    Abort;
  end;
  DataCaixaMov.DataSet.Post;
  Grava_Dados(DataCaixaMov.DataSet);
  Close;

end;

procedure TFrmMovCaixa.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  DataCaixaMov.DataSet.Cancel;
  Grava_Dados(DataCaixaMov.DataSet);
  Close;

end;

procedure TFrmMovCaixa.DbHistoricoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

end.
