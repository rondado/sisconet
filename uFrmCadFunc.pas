unit uFrmCadFunc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, ExtCtrls, DBCtrls, StdCtrls,
  Mask, Grids, DBGrids, ComCtrls, ActnList, DB, uFrameBotaoHorizontal,
  System.Actions;

type
  TFrmCadFunc = class(TFrmCadPadrao)
    Panel1: TPanel;
    Frame1: TFrameBotaoHorizontal;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
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
    Label13: TLabel;
    DbID: TDBEdit;
    DbNome: TDBEdit;
    DbEndereco: TDBEdit;
    DbNumero: TDBEdit;
    DbBairro: TDBEdit;
    DbCidade: TDBEdit;
    DbCep: TDBEdit;
    DbTelefone: TDBEdit;
    DbTelefax: TDBEdit;
    DbCelular: TDBEdit;
    DbCPF: TDBEdit;
    DbRG: TDBEdit;
    ComboEstado: TDBLookupComboBox;
    TabSheet2: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    DbPai: TDBEdit;
    DbMae: TDBEdit;
    DbDataNasc: TDBEdit;
    DbAdmissao: TDBEdit;
    DbDemissao: TDBEdit;
    DbSalario: TDBEdit;
    DbPercCom: TDBEdit;
    DbObservacao: TDBMemo;
    DbEmail: TDBEdit;
    DbChAtivo: TDBCheckBox;
    DbChComissao: TDBCheckBox;
    RadioTipo: TDBRadioGroup;
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DataUF: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadFunc: TFrmCadFunc;

implementation

Uses uLibrary,uDmWorkCom, uDMClientes;

{$R *.dfm}

procedure TFrmCadFunc.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet := DmClientes.CdsFuncionarios;
  DataUF.DataSet   := DmClientes.CdsUF;
  DmClientes.Dados_Funcionario(0);
  DataUF.DataSet.Open;
  PageControl1.TabIndex := 0;

end;

procedure TFrmCadFunc.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  inherited;
  DbNome.SetFocus;

end;

procedure TFrmCadFunc.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame1,DataWork.DataSet);

end;

procedure TFrmCadFunc.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCadFunc.ActPesquisarExecute(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.State in [dsInsert,dsEdit] then
  begin
    MessageDlg('Favor confirmar ou cancelar os registro corrente!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  DmClientes.Dados_Funcionario;
  PageControl1.TabIndex := 2;

end;

procedure TFrmCadFunc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DataUF.DataSet.Close;
  DataWork.DataSet.Close;
end;

procedure TFrmCadFunc.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  // grava tabela de PDV como não sincronizado
  DmWorkCom.GravaPDVNaoSincronizado;

end;

end.
