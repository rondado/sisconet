unit uFrmIdenticaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmPadrao, DB, StdCtrls, Mask, DBCtrls, uFrameConfirmaCancela,
  ExtCtrls, Buttons, ActnList, System.Actions;

type
  TFrmIdenticaCliente = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    DataUF: TDataSource;
    ComboUF: TDBLookupComboBox;
    BtnPesquisar: TBitBtn;
    ActionList1: TActionList;
    ActConfirmar: TAction;
    ActCancelar: TAction;
    ActLocalizar: TAction;
    Label8: TLabel;
    Label9: TLabel;
    EdtCliente: TMaskEdit;
    EdtEndereco: TMaskEdit;
    EdtCidade: TMaskEdit;
    EdtCep: TMaskEdit;
    EdtCPF: TMaskEdit;
    EdtIdentidade: TMaskEdit;
    EdtPlaca: TMaskEdit;
    EdtOdometro: TMaskEdit;
    EdtNumero: TMaskEdit;
    Label10: TLabel;
    EdtComplemento: TMaskEdit;
    Label11: TLabel;
    EdtBairro: TMaskEdit;
    Label12: TLabel;
    ActMenuFiscal: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure EdtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCPFExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure LimpaDadosCliente;
  private
    { Private declarations }
      public
    { Public declarations }
    sOK : Boolean;
    IDCLiente : Integer;
  end;

var
  FrmIdenticaCliente: TFrmIdenticaCliente;

implementation

Uses uDmWorkCom,uFuncoesPAFECF,uLibrary, uFrmClientes, uDMClientes,
  uFrmMenuFiscal;

{$R *.dfm}

procedure TFrmIdenticaCliente.FormShow(Sender: TObject);
begin
  inherited;
  DataUF.DataSet    := DmClientes.CdsUF;
  DataUF.DataSet.Open;
  LimpaDadosCliente;

end;

procedure TFrmIdenticaCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataUF.DataSet.Close;

end;

procedure TFrmIdenticaCliente.ActConfirmarExecute(Sender: TObject);
begin
  inherited;
  if IDCLiente = 0 then
  begin
    MessageDlg('É necessário selecionar o cliente padrão!', mtWarning, [mbOK], 0);
    ActLocalizarExecute(Sender);
    EdtCliente.SelectAll;
    EdtCliente.SetFocus;
    Exit;
  end;

  //fabricio novo inicio
    if (EdtCPF.Text = '11111111111') then
    begin
      EdtCPF.Text := '';
      EdtCliente.Text := '';
    end;
//fabricio novo fim

  if sPAFNFCe = 0 then
  begin
    // atualiza os dados do cliente conforme informado
    if (EdtCPF.Text = '') and (EdtCliente.Text = '') then
    begin
      DmWorkCom.PreencheClientPadraoRegistro;
    end
    else
    begin
      with ClienteCupom do
      begin
        ID          := IDCliente;
        Cliente     := EdtCliente.Text;
        Endereco    := EdtEndereco.Text;
        Numero      := EdtNumero.Text;
        Complemento := EdtComplemento.Text;
        Bairro      := EdtBairro.Text;
        Cidade      := EdtCidade.Text;
        Cep         := EdtCep.Text;
        UF          := ComboUF.Text;
        CPF         := EdtCPF.Text;
        Identidade  := EdtIdentidade.Text;
        Placa       := EdtPlaca.Text;
        Odometro    := EdtOdometro.Text;
      end;
    end;
  end
  else
  begin
    if EdtCPF.Text <> '' then
    begin
      if not VerificaCpf(FiltraNumero(EdtCPF.Text)) then
      begin
        MessageDlg('O CPF informado é inválido!', mtWarning, [mbOK], 0);
        EdtCliente.SelectAll;
        EdtCliente.SetFocus;
        Exit;
      end;
    end;
    // atualiza os dados do cliente conforme informado
    with ClienteCupom do
    begin
      ID          := IDCliente;
      Cliente     := EdtCliente.Text;
      Endereco    := EdtEndereco.Text;
      Numero      := EdtNumero.Text;
      Complemento := EdtComplemento.Text;
      Bairro      := EdtBairro.Text;
      Cidade      := EdtCidade.Text;
      Cep         := EdtCep.Text;
      CPF         := EdtCPF.Text;
      UF          := ComboUF.Text;
      Identidade  := EdtIdentidade.Text;
      Placa       := EdtPlaca.Text;
      Odometro    := EdtOdometro.Text;
    end;
  end;
  sOK := true;
  Close;

end;

procedure TFrmIdenticaCliente.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  sOK := false;
  LimpaDadosCliente;
  Close;

end;

procedure TFrmIdenticaCliente.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmclientes,FrmClientes);
    FrmClientes.sCodCli := 0;
    FrmClientes.sApenasConsulta := true;
    FrmClientes.ShowModal;
    if FrmClientes.sCodCli > 0 then
    begin
      DmClientes.Dados_Contato(FrmClientes.sCodCli);
      IDCliente          := FrmClientes.sCodCli;
      EdtCliente.Text     := DmClientes.CdsContatos.FieldByname('NOME').AsString;
      EdtEndereco.Text    := DmClientes.CdsContatos.FieldByname('ENDERECO').AsString;
      EdtNumero.Text      := DmClientes.CdsContatos.FieldByname('NUM_END').AsString;
      EdtComplemento.Text := DmClientes.CdsContatos.FieldByname('COMPLEMENTO').AsString;
      EdtBairro.Text      := DmClientes.CdsContatos.FieldByname('BAIRRO_END').AsString;
      EdtCidade.Text      := DmClientes.CdsContatos.FieldByname('CIDADE_END').AsString;
      ComboUF.KeyValue    := DmClientes.CdsContatos.FieldByname('UF_END').AsString;
      EdtCep.Text         := DmClientes.CdsContatos.FieldByname('CEP_END').AsString;
      EdtCPF.Text         := DmClientes.CdsContatos.FieldByname('CNPJ_CPF').AsString;
      EdtIdentidade.Text  := DmClientes.CdsContatos.FieldByname('INSC_RG').AsString;
    end;
  finally
    FrmClientes.Free;
  end;

end;

procedure TFrmIdenticaCliente.LimpaDadosCliente;
begin
  // repassa os dados para o registro
  DmWorkCom.PreencheClientPadraoRegistro;
  //
  IDCliente := DmWorkCom.CdsConfigCLIENTE_PADRAO.AsInteger;
  EdtCliente.Text     := ClienteCupom.Cliente;
  EdtEndereco.Text    := ClienteCupom.Endereco;
  EdtCidade.Text      := ClienteCupom.Cidade;
  EdtCep.Text         := ClienteCupom.Cep;
  EdtCPF.Text         := ClienteCupom.CPF;
  EdtIdentidade.Text  := ClienteCupom.Identidade;
  EdtPlaca.Text       := ClienteCupom.Placa;
  EdtOdometro.Text    := ClienteCupom.Odometro;
  EdtNumero.Text      := ClienteCupom.Numero;
  EdtComplemento.Text := ClienteCupom.Complemento;
  EdtBairro.Text      := ClienteCupom.Bairro;
  if ClienteCupom.CPF = '11111111111' then
  begin
    EdtCliente.Text     := '';
    EdtCPF.Text         := '';
  end;
  EdtCliente.SetFocus;

{
  EdtCliente.Clear;
  EdtEndereco.Clear;
  EdtCidade.Clear;
  EdtCep.Clear;
  EdtCPF.Clear;
  EdtIdentidade.Clear;
  EdtPlaca.Clear;
  EdtOdometro.Clear;
  EdtNumero.Clear;
  EdtComplemento.Clear;
  EdtBairro.Clear;
}

end;

procedure TFrmIdenticaCliente.EdtClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(self,key);

end;

procedure TFrmIdenticaCliente.EdtCPFExit(Sender: TObject);
var aEntra:Boolean;
begin
  inherited;
  if EdtCPF.Text <> '' then
  begin
    aEntra := true;
    if Length(FiltraNumero(EdtCPF.Text)) = 11 then // Caso seja CPF
    begin
      if not VerificaCpf(FiltraNumero(EdtCPF.Text)) then
         aEntra := false;
    end
    else if Length(FiltraNumero(EdtCPF.Text)) = 14 then // Caso seja CNPJ
    begin
      if not VerificaCNPJ(FiltraNumero(EdtCPF.Text)) then
         aEntra := false;
    end
    else aEntra := false;
  end
  else
  begin
    if sPAFNFCe = 1 then
       aEntra := true;
  end;
  //
  if not aEntra then
  begin
    MessageDlg('O Documento informado é inválido. Verifique!!!', mtWarning, [mbOK], 0);
    EdtCPF.SelectAll;
    EdtCPF.SetFocus;
  end;

end;

procedure TFrmIdenticaCliente.FormCreate(Sender: TObject);
begin
  inherited;
  sOK := false;
  EdtCliente.Text:= '';
  EdtEndereco.Text:='';
  EdtNumero.Text:='';
  EdtComplemento.Text:='';
  EdtCidade.Text:='';
  EdtBairro.Text:='';
//  ComboUF.Text:= '';
  EdtCep.Text:= '';
  EdtCpf.Text:= '';
  EdtIdentidade.Text:='';
  EdtPlaca.Text:= '';
  EdtOdometro.Text:= '';

end;

procedure TFrmIdenticaCliente.ActMenuFiscalExecute(Sender: TObject);
var aMensagem : String;
begin
  inherited;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
  begin
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  end
  else
  begin
    if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
    begin
      ShowMessage(aMensagem);
      DmWorkCom.PAFECF.sControleECFAtivo := 2;
    end;
  end;  
   Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
   Try
      FrmMenuFiscal.ShowModal;
   Finally
      FrmMenuFiscal.Destroy;
   End;

end;

end.
