program Balcao;

uses
  Forms,
  uFrameBotaoHorizontal in 'uFrameBotaoHorizontal.pas' {FrameBotaoHorizontal: TFrame},
  uFrameBotaoVertical in 'uFrameBotaoVertical.pas' {FrameBotaoVertical: TFrame},
  uFrameConfirmaCancela in 'uFrameConfirmaCancela.pas' {FrameConfirmaCancela: TFrame},
  uFrameItensPedidoLaje in 'uFrameItensPedidoLaje.pas' {FrameItensPedidoLaje: TFrame},
  uDmAcBr in 'DM\uDmAcBr.pas' {DmAcBr: TDataModule},
  uDmConexao in 'DM\uDmConexao.pas' {DmConexao: TDataModule},
  uDmWorkCom in 'DM\uDmWorkCom.pas' {DmWorkCom: TDataModule},
  ICEP1 in 'Funcoes\ICEP1.pas',
  libeay32 in 'Funcoes\libeay32.pas',
  MD5 in 'Funcoes\MD5.pas',
  uFuncoesPAFECF in 'Funcoes\uFuncoesPAFECF.pas',
  uLibrary in 'Funcoes\uLibrary.pas',
  uFrmPadrao in 'uFrmPadrao.pas' {FrmPadrao},
  uFrmCadPadrao in 'uFrmCadPadrao.pas' {FrmCadPadrao},
  uFrmMenuDAVPV in 'uFrmMenuDAVPV.pas' {FrmMenuDAVPV},
  uFrmLancItensGrid in 'uFrmLancItensGrid.pas' {FrmLancItensGrid},
  uFrmLancItensPedido in 'uFrmLancItensPedido.pas' {FrmLancItensPedido},
  uFrmLancPedidos in 'uFrmLancPedidos.pas' {FrmLancPedidos},
  uFrmClientes in 'uFrmClientes.pas' {FrmClientes},
  uFrmCadClassPedido in 'uFrmCadClassPedido.pas' {FrmCadClassPedido},
  uFrmCadFormaPag in 'uFrmCadFormaPag.pas' {FrmCadFormaPag},
  uFrmPedidosConsulta in 'uFrmPedidosConsulta.pas' {FrmPedidosConsulta},
  uFrmProdutos in 'uFrmProdutos.pas' {FrmProdutos},
  uFrmLoginUsuario in 'uFrmLoginUsuario.pas' {FrmLoginUsuario},
  uDMClientes in 'DM\uDMClientes.pas' {DmClientes: TDataModule},
  CharPrinter in 'Funcoes\CharPrinter.pas',
  uMensagem in 'Funcoes\uMensagem.pas',
  uDmSPED in 'DM\uDmSPED.pas' {DmSPED: TDataModule},
  uDmAuxiliar in 'DM\uDmAuxiliar.pas' {DmAuxiliar: TDataModule},
  uDmPosto in 'DM\uDmPosto.pas' {DmPosto: TDataModule},
  uFuncoesPosto in 'Funcoes\uFuncoesPosto.pas',
  uFrmConsPadrao in 'uFrmConsPadrao.pas' {FrmConsPadrao},
  uDmProdutos in 'DM\uDmProdutos.pas' {DmProdutos: TDataModule},
  uFrmCadVolume in 'uFrmCadVolume.pas' {FrmCadVolume};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Emissor de DAV e Pre-Venda';
  Application.CreateForm(TDmAcBr, DmAcBr);
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmAuxiliar, DmAuxiliar);
  Application.CreateForm(TDmWorkCom, DmWorkCom);
  Application.CreateForm(TDmPosto, DmPosto);
  Application.CreateForm(TDmClientes, DmClientes);
  Application.CreateForm(TDmProdutos, DmProdutos);
  Application.CreateForm(TDmSPED, DmSPED);
  Application.CreateForm(TFrmMenuDAVPV, FrmMenuDAVPV);
  Application.Run;
end.
