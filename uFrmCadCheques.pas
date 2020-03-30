unit uFrmCadCheques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ComCtrls, ActnList, DB, uFrameBotaoVertical,
  ExtCtrls, StdCtrls, DBCtrls, Mask, Buttons, System.Actions;

type
  TFrmCadCheques = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Frame: TFrameBotaoVertical;
    Label1: TLabel;
    DbID: TDBEdit;
    Label2: TLabel;
    DbIDCliente: TDBEdit;
    Label6: TLabel;
    DbNumConta: TDBEdit;
    Label7: TLabel;
    DbNumCheque: TDBEdit;
    Label8: TLabel;
    DbAgencia: TDBEdit;
    Label9: TLabel;
    DbEmitente: TDBEdit;
    Label10: TLabel;
    DbDocEmitente: TDBEdit;
    Label11: TLabel;
    DbValor: TDBEdit;
    Label12: TLabel;
    DbDataEmiss: TDBEdit;
    Label13: TLabel;
    DbBomPara: TDBEdit;
    Label15: TLabel;
    DbDataCad: TDBEdit;
    RadioStatus: TDBRadioGroup;
    DataCliente: TDataSource;
    Label3: TLabel;
    ComboBanco: TComboBox;
    DbCliente: TDBEdit;
    SpeedButton1: TSpeedButton;
    ActClientes: TAction;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure ActIncluirExecute(Sender: TObject);
    procedure ComboBancoExit(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure DbIDClienteExit(Sender: TObject);
    procedure ActClientesExecute(Sender: TObject);
    procedure ComboBancoEnter(Sender: TObject);
  private
    { Private declarations }
    sbanco : String;
    Procedure LeBancosArquivo;
    Procedure LocalizaBanco;
  public
    { Public declarations }
  end;

var
  FrmCadCheques: TFrmCadCheques;

implementation

Uses uLibrary,uDmWorkCom, uFrmCheques, uFrmClientes, uDMClientes;

{$R *.dfm}

procedure TFrmCadCheques.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet    := DmWorkCom.CdsCheques;
  DataCliente.DataSet := DmClientes.CdsContatoAux;
  DmWorkCom.Dados_Cheque(0);
  DmClientes.Dados_ContatoAux;
  LeBancosArquivo;
  PageControl1.TabIndex := 0;

end;

procedure TFrmCadCheques.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);

end;

procedure TFrmCadCheques.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmCadCheques.ActIncluirExecute(Sender: TObject);
begin
  inherited;
  DbIDCliente.SetFocus;

end;

procedure TFrmCadCheques.LeBancosArquivo;
var aArquivo : TextFile;
    aNomeArq, Linha : string;
    aTexto : String;
begin
  aNomeArq := ExtractFilePath(Application.ExeName)+'bancos.txt';
  if FileExists(aNomeArq) then
  begin
    AssignFile(aArquivo,aNomeArq);
    Reset(aArquivo);
    While not Eof(aArquivo) do
    begin
      ReadLn(aArquivo,Linha);
      aTexto := copy(Linha,1,3)+' - '+Trim(copy(Linha,4,length(Linha)-3));
      ComboBanco.Items.Add(aTexto);
    end;
    CloseFile(aArquivo);
  end
  else
  begin
    AssignFile(aArquivo,aNomeArq);
    Rewrite(aArquivo);
    Writeln(aArquivo,'001BANCO DO BRASIL S.A.                       ');
    Writeln(aArquivo,'073BB BANCO POPULAR DO BRASIL                 ');
    Writeln(aArquivo,'104CAIXA ECONOMICA FEDERAL                    ');
    Writeln(aArquivo,'237BANCO BRADESCO S.A.                        ');
    Writeln(aArquivo,'341BANCO ITAU S.A.                            ');
    Writeln(aArquivo,'389BANCO MERCANTIL DO BRASIL S.A.             ');
    Writeln(aArquivo,'399HSBC BANK BRASIL S.A.-BANCO MULTIPLO       ');
    Writeln(aArquivo,'409UNIBANCO - UNIAO DE BANCOS BRASILEIROS S.A.');
    Writeln(aArquivo,'453BANCO RURAL S.A.                           ');
    CloseFile(aArquivo);
    LeBancosArquivo;
  end;

end;

procedure TFrmCadCheques.ComboBancoExit(Sender: TObject);
begin
  inherited;
  if sbanco <> ComboBanco.Text then
  begin
    if (DataWork.DataSet.RecordCount > 0) and
       (not (DataWork.DataSet.State in [dsInsert,dsEdit])) then
    begin
      DataWork.DataSet.Edit;
    end;
  end;
  if (ComboBanco.Text <> '') and (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    DataWork.DataSet.FieldByName('COD_BANCO').AsString  := copy(ComboBanco.Text,1,3);
    DataWork.DataSet.FieldByName('NOME_BANCO').AsString := copy(ComboBanco.Text,7,length(ComboBanco.Text)-7);
  end;
end;

procedure TFrmCadCheques.ActPesquisarExecute(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmCheques,FrmCheques);
  try
    FrmCheques.sIdCheque := 0;
    FrmCheques.ShowModal;
    if FrmCheques.sIdCheque > 0 then
    begin
      if DmWorkCom.Dados_Cheque(FrmCheques.sIdCheque) then
         LocalizaBanco;
    end;
  finally
    FrmCheques.Destroy;
  end;
end;

procedure TFrmCadCheques.LocalizaBanco;
var i:Integer;
begin
  ComboBanco.ItemIndex := 0;
  for i:=0 to ComboBanco.Items.Count-1 do
  begin
    if Copy(ComboBanco.Items.Strings[i],1,3) = DataWork.DataSet.FieldByName('COD_BANCO').AsString then
    begin
      ComboBanco.ItemIndex := i;
      ComboBanco.Text := ComboBanco.Items.Strings[i];
      Break;
    end;  
  end;
end;

procedure TFrmCadCheques.DbIDClienteExit(Sender: TObject);
begin
  inherited;
  if (DbIDCliente.Text <> '') and
     (DataWork.DataSet.State in [dsInsert,dsEdit]) then
  begin
    if DmClientes.Dados_Contato(StrToInt(DbIDCliente.Text) ) then
       DataWork.DataSet.FieldByName('CLIENTE').AsString := DmClientes.CdsContatos.FieldByName('NOME').AsString;
  end;
  
end;

procedure TFrmCadCheques.ActClientesExecute(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmClientes,FrmClientes);
  try
    FrmClientes.sCodCli := 0;
    FrmClientes.ShowModal;
    if FrmClientes.sCodCli > 0 then
    begin
      DataWork.DataSet.FieldByName('ID_CLIENTE').AsInteger := FrmClientes.sCodCli;
      DbIDCliente.SetFocus;
    end;
  finally
    FrmClientes.Destroy;
  end;

end;

procedure TFrmCadCheques.ComboBancoEnter(Sender: TObject);
begin
  inherited;
  sbanco := ComboBanco.Text;
  
end;

end.
