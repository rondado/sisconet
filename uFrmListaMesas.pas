unit uFrmListaMesas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmListaMesas = class(TFrmPadrao)
    DataMesas: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDMesa : Integer;
    sNumeroMesa : String;
  end;

var
  FrmListaMesas: TFrmListaMesas;

implementation

{$R *.dfm}

uses uDmWorkCom;

procedure TFrmListaMesas.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if DataMesas.DataSet.RecordCount > 0 then
  begin
    sIDMesa := DataMesas.DataSet.FieldByName('ID').AsInteger;
    sNumeroMesa := DataMesas.DataSet.FieldByName('NUMERO_MESA').AsString;
    Close;
  end;
end;

procedure TFrmListaMesas.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
     DBGrid1DblClick(Sender);
  //
  if key = #27 then
  begin
    sIDMesa := 0;
    sNumeroMesa := '';
    Close;
  end;

end;

procedure TFrmListaMesas.FormCreate(Sender: TObject);
begin
  inherited;
  sIDMesa := 0;
  sNumeroMesa := '';
end;

procedure TFrmListaMesas.FormShow(Sender: TObject);
begin
  inherited;
  DataMesas.DataSet := DmWorkCom.CdsMesas;
  DmWorkCom.Dados_Mesa('M');

end;

end.
