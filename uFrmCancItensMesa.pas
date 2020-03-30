unit uFrmCancItensMesa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, Grids, DBGrids, StdCtrls, ExtCtrls;

type
  TFrmCancItensMesa = class(TFrmPadrao)
    Panel1: TPanel;
    EdtComanda: TEdit;
    Comanda: TLabel;
    DataMesaItens: TDataSource;
    DBGrid2: TDBGrid;
    DataMesasAbertas: TDataSource;
    DataMesa: TDataSource;
    LbValor: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DBGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure EdtComandaExit(Sender: TObject);
    procedure EdtComandaKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure ExibeTotalMesa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCancItensMesa: TFrmCancItensMesa;

implementation

uses uDmWorkCom, uLibrary;

{$R *.dfm}

procedure TFrmCancItensMesa.FormShow(Sender: TObject);
begin
  inherited;
  DataMesasAbertas.DataSet := DmWorkCom.CdsMesasAbertas;
  DataMesaItens.DataSet := DmWorkCom.CdsMesasItens;
  DataMesa.DataSet := DmWorkCom.CdsMesas;
  DmWorkCom.Dados_Mesa;
  EdtComanda.SelectAll;
  EdtComanda.SetFocus;

end;

procedure TFrmCancItensMesa.DBGrid2KeyPress(Sender: TObject; var Key: Char);
var aTotal : Double;
begin
  inherited;
  if Key = #27 then
     Close;
  if Key = #13 then
  begin
    if DataMesaItens.DataSet.RecordCount > 0 then
    begin
      if DataMesaItens.DataSet.FieldByName('CANCELADO').AsString = 'S' then
      begin
        MessageDlg('O item selecionado já esta cancelado!',mtInformation,[mbOK],0);
        Exit;
      end;
      //
      if Confirmacao('Confirma o cancelamendo do item selecionado?') then
      begin
        DataMesaItens.DataSet.Edit;
        DataMesaItens.DataSet.FieldByName('CANCELADO').AsString := 'S';
        Grava_Dados(DataMesaItens.DataSet);
        // atualiza valor da mesa
        aTotal := RetornaTotalMesa(DataMesasAbertas.DataSet.FieldByName('ID').AsInteger);
        DataMesasAbertas.DataSet.Edit;
        DataMesasAbertas.DataSet.FieldByName('VALOR').AsFloat := aTotal;
        Grava_Dados(DataMesasAbertas.DataSet);
        //
        ExibeTotalMesa;
      end;
    end;
  end;

end;

procedure TFrmCancItensMesa.EdtComandaExit(Sender: TObject);
var aIDMesa : Integer;
begin
  inherited;
  if EdtComanda.Text <> '' then
  begin
    if not DataMesa.DataSet.Locate('NUMERO_MESA',EdtComanda.Text,[]) then
    begin
      MessageDlg('Não foi localizdo a comando para o numero informado',mtWarning,[mbOK],0);
      EdtComanda.SelectAll;
      EdtComanda.SetFocus;
      Exit;
    end
    else
    begin
      if VerificaMesaAberta(aIDMesa,DataMesa.DataSet.FieldByName('ID').AsInteger) then
      begin
        DmWorkCom.Dados_MesasItens(aIDMesa);
        ExibeTotalMesa;
      end
    end;
  end;

end;

procedure TFrmCancItensMesa.EdtComandaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
     Close;
  TabEnter(Self,Key);
end;

procedure TFrmCancItensMesa.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if DataMesaItens.DataSet.FieldByName('CANCELADO').AsString = 'S' then
  begin
    DBGrid2.Canvas.Font.Color:= clRed;
    DBGrid2.DefaultDrawDataCell(Rect, DBGrid2.columns[datacol].field, State);
  end;

end;

procedure TFrmCancItensMesa.ExibeTotalMesa;
var aTotal : Double;
    aIDMesa : Integer;
begin
  if VerificaMesaAberta(aIDMesa,DataMesa.DataSet.FieldByName('ID').AsInteger) then
  begin
    aTotal := RetornaTotalMesa(aIDMesa);
    LbValor.Caption := FormatFloat('0.00',aTotal);
  end;
end;

end.
