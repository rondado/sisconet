unit uDmConexao;

interface

uses
  Windows, SysUtils, Classes, DB, SqlExpr, Messages, Variants,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Mask, DBCtrls,
  ExtCtrls, ComCtrls, IniFiles, Data.DBXFirebird; // uFrmPadrao,


type
  TDmConexao = class(TDataModule)
    ConexaoDBX: TSQLConnection;
    ConexaoSISCOM: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ArqIni : TIniFile;
    sPath, sPathV15, sUser, sPass : String;
    procedure CriaArqIni;
    procedure LeArqIni;
    { Private declarations }
  public
    { Public declarations }
    function ConectaBancoSISCOM:Boolean;
  end;

var
  DmConexao: TDmConexao;

implementation

Uses uLibrary;

{$R *.dfm}

procedure TDmConexao.DataModuleCreate(Sender: TObject);
var aux : String;
begin
  //
  try
    // verifica arquivo de configuração de acesso aos dados
    aux := ExtractFilePath(Application.ExeName)+'config.ini';
    if not FileExists(aux) then
       CriaArqIni;
    LeArqIni;
    // realiza conexao com o banco de dados
    ConexaoDBX.Connected := false;
    ConexaoDBX.Params.Values['Database']  := sPath;
    ConexaoDBX.Params.Values['User_Name'] := sUser;
    ConexaoDBX.Params.Values['Password']  := sPass;
    ConexaoDBX.Connected := true;
    // atribui variavel de controle
    ConexaoDados := ConexaoDBX;
  except
    on Exc: Exception do
    begin
      MessageDlg('Erro: '+Exc.Message, mtWarning, [mbOK], 0);
      Application.Terminate;
    end;
  end;

end;

function TDmConexao.ConectaBancoSISCOM:Boolean;
begin
  try
    Result := false;
    // realiza conexao com o banco de dados SISCOM
    ConexaoSISCOM.Connected := false;
    ConexaoSISCOM.Params.Values['Database']  := sPathV15;
    ConexaoSISCOM.Params.Values['User_Name'] := sUser;
    ConexaoSISCOM.Params.Values['Password']  := sPass;
    ConexaoSISCOM.Connected := true;
    Result := ConexaoSISCOM.Connected;
  Except
    on E:Exception do
    begin
      Result := false;
      ShowMessage(E.Message);
    end;
  end;

end;

procedure TDmConexao.CriaArqIni;
var AuxChave : String;
begin
  AuxChave := Criptografa('198208',23);
  ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  ArqINI.WriteString('DADOS','PATH',ExtractFilePath(Application.ExeName)+'Dados\DADOS.GDB');
  ArqINI.WriteString('DADOS','PATHV15',ExtractFilePath(Application.ExeName)+'Dados\BASE.GDB');
  ArqINI.WriteString('DADOS','USUARIO','SYSDBA');
  ArqINI.WriteString('DADOS','SENHA','masterkey');
  ArqINI.WriteString('DADOS','DRVCVE',AuxChave);
  ArqINI.WriteInteger('DADOS','DRVBAT',0);
  ArqIni.Free;
end;

procedure TDmConexao.LeArqIni;
var AuxChave : String;
begin
  ArqIni      := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  sPath       := ArqINI.ReadString('DADOS','PATH',ExtractFilePath(Application.ExeName)+'Dados\DADOS.GDB');
  sPathV15    := ArqINI.ReadString('DADOS','PATHV15',ExtractFilePath(Application.ExeName)+'Dados\BASE.GDB');
  sUser       := ArqINI.ReadString('DADOS','USUARIO','SYSDBA');
  sPass       := ArqINI.ReadString('DADOS','SENHA','masterkey');
  AuxChave    := ArqINI.ReadString('DADOS','DRVCVE','');
  sBloqueio   := ArqINI.ReadInteger('DADOS','DRVBAT',0);
  ArqIni.Free;
  //
  sIDBloqueio := StrToInt(Criptografa(AuxChave,23));
end;


procedure TDmConexao.DataModuleDestroy(Sender: TObject);
begin
  ConexaoDBX.Connected := false;

end;

end.
