object DmClientes: TDmClientes
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 415
  Width = 772
  object QryContatos: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pID'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from contato'
      'where contato.id = :pID')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 32
    Top = 16
    object QryContatosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryContatosNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryContatosENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object QryContatosNUM_END: TStringField
      FieldName = 'NUM_END'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object QryContatosBAIRRO_END: TStringField
      FieldName = 'BAIRRO_END'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosCIDADE_END: TStringField
      FieldName = 'CIDADE_END'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosCEP_END: TStringField
      FieldName = 'CEP_END'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object QryContatosTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryContatosTELEFAX: TStringField
      FieldName = 'TELEFAX'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryContatosCELULAR: TStringField
      FieldName = 'CELULAR'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryContatosCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosINSC_RG: TStringField
      FieldName = 'INSC_RG'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosEND_ENTREGA: TStringField
      FieldName = 'END_ENTREGA'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object QryContatosNUM_END_ENTREGA: TStringField
      FieldName = 'NUM_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object QryContatosBAIRRO_END_ENTREGA: TStringField
      FieldName = 'BAIRRO_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosCID_END_ENTREGA: TStringField
      FieldName = 'CID_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosCEP_END_ENTREGA: TStringField
      FieldName = 'CEP_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object QryContatosLOCAL_TRAB: TStringField
      FieldName = 'LOCAL_TRAB'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryContatosEND_LOCAL_TRAB: TStringField
      FieldName = 'END_LOCAL_TRAB'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryContatosTELEFONE_TRAB: TStringField
      FieldName = 'TELEFONE_TRAB'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryContatosFILIACAO_PAI: TStringField
      FieldName = 'FILIACAO_PAI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryContatosFILIACAO_MAE: TStringField
      FieldName = 'FILIACAO_MAE'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryContatosDATA_CAD: TSQLTimeStampField
      FieldName = 'DATA_CAD'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosDATA_NASC: TSQLTimeStampField
      FieldName = 'DATA_NASC'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosLIMITE_CRED: TFloatField
      FieldName = 'LIMITE_CRED'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosCONTATO: TStringField
      FieldName = 'CONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryContatosTIPO_CONTATO: TStringField
      FieldName = 'TIPO_CONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object QryContatosATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryContatosOBSERVACOES: TMemoField
      FieldName = 'OBSERVACOES'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object QryContatosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosCOMPL_ENT: TStringField
      FieldName = 'COMPL_ENT'
      ProviderFlags = [pfInUpdate]
    end
    object QryContatosUF_END: TStringField
      FieldName = 'UF_END'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object QryContatosUF_END_ENT: TStringField
      FieldName = 'UF_END_ENT'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object QryContatosSITE: TStringField
      FieldName = 'SITE'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object QryContatosEMAIL: TStringField
      FieldName = 'EMAIL'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object QryContatosCODCIDADE: TStringField
      FieldName = 'CODCIDADE'
      ProviderFlags = [pfInUpdate]
      Size = 7
    end
    object QryContatosSINCRONIZADO: TStringField
      FieldName = 'SINCRONIZADO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object DspContatos: TDataSetProvider
    DataSet = QryContatos
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspContatosGetTableName
    Left = 32
    Top = 40
  end
  object CdsContatos: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pID'
        ParamType = ptInput
      end>
    ProviderName = 'DspContatos'
    BeforePost = CdsContatosBeforePost
    OnNewRecord = CdsContatosNewRecord
    Left = 32
    Top = 56
    object CdsContatosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsContatosNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsContatosENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object CdsContatosNUM_END: TStringField
      FieldName = 'NUM_END'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object CdsContatosBAIRRO_END: TStringField
      FieldName = 'BAIRRO_END'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosCIDADE_END: TStringField
      FieldName = 'CIDADE_END'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosCEP_END: TStringField
      FieldName = 'CEP_END'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object CdsContatosTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsContatosTELEFAX: TStringField
      FieldName = 'TELEFAX'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsContatosCELULAR: TStringField
      FieldName = 'CELULAR'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsContatosCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosINSC_RG: TStringField
      FieldName = 'INSC_RG'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosEND_ENTREGA: TStringField
      FieldName = 'END_ENTREGA'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object CdsContatosNUM_END_ENTREGA: TStringField
      FieldName = 'NUM_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object CdsContatosBAIRRO_END_ENTREGA: TStringField
      FieldName = 'BAIRRO_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosCID_END_ENTREGA: TStringField
      FieldName = 'CID_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosCEP_END_ENTREGA: TStringField
      FieldName = 'CEP_END_ENTREGA'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object CdsContatosLOCAL_TRAB: TStringField
      FieldName = 'LOCAL_TRAB'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsContatosEND_LOCAL_TRAB: TStringField
      FieldName = 'END_LOCAL_TRAB'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsContatosTELEFONE_TRAB: TStringField
      FieldName = 'TELEFONE_TRAB'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsContatosFILIACAO_PAI: TStringField
      FieldName = 'FILIACAO_PAI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsContatosFILIACAO_MAE: TStringField
      FieldName = 'FILIACAO_MAE'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsContatosDATA_CAD: TSQLTimeStampField
      FieldName = 'DATA_CAD'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosDATA_NASC: TSQLTimeStampField
      FieldName = 'DATA_NASC'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosLIMITE_CRED: TFloatField
      FieldName = 'LIMITE_CRED'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosCONTATO: TStringField
      FieldName = 'CONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsContatosTIPO_CONTATO: TStringField
      FieldName = 'TIPO_CONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object CdsContatosATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object CdsContatosOBSERVACOES: TMemoField
      FieldName = 'OBSERVACOES'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object CdsContatosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosCOMPL_ENT: TStringField
      FieldName = 'COMPL_ENT'
      ProviderFlags = [pfInUpdate]
    end
    object CdsContatosUF_END: TStringField
      FieldName = 'UF_END'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object CdsContatosUF_END_ENT: TStringField
      FieldName = 'UF_END_ENT'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object CdsContatosSITE: TStringField
      FieldName = 'SITE'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CdsContatosEMAIL: TStringField
      FieldName = 'EMAIL'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CdsContatosCODCIDADE: TStringField
      FieldName = 'CODCIDADE'
      ProviderFlags = [pfInUpdate]
      Size = 7
    end
    object CdsContatosSINCRONIZADO: TStringField
      FieldName = 'SINCRONIZADO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object QryContatoAux: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select contato.id,contato.nome from contato')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 112
    Top = 16
    object QryContatoAuxID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryContatoAuxNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
  end
  object DspContatoAux: TDataSetProvider
    DataSet = QryContatoAux
    OnGetTableName = DspContatoAuxGetTableName
    Left = 112
    Top = 40
  end
  object CdsContatoAux: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspContatoAux'
    Left = 112
    Top = 56
    object CdsContatoAuxID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsContatoAuxNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
  end
  object QryEndereco: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'pCep'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from endereco'
      'where endereco.cep = :pCep')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 192
    Top = 16
    object QryEnderecoID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryEnderecoENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object QryEnderecoBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = [pfInUpdate]
    end
    object QryEnderecoCIDADE: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = [pfInUpdate]
    end
    object QryEnderecoUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object QryEnderecoCEP: TStringField
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
  end
  object QryUF: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from cod_uf_ibge U'
      'order by u.uf')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 264
    Top = 16
    object QryUFCODIGO: TStringField
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 2
    end
    object QryUFUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object QryUFDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QryUFDATA_INICIO: TDateField
      FieldName = 'DATA_INICIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object DspEndereco: TDataSetProvider
    DataSet = QryEndereco
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspEnderecoGetTableName
    Left = 192
    Top = 40
  end
  object DspUF: TDataSetProvider
    DataSet = QryUF
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspUFGetTableName
    Left = 264
    Top = 40
  end
  object CdsUF: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspUF'
    Left = 264
    Top = 56
    object CdsUFCODIGO: TStringField
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 2
    end
    object CdsUFUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object CdsUFDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object CdsUFDATA_INICIO: TDateField
      FieldName = 'DATA_INICIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object CdsEndereco: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pCep'
        ParamType = ptInput
      end>
    ProviderName = 'DspEndereco'
    OnNewRecord = CdsEnderecoNewRecord
    Left = 192
    Top = 56
    object CdsEnderecoID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsEnderecoENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object CdsEnderecoBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsEnderecoCIDADE: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = [pfInUpdate]
    end
    object CdsEnderecoUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object CdsEnderecoCEP: TStringField
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
  end
  object QryContatosAdc: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pID'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from contato_adc'
      'where contato_adc.ID_CONTATO = :pID')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 32
    Top = 120
    object QryContatosAdcID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryContatosAdcID_CONTATO: TIntegerField
      FieldName = 'ID_CONTATO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryContatosAdcNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryContatosAdcTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryContatosAdcRAMAL: TStringField
      FieldName = 'RAMAL'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object QryContatosAdcEMAIL1: TStringField
      FieldName = 'EMAIL1'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object QryContatosAdcEMAIL2: TStringField
      FieldName = 'EMAIL2'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object QryContatosAdcSITE: TStringField
      FieldName = 'SITE'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
  end
  object DspContatosADC: TDataSetProvider
    DataSet = QryContatosAdc
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspContatosADCGetTableName
    Left = 32
    Top = 144
  end
  object CdsContatosADC: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pID'
        ParamType = ptInput
      end>
    ProviderName = 'DspContatosADC'
    OnNewRecord = CdsContatosADCNewRecord
    Left = 32
    Top = 160
    object CdsContatosADCID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsContatosADCID_CONTATO: TIntegerField
      FieldName = 'ID_CONTATO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CdsContatosADCNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsContatosADCTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsContatosADCRAMAL: TStringField
      FieldName = 'RAMAL'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object CdsContatosADCEMAIL1: TStringField
      FieldName = 'EMAIL1'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CdsContatosADCEMAIL2: TStringField
      FieldName = 'EMAIL2'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CdsContatosADCSITE: TStringField
      FieldName = 'SITE'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
  end
  object CdsClienteAux: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 232
    object CdsClienteAuxID: TStringField
      FieldName = 'ID'
      Size = 10
    end
    object CdsClienteAuxDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object CdsClienteAuxCNPJCPF: TStringField
      FieldName = 'CNPJCPF'
      Size = 18
    end
  end
  object QryTipoEnd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from tipoendereco')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 136
    Top = 112
    object QryTipoEndID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryTipoEndDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
    end
    object QryTipoEndSIGLA: TStringField
      FieldName = 'SIGLA'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
  end
  object DspTipoEnd: TDataSetProvider
    DataSet = QryTipoEnd
    UpdateMode = upWhereKeyOnly
    Left = 136
    Top = 136
  end
  object CdsTipoEnd: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspTipoEnd'
    Left = 136
    Top = 152
    object CdsTipoEndID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsTipoEndDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsTipoEndSIGLA: TStringField
      FieldName = 'SIGLA'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
  end
  object QryCliForAux: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'pTipoContato'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select contato.id,contato.nome from contato'
      'where (contato.tipo_contato = :pTipoContato'
      '       or contato.tipo_contato = '#39'A'#39')')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 312
    Top = 112
    object QryCliForAuxID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryCliForAuxNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
  end
  object DspCliForAux: TDataSetProvider
    DataSet = QryCliForAux
    UpdateMode = upWhereKeyOnly
    Left = 312
    Top = 136
  end
  object CdsCliForAux: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pTipoContato'
        ParamType = ptInput
      end>
    ProviderName = 'DspCliForAux'
    Left = 312
    Top = 160
    object CdsCliForAuxID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsCliForAuxNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
  end
  object QryCodCidade: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'pUF'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from cod_mun_ibge c'
      'where c.uf_sigla = :pUF')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 224
    Top = 112
    object QryCodCidadeCOD_UF: TStringField
      FieldName = 'COD_UF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object QryCodCidadeCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object QryCodCidadeUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryCodCidadeMUNICIPIO: TStringField
      FieldName = 'MUNICIPIO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object QryCodCidadeUF_SIGLA: TStringField
      FieldName = 'UF_SIGLA'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
  end
  object DspCodCidade: TDataSetProvider
    DataSet = QryCodCidade
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspCodCidadeGetTableName
    Left = 224
    Top = 128
  end
  object CdsCodCidade: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pUF'
        ParamType = ptInput
      end>
    ProviderName = 'DspCodCidade'
    Left = 224
    Top = 152
    object CdsCodCidadeCOD_UF: TStringField
      FieldName = 'COD_UF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object CdsCodCidadeCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object CdsCodCidadeUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CdsCodCidadeMUNICIPIO: TStringField
      FieldName = 'MUNICIPIO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object CdsCodCidadeUF_SIGLA: TStringField
      FieldName = 'UF_SIGLA'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
  end
  object QryFuncionarios: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'pID'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from funcionario'
      'where funcionario.id = :pID')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 492
    Top = 40
    object QryFuncionariosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryFuncionariosNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryFuncionariosENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object QryFuncionariosNUMERO: TStringField
      FieldName = 'NUMERO'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object QryFuncionariosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosCIDADE: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosCEP: TStringField
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object QryFuncionariosUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object QryFuncionariosTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryFuncionariosTELEFAX: TStringField
      FieldName = 'TELEFAX'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryFuncionariosCELULAR: TStringField
      FieldName = 'CELULAR'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object QryFuncionariosCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosINSC_RG: TStringField
      FieldName = 'INSC_RG'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosFILIACAO_PAI: TStringField
      FieldName = 'FILIACAO_PAI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryFuncionariosFILIACAO_MAE: TStringField
      FieldName = 'FILIACAO_MAE'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryFuncionariosDATA_NASC: TSQLTimeStampField
      FieldName = 'DATA_NASC'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosDATA_ADMISSAO: TSQLTimeStampField
      FieldName = 'DATA_ADMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosDATA_DEMISSAO: TSQLTimeStampField
      FieldName = 'DATA_DEMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosSALARIO: TFloatField
      FieldName = 'SALARIO'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosCOMISSAO: TStringField
      FieldName = 'COMISSAO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object QryFuncionariosPERC_COMISSAO: TFloatField
      FieldName = 'PERC_COMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryFuncionariosOBSERVACOES: TMemoField
      FieldName = 'OBSERVACOES'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
    object QryFuncionariosEMAIL: TStringField
      FieldName = 'EMAIL'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object QryFuncionariosTIPO: TIntegerField
      FieldName = 'TIPO'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosTIPO_COM: TIntegerField
      FieldName = 'TIPO_COM'
      ProviderFlags = [pfInUpdate]
    end
    object QryFuncionariosSINCRONIZADO: TStringField
      FieldName = 'SINCRONIZADO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object DspFuncionarios: TDataSetProvider
    DataSet = QryFuncionarios
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFuncionariosGetTableName
    Left = 492
    Top = 56
  end
  object CdsFuncionarios: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pID'
        ParamType = ptInput
      end>
    ProviderName = 'DspFuncionarios'
    BeforePost = CdsFuncionariosBeforePost
    OnNewRecord = CdsFuncionariosNewRecord
    Left = 492
    Top = 80
    object CdsFuncionariosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsFuncionariosNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsFuncionariosENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object CdsFuncionariosNUMERO: TStringField
      FieldName = 'NUMERO'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object CdsFuncionariosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosCIDADE: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosCEP: TStringField
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object CdsFuncionariosUF: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object CdsFuncionariosTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsFuncionariosTELEFAX: TStringField
      FieldName = 'TELEFAX'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsFuncionariosCELULAR: TStringField
      FieldName = 'CELULAR'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object CdsFuncionariosCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosINSC_RG: TStringField
      FieldName = 'INSC_RG'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosFILIACAO_PAI: TStringField
      FieldName = 'FILIACAO_PAI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsFuncionariosFILIACAO_MAE: TStringField
      FieldName = 'FILIACAO_MAE'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsFuncionariosDATA_NASC: TSQLTimeStampField
      FieldName = 'DATA_NASC'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosDATA_ADMISSAO: TSQLTimeStampField
      FieldName = 'DATA_ADMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosDATA_DEMISSAO: TSQLTimeStampField
      FieldName = 'DATA_DEMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosSALARIO: TFloatField
      FieldName = 'SALARIO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosCOMISSAO: TStringField
      FieldName = 'COMISSAO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object CdsFuncionariosPERC_COMISSAO: TFloatField
      FieldName = 'PERC_COMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object CdsFuncionariosOBSERVACOES: TMemoField
      FieldName = 'OBSERVACOES'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object CdsFuncionariosEMAIL: TStringField
      FieldName = 'EMAIL'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CdsFuncionariosTIPO: TIntegerField
      FieldName = 'TIPO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosTIPO_COM: TIntegerField
      FieldName = 'TIPO_COM'
      ProviderFlags = [pfInUpdate]
    end
    object CdsFuncionariosSINCRONIZADO: TStringField
      FieldName = 'SINCRONIZADO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object CdsFuncionariosAux: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pID'
        ParamType = ptInput
      end>
    ProviderName = 'DspFuncionarios'
    Left = 508
    Top = 88
    object IntegerField5: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField6: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object StringField7: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object StringField8: TStringField
      FieldName = 'NUMERO'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object StringField9: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = [pfInUpdate]
    end
    object StringField10: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = [pfInUpdate]
    end
    object StringField11: TStringField
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object StringField12: TStringField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object StringField13: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object StringField14: TStringField
      FieldName = 'TELEFAX'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object StringField15: TStringField
      FieldName = 'CELULAR'
      ProviderFlags = [pfInUpdate]
      Size = 12
    end
    object StringField16: TStringField
      FieldName = 'CNPJ_CPF'
      ProviderFlags = [pfInUpdate]
    end
    object StringField17: TStringField
      FieldName = 'INSC_RG'
      ProviderFlags = [pfInUpdate]
    end
    object StringField18: TStringField
      FieldName = 'FILIACAO_PAI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object StringField19: TStringField
      FieldName = 'FILIACAO_MAE'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object SQLTimeStampField7: TSQLTimeStampField
      FieldName = 'DATA_NASC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLTimeStampField8: TSQLTimeStampField
      FieldName = 'DATA_ADMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object SQLTimeStampField9: TSQLTimeStampField
      FieldName = 'DATA_DEMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object FloatField5: TFloatField
      FieldName = 'SALARIO'
      ProviderFlags = [pfInUpdate]
    end
    object StringField20: TStringField
      FieldName = 'COMISSAO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object FloatField6: TFloatField
      FieldName = 'PERC_COMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object StringField21: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object MemoField1: TMemoField
      FieldName = 'OBSERVACOES'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object StringField22: TStringField
      FieldName = 'EMAIL'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object IntegerField6: TIntegerField
      FieldName = 'TIPO'
      ProviderFlags = [pfInUpdate]
    end
    object IntegerField7: TIntegerField
      FieldName = 'TIPO_COM'
      ProviderFlags = [pfInUpdate]
    end
    object StringField23: TStringField
      FieldName = 'SINCRONIZADO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object QryUsuarios: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'pUsuario'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from usuarios'
      'where upper(usuarios.usuario) = :pUsuario')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 152
    Top = 232
    object QryUsuariosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryUsuariosUSUARIO: TStringField
      FieldName = 'USUARIO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      ProviderFlags = [pfInUpdate]
    end
    object QryUsuariosATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryUsuariosTIPO_USUARIO: TIntegerField
      FieldName = 'TIPO_USUARIO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryUsuariosNOME_USUAIO: TStringField
      FieldName = 'NOME_USUAIO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object QryUsuariosID_PERFIL: TIntegerField
      FieldName = 'ID_PERFIL'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryUsuariosNUM_CHAVE: TIntegerField
      FieldName = 'NUM_CHAVE'
      ProviderFlags = [pfInUpdate]
    end
    object QryUsuariosID_FUNC: TIntegerField
      FieldName = 'ID_FUNC'
      ProviderFlags = [pfInUpdate]
    end
    object QryUsuariosFUNCAO: TStringField
      FieldName = 'FUNCAO'
      ProviderFlags = [pfInUpdate]
      Size = 25
    end
  end
  object DspUsuarios: TDataSetProvider
    DataSet = QryUsuarios
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspUsuariosGetTableName
    Left = 152
    Top = 256
  end
  object CdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pUsuario'
        ParamType = ptInput
      end>
    ProviderName = 'DspUsuarios'
    BeforePost = CdsUsuariosBeforePost
    OnNewRecord = CdsUsuariosNewRecord
    Left = 152
    Top = 280
    object CdsUsuariosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsUsuariosUSUARIO: TStringField
      FieldName = 'USUARIO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CdsUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      ProviderFlags = [pfInUpdate]
    end
    object CdsUsuariosATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object CdsUsuariosTIPO_USUARIO: TIntegerField
      FieldName = 'TIPO_USUARIO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CdsUsuariosNOME_USUAIO: TStringField
      FieldName = 'NOME_USUAIO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object CdsUsuariosID_PERFIL: TIntegerField
      FieldName = 'ID_PERFIL'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CdsUsuariosNUM_CHAVE: TIntegerField
      FieldName = 'NUM_CHAVE'
      ProviderFlags = [pfInUpdate]
    end
    object CdsUsuariosID_FUNC: TIntegerField
      FieldName = 'ID_FUNC'
      ProviderFlags = [pfInUpdate]
    end
    object CdsUsuariosFUNCAO: TStringField
      FieldName = 'FUNCAO'
      ProviderFlags = [pfInUpdate]
      Size = 25
    end
  end
  object QryUsuariosPerfil: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from usuarios_perfil')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 232
    Top = 232
    object QryUsuariosPerfilID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryUsuariosPerfilDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
    end
    object QryUsuariosPerfilATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object QryUsuariosPermissoes: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pIDPerfil'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from usuarios_permissoes'
      'where usuarios_permissoes.id_perfil = :pIDPerfil')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 320
    Top = 232
    object QryUsuariosPermissoesID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryUsuariosPermissoesID_PERFIL: TIntegerField
      FieldName = 'ID_PERFIL'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryUsuariosPermissoesPERMITE: TStringField
      FieldName = 'PERMITE'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object QryUsuariosPermissoesMENUITEM: TStringField
      FieldName = 'MENUITEM'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryUsuariosPermissoesDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryUsuariosPermissoesNOME_APP: TStringField
      FieldName = 'NOME_APP'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
  end
  object DspUsuariosPerrfil: TDataSetProvider
    DataSet = QryUsuariosPerfil
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspUsuariosPerrfilGetTableName
    Left = 232
    Top = 256
  end
  object CdsUsuariosPerfil: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspUsuariosPerrfil'
    OnNewRecord = CdsUsuariosPerfilNewRecord
    Left = 232
    Top = 280
    object CdsUsuariosPerfilID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsUsuariosPerfilDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
    end
    object CdsUsuariosPerfilATIVO: TStringField
      FieldName = 'ATIVO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspUsuariosPermissoes: TDataSetProvider
    DataSet = QryUsuariosPermissoes
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspUsuariosPermissoesGetTableName
    Left = 320
    Top = 256
  end
  object CdsUsuariosPermissoes: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pIDPerfil'
        ParamType = ptInput
      end>
    ProviderName = 'DspUsuariosPermissoes'
    OnNewRecord = CdsUsuariosPermissoesNewRecord
    Left = 320
    Top = 280
    object CdsUsuariosPermissoesID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsUsuariosPermissoesID_PERFIL: TIntegerField
      FieldName = 'ID_PERFIL'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CdsUsuariosPermissoesPERMITE: TStringField
      FieldName = 'PERMITE'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object CdsUsuariosPermissoesMENUITEM: TStringField
      FieldName = 'MENUITEM'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsUsuariosPermissoesDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsUsuariosPermissoesNOME_APP: TStringField
      FieldName = 'NOME_APP'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
  end
  object QryUsuariosItens: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from usuarios_itens')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 408
    Top = 232
    object QryUsuariosItensID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryUsuariosItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryUsuariosItensNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object QryUsuariosItensNOME_APP: TStringField
      FieldName = 'NOME_APP'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 30
    end
    object QryUsuariosItensNIVEL: TIntegerField
      FieldName = 'NIVEL'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
  object DspUsuariosItens: TDataSetProvider
    DataSet = QryUsuariosItens
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspUsuariosItensGetTableName
    Left = 408
    Top = 256
  end
  object CdsUsuariosItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspUsuariosItens'
    OnNewRecord = CdsUsuariosItensNewRecord
    Left = 408
    Top = 280
    object CdsUsuariosItensID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsUsuariosItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsUsuariosItensNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object CdsUsuariosItensNOME_APP: TStringField
      FieldName = 'NOME_APP'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 30
    end
    object CdsUsuariosItensNIVEL: TIntegerField
      FieldName = 'NIVEL'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
end
