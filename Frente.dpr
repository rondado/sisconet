program Frente;

uses
  MidasLib,
  ShareMem,
  Forms,
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  uFrmPadrao in 'uFrmPadrao.pas' {FrmPadrao},
  uFrmSplash in 'uFrmSplash.pas' {FrmSplash},
  uDmConexao in 'DM\uDmConexao.pas' {DmConexao: TDataModule},
  uDmWorkCom in 'DM\uDmWorkCom.pas' {DmWorkCom: TDataModule},
  uFrmCadPadrao in 'uFrmCadPadrao.pas' {FrmCadPadrao},
  uFrmPrincipalECF in 'uFrmPrincipalECF.pas' {FrmPrincipalECF},
  uFrmEmiCupom in 'uFrmEmiCupom.pas' {FrmEmiCupom},
  uFrmFecharCupom in 'uFrmFecharCupom.pas' {FrmFecharCupom},
  uFrmIdenticaCliente in 'uFrmIdenticaCliente.pas' {FrmIdenticaCliente},
  uFrameConfirmaCancela in 'uFrameConfirmaCancela.pas' {FrameConfirmaCancela: TFrame},
  uFrameBotaoHorizontal in 'uFrameBotaoHorizontal.pas' {FrameBotaoHorizontal: TFrame},
  uFrameBotaoVertical in 'uFrameBotaoVertical.pas' {FrameBotaoVertical: TFrame},
  uFuncoesPAFECF in 'Funcoes\uFuncoesPAFECF.pas',
  uLibrary in 'Funcoes\uLibrary.pas',
  uFrmMenuFiscal in 'uFrmMenuFiscal.pas' {FrmMenuFiscal},
  libeay32 in 'Funcoes\libeay32.pas',
  uFrmLoginUsuario in 'uFrmLoginUsuario.pas' {FrmLoginUsuario},
  uFrmConfiguracoes in 'uFrmConfiguracoes.pas' {FrmConfiguracoes},
  uFrmClientes in 'uFrmClientes.pas' {FrmClientes},
  uFrmProdutos in 'uFrmProdutos.pas' {FrmProdutos},
  uFrmSelListaEstoque in 'uFrmSelListaEstoque.pas' {FrmSelListaEstoque},
  uFrmValorFormaPag in 'uFrmValorFormaPag.pas' {FrmValorFormaPag},
  uFrmCupomAbastecimento in 'uFrmCupomAbastecimento.pas' {FrmCupomAbastecimento},
  uFrmFechaMesa in 'uFrmFechaMesa.pas' {FrmFechaMesa},
  uFrmRegistraDescAcres in 'uFrmRegistraDescAcres.pas' {FrmRegistraDescAcres},
  uFrmMensageemProd in 'uFrmMensageemProd.pas' {FrmMensageemProd},
  uFrmAbreCaixa in 'uFrmAbreCaixa.pas' {FrmAbreCaixa},
  uDmAcBr in 'DM\uDmAcBr.pas' {DmAcBr: TDataModule},
  uFrmImforma in 'uFrmImforma.pas' {FrmImforma},
  uFrmPrecoProduto in 'uFrmPrecoProduto.pas' {FrmPrecoProduto},
  uFuncoesPosto in 'Funcoes\uFuncoesPosto.pas',
  uFrmCadPlacasAbastec in 'uFrmCadPlacasAbastec.pas' {FrmCadPlacasAbastec},
  uFrmLiberacao in 'uFrmLiberacao.pas' {FrmLiberacao},
  uFrmAutorizaVidaLink in 'uFrmAutorizaVidaLink.pas' {FrmAutorizaVidaLink},
  uFrmFechaCaixa in 'uFrmFechaCaixa.pas' {FrmFechaCaixa},
  uFrmNFCePendente in 'uFrmNFCePendente.pas' {FrmNFCePendente},
  uFrmCupomDAVPV in 'uFrmCupomDAVPV.pas' {FrmCupomDAVPV},
  uDMClientes in 'DM\uDMClientes.pas' {DmClientes: TDataModule},
  CharPrinter in 'Funcoes\CharPrinter.pas',
  uRotinas_EFD in 'uRotinas_EFD.pas',
  uRotinas_PisCofins in 'uRotinas_PisCofins.pas',
  uDmSPED in 'DM\uDmSPED.pas' {DmSPED: TDataModule},
  uFrmValSupSangria in 'uFrmValSupSangria.pas' {FrmValSupSangria},
  uFrmEstoqueFisico in 'uFrmEstoqueFisico.pas' {FrmEstoqueFisico},
  uDmAuxiliar in 'DM\uDmAuxiliar.pas' {DmAuxiliar: TDataModule},
  uDmPosto in 'DM\uDmPosto.pas' {DmPosto: TDataModule},
  uFrmProdPosto in 'uFrmProdPosto.pas' {FrmProdPosto},
  uFrmCadReg61 in 'uFrmCadReg61.pas' {FrmCadReg61},
  uFrmDescontinuidade in 'uFrmDescontinuidade.pas' {FrmDescontinuidade},
  uFuncoesSoftPlus in 'Funcoes\uFuncoesSoftPlus.pas',
  untFuncoesPAF in 'Funcoes\untFuncoesPAF.pas',
  uFrmListaContigencia in 'uFrmListaContigencia.pas' {FrmListaContigencia},
  uFrmConsPadrao in 'uFrmConsPadrao.pas' {FrmConsPadrao},
  ICEP1 in 'Funcoes\ICEP1.pas',
  uMensagem in 'Funcoes\uMensagem.pas',
  MD5 in 'Funcoes\MD5.pas',
  uDmRelatorios in 'DM\uDmRelatorios.pas' {DmRelatorios: TDataModule},
  uDmProdutos in 'DM\uDmProdutos.pas' {DmProdutos: TDataModule},
  uFrmRecargaPre in 'uFrmRecargaPre.pas' {FrmRecargaPre};

{$R *.res}

var
pArquivo : TextFile;
pNomeArq, pLinha : string;
pDataSys : TDateTime;
pDiasExpira : Double;

begin
  Hwnd := FindWindow('TApplication','Emissor de Cupom Fiscal');
  if Hwnd = 0 then
  begin
    SetLength(sPathWindows, MAX_PATH);
    lng := GetTempPath(MAX_PATH, PChar(sPathWindows));
    SetLength(sPathWindows, lng);
    pDataSys := date();
    pDiasExpira := 0;
    pNumCli := 0;
    pNumProd := 0;
    frmSplash := TfrmSplash.Create(frmSplash);
    frmSplash.Show;
    frmSplash.Update;
    Application.Initialize;
    Application.Title := 'Emissor de Documento Fiscal';
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
    Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmAuxiliar, DmAuxiliar);
  Application.CreateForm(TDmWorkCom, DmWorkCom);
  Application.CreateForm(TDmPosto, DmPosto);
  Application.CreateForm(TDmClientes, DmClientes);
  Application.CreateForm(TDmProdutos, DmProdutos);
  Application.CreateForm(TDmRelatorios, DmRelatorios);
  Application.CreateForm(TDmAcBr, DmAcBr);
  Application.CreateForm(TDmSPED, DmSPED);
  Application.CreateForm(TFrmPrincipalECF, FrmPrincipalECF);
  Application.Run;
  end
  else
    MessageDlg('Aplicativo ja esta em uso. Verifique!', mtInformation, [mbOK], 0);
end.
