unit uFrmCadVolume;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Mask, Vcl.DBCtrls, uFrameConfirmaCancela;

type
  TFrmCadVolume = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataVolumes: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadVolume: TFrmCadVolume;

implementation

{$R *.dfm}

uses uDmWorkCom, uLibrary;

procedure TFrmCadVolume.FormShow(Sender: TObject);
begin
  inherited;
  DataVolumes.DataSet := DmWorkCom.CdsNFeVolumes;
  DataVolumes.DataSet.Append;

end;

procedure TFrmCadVolume.FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DataVolumes.DataSet.Cancel;
  Close;

end;

procedure TFrmCadVolume.FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if Confirmacao('Confirma o cadastro do volume?') then
  begin
    Grava_Dados(DataVolumes.DataSet);
    Close;
  end;

end;

end.
