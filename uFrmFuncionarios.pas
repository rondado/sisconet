unit uFrmFuncionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmFuncionarios = class(TFrmPadrao)
    DataFuncionarios: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDFuncionario : Integer;
  end;

var
  FrmFuncionarios: TFrmFuncionarios;

implementation

{$R *.dfm}

uses uDMClientes;

procedure TFrmFuncionarios.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if DataFuncionarios.DataSet.RecordCount > 0 then
  begin
    sIDFuncionario := DataFuncionarios.DataSet.FieldByName('ID').AsInteger;
    Close;
  end;
end;

procedure TFrmFuncionarios.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
     DBGrid1DblClick(Sender);
  //
  if key = #27 then
  begin
    sIDFuncionario := 0;
    Close;
  end;

end;

procedure TFrmFuncionarios.FormCreate(Sender: TObject);
begin
  inherited;
  sIDFuncionario := 0;
end;

procedure TFrmFuncionarios.FormShow(Sender: TObject);
begin
  inherited;
  DataFuncionarios.DataSet := DmClientes.CdsFuncionarios;
  DmClientes.Dados_Funcionario;

end;

end.
