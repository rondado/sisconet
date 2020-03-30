unit uFrmAbreRegistra2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, DBClient, DBCtrls, StdCtrls,
  uFrameConfirmaCancela, ExtCtrls, Buttons, Mask, Grids, DBGrids;

type
  TFrmAbreRegistra2 = class(TFrmPadrao)
    DataMesa: TDataSource;
    GroupBox1: TGroupBox;
    CdsAuxiliar: TClientDataSet;
    CdsAuxiliarID_PRODUTO: TIntegerField;
    CdsAuxiliarID_MESA: TIntegerField;
    CdsAuxiliarQUANT: TFloatField;
    DataAuxiliar: TDataSource;
    CdsAuxiliarPRECO: TFloatField;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DsItensMesa: TDataSource;
    Panel2: TPanel;
    Label4: TLabel;
    LbValor: TLabel;
    Panel1: TPanel;
    BtnConfirmar: TBitBtn;
    BtnCancelar: TBitBtn;
    DbQuant: TDBEdit;
    Label3: TLabel;
    EdtProduto: TMaskEdit;
    SpeedButton1: TSpeedButton;
    EdtCodPro: TEdit;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    EdtComanda: TEdit;
    Label1: TLabel;
    EdtMesa: TEdit;
    BitBtn1: TBitBtn;
    ChEntregar: TCheckBox;
    EdtAtendente: TEdit;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EdtEntregador: TEdit;
    SpeedButton3: TSpeedButton;
    EdtLocalEntrega: TEdit;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtComandaExit(Sender: TObject);
    procedure EdtCodProExit(Sender: TObject);
    procedure EdtComandaKeyPress(Sender: TObject; var Key: Char);
    procedure DbQuantKeyDown(Sender: TObject; var Key:Word;Shift:TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    xIDAtendente, xIDEntregador : Integer;
    procedure LimpaDadosComanda(LimparComanda:Boolean=true);
    procedure ExibeTotalMesa;
  public
    { Public declarations }
    sIDMesa : Integer;
  end;

var
  FrmAbreRegistra2: TFrmAbreRegistra2;

implementation

uses uDmWorkCom, uLibrary, uFrmProdutos, uDmProdutos, uFrmListaMesas,
  uFrmFuncionarios, uDMClientes;

{$R *.dfm}

procedure TFrmAbreRegistra2.FormShow(Sender: TObject);
begin
  inherited;
  DataMesa.DataSet := DmWorkCom.CdsMesas;
  DsItensMesa.DataSet := DmWorkCom.CdsMesasItens;
  DmWorkCom.Dados_Mesa;
  DmWorkCom.Dados_MesasItens(0);
  CdsAuxiliar.Open;
  CdsAuxiliar.Append;
  CdsAuxiliarID_MESA.AsInteger := sIDMesa;
  if sIDMesa > 0 then
  begin
    if DmWorkCom.Dados_MesasAbertas(0,sIDMesa) then
    begin
      DataMesa.DataSet.Locate('ID',DmWorkCom.CdsMesasAbertasID_MESA.AsInteger,[]);
      EdtComanda.Text := DataMesa.DataSet.FieldByName('NUMERO_MESA').AsString;
      ChEntregar.Checked := (DmWorkCom.CdsMesasAbertas.FieldByName('ENTREGAR').AsString = 'S');
      EdtLocalEntrega.Text := DmWorkCom.CdsMesasAbertas.FieldByName('LOCAL_ENTREGA').AsString;
      if DmWorkCom.CdsMesasAbertas.FieldByName('ID_VENDEDOR').AsInteger > 0 then
      begin
        xIDAtendente := DmWorkCom.CdsMesasAbertas.FieldByName('ID_VENDEDOR').AsInteger;
        DmClientes.Dados_Funcionario;
        if DmClientes.Dados_FuncionarioAux(xIDAtendente) then
        begin
          EdtAtendente.Text := DmClientes.CdsFuncionariosAux.FieldByName('NOME').AsString;
        end;
      end;
      if DmWorkCom.CdsMesasAbertas.FieldByName('ID_ENTREGADOR').AsInteger > 0 then
      begin
        xIDEntregador := DmWorkCom.CdsMesasAbertas.FieldByName('ID_ENTREGADOR').AsInteger;
        if DmClientes.Dados_FuncionarioAux(xIDEntregador) then
        begin
          EdtEntregador.Text := DmClientes.CdsFuncionariosAux.FieldByName('NOME').AsString;
        end;
      end;
    end;
  end;
  //
  EdtComanda.Enabled := true;
  if sIDMesa > 0 then
  begin
    EdtComanda.Enabled := false;
  end
     
end;

procedure TFrmAbreRegistra2.FormCreate(Sender: TObject);
begin
  inherited;
  sIDMesa := 0;
  if not CdsAuxiliar.Active then
     CdsAuxiliar.CreateDataSet;
  CdsAuxiliar.EmptyDataSet;

end;

procedure TFrmAbreRegistra2.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TfrmProdutos,FrmProdutos);
  try
    FrmProdutos.sIDProd := 0;
    FrmProdutos.sApenasConsulta := true;
    FrmProdutos.ShowModal;
    if FrmProdutos.sIDProd > 0 then
    begin
      if DmProdutos.Dados_Produto(FrmProdutos.sIDProd) then
      begin
        EdtCodPro.Text                  := DmProdutos.CdsProdutos.FieldByName('EAN13').AsString;
        EdtProduto.Text                 := DmProdutos.CdsProdutos.FieldByName('DESCRICAO').AsString;
        CdsAuxiliarID_PRODUTO.AsInteger := DmProdutos.CdsProdutos.FieldByName('ID').AsInteger;
        CdsAuxiliarPRECO.AsFloat        := DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat;
      end;
      DbQuant.SetFocus;
    end;
  finally
    FrmProdutos.Destroy;
  end;
  
end;

procedure TFrmAbreRegistra2.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmFuncionarios,FrmFuncionarios);
    FrmFuncionarios.ShowModal;
    if FrmFuncionarios.sIDFuncionario > 0 then
    begin
      if DmClientes.Dados_FuncionarioAux(FrmFuncionarios.sIDFuncionario) then
      begin
        xIDAtendente := FrmFuncionarios.sIDFuncionario;
        EdtAtendente.Text := DmClientes.CdsFuncionariosAux.FieldByName('NOME').AsString;
      end;
    end;
  finally
    FreeAndNil(FrmFuncionarios);
  end;

end;

procedure TFrmAbreRegistra2.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmFuncionarios,FrmFuncionarios);
    FrmFuncionarios.ShowModal;
    if FrmFuncionarios.sIDFuncionario > 0 then
    begin
      if DmClientes.Dados_FuncionarioAux(FrmFuncionarios.sIDFuncionario) then
      begin
        xIDEntregador := FrmFuncionarios.sIDFuncionario;
        EdtEntregador.Text := DmClientes.CdsFuncionariosAux.FieldByName('NOME').AsString;
      end;
    end;
  finally
    FreeAndNil(FrmFuncionarios);
  end;

end;

procedure TFrmAbreRegistra2.EdtComandaExit(Sender: TObject);
begin
  inherited;
  if EdtComanda.Text <> '' then
  begin
    if not DataMesa.DataSet.Locate('NUMERO_MESA',EdtComanda.Text,[]) then
    begin
      EdtMesa.Clear;
      MessageDlg('Não foi localizdo a comando para o numero informado',mtWarning,[mbOK],0);
      EdtComanda.SelectAll;
      EdtComanda.SetFocus;
      Exit;
    end
    else
    begin
      CdsAuxiliarID_MESA.AsInteger := DataMesa.DataSet.FieldByName('ID').AsInteger;
      EdtMesa.Text := DataMesa.DataSet.FieldByName('DESCRICAO').AsString;
      ExibeTotalMesa;
    end;
  end;
end;

procedure TFrmAbreRegistra2.EdtCodProExit(Sender: TObject);
var AuxCodPro, aCodigo : String;
    aux : double;
    aOK, aBalanca : Boolean;
begin
  inherited;
  if EdtCodPro.Text <> '' then
  begin
    aBalanca := false;
    AuxCodPro := EdtCodPro.Text;
    // verifica codigo de balança
    if DmWorkCom.PAFECF.gNumDigito = 4 then
    begin
      if (Copy(AuxCodPro,1,1) = DmWorkCom.PAFECF.gDigito) and
         (Length(AuxCodPro) = 13) then
      begin
        aBalanca := true;
        aCodigo := ZeroEsquerda(copy(AuxCodPro,2,4),13);
        aux     := StrToFloat(copy(AuxCodPro,8,5));
        aux     := aux /100;
      end;
    end
    else if DmWorkCom.PAFECF.gNumDigito = 5 then
    begin
      if (Copy(AuxCodPro,1,1) = DmWorkCom.PAFECF.gDigito) and
         (Length(AuxCodPro) = 13) then
      begin
        aBalanca := true;
        aCodigo := ZeroEsquerda(copy(AuxCodPro,2,5),13);
        aux     := StrToFloat(copy(AuxCodPro,8,5));
        aux     := aux /100;
      end;
    end
    else if DmWorkCom.PAFECF.gNumDigito = 6 then
    begin
      if (Copy(AuxCodPro,1,1) = DmWorkCom.PAFECF.gDigito) and
         (Length(AuxCodPro) = 13) then
      begin
        aBalanca := true;
        aCodigo := ZeroEsquerda(copy(AuxCodPro,2,6),13);
        aux     := StrToFloat(copy(AuxCodPro,8,5));
        aux     := aux /100;
      end;
    end;
    //
    if not aBalanca then
    begin
      aCodigo := ZeroEsquerda(AuxCodPro,13);
    end;
    //
    aOK := false;
    if Length(Trim(aCodigo)) >= 5 then
    begin
      if DmProdutos.Dados_Produto(StrToInt(aCodigo)) then
         aOK := true;
    end
    else
    begin
      if DmProdutos.Dados_Produto(aCodigo) then
         aOK := true;
    end;
    //
    if aOK then
    begin
      EdtProduto.Text                 := DmProdutos.CdsProdutos.FieldByName('DESCRICAO').AsString;
      CdsAuxiliarID_PRODUTO.AsString  := DmProdutos.CdsProdutos.FieldByName('ID').AsString;
      CdsAuxiliarPRECO.AsFloat        := DmProdutos.CdsProdutos.FieldByName('PRECO_VENDA').AsFloat;
      if aBalanca then
         CdsAuxiliarQUANT.AsFloat := TruncaValor(aux/DmProdutos.CdsProdutos.FieldbyName('PRECO_VENDA').AsFloat,3);
      DbQuant.SetFocus;
    end
    else
    begin
      MessageDlg('Produto não localizado!',mtWarning,[mbOK],0);
      EdtCodPro.SelectAll;
      EdtCodPro.SetFocus;
    end;
  end;

end;

procedure TFrmAbreRegistra2.EdtComandaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,key);
end;

procedure TFrmAbreRegistra2.DbQuantKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var pPesoBalanca : double;  
begin
  inherited;
  if Key = vk_f11 then
  begin
    pPesoBalanca := 0;
    if DmWorkCom.PAFECF.gModeloBal > 0 then
    begin
      if DmWorkCom.PAFECF.AtivarBalancaCaixa then
      begin
        pPesoBalanca := DmWorkCom.PAFECF.CapturarPesoBalanca;
        if pPesoBalanca <= 0 then
        begin
          MessageDlg('Erro ao capturar peso da balança. Verifique!', mtError, [mbOK], 0);
          pPesoBalanca := 0;
        end
        else
        begin
           DataAuxiliar.DataSet.FieldByName('QUANT').AsFloat := TruncaValor(pPesoBalanca,3);
        end;
        DmWorkCom.PAFECF.FinalizaLeitura;
      end
      else
      begin
        MessageDlg('Erro ao inicializar a balança. Verifique a configuração!!!', mtError, [mbOK], 0);
        Abort;
      end;
    end
    else
    begin
      MessageDlg('Não há balança configurada no sistema. Verifique1', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

end;

procedure TFrmAbreRegistra2.LimpaDadosComanda(LimparComanda:Boolean=true);
begin
  EdtCodPro.Clear;
  EdtProduto.Clear;
  CdsAuxiliarID_PRODUTO.AsInteger := 0;
  CdsAuxiliarQUANT.AsInteger := 0;
  CdsAuxiliarPRECO.AsInteger := 0;
  //
  if LimparComanda then
  begin
    EdtComanda.Clear;
    EdtMesa.Clear;
    CdsAuxiliarID_MESA.AsInteger := 0;
    if sIDMesa = 0 then
    begin
      EdtComanda.SelectAll;
      EdtComanda.SetFocus;
    end;
    DmWorkCom.Dados_MesasItens(0);
  end
  else
  begin
    EdtCodPro.SelectAll;
    EdtCodPro.SetFocus;
  end;
end;

procedure TFrmAbreRegistra2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    if Confirmacao('Confirma a saida da tela de registro de itens?') then
    begin
      LimpaDadosComanda;
      Close;
    end;
  end;
end;

procedure TFrmAbreRegistra2.ExibeTotalMesa;
var aTotal : Double;
    aIDMesa : Integer;
begin
  if VerificaMesaAberta(aIDMesa,CdsAuxiliarID_MESA.AsInteger) then
  begin
    aTotal := RetornaTotalMesa(aIDMesa);
    LbValor.Caption := FormatFloat('0.00',aTotal);
    DmWorkCom.Dados_MesasItens(aIDMesa);
  end;
end;

procedure TFrmAbreRegistra2.BtnConfirmarClick(Sender: TObject);
var aTotal : Double;
    aIDMesa : Integer;
begin
  inherited;
  if (CdsAuxiliarID_PRODUTO.AsInteger <= 0) or (CdsAuxiliarID_MESA.AsInteger <= 0) or
     (CdsAuxiliarQUANT.AsFloat <= 0) or (CdsAuxiliarPRECO.AsFloat <= 0) or
     (EdtCodPro.Text = '') or (EdtComanda.Text = '') then
  begin
    MessageDlg('É necessários informar todos os dados!!!', mtWarning, [mbOK], 0);
    EdtComanda.SetFocus;
    Abort;
  end;
  if Confirmacao('Confirma este registro?') then
  begin
    aTotal := 0;
    aTotal := CdsAuxiliarQUANT.AsFloat * CdsAuxiliarPRECO.AsFloat;
    aTotal := aTotal + RetornaTotalMesa(sIDMesa);
    // verifica se mesa já foi aberta
    if not VerificaMesaAberta(aIDMesa,DataMesa.DataSet.FieldByName('ID').AsInteger) then
    begin
      DmWorkCom.CdsMesasAbertas.Append;
      DmWorkCom.CdsMesasAbertas.FieldByName('ID_MESA').AsInteger       := DataMesa.DataSet.FieldByName('ID').AsInteger;
      DmWorkCom.CdsMesasAbertas.FieldByName('NUMERO_MESA').AsString    := DataMesa.DataSet.FieldByName('NUMERO_MESA').AsString;
      if ChEntregar.Checked then
         DmWorkCom.CdsMesasAbertas.FieldByName('ENTREGAR').AsString    := 'S'
      else
         DmWorkCom.CdsMesasAbertas.FieldByName('ENTREGAR').AsString    := 'N';
      DmWorkCom.CdsMesasAbertas.FieldByName('LOCAL_ENTREGA').AsString  := EdtLocalEntrega.Text;
      DmWorkCom.CdsMesasAbertas.FieldByName('ID_VENDEDOR').AsInteger   := xIDAtendente;
      DmWorkCom.CdsMesasAbertas.FieldByName('ID_ENTREGADOR').AsInteger := xIDEntregador;
    end
    else
    begin
      if not DmWorkCom.CdsMesasAbertas.Locate('ID_MESA;STATUS',
                                           VarArrayOf([DataMesa.DataSet.FieldByName('ID').AsInteger,0]),[]) then
      begin
        MessageDlg('Não foi localizado o registro da comanda aberta!!!', mtWarning, [mbOK], 0);
        EdtComanda.SetFocus;
        Abort;
      end;
      DmWorkCom.CdsMesasAbertas.Edit;
    end;
    DmWorkCom.CdsMesasAbertas.FieldByName('VALOR').AsFloat := aTotal;
    Grava_Dados(DmWorkCom.CdsMesasAbertas);
    // registra o item
    DmWorkCom.CdsMesasItens.Append;
    DmWorkCom.CdsMesasItensID_PRODUTO.AsInteger := CdsAuxiliarID_PRODUTO.AsInteger;
    DmWorkCom.CdsMesasItensDESCRICAO.AsString   := EdtProduto.Text;
    DmWorkCom.CdsMesasItensQUANT.AsFloat        := CdsAuxiliarQUANT.AsFloat;
    DmWorkCom.CdsMesasItensPRECO_UNIT.AsFloat   := CdsAuxiliarPRECO.AsFloat;
    DmWorkCom.CdsMesasItensPRECO_TOTAL.AsFloat  := CdsAuxiliarQUANT.AsFloat * CdsAuxiliarPRECO.AsFloat;
    Grava_Dados(DmWorkCom.CdsMesasItens);
    //
    ExibeTotalMesa;
  end;
  LimpaDadosComanda(false);

end;

procedure TFrmAbreRegistra2.BitBtn1Click(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmListaMesas,FrmListaMesas);
    FrmListaMesas.ShowModal;
    if FrmListaMesas.sNumeroMesa <> '' then
    begin
      EdtComanda.Text := FrmListaMesas.sNumeroMesa;
      EdtComanda.SelectAll;
      EdtComanda.SetFocus;
    end;
  finally
    FreeAndNil(FrmListaMesas);
  end;
end;

procedure TFrmAbreRegistra2.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  LimpaDadosComanda;

end;

end.
