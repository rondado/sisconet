unit uFrmComprasConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, StdCtrls, ComCtrls, ExtCtrls, Grids, DBGrids,
  Buttons, ActnList;

type
  TFrmComprasConsulta = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    DataCompra: TDataSource;
    GrpPeriodo: TGroupBox;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    ChTipoData: TCheckBox;
    RadioTipo: TRadioGroup;
    RadioConfirmados: TRadioGroup;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EdtLocalizar: TEdit;
    DBGrid1: TDBGrid;
    ActionList1: TActionList;
    ActLocalizar: TAction;
    ActEncerrar: TAction;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DataiKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDCompra:Integer;
  end;

var
  FrmComprasConsulta: TFrmComprasConsulta;

implementation

Uses uLibrary, uDmWorkCom;

{$R *.dfm}

procedure TFrmComprasConsulta.FormShow(Sender: TObject);
begin
  inherited;
  DataCompra.DataSet := DmWorkCom.CdsConsulta;
  Datai.Date := PrimeiroDia(SVData);
  dataf.Date := UltimoDia(SVData);
  sIDCompra  := 0;
  Datai.SetFocus; 
  
end;

procedure TFrmComprasConsulta.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(DmWorkCom.CdsConsulta,DBGrid1,Column);
  
end;

procedure TFrmComprasConsulta.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  //
  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select compras.id,compras.nota,compras.data_compra,');
  DmWorkCom.QryConsulta.SQL.Add('compras.data_emissao,compras.valor_total,compras.fornecedor from compras');
  if (RadioTipo.ItemIndex <> 0) or (RadioTipo.ItemIndex <> 1) then
  begin
    if ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where compras.data_emissao between :pDatai and :pDataf')
    else if not ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where compras.data_compra between :pDatai and :pDataf');
    if RadioTipo.ItemIndex = 2 then // codigo do clienye
       DmWorkCom.QryConsulta.SQL.Add('and compras.idfornecedor = :pLocalizar')
    else if RadioTipo.ItemIndex = 3 then // mome do cliente
       DmWorkCom.QryConsulta.SQL.Add('and upper(compras.fornecedor) like :pLocalizar')
  end
  else if (RadioTipo.ItemIndex <> 0) then
    DmWorkCom.QryConsulta.SQL.Add('where compras.id = :pLocalizar')
  else if (RadioTipo.ItemIndex <> 1) then
    DmWorkCom.QryConsulta.SQL.Add('where compras.nota = :pLocalizar');
  // confirmados
  if RadioConfirmados.ItemIndex = 0 then
     DmWorkCom.QryConsulta.SQL.Add('and compras.confirmada = '+QuotedStr('S'))
  else if RadioConfirmados.ItemIndex = 1 then
     DmWorkCom.QryConsulta.SQL.Add('and compras.confirmada = '+QuotedStr('N'));

  // parametros
  DmWorkCom.CdsConsulta.FetchParams;
  if (RadioTipo.ItemIndex <> 0) or (RadioTipo.ItemIndex <> 1) then
  begin
    DmWorkCom.CdsConsulta.Params.ParamByName('pDatai').AsDate := Datai.Date;
    DmWorkCom.CdsConsulta.Params.ParamByName('pDataf').AsDate := Dataf.Date;
    if (RadioTipo.ItemIndex = 2) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
    else if (RadioTipo.ItemIndex = 3) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString := UpperCase(EdtLocalizar.Text)+'%';
  end
  else if (RadioTipo.ItemIndex <> 0) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
  else if (RadioTipo.ItemIndex <> 1) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString  := EdtLocalizar.Text;
  //
  DmWorkCom.CdsConsulta.Open;
  DmWorkCom.CdsConsulta.RecordCount;
  DBGrid1.SetFocus;


end;

procedure TFrmComprasConsulta.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmComprasConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataCompra.DataSet.Close;

end;

procedure TFrmComprasConsulta.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  sIDCompra := 0;
  if DataCompra.DataSet.RecordCount > 0 then
     sIDCompra := DataCompra.DataSet.FieldByname('ID').AsInteger;
  Close;

end;

procedure TFrmComprasConsulta.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
     DBGrid1DblClick(Sender);

end;

procedure TFrmComprasConsulta.DataiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

end.
