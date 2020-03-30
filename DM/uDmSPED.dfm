object DmSPED: TDmSPED
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 422
  Width = 531
  object QryEmpresa: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pCdEmp'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from empresa'
      'left outer join config on empresa.id = config.id_empresa'
      'where empresa.id = :pCdEmp')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 24
    Top = 24
    object QryEmpresaID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryEmpresaRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 50
    end
    object QryEmpresaENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 30
    end
    object QryEmpresaNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object QryEmpresaCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
    end
    object QryEmpresaBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object QryEmpresaCIDADE: TStringField
      FieldName = 'CIDADE'
    end
    object QryEmpresaUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 2
    end
    object QryEmpresaCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object QryEmpresaCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object QryEmpresaINSCRICAO_RG: TStringField
      FieldName = 'INSCRICAO_RG'
    end
    object QryEmpresaTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 12
    end
    object QryEmpresaTELEFAX: TStringField
      FieldName = 'TELEFAX'
      Size = 12
    end
    object QryEmpresaCONTATO: TStringField
      FieldName = 'CONTATO'
      Size = 50
    end
    object QryEmpresaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 200
    end
    object QryEmpresaSITE: TStringField
      FieldName = 'SITE'
      Size = 200
    end
    object QryEmpresaINSC_MUNIC: TStringField
      FieldName = 'INSC_MUNIC'
    end
    object QryEmpresaFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 50
    end
    object QryEmpresaCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      Size = 8
    end
    object QryEmpresaIDCONTADOR: TIntegerField
      FieldName = 'IDCONTADOR'
    end
    object QryEmpresaCRT: TIntegerField
      FieldName = 'CRT'
      Required = True
    end
    object QryEmpresaCOD_SUFRAMA: TStringField
      FieldName = 'COD_SUFRAMA'
      Size = 9
    end
    object QryEmpresaID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA'
    end
    object QryEmpresaTIPO_EMPRESA: TIntegerField
      FieldName = 'TIPO_EMPRESA'
    end
    object QryEmpresaTIPO_BUSCA_CLIENTE: TIntegerField
      FieldName = 'TIPO_BUSCA_CLIENTE'
    end
    object QryEmpresaCONF_LANC_CAIXA: TStringField
      FieldName = 'CONF_LANC_CAIXA'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaTIPODOC_PADRAO: TIntegerField
      FieldName = 'TIPODOC_PADRAO'
    end
    object QryEmpresaEXIBIR: TIntegerField
      FieldName = 'EXIBIR'
    end
    object QryEmpresaCADASTRAR_CHEQUES: TStringField
      FieldName = 'CADASTRAR_CHEQUES'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaPATHLOGOMARCA: TStringField
      FieldName = 'PATHLOGOMARCA'
      Size = 200
    end
    object QryEmpresaTELAVENDAPADRAO: TIntegerField
      FieldName = 'TELAVENDAPADRAO'
    end
    object QryEmpresaCLIENTE_PADRAO: TIntegerField
      FieldName = 'CLIENTE_PADRAO'
    end
    object QryEmpresaVENDEDOR_PADRAO: TIntegerField
      FieldName = 'VENDEDOR_PADRAO'
    end
    object QryEmpresaCLASSIFICA_PADRAO: TIntegerField
      FieldName = 'CLASSIFICA_PADRAO'
    end
    object QryEmpresaFORMAPAG_PADRAO: TIntegerField
      FieldName = 'FORMAPAG_PADRAO'
    end
    object QryEmpresaINDICE_TIJOLO: TFloatField
      FieldName = 'INDICE_TIJOLO'
    end
    object QryEmpresaINDICE_ISOPOR: TFloatField
      FieldName = 'INDICE_ISOPOR'
    end
    object QryEmpresaGRUPO_PADRAO: TIntegerField
      FieldName = 'GRUPO_PADRAO'
    end
    object QryEmpresaTIPO_COMISSAO: TIntegerField
      FieldName = 'TIPO_COMISSAO'
    end
    object QryEmpresaINDICE_OUTROS: TFloatField
      FieldName = 'INDICE_OUTROS'
    end
    object QryEmpresaMARGEM_LUCRO: TFloatField
      FieldName = 'MARGEM_LUCRO'
    end
    object QryEmpresaTIPO_CALC_PERC: TIntegerField
      FieldName = 'TIPO_CALC_PERC'
    end
    object QryEmpresaESTOQUE_NEGATICO: TStringField
      FieldName = 'ESTOQUE_NEGATICO'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaPERMITIRVALORNEGATIVO: TStringField
      FieldName = 'PERMITIRVALORNEGATIVO'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaNUMPED_SEQ: TStringField
      FieldName = 'NUMPED_SEQ'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOMISSAO_INTEGRAL_SEG: TStringField
      FieldName = 'COMISSAO_INTEGRAL_SEG'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOMISSAO_INTEGRAL_TER: TStringField
      FieldName = 'COMISSAO_INTEGRAL_TER'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOMISSAO_INTEGRAL_QUA: TStringField
      FieldName = 'COMISSAO_INTEGRAL_QUA'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOMISSAO_INTEGRAL_QUI: TStringField
      FieldName = 'COMISSAO_INTEGRAL_QUI'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOMISSAO_INTEGRAL_SEX: TStringField
      FieldName = 'COMISSAO_INTEGRAL_SEX'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOMISSAO_INTEGRAL_SAB: TStringField
      FieldName = 'COMISSAO_INTEGRAL_SAB'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOMISSAO_INTEGRAL_DOM: TStringField
      FieldName = 'COMISSAO_INTEGRAL_DOM'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaATUALIZAR_PRECO: TStringField
      FieldName = 'ATUALIZAR_PRECO'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCONTROLAR_ESTCOMP: TStringField
      FieldName = 'CONTROLAR_ESTCOMP'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaVERSAO_LAYOUT: TStringField
      FieldName = 'VERSAO_LAYOUT'
      Size = 3
    end
    object QryEmpresaPERFIL_APRESENTA: TStringField
      FieldName = 'PERFIL_APRESENTA'
      Size = 1
    end
    object QryEmpresaINDICADOR_ATV: TIntegerField
      FieldName = 'INDICADOR_ATV'
    end
    object QryEmpresaCOD_PAIS: TStringField
      FieldName = 'COD_PAIS'
      Size = 5
    end
    object QryEmpresaDIAS_AGENDA: TIntegerField
      FieldName = 'DIAS_AGENDA'
    end
    object QryEmpresaMODELO_PEDIDO: TIntegerField
      FieldName = 'MODELO_PEDIDO'
    end
    object QryEmpresaPED_EDITAR_CLI: TStringField
      FieldName = 'PED_EDITAR_CLI'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaEXIBE_IMPOSTO: TStringField
      FieldName = 'EXIBE_IMPOSTO'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaIMPOSTO_MENSAGEM: TStringField
      FieldName = 'IMPOSTO_MENSAGEM'
      FixedChar = True
      Size = 1
    end
    object QryEmpresaCOD_RECEITA: TStringField
      FieldName = 'COD_RECEITA'
      Size = 8
    end
  end
  object DspEmpresa: TDataSetProvider
    DataSet = QryEmpresa
    UpdateMode = upWhereKeyOnly
    Left = 24
    Top = 40
  end
  object CdsEmpresa: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pCdEmp'
        ParamType = ptInput
      end>
    ProviderName = 'DspEmpresa'
    Left = 24
    Top = 56
    object CdsEmpresaID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsEmpresaRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 50
    end
    object CdsEmpresaENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 30
    end
    object CdsEmpresaNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object CdsEmpresaCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
    end
    object CdsEmpresaBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object CdsEmpresaCIDADE: TStringField
      FieldName = 'CIDADE'
    end
    object CdsEmpresaUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 2
    end
    object CdsEmpresaCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object CdsEmpresaCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object CdsEmpresaINSCRICAO_RG: TStringField
      FieldName = 'INSCRICAO_RG'
    end
    object CdsEmpresaTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 12
    end
    object CdsEmpresaTELEFAX: TStringField
      FieldName = 'TELEFAX'
      Size = 12
    end
    object CdsEmpresaCONTATO: TStringField
      FieldName = 'CONTATO'
      Size = 50
    end
    object CdsEmpresaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 200
    end
    object CdsEmpresaSITE: TStringField
      FieldName = 'SITE'
      Size = 200
    end
    object CdsEmpresaINSC_MUNIC: TStringField
      FieldName = 'INSC_MUNIC'
    end
    object CdsEmpresaFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 50
    end
    object CdsEmpresaCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      Size = 8
    end
    object CdsEmpresaIDCONTADOR: TIntegerField
      FieldName = 'IDCONTADOR'
    end
    object CdsEmpresaCRT: TIntegerField
      FieldName = 'CRT'
      Required = True
    end
    object CdsEmpresaCOD_SUFRAMA: TStringField
      FieldName = 'COD_SUFRAMA'
      Size = 9
    end
    object CdsEmpresaID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA'
    end
    object CdsEmpresaTIPO_EMPRESA: TIntegerField
      FieldName = 'TIPO_EMPRESA'
    end
    object CdsEmpresaTIPO_BUSCA_CLIENTE: TIntegerField
      FieldName = 'TIPO_BUSCA_CLIENTE'
    end
    object CdsEmpresaCONF_LANC_CAIXA: TStringField
      FieldName = 'CONF_LANC_CAIXA'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaTIPODOC_PADRAO: TIntegerField
      FieldName = 'TIPODOC_PADRAO'
    end
    object CdsEmpresaEXIBIR: TIntegerField
      FieldName = 'EXIBIR'
    end
    object CdsEmpresaCADASTRAR_CHEQUES: TStringField
      FieldName = 'CADASTRAR_CHEQUES'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaPATHLOGOMARCA: TStringField
      FieldName = 'PATHLOGOMARCA'
      Size = 200
    end
    object CdsEmpresaTELAVENDAPADRAO: TIntegerField
      FieldName = 'TELAVENDAPADRAO'
    end
    object CdsEmpresaCLIENTE_PADRAO: TIntegerField
      FieldName = 'CLIENTE_PADRAO'
    end
    object CdsEmpresaVENDEDOR_PADRAO: TIntegerField
      FieldName = 'VENDEDOR_PADRAO'
    end
    object CdsEmpresaCLASSIFICA_PADRAO: TIntegerField
      FieldName = 'CLASSIFICA_PADRAO'
    end
    object CdsEmpresaFORMAPAG_PADRAO: TIntegerField
      FieldName = 'FORMAPAG_PADRAO'
    end
    object CdsEmpresaINDICE_TIJOLO: TFloatField
      FieldName = 'INDICE_TIJOLO'
    end
    object CdsEmpresaINDICE_ISOPOR: TFloatField
      FieldName = 'INDICE_ISOPOR'
    end
    object CdsEmpresaGRUPO_PADRAO: TIntegerField
      FieldName = 'GRUPO_PADRAO'
    end
    object CdsEmpresaTIPO_COMISSAO: TIntegerField
      FieldName = 'TIPO_COMISSAO'
    end
    object CdsEmpresaINDICE_OUTROS: TFloatField
      FieldName = 'INDICE_OUTROS'
    end
    object CdsEmpresaMARGEM_LUCRO: TFloatField
      FieldName = 'MARGEM_LUCRO'
    end
    object CdsEmpresaTIPO_CALC_PERC: TIntegerField
      FieldName = 'TIPO_CALC_PERC'
    end
    object CdsEmpresaESTOQUE_NEGATICO: TStringField
      FieldName = 'ESTOQUE_NEGATICO'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaPERMITIRVALORNEGATIVO: TStringField
      FieldName = 'PERMITIRVALORNEGATIVO'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaNUMPED_SEQ: TStringField
      FieldName = 'NUMPED_SEQ'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOMISSAO_INTEGRAL_SEG: TStringField
      FieldName = 'COMISSAO_INTEGRAL_SEG'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOMISSAO_INTEGRAL_TER: TStringField
      FieldName = 'COMISSAO_INTEGRAL_TER'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOMISSAO_INTEGRAL_QUA: TStringField
      FieldName = 'COMISSAO_INTEGRAL_QUA'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOMISSAO_INTEGRAL_QUI: TStringField
      FieldName = 'COMISSAO_INTEGRAL_QUI'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOMISSAO_INTEGRAL_SEX: TStringField
      FieldName = 'COMISSAO_INTEGRAL_SEX'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOMISSAO_INTEGRAL_SAB: TStringField
      FieldName = 'COMISSAO_INTEGRAL_SAB'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOMISSAO_INTEGRAL_DOM: TStringField
      FieldName = 'COMISSAO_INTEGRAL_DOM'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaATUALIZAR_PRECO: TStringField
      FieldName = 'ATUALIZAR_PRECO'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCONTROLAR_ESTCOMP: TStringField
      FieldName = 'CONTROLAR_ESTCOMP'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaVERSAO_LAYOUT: TStringField
      FieldName = 'VERSAO_LAYOUT'
      Size = 3
    end
    object CdsEmpresaPERFIL_APRESENTA: TStringField
      FieldName = 'PERFIL_APRESENTA'
      Size = 1
    end
    object CdsEmpresaINDICADOR_ATV: TIntegerField
      FieldName = 'INDICADOR_ATV'
    end
    object CdsEmpresaCOD_PAIS: TStringField
      FieldName = 'COD_PAIS'
      Size = 5
    end
    object CdsEmpresaDIAS_AGENDA: TIntegerField
      FieldName = 'DIAS_AGENDA'
    end
    object CdsEmpresaMODELO_PEDIDO: TIntegerField
      FieldName = 'MODELO_PEDIDO'
    end
    object CdsEmpresaPED_EDITAR_CLI: TStringField
      FieldName = 'PED_EDITAR_CLI'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaEXIBE_IMPOSTO: TStringField
      FieldName = 'EXIBE_IMPOSTO'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaIMPOSTO_MENSAGEM: TStringField
      FieldName = 'IMPOSTO_MENSAGEM'
      FixedChar = True
      Size = 1
    end
    object CdsEmpresaCOD_RECEITA: TStringField
      FieldName = 'COD_RECEITA'
      Size = 8
    end
  end
  object QryContador: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pCodigo'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from contador'
      'where contador.id = :pCodigo')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 96
    Top = 24
    object QryContadorID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryContadorCONTABILIDADE: TStringField
      FieldName = 'CONTABILIDADE'
      Size = 200
    end
    object QryContadorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 300
    end
    object QryContadorEND_NUM: TStringField
      FieldName = 'END_NUM'
    end
    object QryContadorEND_COMPL: TStringField
      FieldName = 'END_COMPL'
      Size = 200
    end
    object QryContadorBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 200
    end
    object QryContadorCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 200
    end
    object QryContadorUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object QryContadorCEP: TStringField
      FieldName = 'CEP'
    end
    object QryContadorCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      Size = 7
    end
    object QryContadorCNPJ: TStringField
      FieldName = 'CNPJ'
    end
    object QryContadorREGISTRO: TStringField
      FieldName = 'REGISTRO'
      Size = 4
    end
    object QryContadorCONTADOR: TStringField
      FieldName = 'CONTADOR'
      Size = 200
    end
    object QryContadorFONE: TStringField
      FieldName = 'FONE'
      Size = 15
    end
    object QryContadorFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object QryContadorCPF_CONTADOR: TStringField
      FieldName = 'CPF_CONTADOR'
    end
    object QryContadorCRC_CONTADOR: TStringField
      FieldName = 'CRC_CONTADOR'
      Size = 15
    end
    object QryContadorEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 200
    end
    object QryContadorSITE: TStringField
      FieldName = 'SITE'
      Size = 200
    end
  end
  object DspContador: TDataSetProvider
    DataSet = QryContador
    UpdateMode = upWhereKeyOnly
    Left = 96
    Top = 40
  end
  object CdsContabil: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pCodigo'
        ParamType = ptInput
      end>
    ProviderName = 'DspContador'
    Left = 96
    Top = 56
    object CdsContabilID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsContabilCONTABILIDADE: TStringField
      FieldName = 'CONTABILIDADE'
      Size = 200
    end
    object CdsContabilENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 300
    end
    object CdsContabilEND_NUM: TStringField
      FieldName = 'END_NUM'
    end
    object CdsContabilEND_COMPL: TStringField
      FieldName = 'END_COMPL'
      Size = 200
    end
    object CdsContabilBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 200
    end
    object CdsContabilCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 200
    end
    object CdsContabilUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object CdsContabilCEP: TStringField
      FieldName = 'CEP'
    end
    object CdsContabilCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      Size = 7
    end
    object CdsContabilCNPJ: TStringField
      FieldName = 'CNPJ'
    end
    object CdsContabilREGISTRO: TStringField
      FieldName = 'REGISTRO'
      Size = 4
    end
    object CdsContabilCONTADOR: TStringField
      FieldName = 'CONTADOR'
      Size = 200
    end
    object CdsContabilFONE: TStringField
      FieldName = 'FONE'
      Size = 15
    end
    object CdsContabilFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object CdsContabilCPF_CONTADOR: TStringField
      FieldName = 'CPF_CONTADOR'
    end
    object CdsContabilCRC_CONTADOR: TStringField
      FieldName = 'CRC_CONTADOR'
      Size = 15
    end
    object CdsContabilEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 200
    end
    object CdsContabilSITE: TStringField
      FieldName = 'SITE'
      Size = 200
    end
  end
  object QryClientes: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'pDatai'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'pDataf'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pEmpresa'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select c.id,c.nome,c.cnpj_cpf,c.insc_rg,c.codcidade,'
      
        'c.endereco,c.num_end,c.bairro_end,c.uf_end,p.status_nfe from ped' +
        'ido p'
      'left outer join contato c on c.id = p.idcliente'
      'where p.data_entrega between :pDatai and :pDataf'
      'and p.status_nfe = '#39'100'#39
      'and p.cancelado = '#39'N'#39
      'and p.idempresa = :pEmpresa'
      'and p.numero_doc is not null'
      'group by c.id,c.nome,c.cnpj_cpf,c.insc_rg,c.codcidade,'
      'c.endereco,c.num_end,c.bairro_end,c.uf_end,p.status_nfe')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 168
    Top = 24
    object QryClientesID: TIntegerField
      FieldName = 'ID'
    end
    object QryClientesNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object QryClientesCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object QryClientesINSC_RG: TStringField
      FieldName = 'INSC_RG'
    end
    object QryClientesCODCIDADE: TStringField
      FieldName = 'CODCIDADE'
      Size = 7
    end
    object QryClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 30
    end
    object QryClientesNUM_END: TStringField
      FieldName = 'NUM_END'
      Size = 10
    end
    object QryClientesBAIRRO_END: TStringField
      FieldName = 'BAIRRO_END'
    end
    object QryClientesUF_END: TStringField
      FieldName = 'UF_END'
      FixedChar = True
      Size = 2
    end
    object QryClientesSTATUS_NFE: TStringField
      FieldName = 'STATUS_NFE'
      FixedChar = True
      Size = 3
    end
  end
  object DspClientes: TDataSetProvider
    DataSet = QryClientes
    UpdateMode = upWhereKeyOnly
    Left = 168
    Top = 40
  end
  object CdsClientes: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'pDatai'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'pDataf'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pEmpresa'
        ParamType = ptInput
      end>
    ProviderName = 'DspClientes'
    Left = 168
    Top = 56
    object CdsClientesID: TIntegerField
      FieldName = 'ID'
    end
    object CdsClientesNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object CdsClientesCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object CdsClientesINSC_RG: TStringField
      FieldName = 'INSC_RG'
    end
    object CdsClientesCODCIDADE: TStringField
      FieldName = 'CODCIDADE'
      Size = 7
    end
    object CdsClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 30
    end
    object CdsClientesNUM_END: TStringField
      FieldName = 'NUM_END'
      Size = 10
    end
    object CdsClientesBAIRRO_END: TStringField
      FieldName = 'BAIRRO_END'
    end
    object CdsClientesUF_END: TStringField
      FieldName = 'UF_END'
      FixedChar = True
      Size = 2
    end
    object CdsClientesSTATUS_NFE: TStringField
      FieldName = 'STATUS_NFE'
      FixedChar = True
      Size = 3
    end
  end
  object QryFornecedor: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'pDatai'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'pDataf'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pEmpresa'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select c.id,c.nome,c.cnpj_cpf,c.insc_rg,c.codcidade,'
      
        'c.endereco,c.num_end,c.bairro_end,c.uf_end,cr.status_nfe from co' +
        'mpras cr'
      'left outer join contato c on c.id = cr.idfornecedor'
      'where cr.data_emissao between :pDatai and :pDataf'
      'and (cr.status_nfe = '#39'100'#39' or cr.status_nfe is null)'
      'and cr.cancelado = '#39'N'#39
      'and cr.idempresa = :pEmpresa'
      'and cr.nota is not null'
      'group by c.id,c.nome,c.cnpj_cpf,c.insc_rg,c.codcidade,'
      'c.endereco,c.num_end,c.bairro_end,c.uf_end,cr.status_nfe')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 240
    Top = 24
    object QryFornecedorID: TIntegerField
      FieldName = 'ID'
    end
    object QryFornecedorNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object QryFornecedorCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object QryFornecedorINSC_RG: TStringField
      FieldName = 'INSC_RG'
    end
    object QryFornecedorCODCIDADE: TStringField
      FieldName = 'CODCIDADE'
      Size = 7
    end
    object QryFornecedorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 30
    end
    object QryFornecedorNUM_END: TStringField
      FieldName = 'NUM_END'
      Size = 10
    end
    object QryFornecedorBAIRRO_END: TStringField
      FieldName = 'BAIRRO_END'
    end
    object QryFornecedorUF_END: TStringField
      FieldName = 'UF_END'
      FixedChar = True
      Size = 2
    end
    object QryFornecedorSTATUS_NFE: TStringField
      FieldName = 'STATUS_NFE'
      FixedChar = True
      Size = 3
    end
  end
  object DspFornecedor: TDataSetProvider
    DataSet = QryFornecedor
    UpdateMode = upWhereKeyOnly
    Left = 240
    Top = 40
  end
  object CdsFornecedor: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'pDatai'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'pDataf'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pEmpresa'
        ParamType = ptInput
      end>
    ProviderName = 'DspFornecedor'
    Left = 240
    Top = 56
    object CdsFornecedorID: TIntegerField
      FieldName = 'ID'
    end
    object CdsFornecedorNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object CdsFornecedorCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object CdsFornecedorINSC_RG: TStringField
      FieldName = 'INSC_RG'
    end
    object CdsFornecedorCODCIDADE: TStringField
      FieldName = 'CODCIDADE'
      Size = 7
    end
    object CdsFornecedorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 30
    end
    object CdsFornecedorNUM_END: TStringField
      FieldName = 'NUM_END'
      Size = 10
    end
    object CdsFornecedorBAIRRO_END: TStringField
      FieldName = 'BAIRRO_END'
    end
    object CdsFornecedorUF_END: TStringField
      FieldName = 'UF_END'
      FixedChar = True
      Size = 2
    end
    object CdsFornecedorSTATUS_NFE: TStringField
      FieldName = 'STATUS_NFE'
      FixedChar = True
      Size = 3
    end
  end
end
