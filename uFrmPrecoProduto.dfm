inherited FrmPrecoProduto: TFrmPrecoProduto
  Left = 323
  Top = 189
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FrmPrecoProduto'
  ClientHeight = 266
  ClientWidth = 677
  Color = clGray
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 220
    Height = 29
    Caption = 'C'#243'digo do produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 16
    Top = 96
    Width = 118
    Height = 29
    Caption = 'Descri'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 16
    Top = 171
    Width = 70
    Height = 29
    Caption = 'Pre'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object EdtCodigo: TEdit
    Left = 16
    Top = 53
    Width = 281
    Height = 37
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnExit = EdtCodigoExit
    OnKeyPress = EdtCodigoKeyPress
  end
  object EdtDescricao: TEdit
    Left = 16
    Top = 126
    Width = 641
    Height = 37
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    OnKeyPress = EdtDescricaoKeyPress
  end
  object EdtPreco: TEdit
    Left = 16
    Top = 200
    Width = 161
    Height = 37
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object ActionList1: TActionList
    Left = 400
    Top = 72
    object ActMenuFiscal: TAction
      Caption = 'ActMenuFiscal'
      ShortCut = 49229
      OnExecute = ActMenuFiscalExecute
    end
  end
end
