inherited FrmMunicipio: TFrmMunicipio
  Left = 305
  Top = 168
  Caption = 'Localizar C'#243'digo do Munic'#237'pio'
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 661
    Height = 47
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 19
      Width = 17
      Height = 13
      Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 104
      Top = 19
      Width = 40
      Height = 13
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboUF: TDBLookupComboBox
      Left = 31
      Top = 15
      Width = 48
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      KeyField = 'UF'
      ListField = 'UF'
      ListSource = DataUF
      ParentFont = False
      TabOrder = 0
      OnKeyPress = ComboUFKeyPress
    end
    object EdtCidade: TEdit
      Left = 147
      Top = 15
      Width = 374
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnExit = EdtCidadeExit
      OnKeyPress = ComboUFKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 47
    Width = 661
    Height = 399
    Align = alClient
    TabOrder = 1
    object GridCidade: TDBGrid
      Left = 2
      Top = 15
      Width = 657
      Height = 382
      Align = alClient
      DataSource = DataCidades
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = GridCidadeDblClick
      OnKeyPress = GridCidadeKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_UF'
          Title.Caption = 'Cod.UF'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_MUNICIPIO'
          Title.Caption = 'Cod.Munic.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Title.Caption = 'Nome UF'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 166
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MUNICIPIO'
          Title.Caption = 'Munic'#237'pio'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 285
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF_SIGLA'
          Title.Caption = 'UF'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
  end
  object DataUF: TDataSource
    DataSet = DmClientes.CdsUF
    Left = 80
    Top = 88
  end
  object DataCidades: TDataSource
    DataSet = CdsCidades
    Left = 208
    Top = 151
  end
  object DspCidades: TDataSetProvider
    DataSet = QryCidades
    UpdateMode = upWhereKeyOnly
    Left = 208
    Top = 95
  end
  object CdsCidades: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspCidades'
    Left = 288
    Top = 151
    object CdsCidadesCOD_UF: TStringField
      FieldName = 'COD_UF'
      Required = True
      FixedChar = True
      Size = 2
    end
    object CdsCidadesCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      Required = True
      FixedChar = True
      Size = 5
    end
    object CdsCidadesUF: TStringField
      FieldName = 'UF'
      Required = True
    end
    object CdsCidadesMUNICIPIO: TStringField
      FieldName = 'MUNICIPIO'
      Required = True
      Size = 50
    end
    object CdsCidadesUF_SIGLA: TStringField
      FieldName = 'UF_SIGLA'
      FixedChar = True
      Size = 2
    end
  end
  object QryCidades: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from cod_mun_ibge c'
      'where -1>0')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 288
    Top = 95
    object QryCidadesCOD_UF: TStringField
      FieldName = 'COD_UF'
      Required = True
      FixedChar = True
      Size = 2
    end
    object QryCidadesCOD_MUNICIPIO: TStringField
      FieldName = 'COD_MUNICIPIO'
      Required = True
      FixedChar = True
      Size = 5
    end
    object QryCidadesUF: TStringField
      FieldName = 'UF'
      Required = True
    end
    object QryCidadesMUNICIPIO: TStringField
      FieldName = 'MUNICIPIO'
      Required = True
      Size = 50
    end
    object QryCidadesUF_SIGLA: TStringField
      FieldName = 'UF_SIGLA'
      FixedChar = True
      Size = 2
    end
  end
end
