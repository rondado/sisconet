unit uFrmCadPlanoConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, Grids, DBGrids, ComCtrls,
  uFrameBotaoVertical, ExtCtrls, DBCtrls, StdCtrls, Mask, System.Actions;

type
  TFrmCadPlanoConta = class(TFrmCadPadrao)
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    PageControl1: TPageControl;
    TbsCadastro: TTabSheet;
    TbsConsulta: TTabSheet;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBMemo1: TDBMemo;
    Label6: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DataConta: TDataSource;
    DBRadioGroup1: TDBRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActIncluirExecute(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure ActConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPlanoConta: TFrmCadPlanoConta;

implementation

uses uDmWorkCom, uLibrary;

{$R *.dfm}

procedure TFrmCadPlanoConta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
end;

procedure TFrmCadPlanoConta.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet  := DmWorkCom.CdsPlanoConta;
  DataConta.DataSet := DmWorkCom.CdsPNMaster;
  DmWorkCom.Dados_PlanoConta;
  DmWorkCom.Dados_PNMaster;
  PageControl1.ActivePage := TbsConsulta;
  
end;

procedure TFrmCadPlanoConta.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);

end;

procedure TFrmCadPlanoConta.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.ActivePage := TbsCadastro;
  inherited;

end;

procedure TFrmCadPlanoConta.DBEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmCadPlanoConta.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  DmWorkCom.Dados_PNMaster;
  
end;

end.
