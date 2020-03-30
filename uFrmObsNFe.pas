unit uFrmObsNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, uFrameConfirmaCancela, ExtCtrls, StdCtrls, Mask,
  DBCtrls;

type
  TFrmObsNFe = class(TFrmPadrao)
    DataNFe: TDataSource;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmObsNFe: TFrmObsNFe;

implementation

uses uDmWorkCom, uLibrary;

{$R *.dfm}

procedure TFrmObsNFe.FormShow(Sender: TObject);
begin
  inherited;
  DataNFe.DataSet := DmWorkCom.CdsPedidos;
  if not(DataNFe.DataSet.State in [dsInsert,dsEdit]) then
     DataNFe.DataSet.Edit;

end;

procedure TFrmObsNFe.FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
begin
  inherited;
  Grava_Dados(DataNFe.DataSet);
  Close;
end;

procedure TFrmObsNFe.FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DataNFe.DataSet.Cancel;
  Close;
end;

procedure TFrmObsNFe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if (DataNFe.DataSet.State in [dsInsert,dsEdit]) then
  begin
    MessageDlg('É necessário confirmar ou cancelar os dados!',mtWarning,[mbOK],0);
    DBEdit1.SetFocus;
    Abort;
  end;
end;

end.
