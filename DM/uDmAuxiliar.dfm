object DmAuxiliar: TDmAuxiliar
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 560
  Width = 804
  object PBMVidaLink1: TPBMVidaLink
    Pasta_Envio = 'C:\PDV01\ENVIO'
    Pasta_Resposta = 'C:\PDV01\RESPOSTA'
    Solicitacao = <>
    Left = 48
    Top = 264
  end
  object QryGeral: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DmConexao.ConexaoDBX
    Left = 24
    Top = 16
  end
  object DspGeral: TDataSetProvider
    DataSet = QryGeral
    Options = [poAllowCommandText]
    Left = 24
    Top = 48
  end
  object CdsRegistros: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspGeral'
    Left = 176
    Top = 32
  end
  object CdsRegAuxiliar: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspGeral'
    Left = 272
    Top = 32
  end
  object CdsRegAuxiliar1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspGeral'
    Left = 352
    Top = 32
  end
  object CdsNFeXml: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspGeral'
    Left = 440
    Top = 32
  end
  object CdsGeral: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspGeral'
    Left = 96
    Top = 32
  end
  object QryAux: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DmConexao.ConexaoDBX
    Left = 32
    Top = 160
  end
  object CdsRegAuxVP: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 160
    object CdsRegAuxVPRegistro: TStringField
      FieldName = 'Registro'
      Size = 2
    end
    object CdsRegAuxVPTotal: TIntegerField
      FieldName = 'Total'
    end
  end
  object ControleLinhaBloco: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 160
    object ControleLinhaBlocoBLOCO: TStringField
      FieldName = 'BLOCO'
      Size = 4
    end
    object ControleLinhaBlocoQUANT: TIntegerField
      FieldName = 'QUANT'
    end
  end
  object CdsListaEstoque: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 160
    object CdsListaEstoqueIDPRODUTO: TIntegerField
      FieldName = 'IDPRODUTO'
    end
    object CdsListaEstoqueDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object CdsListaEstoqueUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 3
    end
  end
end
