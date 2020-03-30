inherited FrmMovCaixa: TFrmMovCaixa
  Left = 345
  Top = 253
  Caption = 'Movimento de caixa'
  ClientHeight = 266
  ClientWidth = 449
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 185
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Hist'#243'rico'
      FocusControl = DbHistorico
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 33
      Height = 13
      Caption = 'Origem'
      FocusControl = DbOrigem
    end
    object Label4: TLabel
      Left = 8
      Top = 96
      Width = 24
      Height = 13
      Caption = 'Valor'
      FocusControl = DbValor
    end
    object DbHistorico: TDBEdit
      Left = 8
      Top = 32
      Width = 357
      Height = 21
      DataField = 'HISTORICO'
      DataSource = DataCaixaMov
      TabOrder = 0
      OnKeyPress = DbHistoricoKeyPress
    end
    object DbOrigem: TDBEdit
      Left = 8
      Top = 72
      Width = 264
      Height = 21
      DataField = 'ORIGEM'
      DataSource = DataCaixaMov
      TabOrder = 1
      OnKeyPress = DbHistoricoKeyPress
    end
    object DbValor: TDBEdit
      Left = 8
      Top = 112
      Width = 81
      Height = 21
      DataField = 'VALOR'
      DataSource = DataCaixaMov
      TabOrder = 2
      OnKeyPress = DbHistoricoKeyPress
    end
    object RadioDC: TDBRadioGroup
      Left = 8
      Top = 136
      Width = 185
      Height = 32
      Columns = 2
      DataField = 'DC'
      DataSource = DataCaixaMov
      Items.Strings = (
        'Saida'
        'Entrada')
      TabOrder = 3
      Values.Strings = (
        'D'
        'C')
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 199
    Width = 449
    Height = 67
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 119
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
  object DataCaixaMov: TDataSource
    DataSet = DmWorkCom.CdsCaixaMov
    Left = 56
    Top = 224
  end
end
