unit uFrmDescontinuidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, Grids, DBGrids, DB;

type
  TFrmDescontinuidade = class(TFrmPadrao)
    DsDescontinuidade: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Abre_Dados_Perdas;
  public
    { Public declarations }
    sIDPerda, sIDProd : Integer;
    sVolPerda : Double;
    sTravaAbast : Integer;
  end;

var
  FrmDescontinuidade: TFrmDescontinuidade;

implementation

uses uDmAuxiliar, DBClient;

{$R *.dfm}

procedure TFrmDescontinuidade.Abre_Dados_Perdas;
var Comando : String;
begin
  with DmAuxiliar.CdsGeral do
  begin
    Close;
    Comando := 'select b.id,b.numbico,b.data_movto,b.volume,p.id as codpro, '+
               '       p.descricao from bico_perdas b '+
               'inner join bicos_abastec x on x.bico_concentrador = b.numbico '+
               'inner join tanques_abastec t on x.id_tanque = t.id '+
               'inner join produtos p on p.id = t.id_produto '+
               'where b.pendente = '+QuotedStr('S')+' ';
    if sIDProd > 0 then
       Comando := Comando + 'and p.id = '+IntToStr(sIDProd)+' ';
    if sTravaAbast = 1 then
       Comando := Comando + 'and b.trava_abast = '+QuotedStr('N')
    else if sTravaAbast = 2 then
       Comando := Comando + 'and b.trava_abast = '+QuotedStr('S');
    CommandText := Comando;
    Open;
  end;

end;

procedure TFrmDescontinuidade.FormShow(Sender: TObject);
begin
  inherited;
  DsDescontinuidade.DataSet := DmAuxiliar.CdsGeral;
  Abre_Dados_Perdas;


end;

procedure TFrmDescontinuidade.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    sIDPerda := 0;
    sVolPerda := 0;
    Close;
  end;
  if Key = #13 then
  begin
    if DsDescontinuidade.DataSet.RecordCount > 0 then
    begin
      sIDPerda := DsDescontinuidade.DataSet.FieldByName('ID').AsInteger;
      sVolPerda := DsDescontinuidade.DataSet.FieldByName('volume').AsFloat;
    end;
    Close;
  end;

end;

procedure TFrmDescontinuidade.FormCreate(Sender: TObject);
begin
  inherited;
  sIDPerda := 0;
  sVolPerda := 0;
  sIDProd := 0;
  sTravaAbast := 0;
end;

end.

