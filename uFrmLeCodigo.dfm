object FrmLeCodigo: TFrmLeCodigo
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 112
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 598
    Height = 112
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 32
    ExplicitTop = 64
    ExplicitWidth = 185
    ExplicitHeight = 105
    object Label1: TLabel
      Left = 9
      Top = 14
      Width = 574
      Height = 29
      Caption = 'Passe a imagem pela leitora de c'#243'digo de barras'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdtCodigo: TEdit
      Left = 9
      Top = 60
      Width = 574
      Height = 37
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyDown = EdtCodigoKeyDown
    end
  end
end
