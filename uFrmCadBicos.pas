unit uFrmCadBicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, uFrameBotaoVertical, DBCtrls,
  StdCtrls, Mask, ExtCtrls, System.Actions;

type
  TFrmCadBicos = class(TFrmCadPadrao)
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    DataTanque: TDataSource;
    DataBomba: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    DBCheckBox1: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadBicos: TFrmCadBicos;

implementation

uses uDmWorkCom, uLibrary, uDmPosto, uDmProdutos;

{$R *.dfm}

procedure TFrmCadBicos.FormShow(Sender: TObject);
begin
  DataWork.DataSet   := DmPosto.CdsBicos;
  DataTanque.DataSet := DmPosto.CdsTanques;
  DataBomba.DataSet  := DmPosto.CdsBombas;
  inherited;
  DmPosto.Dados_Bicos;
  DmPosto.Dados_Tanque;
  DmPosto.Dados_Bomba;

end;

procedure TFrmCadBicos.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);

end;

procedure TFrmCadBicos.ActConfirmarExecute(Sender: TObject);
begin
  if DataWork.DataSet.FieldByName('ID_TANQUE').AsInteger > 0 then
  begin
    if DmProdutos.Dados_Produto(DataTanque.DataSet.FieldByName('ID_PRODUTO').AsInteger) then
       DataWork.DataSet.FieldByName('PRECO').AsFloat := DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat;
  end;
  inherited;

end;

procedure TFrmCadBicos.ActExcluirExecute(Sender: TObject);
begin
  MessageDlg('Não é permitido excluir o Bico do cadastro!',mtWarning,[mbOK],0);
  Abort;
  inherited;

end;

procedure TFrmCadBicos.DataWorkDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  DBEdit5.ReadOnly := true;
  DBEdit6.ReadOnly := true;
  DBEdit2.ReadOnly := true;
  if DataWork.DataSet.State in [dsedit] then
  begin
    DBEdit5.ReadOnly := true;
    DBEdit6.ReadOnly := true;
    DBEdit2.ReadOnly := true;
  end;
end;

end.
