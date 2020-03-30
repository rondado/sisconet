unit uFrmCadRegistro60;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, uFrameBotaoVertical, ExtCtrls,
  StdCtrls, ComCtrls, Mask, DBCtrls, Grids, DBGrids, Buttons, System.Actions;

type
  TFrmCadRegistro60 = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DbID: TDBEdit;
    DbDataEmissao: TDBEdit;
    DbHoraEmissao: TDBEdit;
    DbDataMov: TDBEdit;
    Dbserial: TDBEdit;
    DbCRO: TDBEdit;
    DbCRZ: TDBEdit;
    DbCOOI: TDBEdit;
    DbCOOF: TDBEdit;
    DbVendaBruta: TDBEdit;
    DbGrandetotal: TDBEdit;
    DbCaixa: TDBEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Data60A: TDataSource;
    Grid60A: TDBGrid;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    BitBtn1: TBitBtn;
    Actlocalizar: TAction;
    Grid60M: TDBGrid;
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    procedure FormShow(Sender: TObject);
    procedure ActlocalizarExecute(Sender: TObject);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure Grid60AKeyPress(Sender: TObject; var Key: Char);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure Grid60AEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadRegistro60: TFrmCadRegistro60;

implementation

uses ulibrary, uDmWorkcom;

{$R *.dfm}

procedure TFrmCadRegistro60.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet := DmWorkCom.Cds60M;
  Data60A.DataSet  := DmWorkCom.Cds60A;
  DmWorkCom.Dados_60M(SVData,SVData);
  DmWorkCom.Dados_60A(0);
  Datai.Date := SVData;
  Dataf.Date := SVData;
  PageControl1.TabIndex := 0;
  Datai.SetFocus;

end;

procedure TFrmCadRegistro60.ActlocalizarExecute(Sender: TObject);
begin
  inherited;
  DmWorkCom.Dados_60M(Datai.Date,Dataf.Date);
  Grid60M.SetFocus;
  
end;

procedure TFrmCadRegistro60.DataWorkDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DmWorkCom.Dados_60A(DataWork.DataSet.FieldByName('ID').AsInteger);

end;

procedure TFrmCadRegistro60.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbDataEmissao.SetFocus;

end;

procedure TFrmCadRegistro60.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);
  
end;

procedure TFrmCadRegistro60.Grid60AKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
    Grava_Dados(Data60A.DataSet);

end;

procedure TFrmCadRegistro60.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,key);
  
end;

procedure TFrmCadRegistro60.Grid60AEnter(Sender: TObject);
begin
  inherited;
  if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
     Grava_Dados(DataWork.DataSet);
end;

end.
