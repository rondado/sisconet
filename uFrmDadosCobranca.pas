unit uFrmDadosCobranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TFrmDadosCobranca = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EdtNome: TEdit;
    EdtEndereco: TEdit;
    EdtCNPJCPF: TEdit;
    EdtDiaVenc: TEdit;
    BtnConfirmar: TBitBtn;
    BtnCancelar: TBitBtn;
    Label4: TLabel;
    Label8: TLabel;
    EdtNumDoc: TEdit;
    EdtValor: TCurrencyEdit;
    BitBtn1: TBitBtn;
    EdtParcelas: TCurrencyEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure EdtNomeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDCliente : Integer;
    sValorParc : Double;
  end;

var
  FrmDadosCobranca: TFrmDadosCobranca;

implementation

{$R *.dfm}

uses uFrmClientes, uLibrary, uDMClientes;

procedure TFrmDadosCobranca.BitBtn1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmClientes,FrmClientes);
    with FrmClientes do
    begin
      sApenasConsulta := true;
      ShowModal;
      if sCodCli > 0 then
      begin
        if DmClientes.Dados_Contato(sCodCli) then
        begin
          sIDCliente       := DmClientes.CdsContatosID.AsInteger;
          EdtNome.Text     := DmClientes.CdsContatosNOME.AsString;
          EdtEndereco.Text := Trim(DmClientes.CdsContatosENDERECO.AsString)+', '+
                              Trim(DmClientes.CdsContatosNUM_END.AsString)+' '+
                              Trim(DmClientes.CdsContatosCOMPL_ENT.AsString)+' - '+
                              Trim(DmClientes.CdsContatosBAIRRO_END.AsString);
          EdtCNPJCPF.Text    := DmClientes.CdsContatosCNPJ_CPF.AsString;
          EdtDiaVenc.Text    := '10';
          EdtParcelas.Value  := 1;
          sValorParc         := 0;
          EdtValor.Text      := FormatFloat('0.00',0);
        end;
      end;
    end;
  finally
    FreeAndNil(FrmClientes);
  end;
end;

procedure TFrmDadosCobranca.BtnCancelarClick(Sender: TObject);
begin
  sIDCliente := 0;
  Close;
end;

procedure TFrmDadosCobranca.BtnConfirmarClick(Sender: TObject);
begin
  if (EdtNome.Text = '') or (sIDCliente = 0) then
  begin
    MessageDlg('É necessário selecionar o cliente!',mtWarning,[mbok] ,0);
    Exit;
  end;
  if EdtValor.Value <= 0 then
  begin
    MessageDlg('É necessário informar o valor!',mtWarning,[mbok] ,0);
    Exit;
  end;
  if Trim(EdtNumDoc.Text) = '' then
  begin
    EdtNumDoc.Text := ZeroEsquerda(IntToStr(GenID('NUMERODOC')),10);
  end;
  sValorParc := EdtValor.Value;
  Close;
end;


procedure TFrmDadosCobranca.EdtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  TabEnter(Self,key);
end;

procedure TFrmDadosCobranca.FormCreate(Sender: TObject);
begin
  sIDCliente := 0;
end;

end.
