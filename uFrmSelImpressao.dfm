inherited FrmSelImpressao: TFrmSelImpressao
  Caption = 'Selecione a impress'#227'o'
  ClientHeight = 154
  ClientWidth = 479
  OnCreate = FormCreate
  ExplicitWidth = 485
  ExplicitHeight = 179
  PixelsPerInch = 96
  TextHeight = 13
  object RdTipoImpressao: TRadioGroup
    Left = 0
    Top = 0
    Width = 479
    Height = 89
    Align = alClient
    Caption = ' Selecione o que deseja Imprimir '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      '0 - Impress'#227'o da lista para conferir registros de itens'
      '1 - Impress'#227'o de comanda para prepara'#231#227'o do pedido')
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 89
    Width = 479
    Height = 65
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 120
      Top = 2
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitLeft = 120
      ExplicitTop = 2
      inherited BtnConfirmar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnConfirmarClick
      end
      inherited BtnCancelar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnCancelarClick
      end
    end
  end
end
