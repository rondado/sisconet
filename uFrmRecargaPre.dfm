inherited FrmRecargaPre: TFrmRecargaPre
  Left = 261
  Top = 167
  Caption = 'Recarga de Pr'#233' pago'
  ClientHeight = 390
  ClientWidth = 641
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 323
    Width = 641
    Height = 67
    Align = alBottom
    TabOrder = 1
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 211
      Top = 3
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitLeft = 211
      ExplicitTop = 3
      inherited BtnConfirmar: TBitBtn
        Action = ActConfirmar
      end
      inherited BtnCancelar: TBitBtn
        Action = ActCancelar
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 641
    Height = 323
    Align = alClient
    TabOrder = 0
    object PnInforma: TLabel
      Left = 2
      Top = 284
      Width = 542
      Height = 37
      Align = alBottom
      Alignment = taCenter
      Caption = 'Aguardando os dados para recarga'
      Color = clAppWorkSpace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 103
      Width = 305
      Height = 75
      Caption = ' DDD + N'#186' do celular '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object EdtDDD1: TMaskEdit
        Left = 16
        Top = 30
        Width = 55
        Height = 37
        EditMask = '!99;1;_'
        MaxLength = 2
        TabOrder = 0
        Text = '  '
        OnKeyPress = EdtCEPKeyPress
      end
      object EdtCelular1: TMaskEdit
        Left = 96
        Top = 30
        Width = 153
        Height = 37
        EditMask = '00000-0000;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '     -    '
        OnKeyPress = EdtCEPKeyPress
      end
    end
    object GroupBox4: TGroupBox
      Left = 16
      Top = 189
      Width = 305
      Height = 75
      Caption = 'Conforma'#231#227'o do dados '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object EdtDDD2: TMaskEdit
        Left = 16
        Top = 30
        Width = 55
        Height = 37
        EditMask = '!99;1;_'
        MaxLength = 2
        TabOrder = 0
        Text = '  '
        OnKeyPress = EdtCEPKeyPress
      end
      object EdtCelular2: TMaskEdit
        Left = 96
        Top = 30
        Width = 153
        Height = 37
        EditMask = '00000-0000;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '     -    '
        OnKeyPress = EdtCEPKeyPress
      end
    end
    object GroupBox6: TGroupBox
      Left = 16
      Top = 21
      Width = 185
      Height = 73
      Caption = ' CEP '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object EdtCEP: TMaskEdit
        Left = 16
        Top = 28
        Width = 136
        Height = 37
        EditMask = '00000000;1;_'
        MaxLength = 8
        TabOrder = 0
        Text = '        '
        OnKeyPress = EdtCEPKeyPress
      end
    end
  end
  object ActionList1: TActionList
    Left = 496
    Top = 336
    object ActConfirmar: TAction
      Caption = 'Confirmar'
      OnExecute = ActConfirmarExecute
    end
    object ActCancelar: TAction
      Caption = 'Cancelar'
      OnExecute = ActCancelarExecute
    end
  end
end
