inherited FrmFechaCaixa: TFrmFechaCaixa
  Left = 245
  Top = 126
  Caption = 'FECHAMENTO ATIVO DO CAIXA'
  ClientHeight = 351
  ClientWidth = 474
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 480
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 474
    Height = 285
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 106
      Width = 211
      Height = 24
      Alignment = taRightJustify
      Caption = 'VALOR EM DINHEIRO'
      FocusControl = DbDinheiro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 151
      Width = 198
      Height = 24
      Alignment = taRightJustify
      Caption = 'VALOR EM CARTAO'
      FocusControl = DbCartao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 20
      Top = 190
      Width = 200
      Height = 24
      Alignment = taRightJustify
      Caption = 'VALOR EM CHEQUE'
      FocusControl = DbCheque
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 20
      Top = 229
      Width = 189
      Height = 24
      Alignment = taRightJustify
      Caption = 'OUTROS VALORES'
      FocusControl = DbOutros
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 24
      Top = 67
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
      Left = 68
      Top = 67
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
      Left = 112
      Top = 67
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
      Left = 156
      Top = 67
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
      Left = 200
      Top = 67
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
    object Label18: TLabel
      Left = 403
      Top = 84
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
    object Label29: TLabel
      Left = 24
      Top = 86
      Width = 354
      Height = 13
      Caption = 
        'Campos de c'#225'lculo da gaveta de dinheiro (Apenas dinheiro e moeda' +
        ')'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 24
      Top = 35
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
    object Label6: TLabel
      Left = 68
      Top = 35
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
    object Label7: TLabel
      Left = 112
      Top = 35
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
    object Label8: TLabel
      Left = 156
      Top = 35
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
    object Label9: TLabel
      Left = 200
      Top = 35
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
    object DbDinheiro: TDBEdit
      Left = 248
      Top = 106
      Width = 203
      Height = 32
      DataField = 'DINHEIRO'
      DataSource = DataFechamento
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnKeyPress = DbDinheiroKeyPress
    end
    object DbCartao: TDBEdit
      Left = 248
      Top = 145
      Width = 203
      Height = 32
      DataField = 'CARTAO'
      DataSource = DataFechamento
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnKeyPress = DbDinheiroKeyPress
    end
    object DbCheque: TDBEdit
      Left = 248
      Top = 184
      Width = 203
      Height = 32
      DataField = 'CHEQUE'
      DataSource = DataFechamento
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      OnKeyPress = DbDinheiroKeyPress
    end
    object DbOutros: TDBEdit
      Left = 248
      Top = 223
      Width = 203
      Height = 32
      DataField = 'OUTROS'
      DataSource = DataFechamento
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnKeyPress = DbDinheiroKeyPress
    end
    object Edit1: TEdit
      Left = 24
      Top = 16
      Width = 41
      Height = 21
      TabOrder = 0
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit10: TEdit
      Left = 200
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 9
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit2: TEdit
      Left = 68
      Top = 16
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit3: TEdit
      Left = 112
      Top = 16
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit4: TEdit
      Left = 156
      Top = 16
      Width = 41
      Height = 21
      TabOrder = 3
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit5: TEdit
      Left = 200
      Top = 16
      Width = 41
      Height = 21
      TabOrder = 4
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit6: TEdit
      Left = 24
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 5
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit7: TEdit
      Left = 68
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 6
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit8: TEdit
      Left = 112
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 7
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit9: TEdit
      Left = 156
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 8
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Button1: TButton
      Left = 247
      Top = 16
      Width = 204
      Height = 54
      Caption = 'Total'
      TabOrder = 10
      OnClick = Button1Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 285
    Width = 474
    Height = 66
    Align = alBottom
    TabOrder = 1
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 129
      Top = 2
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitLeft = 129
      ExplicitTop = 2
      inherited BtnConfirmar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnConfirmarClick
      end
      inherited BtnCancelar: TBitBtn
        OnClick = FrameConfirmaCancela1BtnCancelarClick
      end
    end
  end
  object CdsFechamento: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 304
    object CdsFechamentoDINHEIRO: TCurrencyField
      FieldName = 'DINHEIRO'
    end
    object CdsFechamentoCARTAO: TCurrencyField
      FieldName = 'CARTAO'
    end
    object CdsFechamentoCHEQUE: TCurrencyField
      FieldName = 'CHEQUE'
    end
    object CdsFechamentoOUTROS: TCurrencyField
      FieldName = 'OUTROS'
    end
  end
  object DataFechamento: TDataSource
    DataSet = CdsFechamento
    Left = 48
    Top = 304
  end
  object ActionList1: TActionList
    Left = 80
    Top = 310
    object ActMenuFiscal: TAction
      Caption = 'ActMenuFiscal'
      ShortCut = 49229
      OnExecute = ActMenuFiscalExecute
    end
  end
end
