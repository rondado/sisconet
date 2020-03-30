inherited FrmConfigPosto: TFrmConfigPosto
  Left = 268
  Top = 138
  Caption = 'Configura'#231#245'es de Posto'
  ClientHeight = 356
  ClientWidth = 344
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 344
    Height = 289
    Align = alClient
    TabOrder = 0
    object GrpCompanytech: TGroupBox
      Left = 8
      Top = 56
      Width = 161
      Height = 225
      Caption = ' CompanyTech '
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 49
        Height = 13
        Caption = 'Porta CBC'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 8
        Top = 56
        Width = 34
        Height = 13
        Caption = 'IP CBC'
        FocusControl = DBEdit2
      end
      object Label3: TLabel
        Left = 8
        Top = 96
        Width = 45
        Height = 13
        Caption = 'Tipo CBC'
        FocusControl = DBEdit3
      end
      object Label4: TLabel
        Left = 8
        Top = 136
        Width = 74
        Height = 13
        Caption = 'PORTA IP CBC'
        FocusControl = DBEdit4
      end
      object Label5: TLabel
        Left = 8
        Top = 176
        Width = 82
        Height = 13
        Caption = 'CBC Identificador'
        FocusControl = DBEdit5
      end
      object DBEdit1: TDBEdit
        Left = 8
        Top = 32
        Width = 134
        Height = 21
        DataField = 'PORTA_CBC'
        DataSource = DataConfig
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 8
        Top = 72
        Width = 134
        Height = 21
        DataField = 'IP_CBC'
        DataSource = DataConfig
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 8
        Top = 112
        Width = 134
        Height = 21
        DataField = 'TIPO_CBC'
        DataSource = DataConfig
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 8
        Top = 152
        Width = 134
        Height = 21
        DataField = 'PORTA_IP_CBC'
        DataSource = DataConfig
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 8
        Top = 192
        Width = 17
        Height = 21
        DataField = 'CBC_IDENTIFICADOR'
        DataSource = DataConfig
        TabOrder = 4
      end
    end
    object GrpSoftPlus: TGroupBox
      Left = 173
      Top = 56
      Width = 161
      Height = 225
      Caption = ' SoftPlus '
      TabOrder = 1
      object Label6: TLabel
        Left = 8
        Top = 16
        Width = 26
        Height = 13
        Caption = 'Serial'
        FocusControl = DBEdit6
      end
      object Label7: TLabel
        Left = 8
        Top = 56
        Width = 34
        Height = 13
        Caption = 'LAN IP'
        FocusControl = DBEdit7
      end
      object Label8: TLabel
        Left = 8
        Top = 96
        Width = 22
        Height = 13
        Caption = 'Host'
        FocusControl = DBEdit8
      end
      object DBEdit6: TDBEdit
        Left = 8
        Top = 32
        Width = 134
        Height = 21
        DataField = 'SPI_SERIAL'
        DataSource = DataConfig
        TabOrder = 0
      end
      object DBEdit7: TDBEdit
        Left = 8
        Top = 72
        Width = 134
        Height = 21
        DataField = 'SPI_IP'
        DataSource = DataConfig
        TabOrder = 1
      end
      object DBEdit8: TDBEdit
        Left = 8
        Top = 112
        Width = 134
        Height = 21
        DataField = 'SPI_HOST'
        DataSource = DataConfig
        TabOrder = 2
      end
    end
    object RdConcentrador: TDBRadioGroup
      Left = 8
      Top = 12
      Width = 326
      Height = 41
      Caption = ' Concentrador '
      Columns = 2
      DataField = 'CONCENTRADOR'
      DataSource = DataConfig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Items.Strings = (
        '0 - CompanyTech'
        '1 - SoftPlus')
      ParentFont = False
      TabOrder = 2
      Values.Strings = (
        '0'
        '1')
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 289
    Width = 344
    Height = 67
    Align = alBottom
    TabOrder = 1
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 70
      Top = 3
      Width = 203
      Height = 62
      TabOrder = 0
      inherited BtnConfirmar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnConfirmarClick
      end
      inherited BtnCancelar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnCancelarClick
      end
    end
  end
  object DataConfig: TDataSource
    Left = 200
    Top = 280
  end
end
