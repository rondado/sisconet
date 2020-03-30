unit uFrmCadPDV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, ExtCtrls, ActnList, DB,
  DBCtrls, StdCtrls, Mask, System.Actions;

type
  TFrmCadPDV = class(TFrmCadPadrao)
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBNavigator1: TDBNavigator;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    ComboEmpresa: TDBLookupComboBox;
    DataEmpresa: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPDV: TFrmCadPDV;

implementation

uses uDmWorkCom, uLibrary;

{$R *.dfm}

procedure TFrmCadPDV.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet    := DmWorkCom.CdsPDV;
  DataEmpresa.DataSet := DmWorkCom.CdsEmpresa;
  DmWorkCom.Dados_PDV;
  DmWorkCom.Dados_Empresa;
  DBEdit1.SelectAll;
  DBEdit1.SetFocus;

end;

procedure TFrmCadPDV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;

end;

procedure TFrmCadPDV.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);

end;

procedure TFrmCadPDV.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

end.
