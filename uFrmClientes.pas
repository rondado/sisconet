unit uFrmClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmConsPadrao, Data.FMTBcd,
  System.Actions, Vcl.ActnList, Vcl.ImgList, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, frxClass, frxDBSet, System.ImageList;

type
  TFrmClientes = class(TFrmConsPadrao)
    QryConsultaID: TIntegerField;
    QryConsultaNOME: TStringField;
    QryConsultaCNPJ_CPF: TStringField;
    QryConsultaCIDADE_END: TStringField;
    QryConsultaUF_END: TStringField;
    QryConsultaTELEFONE: TStringField;
    QryConsultaATIVO: TStringField;
    QryConsultaTIPO_CONTATO: TStringField;
    CdsConsultaID: TIntegerField;
    CdsConsultaNOME: TStringField;
    CdsConsultaCNPJ_CPF: TStringField;
    CdsConsultaCIDADE_END: TStringField;
    CdsConsultaUF_END: TStringField;
    CdsConsultaTELEFONE: TStringField;
    CdsConsultaATIVO: TStringField;
    CdsConsultaTIPO_CONTATO: TStringField;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    procedure ActLocalizarExecute(Sender: TObject);
    procedure GridDadosDblClick(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActAlterarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure GridDadosKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure CbxTipoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtLocalizarExit(Sender: TObject);
    procedure ActImprimirExecute(Sender: TObject);
    procedure EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sCodCli : Integer;
    sApenasConsulta : Boolean;
  end;

var
  FrmClientes: TFrmClientes;

implementation

{$R *.dfm}

uses uFrmCadastroCliente, uDMClientes, uLibrary, uFrmSelEndereco,
  uFrmContatosADC;

procedure TFrmClientes.ActAlterarExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmCadastroCliente,FrmCadastroCliente);
    Application.CreateForm(TFrmSelEndereco,FrmSelEndereco);
    Application.CreateForm(TFrmContatosADC,FrmContatosADC);
    FrmCadastroCliente.sIDCliente := DataConsulta.DataSet.FieldByName('ID').AsInteger;
    FrmCadastroCliente.ShowModal;
    ActLocalizarExecute(Sender);
  finally
    FreeAndNil(FrmContatosADC);
    FreeAndNil(FrmSelEndereco);
    FreeAndNil(FrmCadastroCliente);
  end;

end;

procedure TFrmClientes.ActExcluirExecute(Sender: TObject);
begin
  inherited;
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    if DmClientes.Dados_Contato(DataConsulta.DataSet.FieldByName('ID').AsInteger) then
    begin
      if Confirmacao('Confirma a exclusão do produto selecionado?') then
      begin
        DmClientes.CdsContatos.Delete;
        Grava_Dados(DmClientes.CdsContatos);
        ActLocalizarExecute(Sender);
      end;
    end;
  end;

end;

procedure TFrmClientes.ActImprimirExecute(Sender: TObject);
begin
  inherited;
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\RelClientes.fr3');
  frxReport1.ShowReport;
end;

procedure TFrmClientes.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  // efetua pesquisa de cliente
  CdsConsulta.Close;
  CdsConsulta.Params.Clear;
  // monta SQL de consulta
  QryConsulta.SQL.Clear;
  QryConsulta.SQL.Add('select contato.id,contato.nome,contato.cnpj_cpf,');
  QryConsulta.SQL.Add('contato.cidade_end,contato.uf_end,contato.telefone,');
  QryConsulta.SQL.Add('contato.ativo, contato.tipo_contato from contato');
  // opcao
  if CbxTipoPesq.ItemIndex = 0 then // Codigo
     QryConsulta.SQL.Add('where contato.id = :pOpcao')
  else if CbxTipoPesq.ItemIndex = 1 then // nome
//fabricio... tirei e coloquei a linha abaixo (upper)     QryConsulta.SQL.Add('where contato.nome like :pOpcao')
     QryConsulta.SQL.Add('where upper(contato.nome) like upper(:pOpcao)')
  else if CbxTipoPesq.ItemIndex = 2 then // cnpg/cpf
     QryConsulta.SQL.Add('where contato.cnpj_cpf = :pOpcao');
  // passa parametros
  CdsConsulta.FetchParams;
  if CbxTipoPesq.ItemIndex = 0 then // codigo
     CdsConsulta.Params.ParamByName('pOpcao').AsInteger := StrToInt(EdtLocalizar.Text)
  else if CbxTipoPesq.ItemIndex = 1 then // nome
     CdsConsulta.Params.ParamByName('pOpcao').AsString  :='%'+UpperCase( EdtLocalizar.Text)+'%'
  else if CbxTipoPesq.ItemIndex = 2 then // cnpj/cpf
     CdsConsulta.Params.ParamByName('pOpcao').AsString  := EdtLocalizar.Text;
  // exibe resultado
  CdsConsulta.Open;
  GridDados.SetFocus;

end;

procedure TFrmClientes.ActNovoExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmCadastroCliente,FrmCadastroCliente);
    Application.CreateForm(TFrmSelEndereco,FrmSelEndereco);
    Application.CreateForm(TFrmContatosADC,FrmContatosADC);
    FrmCadastroCliente.sIDCliente := 0;
    FrmCadastroCliente.ShowModal;
    ActLocalizarExecute(Sender);
  finally
    FreeAndNil(FrmContatosADC);
    FreeAndNil(FrmSelEndereco);
    FreeAndNil(FrmCadastroCliente);
  end;

end;

procedure TFrmClientes.CbxTipoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

procedure TFrmClientes.EdtLocalizarExit(Sender: TObject);
begin
  inherited;
  ActLocalizarExecute(Sender);
end;

procedure TFrmClientes.EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//fabricio
  TabEnter(Self,Key);
end;

procedure TFrmClientes.FormCreate(Sender: TObject);
begin
  inherited;
  sApenasConsulta := false;
end;

procedure TFrmClientes.GridDadosDblClick(Sender: TObject);
begin
  inherited;
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    if not sApenasConsulta then
    begin
       ActAlterarExecute(Sender);
    end
    else
    begin
      sCodCli := CdsConsulta.FieldByName('ID').AsInteger;
      Close;
    end;
  end;

end;

procedure TFrmClientes.GridDadosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = #13) then
  begin
    if DataConsulta.DataSet.RecordCount > 0 then
    begin
      if not sApenasConsulta then
      begin
        ActAlterarExecute(Sender);
      end
      else
      begin
        sCodCli := CdsConsulta.FieldByName('ID').AsInteger;
        Close;
      end;
    end;
  end;

end;

end.
