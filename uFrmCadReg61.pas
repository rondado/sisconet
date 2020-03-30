unit uFrmCadReg61;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, StdCtrls, ComCtrls,
  uFrameBotaoVertical, ExtCtrls, Buttons, Grids, DBGrids, Mask, DBCtrls,
  System.Actions;

type
  TFrmCadReg61 = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    BitBtn1: TBitBtn;
    ActLocalizar: TAction;
    GroupBox4: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    Label9: TLabel;
    DBEdit7: TDBEdit;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    Label12: TLabel;
    DBEdit10: TDBEdit;
    Label13: TLabel;
    DBEdit11: TDBEdit;
    Label14: TLabel;
    DBEdit12: TDBEdit;
    Label15: TLabel;
    DBEdit13: TDBEdit;
    Bevel1: TBevel;
    SpeedButton1: TSpeedButton;
    Label16: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DataCliente: TDataSource;
    DBEdit14: TDBEdit;
    Label17: TLabel;
    DBEdit15: TDBEdit;
    Label18: TLabel;
    DBEdit16: TDBEdit;
    Label19: TLabel;
    Label20: TLabel;
    DBEdit17: TDBEdit;
    Label21: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBEdit18: TDBEdit;
    Label22: TLabel;
    DBEdit19: TDBEdit;
    Label23: TLabel;
    procedure ActLocalizarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ActIncluirExecute(Sender: TObject);
    procedure DBEdit10Exit(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CalculaTotal;
  public
    { Public declarations }
    sContigencia : Boolean;
  end;

var
  FrmCadReg61: TFrmCadReg61;

implementation

Uses uLibrary, uDmWorkcom, uFrmProdutos, uDMClientes, uDmPosto, uFrmProdPosto,
  uDmProdutos;

{$R *.dfm}

procedure TFrmCadReg61.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  DmWorkCom.Dados_61(Datai.Date,Dataf.Date);

end;

procedure TFrmCadReg61.FormShow(Sender: TObject);
begin
  DataWork.DataSet := DmWorkCom.CdsReg61;
  DataCliente.DataSet := DmClientes.CdsContatos;
  inherited;
  Datai.Date := SVData;
  Dataf.Date := SVData;
  DmWorkCom.Dados_61(Datai.Date,Dataf.Date);
  DmClientes.Dados_Contato('C');
  PageControl1.TabIndex :=1;
  
end;

procedure TFrmCadReg61.ActPesquisarExecute(Sender: TObject);
begin
  inherited;
  PageControl1.TabIndex := 1;
  
end;

procedure TFrmCadReg61.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(self,key);
  
end;

procedure TFrmCadReg61.SpeedButton1Click(Sender: TObject);
var aIDProd : Integer;
begin
  inherited;
  aIDProd := 0;
  if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    if not sContigencia then
    begin
      Application.CreateForm(TfrmProdutos,FrmProdutos);
      try
        FrmProdutos.sIDProd := 0;
        FrmProdutos.sApenasConsulta := true;
        FrmProdutos.sPermitirCombustivel := sContigencia;
        FrmProdutos.ShowModal;
        aIDProd := FrmProdutos.sIDProd;
      finally
        FrmProdutos.Free;
      end;
    end
    else
    begin
      Application.CreateForm(TFrmProdPosto,FrmProdPosto);
      try
        FrmProdPosto.ShowModal;
        aIDProd  := FrmProdPosto.sIDProd;
      finally
        FreeAndNil(FrmProdPosto);
      end;
    end;
    //
    if DmProdutos.Dados_Produto(aIDProd) then
    begin
      DataWork.DataSet.FieldByName('IDPRODUTO').AsInteger     := DmProdutos.CdsProdutos.fieldbyName('ID').AsInteger;
      DataWork.DataSet.FieldByName('DESCRICAO').AsString      := DmProdutos.CdsProdutos.fieldbyName('DESCRICAO').AsString;
      DataWork.DataSet.FieldByName('ALIQ_ICMS').AsFloat       := DmProdutos.CdsProdutos.fieldbyName('ALIQUOTA_ICMS').AsFloat;
      DataWork.DataSet.FieldByName('CST').AsString            := DmProdutos.CdsProdutos.fieldbyName('CST_INTERNO').AsString;
      if not sContigencia then
         DataWork.DataSet.FieldByName('CFOP').AsString        := DmProdutos.CdsProdutos.fieldbyName('CFOP_INTERNO').AsString
      else
         DataWork.DataSet.FieldByName('CFOP').AsString        := '5929';
      DataWork.DataSet.FieldByName('VALOR').AsFloat           := DmProdutos.CdsProdutos.fieldbyName('PRECO_VENDA').AsFloat;
      DataWork.DataSet.FieldByName('ID_BICO_PERDA').AsInteger := 0;
    end;
  end;
end;

procedure TFrmCadReg61.ActIncluirExecute(Sender: TObject);
begin
  inherited;
  PageControl1.TabIndex := 0;
  DBEdit3.SetFocus;
end;

procedure TFrmCadReg61.DBEdit10Exit(Sender: TObject);
begin
  inherited;
  if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    CalculaTotal;
  end;

end;

procedure TFrmCadReg61.CalculaTotal;
var aValor, aValICMS : Double;
begin
  aValor := DataWork.DataSet.FieldByName('QUANTIDADE').AsFloat*
            DataWork.DataSet.FieldByName('VALOR').AsFloat;
  aValICMS := (aValor * DataWork.DataSet.FieldByName('ALIQ_ICMS').AsFloat) /100;
  DataWork.DataSet.FieldByName('TOTAL').AsFloat      := aValor;
  DataWork.DataSet.FieldByName('BASE_ICMS').AsFloat  := aValor;
  DataWork.DataSet.FieldByName('VALOR_ICMS').AsFloat := aValICMS;

end;

procedure TFrmCadReg61.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);
  
end;

procedure TFrmCadReg61.FormCreate(Sender: TObject);
begin
  inherited;
  sContigencia := False;
end;

procedure TFrmCadReg61.ActConfirmarExecute(Sender: TObject);
var aEncerranteAnterior : Double;
    aNumBico : String;
begin
  if DataWork.DataSet.FieldByName('NUM_ORDEM').AsString = '' then
  begin
    MessageDlg('É necessário informar o numero de ordem!',mtWarning,[mbok],0);
    Abort;
  end;
  if DataWork.DataSet.State in [dsInsert] then
  begin
   DmWorkCom.GravaRegistroA2(DataWork.DataSet.FieldByName('DATA_EMISSAO').AsDateTime,
                             'DINHEIRO',3,DataWork.DataSet.FieldByName('TOTAL').AsFloat);
  end;
  inherited;
  // verifica se é para vincular a uma descontinuidade
  if DmProdutos.CdsProdutos.FieldByName('COMBUSTIVEL').AsString = 'S' then
  begin
    DmPosto.Dados_Abastecimentos;
    aNumBico := DmWorkCom.RetornaBicoProduto(DmProdutos.CdsProdutos.FieldByName('ID').AsInteger);
    aEncerranteAnterior := DmWorkCom.PAFECF.RetornaUltimoEncerranteBico(aNumBico);
    aEncerranteAnterior := aEncerranteAnterior + DataWork.DataSet.FieldByName('QUANTIDADE').AsFloat;
    DmPosto.RegistraAbastecimentos(aNumBico,
                                   FormatDateTime('dd/mm/yyyy',now),
                                   FormatDateTime('hh:mm:ss',now),
                                   aEncerranteAnterior,
                                   DataWork.DataSet.FieldByName('QUANTIDADE').AsFloat,
                                   DataWork.DataSet.FieldByName('VALOR').AsFloat,
                                   DataWork.DataSet.FieldByName('TOTAL').AsFloat,
                                   false,
                                   true,
                                   DataWork.DataSet.FieldByName('NUM_ORDEM').AsString);
  end;

end;

end.
