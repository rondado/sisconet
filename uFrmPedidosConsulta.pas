unit uFrmPedidosConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, StdCtrls, ComCtrls, ExtCtrls, Grids, DBGrids,
  Buttons, ActnList, System.Actions;

type
  TFrmPedidosConsulta = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    DataPedido: TDataSource;
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
    sementrega: TCheckBox;
    RadioGroup1: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DataiKeyPress(Sender: TObject; var Key: Char);
    procedure EdtLocalizarExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDPedido:Integer;
  end;

var
  FrmPedidosConsulta: TFrmPedidosConsulta;

implementation

Uses uLibrary, uDmWorkCom;

{$R *.dfm}

procedure TFrmPedidosConsulta.FormShow(Sender: TObject);
begin
  inherited;

  DataPedido.DataSet := DmWorkCom.CdsConsulta;
  DBGrid1.Columns.Items[0].Width := 30;
  DBGrid1.Columns.Items[1].Width := 200;
  DBGrid1.Columns.Items[2].Width := 70;
  DBGrid1.Columns.Items[3].Width := 70;
  DBGrid1.Columns.Items[4].Width := 70;

  Datai.Date := SVData;
  dataf.Date := SVData;
  sIDPedido  := 0;
  EdtLocalizar.SetFocus;

end;

procedure TFrmPedidosConsulta.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(DmWorkCom.CdsConsulta,DBGrid1,Column);

end;

procedure TFrmPedidosConsulta.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  //
//fabricio
if RAdioGroup1.ItemIndex = 0 then
begin
  //
  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select pedido.id,pedido.pedido_num,pedido.data_pedido,');
  DmWorkCom.QryConsulta.SQL.Add('pedido.data_entrega,pedido.valor_total,pedido.cliente from pedido');
  DmWorkCom.QryConsulta.SQL.Add(' inner join caixa_mov on (caixa_mov.idpedido = pedido.id)');

  if (RadioTipo.ItemIndex > 1) then
  begin
    if ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_entrega between :pDatai and :pDataf')
    else if not ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_pedido between :pDatai and :pDataf');
    if sementrega.Checked then
       DmWorkCom.QryConsulta.SQL.Add(' and pedido.data_entrega is null ');

    if RadioTipo.ItemIndex = 2 then // codigo do clienye
       DmWorkCom.QryConsulta.SQL.Add('and pedido.idcliente = :pLocalizar')
    else if RadioTipo.ItemIndex = 3 then // mome do cliente
       DmWorkCom.QryConsulta.SQL.Add('and upper(pedido.cliente) like :pLocalizar')
    else if RadioTipo.ItemIndex = 4 then // codigo do vendedor
       DmWorkCom.QryConsulta.SQL.Add('and pedido.id_vendedor = :pLocalizar')
  end
  else if (RadioTipo.ItemIndex = 0) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.id = :pLocalizar')
  else if (RadioTipo.ItemIndex = 1) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.pedido_num = :pLocalizar');
  // confirmados
  if RadioConfirmados.ItemIndex = 0 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('S'))
  else if RadioConfirmados.ItemIndex = 1 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('N'));

//fabricio incluir
  DmWorkCom.QryConsulta.SQL.Add(' order by pedido.id desc');

  // parametros
  DmWorkCom.CdsConsulta.FetchParams;

//fabricio
  Datai.Time:= StrToTime('00:00:00');
  Dataf.Time:= StrToTime('23:59:59');

//fabricio


  if (RadioTipo.ItemIndex > 1) then
  begin
    DmWorkCom.CdsConsulta.Params.ParamByName('pDatai').AsDateTime := Datai.DateTime;
    DmWorkCom.CdsConsulta.Params.ParamByName('pDataf').AsDateTime := Dataf.DateTime;
    if (RadioTipo.ItemIndex = 2) or (RadioTipo.ItemIndex = 4) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
    else if (RadioTipo.ItemIndex = 3) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString := UpperCase(EdtLocalizar.Text)+'%';
  end
  else if (RadioTipo.ItemIndex = 0) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
  else if (RadioTipo.ItemIndex = 1) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString  := EdtLocalizar.Text;
  //
  DmWorkCom.CdsConsulta.Open;
  DmWorkCom.CdsConsulta.RecordCount;
  DBGrid1.SetFocus;


end
else
begin

  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select pedido.id,pedido.pedido_num,pedido.data_pedido,');
  DmWorkCom.QryConsulta.SQL.Add('pedido.data_entrega,pedido.valor_total,pedido.cliente from pedido');
  if (RadioTipo.ItemIndex > 1) then
  begin
    if ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_entrega between :pDatai and :pDataf')
    else if not ChTipoData.Checked then
       DmWorkCom.QryConsulta.SQL.Add('where pedido.data_pedido between :pDatai and :pDataf');
    if sementrega.Checked then
       DmWorkCom.QryConsulta.SQL.Add(' and pedido.data_entrega is null ');


    if RadioTipo.ItemIndex = 2 then // codigo do clienye
       DmWorkCom.QryConsulta.SQL.Add('and pedido.idcliente = :pLocalizar')
    else if RadioTipo.ItemIndex = 3 then // mome do cliente
       DmWorkCom.QryConsulta.SQL.Add('and upper(pedido.cliente) like :pLocalizar')
    else if RadioTipo.ItemIndex = 4 then // codigo do vendedor
       DmWorkCom.QryConsulta.SQL.Add('and pedido.id_vendedor = :pLocalizar')
  end
  else if (RadioTipo.ItemIndex = 0) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.id = :pLocalizar')
  else if (RadioTipo.ItemIndex = 1) then
    DmWorkCom.QryConsulta.SQL.Add('where pedido.pedido_num = :pLocalizar');
  // confirmados
  if RadioConfirmados.ItemIndex = 0 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('S'))
  else if RadioConfirmados.ItemIndex = 1 then
     DmWorkCom.QryConsulta.SQL.Add('and pedido.confirmada = '+QuotedStr('N'));

//fabricio incluir
  DmWorkCom.QryConsulta.SQL.Add(' order by pedido.id desc');


  // parametros
  DmWorkCom.CdsConsulta.FetchParams;

//fabricio
  Datai.Time:= StrToTime('00:00:00');
  Dataf.Time:= StrToTime('23:59:59');

//fabricio


  if (RadioTipo.ItemIndex > 1) then
  begin
    DmWorkCom.CdsConsulta.Params.ParamByName('pDatai').AsDateTime := Datai.DateTime;
    DmWorkCom.CdsConsulta.Params.ParamByName('pDataf').AsDateTime := Dataf.DateTime;
    if (RadioTipo.ItemIndex = 2) or (RadioTipo.ItemIndex = 4) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
    else if (RadioTipo.ItemIndex = 3) then
       DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString := UpperCase(EdtLocalizar.Text)+'%';
  end
  else if (RadioTipo.ItemIndex = 0) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsInteger := StrToInt(EdtLocalizar.Text)
  else if (RadioTipo.ItemIndex = 1) then
     DmWorkCom.CdsConsulta.Params.ParamByName('pLocalizar').AsString  := EdtLocalizar.Text;
  //
  DmWorkCom.CdsConsulta.Open;
  DmWorkCom.CdsConsulta.RecordCount;
  DBGrid1.SetFocus;


//fabricio

if RadioGroup1.ItemIndex = 1 then
begin
  DataPedido.DataSet.First;
  while not DataPedido.DataSet.Eof do
  begin
  DmWorkCom.CdsCaixaMov.Close;
  DmWorkCom.CdsCaixaMov.Params.Clear;
  DmWorkCom.QryCaixaMov.Close;
  DmWorkCom.QryCaixaMov.SQL.Clear;
  DmWorkCom.QryCaixaMov.SQL.Add('select * from caixa_mov where ');
  DmWorkCom.QryCaixaMov.SQL.Add('caixa_mov.idpedido = ');
//  DmWorkCom.CdsCaixaMov.Params.ParamByName('pID').AsString  := DataPedido.DataSet.FieldByname('ID').AsString;
  DmWorkCom.QryCaixaMov.SQL.Add(DataPedido.DataSet.FieldByname('ID').AsString);
  DmWorkCom.CdsCaixaMov.Open;

  if DmWorkCom.CdsCaixaMov.RecordCount > 0 then
//    if DmWorkCom.Dados_CaixaMov(DataPedido.DataSet.FieldByname('ID').AsInteger) then
    begin
      DataPedido.DataSet.Delete;
    end
    else
      DataPedido.DataSet.Next;

  end;
end;

// DbGrid1.Refresh;






//fabricio incluir
    (dbgrid1.fields[5] as Tfloatfield).DisplayFormat := 'R$ ###,##0.00';
     dbgrid1.columns[2].Width:=200;


end;


end;

procedure TFrmPedidosConsulta.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmPedidosConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataPedido.DataSet.Close;
   
end;

procedure TFrmPedidosConsulta.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  sIDPedido := 0;
  if DataPedido.DataSet.RecordCount > 0 then
     sIDPedido := DataPedido.DataSet.FieldByname('ID').AsInteger;
  Close;

end;

procedure TFrmPedidosConsulta.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
     DBGrid1DblClick(Sender);
     
end;

procedure TFrmPedidosConsulta.DataiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmPedidosConsulta.EdtLocalizarExit(Sender: TObject);
begin
  inherited;
  if RadioTipo.ItemIndex = 1 then
  begin
    if sPedidoSeq = 'S' then
       EdtLocalizar.Text := ZeroEsquerda(EdtLocalizar.Text,10)
    else if sPedidoSeq = 'N' then
       EdtLocalizar.Text := ZeroEsquerda(EdtLocalizar.Text,6);
  end;
end;

end.
