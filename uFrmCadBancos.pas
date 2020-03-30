unit uFrmCadBancos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, ExtCtrls, DBCtrls, StdCtrls,
  Mask, Grids, DBGrids, ComCtrls, ActnList, DB, uFrameBotaoHorizontal,
  System.Actions;

type
  TFrmCadBancos = class(TFrmCadPadrao)
    Panel1: TPanel;
    Frame1: TFrameBotaoHorizontal;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DbID: TDBEdit;
    ComboEstado: TDBLookupComboBox;
    TbsConsulta: TTabSheet;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DataUF: TDataSource;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    CbxTipoCob: TComboBox;
    DBComboBox1: TDBComboBox;
    procedure FormShow(Sender: TObject);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadBancos: TFrmCadBancos;

implementation

Uses uLibrary,uDmWorkCom, uDMClientes;

{$R *.dfm}

procedure TFrmCadBancos.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet := DmWorkCom.CdsBancos;
  DataUF.DataSet   := DmClientes.CdsUF;
  DmWorkCom.Dados_Banco;
  DataUF.DataSet.Open;
  PageControl1.TabIndex := 0;

end;

procedure TFrmCadBancos.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  inherited;
  DBEdit2.SetFocus;

end;

procedure TFrmCadBancos.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame1,DataWork.DataSet);

end;

procedure TFrmCadBancos.DataWorkDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
     CbxTipoCob.ItemIndex := DataWork.DataSet.FieldByName('TIPO_COBRANCA').AsInteger;
end;

procedure TFrmCadBancos.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCadBancos.ActPesquisarExecute(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.State in [dsInsert,dsEdit] then
  begin
    MessageDlg('Favor confirmar ou cancelar os registro corrente!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  DmWorkCom.Dados_Banco;
  PageControl1.TabIndex := 1;

end;

procedure TFrmCadBancos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DataUF.DataSet.Close;
  DataWork.DataSet.Close;
end;

procedure TFrmCadBancos.ActConfirmarExecute(Sender: TObject);
begin
  if Trim(CbxTipoCob.Text) = '' then
  begin
    MessageDlg('É necessário selecionar o tipo de cobrança!',mtWarning,[mbOK],0);
    Exit;
  end;
  DataWork.DataSet.FieldByName('TIPO_COBRANCA').AsInteger := CbxTipoCob.ItemIndex;
  inherited;
  // grava tabela de PDV como não sincronizado
  DmWorkCom.GravaPDVNaoSincronizado;

end;

end.
