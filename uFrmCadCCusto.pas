unit uFrmCadCCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, StdCtrls, DBCtrls, Mask,
  uFrameBotaoVertical, ExtCtrls, Grids, DBGrids, ComCtrls, System.Actions;

type
  TFrmCadCCusto = class(TFrmCadPadrao)
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    PageControl1: TPageControl;
    TbsCadastro: TTabSheet;
    TbsConsulta: TTabSheet;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DbEdDescricao: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBMemo1: TDBMemo;
    DBCheckBox1: TDBCheckBox;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure ActIncluirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadCCusto: TFrmCadCCusto;

implementation

uses uDmWorkCom, uLibrary;

{$R *.dfm}

procedure TFrmCadCCusto.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet := DmWorkCom.CdsCentroCusto;
  DmWorkCom.Dados_CentroCusto;
  PageControl1.ActivePage := TbsConsulta;
  
end;

procedure TFrmCadCCusto.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);

end;

procedure TFrmCadCCusto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
  
end;

procedure TFrmCadCCusto.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

procedure TFrmCadCCusto.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.ActivePage := TbsCadastro;
  inherited;

end;

end.
