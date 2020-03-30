program NFe;

uses
  Forms,
  uFrmMenuNFe in 'uFrmMenuNFe.pas' {FrmMenuNFe},
  uDmConexao in 'DM\uDmConexao.pas' {DmConexao: TDataModule},
  uLibrary in 'Funcoes\uLibrary.pas',
  uFrameBotaoHorizontal in 'uFrameBotaoHorizontal.pas' {FrameBotaoHorizontal: TFrame},
  uFrameBotaoVertical in 'uFrameBotaoVertical.pas' {FrameBotaoVertical: TFrame},
  uFrameConfirmaCancela in 'uFrameConfirmaCancela.pas' {FrameConfirmaCancela: TFrame},
  uFrameItensPedidoLaje in 'uFrameItensPedidoLaje.pas' {FrameItensPedidoLaje: TFrame},
  uFrmPadrao in 'uFrmPadrao.pas' {FrmPadrao},
  uFrmCadPadrao in 'uFrmCadPadrao.pas' {FrmCadPadrao},
  MD5 in 'Funcoes\MD5.pas',
  uFuncoesPAFECF in 'Funcoes\uFuncoesPAFECF.pas',
  uDmAcBr in 'DM\uDmAcBr.pas' {DmAcBr: TDataModule},
  ICEP1 in 'Funcoes\ICEP1.pas',
  uFrmGeraNFe in 'uFrmGeraNFe.pas' {FrmGeraNFe},
  uFrmInutiliza in 'uFrmInutiliza.pas' {FrmInutiliza},
  uFrmConsultasNFe in 'uFrmConsultasNFe.pas' {FrmConsultasNFe},
  uDmWorkCom in 'DM\uDmWorkCom.pas' {DmWorkCom: TDataModule},
  uFrmClientes in 'uFrmClientes.pas' {FrmClientes},
  uFrmCadClassPedido in 'uFrmCadClassPedido.pas' {FrmCadClassPedido},
  uFrmCadFormaPag in 'uFrmCadFormaPag.pas' {FrmCadFormaPag},
  uFrmProdutos in 'uFrmProdutos.pas' {FrmProdutos},
  uFrmPedidosConsulta in 'uFrmPedidosConsulta.pas' {FrmPedidosConsulta},
  uFrmLancPedidos in 'uFrmLancPedidos.pas' {FrmLancPedidos},
  uMensagem in 'Funcoes\uMensagem.pas',
  uDMClientes in 'DM\uDMClientes.pas' {DmClientes: TDataModule},
  CharPrinter in 'Funcoes\CharPrinter.pas',
  uDmSPED in 'DM\uDmSPED.pas' {DmSPED: TDataModule},
  uDmAuxiliar in 'DM\uDmAuxiliar.pas' {DmAuxiliar: TDataModule},
  uDmPosto in 'DM\uDmPosto.pas' {DmPosto: TDataModule},
  uFuncoesPosto in 'Funcoes\uFuncoesPosto.pas',
  uFrmCupomAbastecimento in 'uFrmCupomAbastecimento.pas' {FrmCupomAbastecimento},
  uFuncoesSoftPlus in 'Funcoes\uFuncoesSoftPlus.pas',
  untFuncoesPAF in 'Funcoes\untFuncoesPAF.pas',
  uFrmConsPadrao in 'uFrmConsPadrao.pas' {FrmConsPadrao},
  uDmProdutos in 'DM\uDmProdutos.pas' {DmProdutos: TDataModule},
  uDmRelatorios in 'DM\uDmRelatorios.pas' {DmRelatorios: TDataModule},
  uFrmCadVolume in 'uFrmCadVolume.pas' {FrmCadVolume},
  ufrmStatus in 'DM\ufrmStatus.pas' {frmStatus},
  uFrmPedidosagrupa in 'uFrmPedidosagrupa.pas' {FrmPedidosAgrupa},
  uFrmCFOPPedido in 'uFrmCFOPPedido.pas' {FrmCFOPPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Emissor de NFe';
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmAcBr, DmAcBr);
  Application.CreateForm(TDmAuxiliar, DmAuxiliar);
  Application.CreateForm(TDmWorkCom, DmWorkCom);
  Application.CreateForm(TDmClientes, DmClientes);
  Application.CreateForm(TDmProdutos, DmProdutos);
  Application.CreateForm(TDmPosto, DmPosto);
  Application.CreateForm(TDmSPED, DmSPED);
  Application.CreateForm(TDmRelatorios, DmRelatorios);
  Application.CreateForm(TFrmMenuNFe, FrmMenuNFe);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.CreateForm(TFrmPedidosAgrupa, FrmPedidosAgrupa);
  Application.CreateForm(TFrmCFOPPedido, FrmCFOPPedido);
  Application.Run;
end.
