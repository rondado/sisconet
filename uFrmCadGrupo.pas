unit uFrmCadGrupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, ExtCtrls, Grids, DBGrids,
  StdCtrls, DBCtrls, Mask, ComCtrls, ActnList, DB, System.Actions;

type
  TFrmCadGrupo = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DbID: TDBEdit;
    DbDescricao: TDBEdit;
    DbChAtivo: TDBCheckBox;
    DBGrid2: TDBGrid;
    Panel1: TPanel;
    Frame1: TFrameBotaoVertical;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    DbGrupoDescricao: TDBEdit;
    DataSubGrupo: TDataSource;
    DbChAtivoVenda: TDBCheckBox;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadGrupo: TFrmCadGrupo;

implementation

uses uLibrary, uDmWorkCom, uDmProdutos;

{$R *.dfm}

procedure TFrmCadGrupo.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet     := DmProdutos.CdsGrupo;
  DataSubGrupo.DataSet := DmProdutos.CdsSubGrupo;
  DmProdutos.Dados_Grupo;
  TabSheet2Enter(Sender);
  PageControl1.TabIndex := 0;
  DbDescricao.SetFocus;

end;

procedure TFrmCadGrupo.TabSheet2Enter(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.RecordCount > 0 then
     DmProdutos.Dados_SubGrupo(DataWork.DataSet.FieldByname('ID').AsInteger);

end;

procedure TFrmCadGrupo.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame1,DataWork.DataSet);

end;

procedure TFrmCadGrupo.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
     Grava_Dados(DataSubGrupo.DataSet);

end;

procedure TFrmCadGrupo.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCadGrupo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
  DataSubGrupo.DataSet.Close;
  
end;

procedure TFrmCadGrupo.Button1Click(Sender: TObject);
begin
  inherited;
  Grava_Dados(DataSubGrupo.DataSet);

end;

end.
