program SPED;

uses
  Forms,
  uFrmSPED in 'uFrmSPED.pas' {FrmSPED},
  uDmConexao in 'Dm\uDmConexao.pas' {DmConexao: TDataModule},
  uDmSPED in 'Dm\uDmSPED.pas' {DmSPED: TDataModule},
  uFrmSenha in 'uFrmSenha.pas' {FrmSenha},
  uRotinas_EFD in 'uRotinas_EFD.pas',
  uDmAcBr in 'Dm\uDmAcBr.pas' {DmAcBr: TDataModule},
  uRotinas_PisCofins in 'uRotinas_PisCofins.pas',
  uLibrary in 'Funcoes\uLibrary.pas',
  MD5 in 'Funcoes\MD5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gerador de SPED Fiscal';
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmSPED, DmSPED);
  Application.CreateForm(TDmAcBr, DmAcBr);
  Application.CreateForm(TFrmSPED, FrmSPED);
  Application.Run;
end.
