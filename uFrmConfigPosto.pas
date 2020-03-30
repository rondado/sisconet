unit uFrmConfigPosto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, uFrameConfirmaCancela, DB, StdCtrls, Mask, DBCtrls,
  ExtCtrls;

type
  TFrmConfigPosto = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    DataConfig: TDataSource;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    GrpCompanytech: TGroupBox;
    GrpSoftPlus: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    RdConcentrador: TDBRadioGroup;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FrameConfirmaCancela1BtnConfirmarClick(Sender: TObject);
    procedure FrameConfirmaCancela1BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfigPosto: TFrmConfigPosto;

implementation

uses uDmWorkCom, uLibrary, uDmPosto;

{$R *.dfm}

procedure TFrmConfigPosto.FormShow(Sender: TObject);
begin
  DataConfig.DataSet := DmPosto.CdsConfigPosto;
  inherited;
  DmPosto.Dados_ConfigPosto;
  if DataConfig.DataSet.RecordCount = 0 then
  begin
    DataConfig.DataSet.Append;
    Grava_Dados(DataConfig.DataSet);
  end;
    
end;

procedure TFrmConfigPosto.FrameConfirmaCancela1BtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  Grava_Dados(DataConfig.DataSet);
  DmPosto.GravaArquivoConfigPosto;
  Close;
  
end;

procedure TFrmConfigPosto.FrameConfirmaCancela1BtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  DataConfig.DataSet.Cancel;
  Close;
  
end;

end.
