unit uFrmRelComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, FMTBcd, DB, SqlExpr, uFrameConfirmaCancela, ExtCtrls,
  StdCtrls, DBCtrls, ComCtrls, ActnList, Provider, DBClient, System.Actions;

type
  TFrmRelComissao = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Frame: TFrameConfirmaCancela;
    GrpPeriodo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    DataVendedor: TDataSource;
    GrpVendedor: TGroupBox;
    ComboVendedor: TDBLookupComboBox;
    ActionList1: TActionList;
    ActImprimir: TAction;
    ActEncerrar: TAction;
    ChResumo: TCheckBox;
    RadioOrdem: TRadioGroup;
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActImprimirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelComissao: TFrmRelComissao;

implementation

Uses uLibrary, uDmConexao, uDmWorkCom, uDMClientes, uDmRelatorios;

{$R *.dfm}

procedure TFrmRelComissao.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmRelComissao.ActImprimirExecute(Sender: TObject);
begin
  inherited;
  if ComboVendedor.Text = '' then
  begin
    MessageDlg('É necessário selecionar o vendedor!',mtWarning,[mbOK],0);
    Exit;
  end;
  //
  DmRelatorios.CdsRelatorios.Close;
  DmRelatorios.CdsRelatorios.Params.Clear;
  DmRelatorios.QryRelatorios.Close;
  DmRelatorios.QryRelatorios.SQL.Clear;
  DmRelatorios.QryRelatorios.SQL.Add('select * from proc_comissoes_func(:pDatai,:pDataf,:pIDFunc,:pOrdem,:pExibe)');
  DmRelatorios.CdsRelatorios.FetchParams;
  DmRelatorios.CdsRelatorios.Params.ParamByName('pDatai').AsDate     := Datai.Date;
  DmRelatorios.CdsRelatorios.Params.ParamByName('pDataf').AsDate     := Dataf.Date;
  DmRelatorios.CdsRelatorios.Params.ParamByName('pIDFunc').AsInteger := DataVendedor.DataSet.FieldByName('ID').AsInteger;
  DmRelatorios.CdsRelatorios.Params.ParamByName('pOrdem').AsInteger  := RadioOrdem.ItemIndex;
  if ChResumo.Checked then
     DmRelatorios.CdsRelatorios.Params.ParamByName('pExibe').AsString := 'S'
  else
     DmRelatorios.CdsRelatorios.Params.ParamByName('pExibe').AsString := 'N';
  DmRelatorios.CdsRelatorios.Open;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('VALOR_TOTAL')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('COMISSAO_PEDIDO')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('QUANTIDADE')).DisplayFormat := '###,###,###0.000';
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('VALOR_PRODUTO')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('TOTAL_PRODUTO')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('PERC_COMISSAO')).DisplayFormat := '###,###0.00';
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('COMISSAO_PROD')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  //
  DmRelatorios.PassaPeriodoRelatorio(Datai.Date,Dataf.Date);
  if ChResumo.Checked then
  begin
    DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ComissoesItens.fr3');
    DmRelatorios.frxGeral.ShowReport();
  end
  else
  begin
    DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\Comissoes.fr3');
    DmRelatorios.frxGeral.ShowReport();
  end;

end;

procedure TFrmRelComissao.FormShow(Sender: TObject);
begin
  inherited;
  DataVendedor.DataSet := DmClientes.CdsFuncionarios;
  DmClientes.Dados_Funcionario;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);

end;

end.
