inherited FrmValorFormaPag: TFrmValorFormaPag
  Left = 286
  Top = 281
  BorderIcons = []
  Caption = 'Valor da Forma de Pagamento'
  ClientHeight = 178
  ClientWidth = 212
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 218
  ExplicitHeight = 207
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 212
    Height = 109
    Align = alClient
    Caption = ' Informe o valor '
    TabOrder = 0
    ExplicitHeight = 79
    object Label1: TLabel
      Left = 8
      Top = 86
      Width = 34
      Height = 13
      Caption = 'Troco: '
    end
    object LbTroco: TLabel
      Left = 145
      Top = 70
      Width = 56
      Height = 34
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 8
      Top = 19
      Width = 193
      Height = 45
      DataField = 'Valor'
      DataSource = DataValor
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnExit = DBEdit1Exit
      OnKeyPress = DBEdit1KeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 109
    Width = 212
    Height = 69
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 79
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 5
      Top = 4
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitLeft = 5
      ExplicitTop = 4
      inherited BtnConfirmar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnConfirmarClick
      end
      inherited BtnCancelar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnCancelarClick
      end
    end
  end
  object CdsValor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 80
    object CdsValorValor: TFloatField
      FieldName = 'Valor'
    end
  end
  object DataValor: TDataSource
    DataSet = CdsValor
    Left = 40
    Top = 88
  end
end
