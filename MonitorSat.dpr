program MonitorSat;

uses
  Forms,
  uFrmMonitorSat in 'uFrmMonitorSat.pas' {FrmMonitorSAT},
  uLibrary in 'Funcoes\uLibrary.pas',
  MD5 in 'Funcoes\MD5.pas',
  uDmAcBr in 'DM\uDmAcBr.pas' {DmAcBr: TDataModule},
  uDMClientes in 'DM\uDMClientes.pas' {DmClientes: TDataModule},
  uDmConexao in 'DM\uDmConexao.pas' {DmConexao: TDataModule},
  uDmWorkCom in 'DM\uDmWorkCom.pas' {DmWorkCom: TDataModule},
  uFuncoesPAFECF in 'Funcoes\uFuncoesPAFECF.pas',
  uMensagem in 'Funcoes\uMensagem.pas',
  CharPrinter in 'Funcoes\CharPrinter.pas',
  uDmPosto in 'DM\uDmPosto.pas' {DmPosto: TDataModule},
  uFuncoesPosto in 'Funcoes\uFuncoesPosto.pas',
  uDmAuxiliar in 'DM\uDmAuxiliar.pas' {DmAuxiliar: TDataModule},
  uDmProdutos in 'DM\uDmProdutos.pas' {DmProdutos: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmWorkCom, DmWorkCom);
  Application.CreateForm(TDmAuxiliar, DmAuxiliar);
  Application.CreateForm(TDmPosto, DmPosto);
  Application.CreateForm(TDmClientes, DmClientes);
  Application.CreateForm(TDmProdutos, DmProdutos);
  Application.CreateForm(TDmAcBr, DmAcBr);
  Application.CreateForm(TFrmMonitorSAT, FrmMonitorSAT);
  Application.Run;
end.
