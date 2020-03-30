unit uFrmSelEndereco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, Grids, DBGrids;

type
  TFrmSelEndereco = class(TFrmPadrao)
    DataEndereco: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sOK : Boolean;
  end;

var
  FrmSelEndereco: TFrmSelEndereco;

implementation

uses uLibrary,uDmWorkCom, uDMClientes;

{$R *.dfm}

procedure TFrmSelEndereco.FormShow(Sender: TObject);
begin
  inherited;
  DataEndereco.DataSet := DmClientes.CdsEndereco;
  sOK := false;

end;

procedure TFrmSelEndereco.DBGrid1Enter(Sender: TObject);
begin
  inherited;
  DBGrid1.Tag := 1;

end;

procedure TFrmSelEndereco.DBGrid1Exit(Sender: TObject);
begin
  inherited;
  DBGrid1.Tag := 0;

end;

procedure TFrmSelEndereco.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
     sOK := true
  else if Key = #27 then
     sOK := false;
  close;
end;

end.
