unit uFrmRelContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ComCtrls, StdCtrls, DB, ExtCtrls, DBCtrls, ActnList,
  uFrameConfirmaCancela, FMTBcd, SqlExpr, System.Actions, Datasnap.Provider,
  Datasnap.DBClient, frxClass, frxDBSet;

type
  TFrmRelContas = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    GrpPeriodo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    RadioTipoConta: TRadioGroup;
    RadioTipoFiltro: TRadioGroup;
    GrpContato: TGroupBox;
    DataContato: TDataSource;
    ComboContatos: TDBLookupComboBox;
    Panel1: TPanel;
    ActionList1: TActionList;
    ActImprimir: TAction;
    ActFechar: TAction;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    QryContas: TSQLQuery;
    RadioStatus: TRadioGroup;
    DataContas: TDataSource;
    CdsContas: TClientDataSet;
    DspContas: TDataSetProvider;
    frxReport1: TfrxReport;
    frxDbContas: TfrxDBDataset;
    QryContasNUMCONTA: TStringField;
    QryContasNOME: TStringField;
    QryContasDATA_LANC: TSQLTimeStampField;
    QryContasDATA_VENC: TSQLTimeStampField;
    QryContasDATA_QUIT: TSQLTimeStampField;
    QryContasJUROS: TFloatField;
    QryContasMULTA: TFloatField;
    QryContasSERIE: TIntegerField;
    QryContasVALOR_CONTA: TFloatField;
    QryContasIDCONTATO: TIntegerField;
    QryContasVALOR_ACRESCIMO: TFloatField;
    QryContasVALOR_DESCONTO: TFloatField;
    QryContasVALOR_QUITATO: TFloatField;
    CdsContasNUMCONTA: TStringField;
    CdsContasNOME: TStringField;
    CdsContasDATA_LANC: TSQLTimeStampField;
    CdsContasDATA_VENC: TSQLTimeStampField;
    CdsContasDATA_QUIT: TSQLTimeStampField;
    CdsContasJUROS: TFloatField;
    CdsContasMULTA: TFloatField;
    CdsContasSERIE: TIntegerField;
    CdsContasVALOR_CONTA: TFloatField;
    CdsContasIDCONTATO: TIntegerField;
    CdsContasVALOR_ACRESCIMO: TFloatField;
    CdsContasVALOR_DESCONTO: TFloatField;
    CdsContasVALOR_QUITATO: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure ActImprimirExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure RadioTipoFiltroClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmRelContas: TFrmRelContas;

implementation

Uses uLibrary,uDmConexao,uDmWorkCom, uDMClientes;

{$R *.dfm}

procedure TFrmRelContas.FormShow(Sender: TObject);
begin
  inherited;
  DataContato.DataSet := DmClientes.CdsContatoAux;
  DataContato.DataSet.Open;
  RadioTipoFiltroClick(Sender);
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);
  Datai.SetFocus;

end;

procedure TFrmRelContas.ActImprimirExecute(Sender: TObject);
begin
  inherited;
  //
  CdsContas.Close;
  CdsContas.Params.Clear;
  QryContas.Close;
  QryContas.SQL.Clear;
  QryContas.SQL.Add('select contas.numconta,contato.nome,contas.data_lanc,');
  QryContas.SQL.Add('contas.data_venc,contas.data_quit,contas.juros,');
  QryContas.SQL.Add('contas.multa,contas.serie,contas.valor_conta,contas.idcontato,');
  QryContas.SQL.Add('contas.valor_acrescimo,contas.valor_desconto,');
  QryContas.SQL.Add('contas.valor_quitato from contas');
  QryContas.SQL.Add('left outer join contato on contas.idcontato = contato.id');
  QryContas.SQL.Add('where contas.tipo = :pTipo');
  if RadioStatus.ItemIndex <> 1 then // apenas quitadas
     QryContas.SQL.Add('and contas.data_lanc between :pDatai and :pDataf')
  else // outras
     QryContas.SQL.Add('and contas.data_quit between :pDatai and :pDataf');
  if RadioStatus.ItemIndex = 0 then // apenas em aberto
     QryContas.SQL.Add('and contas.status = '+QuotedStr('0'))
  else if RadioStatus.ItemIndex = 1 then // apenas quitadas
     QryContas.SQL.Add('and contas.status = '+QuotedStr('1'))
  else if RadioStatus.ItemIndex = 2 then // apenas renegociadas
     QryContas.SQL.Add('and contas.status = '+QuotedStr('2'));
  if RadioTipoFiltro.ItemIndex = 1 then // por clentes
     QryContas.SQL.Add('and contas.idcontato = '+QuotedStr(IntToStr(DataContato.DataSet.FieldByName('').AsInteger)));
  CdsContas.FetchParams;
  // passa parametros
  CdsContas.Params.ParamByName('pTipo').AsInteger := RadioTipoConta.ItemIndex;
  CdsContas.Params.ParamByName('pDatai').AsDate   := Datai.Date;
  CdsContas.Params.ParamByName('pDataf').AsDate   := Dataf.Date;
  CdsContas.Open;
  if CdsContas.IsEmpty then
  begin
    MessageDlg('Nâo foram encontrados dados para o relatório!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\RelContasGeral.fr3');
  frxReport1.ShowReport;


end;

procedure TFrmRelContas.ActFecharExecute(Sender: TObject);
begin
  inherited;
  //
  close;
  
end;

procedure TFrmRelContas.RadioTipoFiltroClick(Sender: TObject);
begin
  inherited;
  GrpContato.Visible  := false;
  if RadioTipoFiltro.ItemIndex = 1 then // contato
     GrpContato.Visible  := true


end;


end.
