inherited FrmNFCePendente: TFrmNFCePendente
  Left = 291
  Caption = 'Selecionar NFCe pendente'
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 667
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 661
    Height = 446
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 657
      Height = 429
      Align = alClient
      DataSource = DataNFCe
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyPress = DBGrid1KeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'DATA_PEDIDO'
          Title.Caption = 'Data Gerado'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_ENTREGA'
          Title.Caption = 'Data Envio'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IDCLIENTE'
          Title.Caption = 'Cliente'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLIENTE'
          Title.Caption = 'Nome do Cliente'
          Width = 319
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Caption = 'Valor Total'
          Visible = True
        end>
    end
  end
  object DataNFCe: TDataSource
    DataSet = CdsNFCe
    Left = 184
    Top = 272
  end
  object CdsNFCe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspNFCe'
    Left = 104
    Top = 264
    object CdsNFCeID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsNFCeDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
    end
    object CdsNFCeDATA_ENTREGA: TSQLTimeStampField
      FieldName = 'DATA_ENTREGA'
    end
    object CdsNFCeIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Required = True
    end
    object CdsNFCeCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 50
    end
    object CdsNFCeVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
  end
  object DspNFCe: TDataSetProvider
    DataSet = QryNFCe
    UpdateMode = upWhereKeyOnly
    Left = 184
    Top = 192
  end
  object QryNFCe: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select p.id,p.data_pedido,p.data_entrega,p.idcliente,'
      'p.cliente,p.valor_total from pedido p'
      'where p.confirmada = '#39'N'#39
      'and p.cancelado = '#39'N'#39
      'and (p.chave_nfe is null or p.chave_nfe = '#39#39')'
      'and (p.coo is null or p.coo <=0)'
      'and p.nfe_tipoemiss is null'
      'order by p.data_pedido desc')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 104
    Top = 192
    object QryNFCeID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryNFCeDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
    end
    object QryNFCeDATA_ENTREGA: TSQLTimeStampField
      FieldName = 'DATA_ENTREGA'
    end
    object QryNFCeIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Required = True
    end
    object QryNFCeCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 50
    end
    object QryNFCeVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
  end
end
