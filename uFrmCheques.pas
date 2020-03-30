unit uFrmCheques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ComCtrls, StdCtrls, ActnList, Buttons, Grids,
  DBGrids, DB, ExtCtrls;

type
  TFrmCheques = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    GrpPeriodo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    RadioStatus: TRadioGroup;
    GrpLocalizar: TGroupBox;
    GrpTipo: TGroupBox;
    ComboTipo: TComboBox;
    EdtLocalizar: TEdit;
    DataCheques: TDataSource;
    DBGrid1: TDBGrid;
    BtnLocalizar: TBitBtn;
    BtnEncerrar: TBitBtn;
    ActionList1: TActionList;
    ActLocalizar: TAction;
    ActEncerrar: TAction;
    ChTipoData: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sIdCheque : Integer;
  end;

var
  FrmCheques: TFrmCheques;

implementation

Uses uLibrary,uDmWorkCom;

{$R *.dfm}

procedure TFrmCheques.FormShow(Sender: TObject);
begin
  inherited;
  DataCheques.DataSet := DmWorkCom.CdsConsulta;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);
  ComboTipo.ItemIndex := 0;
  ComboTipo.Text := '0 - Cliente';
  ActLocalizarExecute(Sender);


end;

procedure TFrmCheques.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  //
  DmWorkCom.CdsConsulta.Close;
  DmWorkCom.CdsConsulta.Params.Clear;
  DmWorkCom.QryConsulta.Close;
  DmWorkCom.QryConsulta.SQL.Clear;
  DmWorkCom.QryConsulta.SQL.Add('select cheques.id_pedido,cheques.data_cad,');
  DmWorkCom.QryConsulta.SQL.Add('cheques.data_emissao,cheques.bom_para,');
  DmWorkCom.QryConsulta.SQL.Add('cheques.emitente,cheques.agencia,cheques.id,');
  DmWorkCom.QryConsulta.SQL.Add('cheques.cod_banco,cheques.num_cheque,');
  DmWorkCom.QryConsulta.SQL.Add('cheques.num_conta,cheques.status from cheques');
  if not ChTipoData.Checked then
     DmWorkCom.QryConsulta.SQL.Add('where cheques.data_emissao between :pDatai and :pDataf')
  else if ChTipoData.Checked then
     DmWorkCom.QryConsulta.SQL.Add('where cheques.data_cad between :pDatai and :pDataf');
  DmWorkCom.QryConsulta.SQL.Add('and cheques.status = :pStatus');
  if ComboTipo.ItemIndex = 0 then  // CLIENTE
     DmWorkCom.QryConsulta.SQL.Add('and cheques.cliente like :pLocaliza')
  else if ComboTipo.ItemIndex = 1 then // EMITENTE
     DmWorkCom.QryConsulta.SQL.Add('and cheques.emitente like :pLocaliza');
  // parametros
  DmWorkCom.CdsConsulta.FetchParams;
  DmWorkCom.CdsConsulta.Params.ParamByName('pDatai').AsDate      := Datai.Date;
  DmWorkCom.CdsConsulta.Params.ParamByName('pDataf').AsDate      := Dataf.Date;
  DmWorkCom.CdsConsulta.Params.ParamByName('pStatus').AsInteger  := RadioStatus.ItemIndex;
  DmWorkCom.CdsConsulta.Params.ParamByName('pLocaliza').AsString := EdtLocalizar.Text+'%';
  DmWorkCom.CdsConsulta.Open;
  DmWorkCom.CdsConsulta.RecordCount;
  DBGrid1.SetFocus;

end;

procedure TFrmCheques.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(DmWorkCom.CdsConsulta,DBGrid1,Column);

end;

procedure TFrmCheques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DataCheques.DataSet.Close;

end;

procedure TFrmCheques.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  close;

end;

procedure TFrmCheques.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  sIdCheque := DataCheques.DataSet.FieldByName('ID').AsInteger;
  Close;
  
end;

procedure TFrmCheques.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
     DBGrid1DblClick(Sender);
     
end;

end.
