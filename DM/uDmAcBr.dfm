object DmAcBr: TDmAcBr
  OldCreateOrder = False
  Height = 457
  Width = 665
  object ACBrECF1: TACBrECF
    QuebraLinhaRodape = False
    Porta = 'procurar'
    ReTentar = False
    DescricaoGrande = True
    MsgAguarde = 'Aguardando a resposta da Impressora: %d segundos'
    MsgTrabalhando = 'Impressora est'#225' trabalhando'
    MsgRelatorio = 'Imprimindo %s  %d'#170' Via '
    MsgPausaRelatorio = 'Destaque a %d'#170' via, <ENTER> proxima, %d seg.'
    PaginaDeCodigo = 0
    OnMsgAguarde = ACBrECF1MsgAguarde
    OnAguardandoRespostaChange = ACBrECF1AguardandoRespostaChange
    OnMsgPoucoPapel = ACBrECF1MsgPoucoPapel
    OnErrorSemPapel = ACBrECF1ErrorSemPapel
    OnDepoisAbreCupom = ACBrECF1DepoisAbreCupom
    OnErrorFechaNaoFiscal = ACBrECF1ErrorFechaNaoFiscal
    OnErrorCancelaNaoFiscal = ACBrECF1ErrorCancelaNaoFiscal
    OnDepoisLeituraX = ACBrECF1DepoisLeituraX
    OnDepoisReducaoZ = ACBrECF1DepoisReducaoZ
    OnDepoisAbreRelatorioGerencial = ACBrECF1DepoisAbreRelatorioGerencial
    OnDepoisFechaRelatorio = ACBrECF1DepoisFechaRelatorio
    OnErrorFechaRelatorio = ACBrECF1ErrorFechaRelatorio
    OnChangeEstado = ACBrECF1ChangeEstado
    DecimaisPreco = 2
    MemoParams.Strings = (
      '[Cabecalho]'
      'LIN000=<center><b>Nome da Empresa</b></center>'
      'LIN001=<center>Nome da Rua , 1234  -  Bairro</center>'
      'LIN002=<center>Cidade  -  UF  -  99999-999</center>'
      
        'LIN003=<center>CNPJ: 01.234.567/0001-22    IE: 012.345.678.90</c' +
        'enter>'
      
        'LIN004=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>COO: <b><code>NumCupom</code' +
        '></b></td></tr></table>'
      'LIN005=<hr>'
      ''
      '[Cabecalho_Item]'
      'LIN000=ITEM   CODIGO     DESCRICAO'
      'LIN001=QTD         x UNITARIO       Aliq     VALOR (R$)'
      'LIN002=<hr>'
      
        'MascaraItem=III CCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDQQQQ' +
        'QQQQ UU x VVVVVVVVVVVVV AAAAAA TTTTTTTTTTTTT'
      ''
      '[Rodape]'
      'LIN000=<hr>'
      
        'LIN001=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>Projeto ACBr: <b><code>ACBR<' +
        '/code></b></td></tr></table>'
      'LIN002=<center>Obrigado Volte Sempre</center>'
      'LIN003=<hr>'
      ''
      '[Formato]'
      'Colunas=48'
      'HTML=1'
      'HTML_Title_Size=4'
      'HTML_Font=<font size="5" face="Lucida Console">')
    EAD = ACBrEAD1
    ArqLOG = 'acbrlog.txt'
    ConfigBarras.MostrarCodigo = True
    ConfigBarras.LarguraLinha = 3
    ConfigBarras.Altura = 10
    ConfigBarras.Margem = 0
    InfoRodapeCupom.Imposto.ModoCompacto = False
    Left = 48
    Top = 37
  end
  object ACBrBAL1: TACBrBAL
    Porta = 'COM1'
    Left = 152
    Top = 32
  end
  object ACBrEAD1: TACBrEAD
    Left = 40
    Top = 112
  end
  object ACBrSPEDFiscal1: TACBrSPEDFiscal
    Path = 'C:\Arquivos de programas\Borland\Delphi7\Bin\'
    Delimitador = '|'
    TrimString = True
    CurMascara = '#0.00'
    Left = 160
    Top = 192
  end
  object ACBrSPEDPisCofins1: TACBrSPEDPisCofins
    Path = 'C:\Arquivos de programas\Borland\Delphi7\Bin\'
    Delimitador = '|'
    TrimString = True
    CurMascara = '#0.00'
    Left = 56
    Top = 192
  end
  object ACBrCNIEE1: TACBrCNIEE
    ProxyPort = '8080'
    URLDownload = 'http://www.fazenda.mg.gov.br/empresas/ecf/files/Tabela_CNIEE.bin'
    Left = 248
    Top = 32
  end
  object ACBrValidador1: TACBrValidador
    TipoDocto = docGTIN
    IgnorarChar = './-'
    Left = 384
    Top = 32
  end
  object ACBrIBPTax1: TACBrIBPTax
    ProxyPort = '8080'
    Left = 256
    Top = 192
  end
  object ACBrSintegra1: TACBrSintegra
    VersaoValidador = vv524
    Informa88SME = False
    Informa88SMS = False
    Informa88EAN = False
    Informa88C = False
    InformaSapiMG = False
    Left = 424
    Top = 96
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 384
    Top = 192
  end
  object ACBrSAT1: TACBrSAT
    NomeDLL = 'c:\sat\SAT.DLL'
    Config.infCFe_versaoDadosEnt = 0.050000000000000000
    Config.ide_numeroCaixa = 0
    Config.ide_tpAmb = taHomologacao
    Config.emit_cRegTrib = RTSimplesNacional
    Config.emit_cRegTribISSQN = RTISSMicroempresaMunicipal
    Config.emit_indRatISSQN = irSim
    Config.EhUTF8 = True
    Config.PaginaDeCodigo = 65001
    Config.XmlSignLib = xsNone
    ConfigArquivos.PrefixoArqCFe = 'AD'
    ConfigArquivos.PrefixoArqCFeCanc = 'ADC'
    Rede.tipoInter = infETHE
    Rede.seg = segNONE
    Rede.tipoLan = lanDHCP
    Rede.proxy = 0
    Rede.proxy_porta = 0
    OnGetcodigoDeAtivacao = ACBrSAT1GetcodigoDeAtivacao
    OnGetsignAC = ACBrSAT1GetsignAC
    Left = 56
    Top = 256
  end
  object ACBrSATExtratoFortes1: TACBrSATExtratoFortes
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    Site = 'http://www.projetoacbr.com.br'
    MargemInferior = 4.000000000000000000
    MargemSuperior = 2.000000000000000000
    MargemEsquerda = 2.000000000000000000
    MargemDireita = 2.000000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    ImprimeQRCode = False
    MsgAppQRCode = 
      'Consulte o QR Code pelo aplicativo  "De olho na nota", dispon'#237've' +
      'l na AppStore (Apple) e PlayStore (Android)'
    Left = 144
    Top = 264
  end
  object ACBrPosPrinter1: TACBrPosPrinter
    ConfigBarras.MostrarCodigo = False
    ConfigBarras.LarguraLinha = 0
    ConfigBarras.Altura = 0
    ConfigBarras.Margem = 0
    ConfigQRCode.Tipo = 2
    ConfigQRCode.LarguraModulo = 4
    ConfigQRCode.ErrorLevel = 0
    LinhasEntreCupons = 0
    CortaPapel = False
    Left = 400
    Top = 256
  end
  object ACBrSATExtratoESCPOS1: TACBrSATExtratoESCPOS
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    Site = 'http://www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    MsgAppQRCode = 
      'Consulte o QR Code pelo aplicativo  "De olho na nota", dispon'#237've' +
      'l na AppStore (Apple) e PlayStore (Android)'
    Left = 272
    Top = 264
  end
  object ACBrNCMs1: TACBrNCMs
    ProxyPort = '8080'
    UrlConsulta = 'http://www4.receita.fazenda.gov.br/simulador/PesquisarNCM.jsp?'
    Left = 312
    Top = 24
  end
  object ACBrBlocoX1: TACBrBlocoX
    Configuracoes.VersaoER = erv0204
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.SSLCryptLib = cryCapicom
    Configuracoes.Geral.SSLHttpLib = httpIndy
    Configuracoes.Geral.SSLXmlSignLib = xsMsXmlCapicom
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 416
    Top = 304
  end
  object ACBrCTe1: TACBrCTe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.SSLCryptLib = cryCapicom
    Configuracoes.Geral.SSLHttpLib = httpIndy
    Configuracoes.Geral.SSLXmlSignLib = xsMsXmlCapicom
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 448
    Top = 160
  end
  object ACBrNFSe1: TACBrNFSe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.SSLCryptLib = cryCapicom
    Configuracoes.Geral.SSLHttpLib = httpIndy
    Configuracoes.Geral.SSLXmlSignLib = xsMsXmlCapicom
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.CodigoMunicipio = 0
    Configuracoes.Geral.ConsultaLoteAposEnvio = False
    Configuracoes.Geral.Emitente.DadosSenhaParams = <>
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 464
    Top = 24
  end
  object ACBrBoleto1: TACBrBoleto
    Banco.TamanhoMaximoNossoNum = 10
    Banco.TipoCobranca = cobNenhum
    Banco.LayoutVersaoArquivo = 0
    Banco.LayoutVersaoLote = 0
    Cedente.TipoInscricao = pJuridica
    NumeroArquivo = 0
    ACBrBoletoFC = ACBrBoletoFCFortes1
    Left = 104
    Top = 320
  end
  object ACBrBoletoFCFortes1: TACBrBoletoFCFortes
    Left = 200
    Top = 320
  end
  object ACBrExtenso1: TACBrExtenso
    StrMoeda = 'Real'
    StrMoedas = 'Reais'
    StrCentavo = 'Centavo'
    StrCentavos = 'Centavos'
    Left = 320
    Top = 328
  end
  object ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    TipoDANFE = tiSemGeracao
    Left = 536
    Top = 112
  end
  object ACBrValidador_SSL: TACBrValidador
    TipoDocto = docCNPJ
    IgnorarChar = './-'
    Left = 40
    Top = 392
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 112
    Top = 112
  end
  object ACBrNFe2: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 104
    Top = 176
  end
  object ACBrNFeDANFEFR1: TACBrNFeDANFEFR
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    TipoDANFE = tiSemGeracao
    ExibeTotalTributosItem = True
    EspessuraBorda = 1
    ExpandirDadosAdicionaisAuto = False
    IncorporarBackgroundPdf = True
    IncorporarFontesPdf = True
    BorderIcon = [biSystemMenu, biMinimize, biMaximize]
    Left = 208
    Top = 144
  end
  object ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.200000000000000000
    MargemDireita = 0.200000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    TipoDANFE = tiSemGeracao
    LarguraBobina = 280
    Left = 328
    Top = 120
  end
end
