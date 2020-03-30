inherited FrmListaCompras: TFrmListaCompras
  Left = 325
  Top = 183
  Caption = 'Lista de compras efetudas'
  ClientHeight = 213
  ClientWidth = 306
  OldCreateOrder = True
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 312
  ExplicitHeight = 241
  PixelsPerInch = 96
  TextHeight = 13
  object GrpPeriodo: TGroupBox
    Left = 8
    Top = 60
    Width = 290
    Height = 45
    Caption = ' Per'#237'odo '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 22
      Width = 17
      Height = 13
      Caption = 'De'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 144
      Top = 20
      Width = 8
      Height = 13
      Caption = #224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Datai: TDateTimePicker
      Left = 32
      Top = 18
      Width = 105
      Height = 21
      Date = 39759.092323807870000000
      Time = 39759.092323807870000000
      TabOrder = 0
    end
    object Dataf: TDateTimePicker
      Left = 168
      Top = 18
      Width = 105
      Height = 21
      Date = 39759.092336979160000000
      Time = 39759.092336979160000000
      TabOrder = 1
    end
  end
  object ChConfirmados: TCheckBox
    Left = 8
    Top = 118
    Width = 138
    Height = 17
    Caption = 'Apenas confirmados'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 147
    Width = 306
    Height = 66
    Align = alBottom
    TabOrder = 2
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 48
      Top = 2
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitLeft = 48
      ExplicitTop = 2
      inherited BtnConfirmar: TBitBtn
        Action = ActImprimir
        Caption = 'F2 - Imprimir'
      end
      inherited BtnCancelar: TBitBtn
        Action = ActEncerrar
        Caption = 'F10 - Encerrar'
      end
    end
  end
  object ChItens: TCheckBox
    Left = 154
    Top = 118
    Width = 146
    Height = 17
    Caption = 'Sair Itens do registro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object ActionList1: TActionList
    Left = 248
    Top = 16
    object ActImprimir: TAction
      Caption = 'F2 - Imprimir'
      ShortCut = 113
      OnExecute = ActImprimirExecute
    end
    object ActEncerrar: TAction
      Caption = 'F10 - Encerrar'
      ShortCut = 121
      OnExecute = ActEncerrarExecute
    end
  end
end
