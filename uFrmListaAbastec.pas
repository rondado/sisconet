unit uFrmListaAbastec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, Grids, DBGrids, DB;

type
  TFrmListaAbastec = class(TFrmPadrao)
    DsAbastec: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Abre_Dados_Abastecimentos;
  public
    { Public declarations }
    sIDProduto, sIDAbastec : Integer;
    sVolume : Double;
  end;

var
  FrmListaAbastec: TFrmListaAbastec;

implementation

uses uDmAuxiliar, DBClient;

{$R *.dfm}

procedure TFrmListaAbastec.Abre_Dados_Abastecimentos;
var Comando : String;
begin
  with DmAuxiliar.CdsGeral do
  begin
    Close;
    Comando := 'select a.* from abastecimentos a '+
               'left outer join bicos_abastec bi on bi.bico_concentrador = a.num_bico '+
               'left outer join bombas_abastec bo on bo.id = bi.id_bomba '+
               'where a.status_abastec = 1 '+
               'and a.idproduto = '+IntToStr(sIDProduto);
    CommandText := Comando;
    Open;
  end;

end;

procedure TFrmListaAbastec.FormShow(Sender: TObject);
begin
  inherited;
  DsAbastec.DataSet := DmAuxiliar.CdsGeral;
  Abre_Dados_Abastecimentos;


end;

procedure TFrmListaAbastec.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    sIDAbastec := 0;
    sVolume := 0;
    Close;
  end;
  if Key = #13 then
  begin
    if DsAbastec.DataSet.RecordCount > 0 then
    begin
      sIDAbastec := DsAbastec.DataSet.FieldByName('ID').AsInteger;
      sVolume := DsAbastec.DataSet.FieldByName('litros').AsFloat;
    end;
    Close;
  end;

end;

procedure TFrmListaAbastec.FormCreate(Sender: TObject);
begin
  inherited;
  sIDAbastec := 0;
  sVolume := 0;
end;

end.

