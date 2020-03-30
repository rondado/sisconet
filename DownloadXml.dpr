program DownloadXml;

uses
  Forms,
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  MidasLib,
  uXML in 'uXML.pas' {frmxml},
  uDmAcBr in 'DM\uDmAcBr.pas' {DmAcBr: TDataModule},
  uDmWorkCom in 'DM\uDmWorkCom.pas' {DmWorkCom: TDataModule},
  uFrmSplash in 'uFrmSplash.pas' {FrmSplash},
  uLibrary in 'Funcoes\uLibrary.pas',
  uFuncoesPAFECF in 'Funcoes\uFuncoesPAFECF.pas',
  uMensagem in 'Funcoes\uMensagem.pas',
  uFrmFecharCupom in 'uFrmFecharCupom.pas',
  CharPrinter in 'Funcoes\CharPrinter.pas',
  uDmPosto in 'DM\uDmPosto.pas' {DmPosto: TDataModule},
  uDmConexao in 'DM\uDmConexao.pas' {DmConexao: TDataModule},
  uDMClientes in 'DM\uDMClientes.pas' {DmClientes: TDataModule},
  uDmAuxiliar in 'DM\uDmAuxiliar.pas' {DmAuxiliar: TDataModule},
  uDmProdutos in 'DM\uDmProdutos.pas' {DmProdutos: TDataModule},
  uFuncoesPosto in 'Funcoes\uFuncoesPosto.pas',
  ICEP1 in 'Funcoes\ICEP1.pas',
  MD5 in 'Funcoes\MD5.pas',
  uDmSPED in 'DM\uDmSPED.pas' {DmSPED: TDataModule},
  uFrmCadPadrao in 'uFrmCadPadrao.pas' {FrmCadPadrao},
  uFrmConfiguracoes in 'uFrmConfiguracoes.pas',
  uFrameBotaoVertical in 'uFrameBotaoVertical.pas' {FrameBotaoVertical: TFrame},
  uFrameBotaoHorizontal in 'uFrameBotaoHorizontal.pas' {FrameBotaoHorizontal: TFrame},
  uFrmCadastroCliente in 'uFrmCadastroCliente.pas' {FrmCadastroCliente},
  uFrmConsPadrao in 'uFrmConsPadrao.pas' {FrmConsPadrao},
  uFrmClientes in 'uFrmClientes.pas',
  uFrmPadrao in 'uFrmPadrao.pas' {FrmPadrao},
  uFrmSelEndereco in 'uFrmSelEndereco.pas',
  uFrmContatosADC in 'uFrmContatosADC.pas' {FrmContatosADC},
  uFrmProdutos in 'uFrmProdutos.pas' {FrmProdutos},
  uFrmCadProdutos in 'uFrmCadProdutos.pas' {FrmCadProdutos};

{$R *.res}

var
pArquivo : TextFile;
pNomeArq, pLinha : string;
pDataSys : TDateTime;
pDiasExpira : Double;

begin
  Hwnd := FindWindow('TApplication','Controle Comercial');
  SetLength(sPathWindows, MAX_PATH);
  lng := GetTempPath(MAX_PATH, PChar(sPathWindows));
  SetLength(sPathWindows, lng);
  pDataSys := date();
  if Hwnd = 0 then
  begin
    pDiasExpira := 0;
    pNumCli := 0;
    pNumProd := 0;
    frmSplash := TfrmSplash.Create(frmSplash);
    frmSplash.Show;
    frmSplash.Update;
    Application.Initialize;
//    Application.HelpFile := 'HELP.HLP';
    Application.Title := 'Controle Comercial';
  if pDiasExpira > 0 then
    begin
      pNomeArq := sPathWindows+'WC.vcn';
      if not FileExists(pNomeArq) then
      begin
        pDataSys := SVData;
        pDataSys := pDataSys + pDiasExpira;
        AssignFile(pArquivo,pNomeArq);
        Rewrite(pArquivo);
        Writeln(pArquivo,datetostr(pDataSys));
        CloseFile(pArquivo);
      end
      else
      begin
        AssignFile(pArquivo,pNomeArq);
        Reset(pArquivo);
        While not Eof(pArquivo) do
        begin
          ReadLn(pArquivo,pLinha);
          pDataSys := StrToDate(pLinha);
        end;
        CloseFile(pArquivo);
      end;
      // verifica data
      pDiasExpira := pDataSys - SVData;
      if SVData > pDataSys then
      begin
        MessageDlg('Sistema Expirou. Entre em contato com o Suporte Técnico!!!', mtWarning, [mbOK], 0);
        Application.Terminate;
      end;
      // exibe dias para expirar
      MessageDlg('Versão de Demonstração.'+#13+#10+
                 'Expira Em '+FloatToStr(pDiasExpira)+' Dias.', mtWarning, [mbOK], 0);
    end;
//  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmAcBr, DmAcBr);
  Application.CreateForm(TDmWorkCom, DmWorkCom);
  Application.CreateForm(TDmPosto, DmPosto);
  Application.CreateForm(TDmClientes, DmClientes);
  Application.CreateForm(TDmAuxiliar, DmAuxiliar);
  Application.CreateForm(TDmProdutos, DmProdutos);
  Application.CreateForm(TDmSPED, DmSPED);
//  Application.CreateForm(TFrmCadastroCliente, FrmCadastroCliente);
//  Application.CreateForm(TFrmConsPadrao, FrmConsPadrao);
//  Application.CreateForm(TFrmPadrao, FrmPadrao);
//  Application.CreateForm(TFrmContatosADC, FrmContatosADC);
//  Application.CreateForm(TFrmProdutos, FrmProdutos);
//  Application.CreateForm(TFrmCadProdutos, FrmCadProdutos);
  //  Application.CreateForm(TFrmCadPadrao, FrmCadPadrao);
  Application.CreateForm(Tfrmxml, frmxml);
  FrmSplash.Free;
  Application.Run;
  end
  else
  begin
    MessageDlg('O aplicativo já esta aberto!!!', mtWarning, [mbOK], 0);
    Application.Terminate;
  end;


end.



