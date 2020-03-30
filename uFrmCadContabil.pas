unit uFrmCadContabil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, uFrameBotaoVertical, ExtCtrls,
  StdCtrls, Mask, DBCtrls, System.Actions;

type
  TFrmCadContabil = class(TFrmCadPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DbUF: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    Label16: TLabel;
    DBEdit16: TDBEdit;
    Label17: TLabel;
    DBEdit17: TDBEdit;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    Label19: TLabel;
    DBEdit19: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBLookupComboBox1: TDBLookupComboBox;
    DataCodCidade: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure DbUFExit(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadContabil: TFrmCadContabil;

implementation

uses uDmWorkCom, uLibrary, uDMClientes;

{$R *.dfm}

procedure TFrmCadContabil.FormShow(Sender: TObject);
begin
  DataWork.DataSet      := DmWorkCom.CdsContador;
  DataCodCidade.DataSet := DmClientes.CdsCodCidade;
  inherited;
  DmWorkCom.Dados_Contador;
  DmClientes.Dados_CodCidade(DmWorkCom.CdsEmpresaUF.AsString);

end;

procedure TFrmCadContabil.DbUFExit(Sender: TObject);
begin
  inherited;
  if DbUF.Text <> '' then
     DmClientes.Dados_CodCidade(DbUF.Text);

end;

procedure TFrmCadContabil.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);

end;

end.
