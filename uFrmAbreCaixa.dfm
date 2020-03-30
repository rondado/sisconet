inherited FrmAbreCaixa: TFrmAbreCaixa
  Left = 368
  Top = 229
  Caption = 'ABRE CAIXA DO SISCONET'
  ClientHeight = 301
  ClientWidth = 473
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 479
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 236
    Width = 473
    Height = 65
    Align = alBottom
    TabOrder = 0
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 74
      Top = 1
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitLeft = 74
      ExplicitTop = 1
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
    Width = 473
    Height = 236
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 82
      Height = 16
      Caption = 'Funcionario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 166
      Width = 123
      Height = 16
      Caption = 'Valor de Abertura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 90
      Width = 35
      Height = 13
      Caption = 'R$1,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 60
      Top = 90
      Width = 35
      Height = 13
      Caption = 'R$0,50'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 104
      Top = 90
      Width = 35
      Height = 13
      Caption = 'R$0,25'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 148
      Top = 90
      Width = 35
      Height = 13
      Caption = 'R$0,10'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 192
      Top = 90
      Width = 35
      Height = 13
      Caption = 'R$0,05'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 299
      Top = 141
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 16
      Top = 122
      Width = 41
      Height = 13
      Caption = 'R$50,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 60
      Top = 122
      Width = 41
      Height = 13
      Caption = 'R$20,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 104
      Top = 122
      Width = 41
      Height = 13
      Caption = 'R$10,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 148
      Top = 122
      Width = 35
      Height = 13
      Caption = 'R$5,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 192
      Top = 122
      Width = 35
      Height = 13
      Caption = 'R$2,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label29: TLabel
      Left = 16
      Top = 141
      Width = 211
      Height = 13
      Caption = 'Campos de c'#225'lculo da gaveta de dinheiro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 236
      Top = 90
      Width = 46
      Height = 13
      Caption = 'Cheques'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 236
      Top = 122
      Width = 41
      Height = 13
      Caption = 'Cart'#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboFuncionario: TDBLookupComboBox
      Left = 16
      Top = 34
      Width = 329
      Height = 24
      DataField = 'IDFUNC'
      DataSource = DataCaixa
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'ID'
      ListField = 'NOME'
      ListSource = DataFuncionario
      ParentFont = False
      TabOrder = 0
      OnKeyPress = ComboFuncionarioKeyPress
    end
    object DbValor: TDBEdit
      Left = 16
      Top = 184
      Width = 201
      Height = 32
      DataField = 'VALOR_ABERTURA'
      DataSource = DataCaixa
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnKeyPress = ComboFuncionarioKeyPress
    end
    object Edit1: TEdit
      Left = 16
      Top = 71
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit2: TEdit
      Left = 60
      Top = 71
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit3: TEdit
      Left = 104
      Top = 71
      Width = 41
      Height = 21
      TabOrder = 3
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit4: TEdit
      Left = 148
      Top = 71
      Width = 41
      Height = 21
      TabOrder = 4
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit5: TEdit
      Left = 192
      Top = 71
      Width = 41
      Height = 21
      TabOrder = 5
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Button1: TButton
      Left = 223
      Top = 184
      Width = 122
      Height = 32
      Caption = 'Total'
      TabOrder = 13
      OnClick = Button1Click
    end
    object Edit6: TEdit
      Left = 16
      Top = 103
      Width = 41
      Height = 21
      TabOrder = 6
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit7: TEdit
      Left = 60
      Top = 103
      Width = 41
      Height = 21
      TabOrder = 7
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit8: TEdit
      Left = 104
      Top = 103
      Width = 41
      Height = 21
      TabOrder = 8
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit9: TEdit
      Left = 148
      Top = 103
      Width = 41
      Height = 21
      TabOrder = 9
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit10: TEdit
      Left = 192
      Top = 103
      Width = 41
      Height = 21
      TabOrder = 10
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit11: TEdit
      Left = 236
      Top = 71
      Width = 109
      Height = 21
      TabOrder = 11
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit12: TEdit
      Left = 236
      Top = 103
      Width = 109
      Height = 21
      TabOrder = 12
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
  end
  object DataCaixa: TDataSource
    DataSet = DmWorkCom.CdsCaixa
    Left = 368
    Top = 32
  end
  object DataFuncionario: TDataSource
    Left = 368
    Top = 80
  end
  object ActionList1: TActionList
    Left = 368
    Top = 136
    object ActMenuFiscal: TAction
      Caption = 'ActMenuFiscal'
      ShortCut = 49229
      OnExecute = ActMenuFiscalExecute
    end
  end
end
