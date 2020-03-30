unit uFrmCadTanques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, DBCtrls, StdCtrls, Mask,
  uFrameBotaoVertical, ExtCtrls, System.Actions;

type
  TFrmCadTanques = class(TFrmCadPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DataProduto: TDataSource;
    DBNavigator1: TDBNavigator;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActExcluirExecute(Sender: TObject);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadTanques: TFrmCadTanques;

implementation

uses uDmWorkCom, uLibrary, uDmPosto, uDmProdutos;

{$R *.dfm}

procedure TFrmCadTanques.FormShow(Sender: TObject);
begin
  DataWork.DataSet    := DmPosto.CdsTanques;
  DataProduto.DataSet := DmProdutos.CdsProdutos;
  inherited;
  DmPosto.Dados_Tanque;
  DmProdutos.Dados_ProdutoPosto;

end;

procedure TFrmCadTanques.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);

end;

procedure TFrmCadTanques.ActExcluirExecute(Sender: TObject);
begin
  MessageDlg('Não é permitido excluir o tanque do cadastro!',mtWarning,[mbOK],0);
  Abort;
  inherited;

end;

procedure TFrmCadTanques.DataWorkDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBEdit2.ReadOnly := true;
  if DataWork.DataSet.State in [dsedit] then
  begin
    DBEdit2.ReadOnly := true;
  end;

end;

end.
