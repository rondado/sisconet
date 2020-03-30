inherited FrmDadosPOS: TFrmDadosPOS
  Top = 158
  Caption = 'Informar Dados Cart'#227'o POS'
  ClientHeight = 249
  ClientWidth = 324
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 330
  ExplicitHeight = 278
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 11
    Top = 68
    Width = 304
    Height = 63
    Caption = ' Bandeira '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object CbxBandeiras: TDBLookupComboBox
      Left = 8
      Top = 24
      Width = 281
      Height = 32
      KeyField = 'CODIGO'
      ListField = 'DESCRICAO'
      ListFieldIndex = 2
      ListSource = Databandeira
      TabOrder = 0
      OnKeyPress = CbxTipoOperacaoKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 11
    Top = 137
    Width = 304
    Height = 63
    Caption = ' N'#250'mero da Transa'#231#227'o '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object EdtNSU: TEdit
      Left = 10
      Top = 24
      Width = 276
      Height = 32
      TabOrder = 0
      OnKeyPress = CbxTipoOperacaoKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 207
    Width = 324
    Height = 42
    Align = alBottom
    TabOrder = 2
    object BtnOk: TBitBtn
      Left = 80
      Top = 4
      Width = 147
      Height = 34
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = BtnOkClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 11
    Top = 1
    Width = 304
    Height = 63
    Caption = ' Tipo de Opera'#231#227'o '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object CbxTipoOperacao: TComboBox
      Left = 7
      Top = 23
      Width = 284
      Height = 32
      ItemIndex = 0
      TabOrder = 0
      Text = 'Credito'
      OnKeyPress = CbxTipoOperacaoKeyPress
      Items.Strings = (
        'Credito'
        'Debito')
    end
  end
  object Databandeira: TDataSource
    DataSet = DmWorkCom.CdsBandeiras
    Left = 152
    Top = 128
  end
end
