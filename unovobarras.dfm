object Fbarras: TFbarras
  Left = 413
  Top = 256
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Impress'#227'o de etiquetas '
  ClientHeight = 218
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 10
    Width = 75
    Height = 13
    Caption = 'Digite o C'#243'digo '
  end
  object Label2: TLabel
    Left = 0
    Top = 50
    Width = 149
    Height = 13
    Caption = 'Largura da Etiqueta - mil'#237'metros'
  end
  object Label3: TLabel
    Left = 0
    Top = 88
    Width = 140
    Height = 13
    Caption = 'Altura da Etiqueta - mil'#237'metros'
  end
  object Label4: TLabel
    Left = 8
    Top = 120
    Width = 110
    Height = 13
    Caption = 'Selecione a Impressora'
  end
  object Button1: TButton
    Left = 202
    Top = 10
    Width = 120
    Height = 25
    Caption = '&Imprimir'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 80
    Top = 10
    Width = 120
    Height = 21
    TabOrder = 1
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 200
    Top = 50
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '88,00'
  end
  object Edit3: TEdit
    Left = 200
    Top = 82
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '30,00'
  end
  object eporta: TEdit
    Left = 8
    Top = 136
    Width = 49
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Text = '1'
    OnKeyPress = eportaKeyPress
  end
  object Impre: TComboBox
    Left = 64
    Top = 136
    Width = 257
    Height = 21
    TabOrder = 5
    OnChange = ImpreChange
  end
end
