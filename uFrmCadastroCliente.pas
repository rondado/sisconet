unit uFrmCadastroCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, Menus, DBCtrls, StdCtrls, ExtCtrls,
  Mask, ComCtrls, uFrameBotaoHorizontal, Buttons, wscep, System.Actions;

type
  TFrmCadastroCliente = class(TFrmCadPadrao)
    Pagina: TPageControl;
    TabSheet1: TTabSheet;
    PopupMenu1: TPopupMenu;
    DataUF: TDataSource;
    DataEndereco: TDataSource;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    ActContatosADC: TAction;
    ActConsultarCep: TAction;
    ConsultarEndereonaInternet1: TMenuItem;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label24: TLabel;
    ChAtivo: TDBCheckBox;
    RadioTipo: TDBRadioGroup;
    DbCadastro: TDBEdit;
    DbInsc: TDBEdit;
    DbCNPJ: TDBEdit;
    DbTelefone: TDBEdit;
    DbCidade: TDBEdit;
    DbBairro: TDBEdit;
    DnEnd: TDBEdit;
    DbCep: TDBEdit;
    DbContato: TDBEdit;
    DbID: TDBEdit;
    Label10: TLabel;
    Label30: TLabel;
    ComboUF: TDBLookupComboBox;
    Label28: TLabel;
    DbComplemento: TDBEdit;
    Label5: TLabel;
    DbNum: TDBEdit;
    Label11: TLabel;
    DbCelular: TDBEdit;
    TbTelefax: TDBEdit;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    DbCepEnt: TDBEdit;
    Label14: TLabel;
    DbEndEnt: TDBEdit;
    Label15: TLabel;
    DbNumEndEnt: TDBEdit;
    Label16: TLabel;
    DbBairroEndEnt: TDBEdit;
    Label17: TLabel;
    DbCidEndEnt: TDBEdit;
    Label31: TLabel;
    DbUFEndEnt: TDBEdit;
    DbComplEnt: TDBEdit;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label29: TLabel;
    DbObservacao: TDBMemo;
    DbSite: TDBEdit;
    DbEmail: TDBEdit;
    DbContatoGeral: TDBEdit;
    DbLimiteCred: TDBEdit;
    DbDataNasc: TDBEdit;
    DbNomeMae: TDBEdit;
    DbNomePai: TDBEdit;
    DbTelTrab: TDBEdit;
    DbEndTrab: TDBEdit;
    DbTrabalho: TDBEdit;
    Label34: TLabel;
    DbCodCidade: TDBEdit;
    SpbConsultaCep: TBitBtn;
    BtnContatosADC: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure DbCepExit(Sender: TObject);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure DbCepEntExit(Sender: TObject);
    procedure DbCNPJExit(Sender: TObject);
    procedure ActContatosADCExecute(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActConsultarCepExecute(Sender: TObject);
    procedure DbCodCidadeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDCliente : Integer;
    sCadNFe : Boolean;
    //
    xNOME,xENDERECO,xNUM_END,xBAIRRO_END,xCIDADE_END,xCEP_END,xTELEFONE,
    xCNPJ_CPF,xINSC_RG,xCOMPLEMENTO,xUF_END,xCODCIDADE : String;
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

Uses uDmWorkCom, uLibrary, uFrmClientes, uFrmSelEndereco,
  uFrmContatosADC, uFrmBuscaEnd, uFrmMunicipio, uDMClientes;

{$R *.dfm}

procedure TFrmCadastroCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
  DataUF.DataSet.Close;
  DataEndereco.DataSet.Close;

end;

procedure TFrmCadastroCliente.FormCreate(Sender: TObject);
begin
  inherited;
  sIDCLiente := 0;
  sCadNFe := false;
end;

procedure TFrmCadastroCliente.FormShow(Sender: TObject);
begin
  DataWork.DataSet := DmClientes.CdsContatos;
  inherited;
  DataEndereco.DataSet := DmClientes.CdsEndereco;
  DataUF.DataSet       := DmClientes.CdsUF;
  DmClientes.Dados_Contato(sIDCliente);
  DataUF.DataSet.Open;
  Pagina.TabIndex := 0;
  // verifica os dados
  if DataWork.DataSet.RecordCount > 0 then
     DataWork.DataSet.Edit
  else
     DataWork.DataSet.Append;
  //
  if sCadNFe then
  begin
    with DataWork.DataSet do
    begin
      FieldByName('NOME').AsString               := xNOME;
      FieldByName('ENDERECO').AsString           := xENDERECO;
      FieldByName('NUM_END').AsString            := xNUM_END;
      FieldByName('BAIRRO_END').AsString         := xBAIRRO_END;
      FieldByName('CIDADE_END').AsString         := xCIDADE_END;
      FieldByName('CEP_END').AsString            := xCEP_END;
      FieldByName('TELEFONE').AsString           := xTELEFONE;
      FieldByName('CNPJ_CPF').AsString           := xCNPJ_CPF;
      FieldByName('INSC_RG').AsString            := xINSC_RG;
      FieldByName('END_ENTREGA').AsString        := xENDERECO;
      FieldByName('NUM_END_ENTREGA').AsString    := xNUM_END;
      FieldByName('BAIRRO_END_ENTREGA').AsString := xBAIRRO_END;
      FieldByName('CID_END_ENTREGA').AsString    := xCIDADE_END;
      FieldByName('CEP_END_ENTREGA').AsString    := xCEP_END;
      FieldByName('COMPLEMENTO').AsString        := xCOMPLEMENTO;
      FieldByName('COMPL_ENT').AsString          := xCOMPLEMENTO;
      FieldByName('UF_END').AsString             := xUF_END;
      FieldByName('UF_END_ENT').AsString         := xUF_END;
      FieldByName('CODCIDADE').AsString          := xCODCIDADE;
    end;
  end;
  DbContato.SetFocus;

end;




procedure TFrmCadastroCliente.ActPesquisarExecute(Sender: TObject);
begin
  inherited;
  //
  FrmClientes.sCodCli := 0;
  FrmClientes.ShowModal;
  if FrmClientes.sCodCli > 0 then
  begin
    DmClientes.Dados_Contato(FrmClientes.sCodCli);
  end;
  Pagina.TabIndex := 0;
  DbContato.SetFocus;

end;

procedure TFrmCadastroCliente.DbCepExit(Sender: TObject);
begin
  inherited;
  if (DataWork.DataSet.FieldByName('CEP_END').AsString <> '') or
     not(DataWork.DataSet.FieldByName('CEP_END').IsNull) then
  begin
    if length(DataWork.DataSet.FieldByName('CEP_END').AsString) > 8 then
    begin
      MessageDlg('No CEP deve ser informado apenas numeros!!!', mtWarning, [mbOK], 0);
      Abort;
    end
    else
    begin
      if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
      begin
        if DmClientes.Dados_Endereco(DataWork.DataSet.FieldByName('CEP_END').AsString) then
        begin
          FrmSelEndereco.ShowModal;
          if FrmSelEndereco.sOK then
          begin
            DataWork.DataSet.FieldByName('ENDERECO').AsString   := DataEndereco.DataSet.FieldByname('ENDERECO').AsString;
            DataWork.DataSet.FieldByName('BAIRRO_END').AsString := DataEndereco.DataSet.FieldByname('BAIRRO').AsString;
            DataWork.DataSet.FieldByName('CIDADE_END').AsString := DataEndereco.DataSet.FieldByname('CIDADE').AsString;
            DataWork.DataSet.FieldByName('CEP_END').AsString    := DataEndereco.DataSet.FieldByname('CEP').AsString;
            DataWork.DataSet.FieldByName('UF_END').AsString     := DataEndereco.DataSet.FieldByname('UF').AsString;
          end;
        end;
      end;
    end;
  end;

end;

procedure TFrmCadastroCliente.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,key);

end;

procedure TFrmCadastroCliente.DbCepEntExit(Sender: TObject);
begin
  inherited;
  if (DataWork.DataSet.FieldByName('CEP_END_ENTREGA').AsString <> '') or
     not(DataWork.DataSet.FieldByName('CEP_END_ENTREGA').IsNull) then
  begin
    if length(DataWork.DataSet.FieldByName('CEP_END_ENTREGA').AsString) > 8 then
    begin
      MessageDlg('No CEP deve ser informado apenas numeros!!!', mtWarning, [mbOK], 0);
      Abort;
    end
    else
    begin
      if (DataWork.DataSet.State in [dsInsert,dsEdit]) then
      begin
        if DmClientes.Dados_Endereco(DataWork.DataSet.FieldByName('CEP_END_ENTREGA').AsString) then
        begin
          FrmSelEndereco.ShowModal;
          if FrmSelEndereco.sOK then
          begin
            DataWork.DataSet.FieldByName('END_ENTREGA').AsString        := DataEndereco.DataSet.FieldByname('ENDERECO').AsString;
            DataWork.DataSet.FieldByName('BAIRRO_END_ENTREGA').AsString := DataEndereco.DataSet.FieldByname('BAIRRO').AsString;
            DataWork.DataSet.FieldByName('CID_END_ENTREGA').AsString    := DataEndereco.DataSet.FieldByname('CIDADE').AsString;
            DataWork.DataSet.FieldByName('CEP_END_ENTREGA').AsString    := DataEndereco.DataSet.FieldByname('CEP').AsString;
            DataWork.DataSet.FieldByName('UF_END_ENT').AsString         := DataEndereco.DataSet.FieldByname('UF').AsString;
          end;
        end;
      end;
    end;
  end;

end;

procedure TFrmCadastroCliente.DbCNPJExit(Sender: TObject);
var aEntra:Boolean;
begin
  inherited;
  if DataWork.DataSet.State in [dsInsert,dsEdit] then
  begin
    if (DataWork.DataSet.FieldByName('CNPJ_CPF').AsString <> '') then
    begin
      aEntra := true;
      if Length(FiltraNumero(DataWork.DataSet.FieldByName('CNPJ_CPF').AsString)) = 11 then
      begin
        if not VerificaCpf(FiltraNumero(DataWork.DataSet.FieldByName('CNPJ_CPF').AsString)) then
           aEntra := false;
      end
      else if Length(FiltraNumero(DataWork.DataSet.FieldByName('CNPJ_CPF').AsString)) = 14 then
      begin
        if not VerificaCNPJ(FiltraNumero(DataWork.DataSet.FieldByName('CNPJ_CPF').AsString)) then
           aEntra := false;
      end
      else aEntra := false;
      //
      if not aEntra then
      begin
        MessageDlg('O Documento informado é inválido. Verifique!!!', mtWarning, [mbOK], 0);
        DbCNPJ.SetFocus;
      end;
    end;

  end;

end;

procedure TFrmCadastroCliente.ActContatosADCExecute(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.RecordCount = 0 then
  begin
    MessageDlg('É necessário inserir contato antes dos adcionais!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  FrmContatosADC.sIDContato := DataWork.DataSet.FieldByName('ID').AsInteger;
  frmContatosADC.ShowModal;

end;

procedure TFrmCadastroCliente.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadastroCliente.ActConfirmarExecute(Sender: TObject);
begin
  if (DataWork.DataSet.FieldByName('CNPJ_CPF').IsNull) or
     (DataWork.DataSet.FieldByName('CNPJ_CPF').AsString = '') then
  begin
    MessageDlg('É necessário validar o CNPJ ou CPF do cliente!', mtWarning, [mbOK], 0);
    DbCNPJ.SelectAll;
    DbCNPJ.SetFocus;
    Exit;
  end;
  if (DataWork.DataSet.FieldByName('CODCIDADE').IsNull) or
     (DataWork.DataSet.FieldByName('CODCIDADE').AsString = '') then
  begin
    MessageDlg('É necessário validar o codigo do município do cliente!', mtWarning, [mbOK], 0);
    DbCodCidade.SelectAll;
    DbCodCidade.SetFocus;
    Exit;
  end;
  inherited;
  sIDCliente := DataWork.DataSet.FieldByName('ID').AsInteger;
  // grava tabela de PDV como não sincronizado
  DmWorkCom.GravaPDVNaoSincronizado;
  Close;

end;

procedure TFrmCadastroCliente.ActConsultarCepExecute(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmBuscaEnd,FrmBuscaEnd);
  try
    FrmBuscaEnd.sEndereco := '';
    FrmBuscaEnd.ShowModal;
    // repassa valores pesquisados
    if FrmBuscaEnd.sEndereco <> '' then
    begin
      DataWork.DataSet.FieldByName('CEP_END').AsString    := UpperCase(FrmBuscaEnd.sCEP);
      DataWork.DataSet.FieldByName('ENDERECO').AsString   := UpperCase(FrmBuscaEnd.sEndereco);
      DataWork.DataSet.FieldByName('BAIRRO_END').AsString := UpperCase(FrmBuscaEnd.sBairro);
      DataWork.DataSet.FieldByName('CIDADE_END').AsString := UpperCase(FrmBuscaEnd.sCidade);
      DataWork.DataSet.FieldByName('UF_END').AsString     := UpperCase(FrmBuscaEnd.sUF);
    end;
  finally
    FrmBuscaEnd.Destroy;
  end;

end;

procedure TFrmCadastroCliente.DbCodCidadeExit(Sender: TObject);
begin
  inherited;
  if DataWork.DataSet.State in [dsInsert,dsEdit] then
  begin
    if (DataWork.DataSet.FieldByName('CODCIDADE').AsString <> '') then
    begin
      if not DmClientes.Dados_CodCidade(DataWork.DataSet.FieldByName('CODCIDADE').AsString,true) then
      begin
        MessageDlg('O código da cidade informado é inválido. Verifique!!!', mtWarning, [mbOK], 0);
        DbCodCidade.SetFocus;
      end;
    end
    else
    begin
      Application.CreateForm(TFrmMunicipio,FrmMunicipio);
      try
        FrmMunicipio.ShowModal;
        if FrmMunicipio.sCodCidade <> '' then
           DataWork.DataSet.FieldByName('CODCIDADE').AsString := FrmMunicipio.sCodCidade;
      finally
        FreeAndNil(FrmMunicipio);
        DbCodCidade.SetFocus;
      end;  
    end;
  end;

end;

end.
