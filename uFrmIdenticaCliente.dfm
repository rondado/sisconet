inherited FrmIdenticaCliente: TFrmIdenticaCliente
  Left = 279
  Top = 174
  BorderIcons = []
  Caption = 'Identifica'#231#227'o do Cliente'
  ClientHeight = 339
  ClientWidth = 473
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 457
    Height = 253
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 14
      Width = 94
      Height = 13
      Caption = 'Nome do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 15
      Top = 58
      Width = 55
      Height = 13
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 15
      Top = 103
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
    object Label4: TLabel
      Left = 301
      Top = 102
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
    object Label5: TLabel
      Left = 359
      Top = 102
      Width = 25
      Height = 13
      Caption = 'CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 15
      Top = 148
      Width = 24
      Height = 13
      Caption = 'CPF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 143
      Top = 148
      Width = 61
      Height = 13
      Caption = 'Identidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 279
      Top = 149
      Width = 33
      Height = 13
      Caption = 'Placa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 359
      Top = 149
      Width = 55
      Height = 13
      Caption = 'Od'#244'metro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 287
      Top = 58
      Width = 44
      Height = 13
      Caption = 'Numero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 346
      Top = 58
      Width = 76
      Height = 13
      Caption = 'Complemento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 156
      Top = 103
      Width = 34
      Height = 13
      Caption = 'Bairro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboUF: TDBLookupComboBox
      Left = 298
      Top = 119
      Width = 56
      Height = 21
      DataField = 'UF_END_ENTREGA'
      KeyField = 'UF'
      ListField = 'UF'
      ListSource = DataUF
      TabOrder = 6
      OnKeyPress = EdtClienteKeyPress
    end
    object BtnPesquisar: TBitBtn
      Left = 14
      Top = 212
      Width = 424
      Height = 28
      Action = ActLocalizar
      Caption = 'F4 - Selecionar no Cadastro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
    end
    object EdtCliente: TMaskEdit
      Left = 16
      Top = 30
      Width = 425
      Height = 21
      MaxLength = 50
      TabOrder = 0
      Text = 'EdtCliente'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtEndereco: TMaskEdit
      Left = 16
      Top = 74
      Width = 265
      Height = 21
      TabOrder = 1
      Text = 'EdtEndereco'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtCidade: TMaskEdit
      Left = 16
      Top = 119
      Width = 136
      Height = 21
      MaxLength = 20
      TabOrder = 4
      Text = 'EdtCidade'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtCep: TMaskEdit
      Left = 360
      Top = 119
      Width = 81
      Height = 21
      MaxLength = 10
      TabOrder = 7
      Text = 'EdtCep'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtCPF: TMaskEdit
      Left = 16
      Top = 164
      Width = 121
      Height = 21
      TabOrder = 8
      Text = 'EdtCPF'
      OnExit = EdtCPFExit
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtIdentidade: TMaskEdit
      Left = 144
      Top = 164
      Width = 121
      Height = 21
      TabOrder = 9
      Text = 'EdtIdentidade'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtPlaca: TMaskEdit
      Left = 280
      Top = 164
      Width = 73
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 10
      Text = 'EDTPLACA'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtOdometro: TMaskEdit
      Left = 360
      Top = 164
      Width = 81
      Height = 21
      MaxLength = 10
      TabOrder = 11
      Text = 'EdtOdometro'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtNumero: TMaskEdit
      Left = 288
      Top = 74
      Width = 52
      Height = 21
      MaxLength = 10
      TabOrder = 2
      Text = 'MaskEdit2'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtComplemento: TMaskEdit
      Left = 347
      Top = 74
      Width = 91
      Height = 21
      MaxLength = 20
      TabOrder = 3
      Text = 'MaskEdit2'
      OnKeyPress = EdtClienteKeyPress
    end
    object EdtBairro: TMaskEdit
      Left = 157
      Top = 119
      Width = 136
      Height = 21
      MaxLength = 20
      TabOrder = 5
      Text = 'MaskEdit3'
      OnKeyPress = EdtClienteKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 269
    Width = 473
    Height = 70
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 1
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 139
      Top = 6
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitLeft = 139
      ExplicitTop = 6
      inherited BtnConfirmar: TBitBtn
        Action = ActConfirmar
        Caption = 'F2 - Confirmar'
      end
      inherited BtnCancelar: TBitBtn
        Action = ActCancelar
        Caption = 'F3 - Cancelar'
      end
    end
  end
  object DataUF: TDataSource
    Left = 376
    Top = 251
  end
  object ActionList1: TActionList
    Left = 312
    Top = 248
    object ActConfirmar: TAction
      Caption = 'F2 - Confirmar'
      ShortCut = 113
      OnExecute = ActConfirmarExecute
    end
    object ActCancelar: TAction
      Caption = 'F3 - Cancelar'
      ShortCut = 114
      OnExecute = ActCancelarExecute
    end
    object ActLocalizar: TAction
      Caption = 'F4 - Selecionar no Cadastro'
      ShortCut = 115
      OnExecute = ActLocalizarExecute
    end
    object ActMenuFiscal: TAction
      Caption = 'ActMenuFiscal'
      ShortCut = 49229
      OnExecute = ActMenuFiscalExecute
    end
  end
end
