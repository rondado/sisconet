unit uFrmBuscaEnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, StdCtrls, Buttons, InvokeRegistry,
  ActnList, Rio, SOAPHTTPClient, DB, DBClient, Grids, DBGrids, DBCtrls,
  System.Actions;

type
  TFrmBuscaEnd = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    RadioOpcao: TRadioGroup;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    HTTPRIO1: THTTPRIO;
    ActionList1: TActionList;
    ActBuscaCep: TAction;
    ActEncerrar: TAction;
    BitBtn2: TBitBtn;
    DBGrid1: TDBGrid;
    CdsEndereco: TClientDataSet;
    CdsEnderecoCEP: TStringField;
    CdsEnderecoENDERECO: TStringField;
    CdsEnderecoCIDADE: TStringField;
    CdsEnderecoBAIRRO: TStringField;
    CdsEnderecoUF: TStringField;
    DataEndereco: TDataSource;
    GroupBox3: TGroupBox;
    EdLocalizar: TEdit;
    Label2: TLabel;
    EdtUF: TEdit;
    LbLocalizar: TLabel;
    GroupBox4: TGroupBox;
    EdNumRegistro: TEdit;
    Memo1: TMemo;
    procedure ActBuscaCepExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure EdLocalizarKeyPress(Sender: TObject; var Key: Char);
    procedure EdLocalizarExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioOpcaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sUsuario, sSenha, sCEP, sEndereco,sBairro, sCidade, sUF:Widestring;
  end;

var
  FrmBuscaEnd: TFrmBuscaEnd;

implementation

Uses uLibrary,ICEP1,wscep,uDmWorkCom;

{$R *.dfm}

procedure TFrmBuscaEnd.ActBuscaCepExecute(Sender: TObject);
var i,l,aIndice:Integer;
    aLinha,aux : String;
begin
  inherited;
//  Memo1.Lines.Clear;
  CdsEndereco.EmptyDataSet;
  if (RadioOpcao.ItemIndex = 1) and (EdtUF.Text = '') then
  begin
    MessageDlg('É necessário informar a UF!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  // busca dados
  case RadioOpcao.ItemIndex of
    0 : begin
          sCEP := EdLocalizar.Text;
          GetcepwsdlPortType.ConsultarCEP(sUsuario,sSenha,sCEP,sEndereco,sBairro,sCidade,sUF);
        end;
    1 : begin
          Memo1.Lines.Text := (HTTPRIO1 as ICEP).LogradourosPorNome(EdLocalizar.Text,EdtUF.Text,EdNumRegistro.Text);
        end;
  end;
  if RadioOpcao.ItemIndex = 0 then
  begin
    if sEndereco <> '' then
    begin
      CdsEndereco.Append;
      CdsEnderecoCEP.AsString      := sCEP;
      CdsEnderecoENDERECO.AsString := sEndereco;
      CdsEnderecoBAIRRO.AsString   := sBairro;
      CdsEnderecoCIDADE.AsString   := sCidade;
      CdsEnderecoUF.AsString       := sUF;
      CdsEndereco.Post;
    end;
  end
  else if RadioOpcao.ItemIndex = 1 then
  begin
    if Memo1.Lines.Count > 0 then
    begin
      aux := '';
      aIndice := 0;
      // grava endereços encontrados
      for i:=0 to Memo1.Lines.Count-1 do
      begin
        aLinha := Memo1.Lines.Strings[i];
        for l:=1 to Length(aLinha) do
        begin
          if aIndice = 0 then
          begin
            CdsEndereco.Append;
            aIndice := 1;
          end;
          //
          if Copy(aLinha,l,1) = '-' then
          begin
            case aIndice of
              1: CdsEnderecoCEP.AsString      := Trim(aux);
              2: CdsEnderecoENDERECO.AsString := copy(aux,2,length(aux)-2);
              3: CdsEnderecoBAIRRO.AsString   := copy(aux,2,length(aux)-2);
              4: CdsEnderecoCIDADE.AsString   := copy(aux,2,length(aux)-2);
              5: CdsEnderecoUF.AsString       := Trim(aux);
            end;
            aux := '';
            Inc(aIndice);
          end
          else aux := aux + Copy(aLinha,l,1);
          if aIndice = 6 then
          begin
            aIndice := 0;
            CdsEndereco.Post;
          end;
        end;
        if (aux <> '') and (aIndice = 5) and (CdsEndereco.State in [dsInsert]) then
        begin
          CdsEnderecoUF.AsString := Trim(aux);
          CdsEndereco.Post;
        end;
      end;
    end
    else
    begin
      MessageDlg('Não foram encontrado dados com as informações passadas!!!', mtWarning, [mbOK], 0);
    end;
  end;
  DBGrid1.SetFocus;
end;

procedure TFrmBuscaEnd.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmBuscaEnd.EdLocalizarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmBuscaEnd.EdLocalizarExit(Sender: TObject);
begin
  inherited;
  if (EdLocalizar.Text <> '') and(RadioOpcao.ItemIndex = 0)  then
  begin
    ActBuscaCepExecute(Sender);
  end;
end;

procedure TFrmBuscaEnd.FormCreate(Sender: TObject);
begin
  inherited;
  if not CdsEndereco.Active then
     CdsEndereco.CreateDataSet;
  CdsEndereco.EmptyDataSet;

end;

procedure TFrmBuscaEnd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CdsEndereco.Close;
  CdsEndereco.Free;

end;

procedure TFrmBuscaEnd.RadioOpcaoClick(Sender: TObject);
begin
  inherited;
  if RadioOpcao.ItemIndex = 0 then
     LbLocalizar.Caption := 'CEP'
  else if RadioOpcao.ItemIndex = 1 then
     LbLocalizar.Caption := 'Logradouro';

end;

procedure TFrmBuscaEnd.FormShow(Sender: TObject);
begin
  inherited;
  EdLocalizar.SetFocus;

end;

procedure TFrmBuscaEnd.DBGrid1Enter(Sender: TObject);
begin
  inherited;
  DBGrid1.Tag := 1;
end;

procedure TFrmBuscaEnd.DBGrid1Exit(Sender: TObject);
begin
  inherited;
  DBGrid1.Tag := 1;

end;

procedure TFrmBuscaEnd.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
  begin
    DBGrid1DblClick(Sender);
  end;
end;

procedure TFrmBuscaEnd.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  sEndereco := CdsEnderecoENDERECO.AsString;
  sBairro   := CdsEnderecoBAIRRO.AsString;
  sCidade   := CdsEnderecoCIDADE.AsString;
  sUF       := CdsEnderecoUF.AsString;
  sCEP      := CdsEnderecoCEP.AsString;
  // fecha formulário
  close;
end;

end.


{
  if EdtUF.Text = '' then
  begin
    MessageDlg('É necessário informar a UF!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if Memo1.Lines.Count > 0 then
  begin
    sUF := EdtUF.Text;
    sCEP := EdLocalizar.Text;
    GetcepwsdlPortType.ConsultarCEP(sUsuario,sSenha,sCEP,sEndereco,sBairro,sCidade,sUF);
    Close;
  end;
}