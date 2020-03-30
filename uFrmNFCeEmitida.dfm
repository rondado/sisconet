inherited FrmNFCeEmitida: TFrmNFCeEmitida
  Left = 247
  Top = 116
  Caption = 'Selecionar NFCe emitida'
  ClientHeight = 466
  ClientWidth = 798
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 804
  ExplicitHeight = 495
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 798
    Height = 466
    Align = alClient
    TabOrder = 0
    object GridNFe: TDBGrid
      Left = 2
      Top = 15
      Width = 794
      Height = 449
      Align = alClient
      DataSource = DataNFCe
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridNFeDrawColumnCell
      OnDblClick = GridNFeDblClick
      OnKeyPress = GridNFeKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'DATA_PEDIDO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Caption = 'Data Gerado'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_ENTREGA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Caption = 'Data Envio'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IDCLIENTE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Caption = 'Cliente'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLIENTE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Caption = 'Nome do Cliente'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 290
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Caption = 'Valor Total'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS_NFE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Caption = 'Status'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHAVE_NFE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Caption = 'Chave NFCe'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
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
    object CdsNFCeCHAVE_NFE: TStringField
      FieldName = 'CHAVE_NFE'
      Size = 100
    end
    object CdsNFCeSTATUS_NFE: TStringField
      FieldName = 'STATUS_NFE'
      FixedChar = True
      Size = 3
    end
    object CdsNFCeCANCELADO: TStringField
      FieldName = 'CANCELADO'
      FixedChar = True
      Size = 1
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
      'p.cliente,p.valor_total,p.chave_nfe,p.status_nfe,'
      'p.cancelado from pedido p'
      'where p.data_entrega = current_date'
      'and p.confirmada = '#39'S'#39
      'and (p.chave_nfe is not null or p.chave_nfe <> '#39#39')'
      'and (p.coo is null or p.coo <=0)'
      'order by p.data_entrega desc')
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
    object QryNFCeCHAVE_NFE: TStringField
      FieldName = 'CHAVE_NFE'
      Size = 100
    end
    object QryNFCeSTATUS_NFE: TStringField
      FieldName = 'STATUS_NFE'
      FixedChar = True
      Size = 3
    end
    object QryNFCeCANCELADO: TStringField
      FieldName = 'CANCELADO'
      FixedChar = True
      Size = 1
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 512
    Top = 168
    object CancelaPedido1: TMenuItem
      Caption = 'Cancela Pedido'
      OnClick = CancelaPedido1Click
    end
  end
end
