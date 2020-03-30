inherited FrmListaContigencia: TFrmListaContigencia
  Left = 253
  Top = 122
  Caption = 'Lista NFCe em Contigencia'
  ClientHeight = 488
  ClientWidth = 818
  OnShow = FormShow
  ExplicitWidth = 824
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 818
    Height = 445
    Align = alClient
    DataSource = DataNFCe
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyPress = DBGrid1KeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Caption = 'C'#243'digo'
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
        Title.Caption = 'Chave NFCe'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_ENTREGA'
        Title.Caption = 'Data Emiss'#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 99
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 445
    Width = 818
    Height = 43
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 133
      Height = 29
      Action = ActEnviar
      Caption = 'Alt+F - Enviar NFCe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 144
      Top = 8
      Width = 166
      Height = 29
      Action = ActAjustar
      Caption = 'F5 - Ajustar Dados NFCe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 707
      Top = 8
      Width = 101
      Height = 29
      Action = ActFechar
      Caption = 'Alt+S - Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object MemoXML: TMemo
    Left = 848
    Top = 192
    Width = 185
    Height = 89
    Lines.Strings = (
      'MemoXML')
    TabOrder = 2
    Visible = False
  end
  object PnAjustes: TPanel
    Left = 192
    Top = 112
    Width = 425
    Height = 257
    BevelInner = bvRaised
    BevelWidth = 3
    Color = clActiveBorder
    TabOrder = 3
    Visible = False
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 88
      Height = 16
      Caption = 'Procolo NFe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 72
      Width = 94
      Height = 16
      Caption = 'N'#186' do Recibo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdtProtocolo: TEdit
      Left = 24
      Top = 40
      Width = 382
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 100
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EdtProtocoloKeyPress
    end
    object EdtRecibo: TEdit
      Left = 24
      Top = 88
      Width = 382
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 100
      ParentFont = False
      TabOrder = 1
      OnKeyPress = EdtProtocoloKeyPress
    end
    object RdTipoEmiss: TRadioGroup
      Left = 24
      Top = 120
      Width = 385
      Height = 76
      Caption = ' Tipo de Emiss'#227'o '
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Normal'
        'Conting'#234'ncia'
        'SCAN'
        'DPEC'
        'FSDA'
        'SVCAN'
        'SVCRS'
        'SVCSP'
        'OffLine')
      ParentFont = False
      TabOrder = 2
    end
    object BitBtn4: TBitBtn
      Left = 51
      Top = 210
      Width = 163
      Height = 31
      Caption = 'Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      Left = 215
      Top = 210
      Width = 163
      Height = 31
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333FFF33FF333FFF339993370733
        999333777FF37FF377733339993000399933333777F777F77733333399970799
        93333333777F7377733333333999399933333333377737773333333333990993
        3333333333737F73333333333331013333333333333777FF3333333333910193
        333333333337773FF3333333399000993333333337377737FF33333399900099
        93333333773777377FF333399930003999333337773777F777FF339993370733
        9993337773337333777333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtn5Click
    end
  end
  object QryNFCe: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select p.id,p.chave_nfe,p.data_entrega,p.hora_entrega,'
      '       p.data_pedido,p.hora_pedido,p.nfe_tipoemiss'
      'from pedido p'
      'where p.nfe_tipoemiss <> 1'
      'and (p.chave_nfe is not null or p.chave_nfe <> '#39#39')'
      'order by id desc')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 88
    Top = 136
    object QryNFCeID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryNFCeCHAVE_NFE: TStringField
      FieldName = 'CHAVE_NFE'
      Size = 100
    end
    object QryNFCeDATA_ENTREGA: TSQLTimeStampField
      FieldName = 'DATA_ENTREGA'
    end
    object QryNFCeHORA_ENTREGA: TSQLTimeStampField
      FieldName = 'HORA_ENTREGA'
    end
    object QryNFCeDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
    end
    object QryNFCeHORA_PEDIDO: TSQLTimeStampField
      FieldName = 'HORA_PEDIDO'
    end
    object QryNFCeNFE_TIPOEMISS: TIntegerField
      FieldName = 'NFE_TIPOEMISS'
    end
  end
  object DspNFCe: TDataSetProvider
    DataSet = QryNFCe
    Left = 88
    Top = 200
  end
  object CdsNFCe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspNFCe'
    Left = 24
    Top = 136
    object CdsNFCeID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsNFCeCHAVE_NFE: TStringField
      FieldName = 'CHAVE_NFE'
      Size = 100
    end
    object CdsNFCeDATA_ENTREGA: TSQLTimeStampField
      FieldName = 'DATA_ENTREGA'
    end
    object CdsNFCeHORA_ENTREGA: TSQLTimeStampField
      FieldName = 'HORA_ENTREGA'
    end
    object CdsNFCeDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
    end
    object CdsNFCeHORA_PEDIDO: TSQLTimeStampField
      FieldName = 'HORA_PEDIDO'
    end
    object CdsNFCeNFE_TIPOEMISS: TIntegerField
      FieldName = 'NFE_TIPOEMISS'
    end
  end
  object DataNFCe: TDataSource
    DataSet = CdsNFCe
    Left = 24
    Top = 200
  end
  object ActionList1: TActionList
    Left = 128
    Top = 80
    object ActEnviar: TAction
      Caption = 'Alt+F - Enviar NFCe'
      ShortCut = 32838
      OnExecute = ActEnviarExecute
    end
    object ActAjustar: TAction
      Caption = 'F5 - Ajustar Dados NFCe'
      ShortCut = 116
      OnExecute = ActAjustarExecute
    end
    object ActFechar: TAction
      Caption = 'Alt+S - Fechar'
      ShortCut = 32851
      OnExecute = ActFecharExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos XML|*.xml|Todos os Arquivos|*.*'
    Left = 136
    Top = 264
  end
end
