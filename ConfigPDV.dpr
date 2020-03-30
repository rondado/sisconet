program ConfigPDV;

uses
  MidasLib,
  Forms,
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  uFrmGravaArqVerificacao in 'uFrmGravaArqVerificacao.pas' {FrmGravaArqVerificacao},
  uFuncoesPAFECF in 'Funcoes\uFuncoesPAFECF.pas',
  uLibrary in 'Funcoes\uLibrary.pas',
  libeay32 in 'Funcoes\libeay32.pas',
  MD5 in 'Funcoes\MD5.pas',
  uDmAcBr in 'DM\uDmAcBr.pas' {DmAcBr: TDataModule},
  uDmWorkCom in 'DM\uDmWorkCom.pas' {DmWorkCom: TDataModule},
  uDmConexao in 'DM\uDmConexao.pas' {DmConexao: TDataModule},
  uDMClientes in 'DM\uDMClientes.pas' {DmClientes: TDataModule},
  CharPrinter in 'Funcoes\CharPrinter.pas',
  uMensagem in 'Funcoes\uMensagem.pas',
  uDmAuxiliar in 'DM\uDmAuxiliar.pas' {DmAuxiliar: TDataModule},
  uDmPosto in 'DM\uDmPosto.pas' {DmPosto: TDataModule},
  uFuncoesPosto in 'Funcoes\uFuncoesPosto.pas',
  uDmProdutos in 'DM\uDmProdutos.pas' {DmProdutos: TDataModule};

{$R *.res}

begin
  Hwnd := FindWindow('TApplication','Grava arquivo de Configuração do ECF');
  if Hwnd = 0 then
  begin
    Application.Initialize;
    Application.Title := 'Grava arquivo de Configuração do ECF';
    Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmAuxiliar, DmAuxiliar);
  Application.CreateForm(TDmWorkCom, DmWorkCom);
  Application.CreateForm(TDmClientes, DmClientes);
  Application.CreateForm(TDmProdutos, DmProdutos);
  Application.CreateForm(TDmPosto, DmPosto);
  Application.CreateForm(TDmAcBr, DmAcBr);
  Application.CreateForm(TFrmGravaArqVerificacao, FrmGravaArqVerificacao);
  Application.Run;
  end
  else
  begin
    MessageDlg('O Aplicativo já esta em uso!!!', mtWarning, [mbOK], 0);
    Application.Terminate;
  end;

end.
