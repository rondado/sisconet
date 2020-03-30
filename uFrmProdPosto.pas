unit uFrmProdPosto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, Grids, DBGrids, DB;

type
  TFrmProdPosto = class(TFrmPadrao)
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
    sIDProd : Integer;
  end;

var
  FrmProdPosto: TFrmProdPosto;

implementation

uses uDmAuxiliar, DBClient, uDmPosto;

{$R *.dfm}

procedure TFrmProdPosto.Abre_Dados_Perdas;
begin
  with DmAuxiliar.CdsGeral do
  begin
    Close;
    CommandText := 'select b.bico_concentrador,t.id_produto, '+
                   '       p.descricao,b.ativo '+
                   'from bicos_abastec b '+
                   'inner join tanques_abastec t on t.id = b.id_tanque '+
                   'inner join produtos p on p.id = t.id_produto ';
//                   'where b.ativo = '+QuotedStr('N');
    Open;
  end;

end;

procedure TFrmProdPosto.FormShow(Sender: TObject);
begin
  inherited;
  DsDescontinuidade.DataSet := DmAuxiliar.CdsGeral;
  Abre_Dados_Perdas;


end;

procedure TFrmProdPosto.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    sIDProd := 0;
    Close;
  end;
  if Key = #13 then
  begin
    if DsDescontinuidade.DataSet.RecordCount > 0 then
    begin
      if DsDescontinuidade.DataSet.FieldByName('ativo').AsString = 'S' then
      begin
        if not DmPosto.Dados_Bicos_Perda(DsDescontinuidade.DataSet.FieldByName('bico_concentrador').AsString,'S',0) then
        begin
          MessageDlg('Não pode gerar nota em contigência para produto com bico ativo!',mtWarning,[mbOK],0);
          Abort;
        end;
      end;
      sIDProd := DsDescontinuidade.DataSet.FieldByName('id_produto').AsInteger;
    end;
    Close;
  end;

end;

procedure TFrmProdPosto.FormCreate(Sender: TObject);
begin
  inherited;
  sIDProd := 0;
  
end;

end.

