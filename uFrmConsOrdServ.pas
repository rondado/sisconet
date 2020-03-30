unit uFrmConsOrdServ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmConsOrdServ = class(TFrmPadrao)
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Label41: TLabel;
    Label42: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    RadioStatus: TRadioGroup;
    GroupBox7: TGroupBox;
    GridOS: TDBGrid;
    BitBtn8: TBitBtn;
    DataOS: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure GridOSDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsOrdServ: TFrmConsOrdServ;

implementation

{$R *.dfm}

uses uLibrary, uDmWorkCom;

procedure TFrmConsOrdServ.BitBtn8Click(Sender: TObject);
begin
  inherited;
  DmWorkCom.Dados_OS(Datai.Date,Dataf.Date,RadioStatus.ItemIndex);
  GridOS.SetFocus;

end;

procedure TFrmConsOrdServ.FormShow(Sender: TObject);
begin
  inherited;
  DataOS.DataSet := DmWorkCom.CdsOS;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);

end;

procedure TFrmConsOrdServ.GridOSDblClick(Sender: TObject);
begin
  inherited;
  if DataOS.DataSet.RecordCount > 0 then
     Close;

end;

end.
