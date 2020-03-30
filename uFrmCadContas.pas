unit uFrmCadContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, ComCtrls, ExtCtrls, SqlExpr,
  uFrameBotaoHorizontal, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Buttons,
  Menus, System.Actions, Data.FMTBcd, Datasnap.Provider, Datasnap.DBClient;

type
  TFrmCadContas = class(TFrmCadPadrao)
    Panel1: TPanel;
    DataContato: TDataSource;
    ActConsultarContato: TAction;
    ActCadastrar: TAction;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DbID: TDBEdit;
    DbDatacad: TDBEdit;
    DbNumConta: TDBEdit;
    DbSerie: TDBEdit;
    GrpContato: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DbIdContato: TDBEdit;
    DbDocContato: TDBEdit;
    DbContato: TDBEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioStatus: TDBRadioGroup;
    GrpValores: TGroupBox;
    Label11: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    DbValorConta: TDBEdit;
    DbValorPago: TDBEdit;
    DbAcrescimo: TDBEdit;
    DbDesconto: TDBEdit;
    DbJuros: TDBEdit;
    DbMulta: TDBEdit;
    GrpData: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    DbDataVenc: TDBEdit;
    DbDataPago: TDBEdit;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ComboFormaPag: TDBLookupComboBox;
    Label16: TLabel;
    DataFormaPag: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DbIdContatoExit(Sender: TObject);
    procedure ActConsultarContatoExecute(Sender: TObject);
    procedure ActCadastrarExecute(Sender: TObject);
    procedure ActIncluirExecute(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure DbValorPagoEnter(Sender: TObject);
  private
    { Private declarations }
    procedure GravaValorAPagar;
    procedure HabilitaCamposEditaveis;
  public
    { Public declarations }
    sIDConta : Integer;
  end;

var
  FrmCadContas: TFrmCadContas;

implementation

Uses uLibrary, uDmWorkCom, uFrmClientes, uFrmCadastroCliente, uDMClientes, unrecibo, extens; //fabricio unrecibo extens

{$R *.dfm}
procedure TFrmCadContas.FormShow(Sender: TObject);
begin
  DataWork.DataSet := DmWorkCom.CdsContas;
  inherited;
  DataContato.DataSet  := DmClientes.CdsContatos;
  DmWorkCom.Dados_Contas(sIDConta);
  if not DataWork.DataSet.IsEmpty  then
     DmClientes.Dados_Contato(DataWork.DataSet.FieldByName('IDCONTATO').AsInteger)
  else
     DmClientes.Dados_Contato(0);
  HabilitaCamposEditaveis;
  // verifica os dados
  if DataWork.DataSet.RecordCount > 0 then
     DataWork.DataSet.Edit
  else
     DataWork.DataSet.Append;

//fabricio novo    inicio
     if not DmWorkCom.QryFormaPag.Active then
        begin
         DmWorkCom.QryFormaPag.Active:=true;
         DmWorkCom.CdsFormaPag.Active:=true;

        end;

     comboformapag.KeyValue := '1';
//fabricio novo fim
  //
  if DmWorkCom.sProcessoQui = 0 then
  begin
    DbNumConta.SelectAll;
    DbNumConta.SetFocus;
  end
  else
  begin
    DbDesconto.SelectAll;
    DbDesconto.SetFocus;
  end;
end;

procedure TFrmCadContas.GravaValorAPagar;
var aTotPagar:Double;
begin
  aTotPagar := DataWork.DataSet.FieldByName('VALOR_CONTA').AsFloat -
               DataWork.DataSet.FieldByName('VALOR_DESCONTO').AsFloat +
               DataWork.DataSet.FieldByName('VALOR_ACRESCIMO').AsFloat +
               DataWork.DataSet.FieldByName('JUROS').AsFloat +
               DataWork.DataSet.FieldByName('MULTA').AsFloat;
  if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
     DataWork.DataSet.Edit;
  DataWork.DataSet.FieldByName('VALOR_QUITATO').AsFloat := aTotPagar;

end;

procedure TFrmCadContas.HabilitaCamposEditaveis;
var Ativa : Boolean;
begin
  Ativa := (DmWorkCom.sProcessoQui = 1);
  DbNumConta.Enabled := not Ativa;
  DbIdContato.Enabled := not Ativa;
  GrpData.Enabled := not Ativa;
  RadioStatus.Enabled := not Ativa;

  DbValorConta.Enabled := not Ativa;
  DbDesconto.Enabled := Ativa;
  DbAcrescimo.Enabled := Ativa;
  DbJuros.Enabled := Ativa;
  DbMulta.Enabled := Ativa;
  DbValorPago.Enabled := Ativa;

end;

procedure TFrmCadContas.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
//  AbilitaFrame(Frame,DataWork.DataSet);
end;

procedure TFrmCadContas.DbIdContatoExit(Sender: TObject);
begin
  inherited;
  if DbIdContato.Text <> '' then
  begin
    if DmClientes.Dados_Contato(DataWork.DataSet.FieldByName('IDCONTATO').AsInteger) then
    begin
      DataWork.DataSet.FieldByName('IDCONTATO').AsInteger  := DataContato.DataSet.FieldByName('ID').AsInteger;
      DataWork.DataSet.FieldByName('CONTATO').AsString     := DataContato.DataSet.FieldByName('NOME').AsString;
      DataWork.DataSet.FieldByName('DOC_CONTATO').AsString := DataContato.DataSet.FieldByName('CNPJ_CPF').AsString;
    end
    else
    begin
      MessageDlg('Contato não encontrado. Verifique!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
     
end;

procedure TFrmCadContas.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCadContas.DbValorPagoEnter(Sender: TObject);
begin
  inherited;
  GravaValorAPagar;

end;

procedure TFrmCadContas.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmCadContas.ActConfirmarExecute(Sender: TObject);

begin
  if DmWorkCom.sProcessoQui = 1 then
  begin
    DmWorkCom.sValorQuitacao := DataWork.DataSet.FieldByName('VALOR_QUITATO').AsFloat;
//fabricio novo inicio
      if Confirmacao('Deseja Imprimir um Recibo ?') then
      begin
         FrmRecibo.LabeledEdit1.Text:= FrmCadContas.DbID.Text;
         //+'/'+FrmCadContas.DbNumConta.Text+'/'+FrmCadContas.DbSerie.Text;
         FrmRecibo.LabeledEdit2.Text:= FrmCadContas.DbValorPago.Text;
         FrmRecibo.LabeledEdit3.Text:= FrmCadContas.DbIdContato.Text+' / '+FrmCadContas.DbContato.Text;
         FrmRecibo.LabeledEdit4.Text:=
         DataContato.DataSet.FieldByName('ENDERECO').AsString+
         ' '+ FrmCadContas.DbDocContato.Text;
         FrmRecibo.Memo2.Text:=
         'Pgto da Conta, Vcto '+FrmCadContas.DbDataVenc.Text +', Conta R$'+FrmCadContas.DbValorConta.Text+
         ', Pago R$'+FrmCadContas.DbValorPago.Text+
         ', Desc R$'+FrmCadContas.DbAcrescimo.Text+
         ', Acrésc R$'+FrmCadContas.DbDesconto.Text+
         ', Juros R$'+FrmCadContas.DbJuros.Text+
         ', '+FrmCadContas.ComboFormaPag.Text;
         FrmRecibo.Memo1.text := Extenso(DataWork.DataSet.FieldByName('VALOR_QUITATO').AsCurrency)
        + ' Conta '+FrmCadContas.DbNumConta.Text+'/'+FrmCadContas.DbSerie.Text;
//         FrmRecibo.labelededit2.Text:= format('%n', [strtofloat(FrmRecibo.labelededit2.Text)]);

         FrmRecibo.SpeedButton1.Click;
//         FrmRecibo.QuickRep1.Preview;
      end;

//fabricio novo fim




  end;
  inherited;
  Close;

end;

procedure TFrmCadContas.ActConsultarContatoExecute(Sender: TObject);
begin
  inherited;
  FrmClientes.sCodCli := 0;
  FrmClientes.sApenasConsulta := true;
  FrmClientes.ShowModal;
  if FrmClientes.sCodCli > 0 then
  begin
    if DmClientes.Dados_Contato(FrmClientes.sCodCli) then
    begin
      DataWork.DataSet.FieldByName('IDCONTATO').AsInteger  := DataContato.DataSet.FieldByName('ID').AsInteger;
      DataWork.DataSet.FieldByName('CONTATO').AsString     := DataContato.DataSet.FieldByName('NOME').AsString;
      DataWork.DataSet.FieldByName('DOC_CONTATO').AsString := DataContato.DataSet.FieldByName('CNPJ_CPF').AsString;
    end
    else
    begin
      MessageDlg('Contato não encontrado. Verifique!!!', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
end;

procedure TFrmCadContas.ActCadastrarExecute(Sender: TObject);
begin
  inherited;
  // cadastro
    FrmCadastroCliente.showmodal;

end;

procedure TFrmCadContas.ActIncluirExecute(Sender: TObject);
begin
  inherited;
  DbNumConta.SetFocus;

end;

procedure TFrmCadContas.TabSheet2Show(Sender: TObject);
begin
  inherited;
  if DmWorkCom.CdsConsulta.Active then
  begin
    if DmWorkCom.CdsConsulta.RecordCount > 0 then
    begin
      DmWorkCom.Dados_Contas(DmWorkCom.CdsConsulta.FieldByName('ID').AsInteger);
    end;
  end;
end;


procedure TFrmCadContas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if DataWork.DataSet.RecordCount > 0 then
     sIDConta := DataWork.DataSet.FieldByName('ID').AsInteger;
  // fecha tabelas
  DataWork.DataSet.Close;
  DataContato.DataSet.Close;

end;

procedure TFrmCadContas.FormCreate(Sender: TObject);
begin
  inherited;
  sIDConta := 0;

end;

end.
