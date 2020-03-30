object dtmxml: Tdtmxml
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 524
  Width = 765
  object ACBrNFe1: TACBrNFe
    MAIL = ACBrMail1
    Configuracoes.Geral.SSLLib = libCustom
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpWinHttp
    Configuracoes.Geral.SSLXmlSignLib = xsMsXml
    Configuracoes.Geral.ExibirErroSchema = False
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.IncluirQRCodeXMLNFCe = False
    Configuracoes.Arquivos.PathSalvar = '.\Salvar\'
    Configuracoes.Arquivos.PathSchemas = '.\Schemas\'
    Configuracoes.Arquivos.IniServicos = 'UrlsTXT.txt'
    Configuracoes.Arquivos.AdicionarLiteral = True
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.Arquivos.SepararPorMes = True
    Configuracoes.Arquivos.EmissaoPathNFe = True
    Configuracoes.Arquivos.SalvarEvento = True
    Configuracoes.Arquivos.PathNFe = '.\NFe'
    Configuracoes.Arquivos.PathInu = '.\Inu'
    Configuracoes.Arquivos.PathEvento = '.\Eventos'
    Configuracoes.Arquivos.DownloadNFe.PathDownload = '.\Download'
    Configuracoes.WebServices.UF = 'ES'
    Configuracoes.WebServices.Ambiente = taProducao
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    DANFE = ACBrNFeDANFeRL1
    Left = 514
    Top = 38
  end
  object ACBrNFeDANFeRL1: TACBrNFeDANFeRL
    ACBrNFe = ACBrNFe1
    PathPDF = '.\PDFs\'
    MostrarPreview = True
    MostrarStatus = True
    TipoDANFE = tiRetrato
    NumCopias = 1
    ImprimeNomeFantasia = False
    ImprimirDescPorc = False
    ImprimirTotalLiquido = True
    MargemInferior = 0.700000000000000000
    MargemSuperior = 0.700000000000000000
    MargemEsquerda = 0.700000000000000000
    MargemDireita = 0.700000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais._qCom = 4
    CasasDecimais._vUnCom = 4
    CasasDecimais._Mask_qCom = '###,###,###,##0.00'
    CasasDecimais._Mask_vUnCom = '###,###,###,##0.00'
    ExibirResumoCanhoto = False
    FormularioContinuo = False
    TamanhoFonte_DemaisCampos = 10
    ProdutosPorPagina = 0
    ImprimirDetalhamentoEspecifico = True
    NFeCancelada = False
    ImprimirItens = True
    ViaConsumidor = True
    TamanhoLogoHeight = 0
    TamanhoLogoWidth = 0
    RecuoEndereco = 0
    RecuoEmpresa = 0
    LogoemCima = False
    TamanhoFonteEndereco = 0
    RecuoLogo = 0
    LarguraCodProd = 54
    ExibirEAN = False
    QuebraLinhaEmDetalhamentoEspecifico = True
    ExibeCampoFatura = False
    ImprimirUnQtVlComercial = iuComercial
    ImprimirDadosDocReferenciados = True
    Left = 514
    Top = 102
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = UTF_8
    Left = 514
    Top = 174
  end
  object qXmlCfg: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select * from xmlcfg')
    Left = 71
    Top = 363
  end
  object qXmlRes: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select * from xmlnfe')
    Left = 165
    Top = 361
  end
  object qXmlDfe: TFDQuery
    Connection = Conn
    Left = 268
    Top = 359
  end
  object qXmlNfe: TFDQuery
    Connection = Conn
    Left = 366
    Top = 355
  end
  object AutoExec: TTimer
    Enabled = False
    OnTimer = AutoExecTimer
    Left = 648
    Top = 30
  end
  object Conn: TFDConnection
    Params.Strings = (
      'Database=C:\Sisconet18\Exec\Dados\DADOS.FDB'
      'LockingMode=Normal'
      'DriverID=FB'
      'User_Name=SYSDBA'
      'Password=masterkey')
    Connected = True
    Left = 71
    Top = 56
  end
  object pXmlCfg: TDataSetProvider
    DataSet = qXmlCfg
    Options = [poAutoRefresh, poPropogateChanges, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateData = pXmlCfgUpdateData
    Left = 72
    Top = 408
  end
  object XmlCfg: TClientDataSet
    Aggregates = <>
    PacketRecords = 1
    Params = <>
    ProviderName = 'pXmlCfg'
    AfterOpen = XmlCfgAfterOpen
    AfterPost = XmlCfgAfterPost
    OnNewRecord = XmlCfgNewRecord
    Left = 72
    Top = 455
    object XmlCfgIDDFE: TIntegerField
      FieldName = 'IDDFE'
      Required = True
    end
    object XmlCfgULTNSU: TIntegerField
      FieldName = 'ULTNSU'
    end
    object XmlCfgUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object XmlCfgTIMEINTERVAL: TIntegerField
      FieldName = 'TIMEINTERVAL'
    end
    object XmlCfgNUMEROSERIE: TStringField
      FieldName = 'NUMEROSERIE'
      Size = 50
    end
    object XmlCfgIDDFEAUTOINC: TIntegerField
      FieldName = 'IDDFEAUTOINC'
    end
    object XmlCfgSENHA: TStringField
      FieldName = 'SENHA'
      Size = 30
    end
    object XmlCfgARQUIVOPFX: TStringField
      FieldName = 'ARQUIVOPFX'
      Size = 254
    end
    object XmlCfgPATHDB: TStringField
      FieldName = 'PATHDB'
      Size = 254
    end
    object XmlCfgSSLLIB: TStringField
      FieldName = 'SSLLIB'
      Size = 2
    end
    object XmlCfgAUTOEXECUTE: TIntegerField
      FieldName = 'AUTOEXECUTE'
    end
    object XmlCfgAUTOTIMER: TIntegerField
      FieldName = 'AUTOTIMER'
    end
  end
  object pXmlRes: TDataSetProvider
    DataSet = qXmlRes
    Options = [poAutoRefresh, poPropogateChanges, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateData = pXmlResUpdateData
    Left = 165
    Top = 409
  end
  object XmlRes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'pXmlRes'
    Left = 163
    Top = 456
    object XmlResIDDFE: TIntegerField
      FieldName = 'IDDFE'
      Required = True
    end
    object XmlResXNUMERONFE: TStringField
      FieldName = 'XNUMERONFE'
      Size = 10
    end
    object XmlResXSERIE: TStringField
      FieldName = 'XSERIE'
      Size = 3
    end
    object XmlResCHNFE: TStringField
      FieldName = 'CHNFE'
      Size = 44
    end
    object XmlResCNPJCPF: TStringField
      FieldName = 'CNPJCPF'
      Size = 14
    end
    object XmlResXNOME: TStringField
      FieldName = 'XNOME'
      Size = 100
    end
    object XmlResIE: TStringField
      FieldName = 'IE'
      Size = 18
    end
    object XmlResDHEMI: TSQLTimeStampField
      FieldName = 'DHEMI'
    end
    object XmlResTPNF: TIntegerField
      FieldName = 'TPNF'
    end
    object XmlResVNF: TBCDField
      FieldName = 'VNF'
      Precision = 18
      Size = 2
    end
    object XmlResDIGVAL: TStringField
      FieldName = 'DIGVAL'
      Size = 100
    end
    object XmlResDHRECBTO: TSQLTimeStampField
      FieldName = 'DHRECBTO'
    end
    object XmlResNPROT: TStringField
      FieldName = 'NPROT'
    end
    object XmlResCSITNFE: TIntegerField
      FieldName = 'CSITNFE'
    end
    object XmlResNSU: TIntegerField
      FieldName = 'NSU'
    end
    object XmlResNFE: TStringField
      FieldName = 'NFE'
      Size = 1
    end
    object XmlResDFE: TStringField
      FieldName = 'DFE'
      Size = 1
    end
  end
  object pXmlDfe: TDataSetProvider
    DataSet = qXmlDfe
    Options = [poReadOnly, poAllowCommandText, poUseQuoteChar]
    Left = 268
    Top = 404
  end
  object XmlDfe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'pXmlDfe'
    Left = 266
    Top = 449
  end
  object pXmlNfe: TDataSetProvider
    DataSet = qXmlNfe
    Options = [poReadOnly, poAllowCommandText, poUseQuoteChar]
    Left = 368
    Top = 400
  end
  object XmlNfe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'pXmlNfe'
    Left = 366
    Top = 445
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 189
    Top = 53
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 189
    Top = 102
  end
  object FDSQLiteValidate1: TFDSQLiteValidate
    DriverLink = FDPhysSQLiteDriverLink1
    Left = 315
    Top = 50
  end
end
