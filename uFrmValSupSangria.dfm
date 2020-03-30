inherited FrmValSupSangria: TFrmValSupSangria
  Left = 270
  Top = 161
  Caption = 'Movimento Caixa'
  ClientHeight = 204
  ClientWidth = 282
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 138
    Width = 282
    Height = 66
    Align = alBottom
    TabOrder = 0
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 42
      Top = 2
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 282
    Height = 138
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 256
      Height = 37
      Caption = 'Valor Movimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 18
      Top = 53
      Width = 250
      Height = 45
      DataField = 'VALOR'
      DataSource = DataValor
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object CdsValor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 104
    object CdsValorVALOR: TFloatField
      FieldName = 'VALOR'
    end
  end
  object DataValor: TDataSource
    DataSet = CdsValor
    Left = 184
    Top = 104
  end
  object ActionList1: TActionList
    Left = 176
    Top = 72
    object ActMenuFiscal: TAction
      Caption = 'ActMenuFiscal'
      ShortCut = 49229
      OnExecute = ActMenuFiscalExecute
    end
  end
end
