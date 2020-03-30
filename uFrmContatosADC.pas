unit uFrmContatosADC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, StdCtrls, Mask, DBCtrls, uFrameBotaoHorizontal,
  ExtCtrls, Grids, DBGrids, ComCtrls, ActnList, DB;

type
  TFrmContatosADC = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Frame: TFrameBotaoHorizontal;
    DbID: TDBEdit;
    DbIDContato: TDBEdit;
    DbNome: TDBEdit;
    DbTelefone: TDBEdit;
    DbRamall: TDBEdit;
    DbEmail1: TDBEdit;
    DbEmail2: TDBEdit;
    DbSite: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDContato:Integer;
  end;

var
  FrmContatosADC: TFrmContatosADC;

implementation

Uses uLibrary,uDmWorkCom, uDMClientes;

{$R *.dfm}

procedure TFrmContatosADC.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet := DmClientes.CdsContatosADC;
  DmClientes.Dados_ContatoADC(sIDContato);
  PageControl1.TabIndex := 0;

end;

procedure TFrmContatosADC.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbNome.SetFocus;

end;

procedure TFrmContatosADC.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);

end;

procedure TFrmContatosADC.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmContatosADC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
  
end;

end.
