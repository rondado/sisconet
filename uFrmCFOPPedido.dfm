object FrmCFOPPedido: TFrmCFOPPedido
  Left = 0
  Top = 0
  Caption = 'Altera'#231#227'o do CFOP dos Produtos'
  ClientHeight = 77
  ClientWidth = 211
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 63
    Height = 13
    Caption = 'C'#211'DIGO CST'
  end
  object Label2: TLabel
    Left = 8
    Top = 37
    Width = 71
    Height = 13
    Caption = 'C'#211'DIGO CFOP'
  end
  object EdCST: TEdit
    Left = 96
    Top = 10
    Width = 49
    Height = 21
    TabOrder = 0
    OnKeyPress = EdCSTKeyPress
  end
  object EdCFOP: TEdit
    Left = 96
    Top = 37
    Width = 49
    Height = 21
    TabOrder = 1
    OnKeyPress = EdCFOPKeyPress
  end
end
