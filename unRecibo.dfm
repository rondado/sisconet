object frmRecibo: TfrmRecibo
  Left = 351
  Top = 143
  Caption = 'Impress'#227'o de Recibos'
  ClientHeight = 541
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object QuickRep1: TQuickRep
    Left = -31
    Top = 25
    Width = 794
    Height = 1123
    ShowingPreview = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.MemoryLimit = 1000000
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsMaximized
    PreviewWidth = 500
    PreviewHeight = 500
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stPDF
    PreviewLeft = 0
    PreviewTop = 0
    object QRBand1: TQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 443
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        1172.104166666667000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRShape13: TQRShape
        Left = 0
        Top = 48
        Width = 577
        Height = 385
        Size.Values = (
          1018.645833333333000000
          0.000000000000000000
          127.000000000000000000
          1526.645833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 8
        Top = 56
        Width = 559
        Height = 177
        Size.Values = (
          468.312500000000000000
          21.166666666666670000
          148.166666666666700000
          1479.020833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Pen.Style = psDot
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 8
        Top = 288
        Width = 559
        Height = 140
        Size.Values = (
          370.416666666666700000
          21.166666666666670000
          762.000000000000000000
          1479.020833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Pen.Style = psDot
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 16
        Top = 338
        Width = 549
        Height = 38
        Size.Values = (
          100.541666666667000000
          42.333333333333300000
          894.291666666667000000
          1452.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsTopAndBottom
        VertAdjust = 0
      end
      object QRShape4: TQRShape
        Left = 16
        Top = 245
        Width = 549
        Height = 34
        Size.Values = (
          89.958333333333300000
          42.333333333333300000
          648.229166666667000000
          1452.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsTopAndBottom
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 344
        Top = 4
        Width = 223
        Height = 34
        Size.Values = (
          89.958333333333300000
          910.166666666667000000
          10.583333333333300000
          590.020833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsTopAndBottom
        VertAdjust = 0
      end
      object QRShape1: TQRShape
        Left = 6
        Top = 4
        Width = 187
        Height = 34
        Size.Values = (
          89.958333333333300000
          15.875000000000000000
          10.583333333333300000
          494.770833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsTopAndBottom
        VertAdjust = 0
      end
      object QRLabel1: TQRLabel
        Left = 206
        Top = 3
        Width = 121
        Height = 38
        Size.Values = (
          100.541666666666700000
          545.041666666666700000
          7.937500000000000000
          320.145833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'RECIBO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 24
      end
      object lnrecibo: TQRLabel
        Left = 9
        Top = 10
        Width = 180
        Height = 23
        Size.Values = (
          60.854166666666700000
          23.812500000000000000
          26.458333333333300000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'RECIBO N'#186
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 14
      end
      object lvalor: TQRLabel
        Left = 350
        Top = 10
        Width = 213
        Height = 23
        Size.Values = (
          60.854166666666700000
          926.041666666667000000
          26.458333333333300000
          563.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'VALOR'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 14
      end
      object lrecebi: TQRLabel
        Left = 16
        Top = 72
        Width = 409
        Height = 20
        Size.Values = (
          52.916666666666670000
          42.333333333333330000
          190.500000000000000000
          1082.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'REcebi (emos) de'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Limportancia: TQRLabel
        Left = 16
        Top = 129
        Width = 409
        Height = 39
        Size.Values = (
          103.187500000000000000
          42.333333333333330000
          341.312500000000000000
          1082.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Cinco Mil, e Novecentos e Noventa e Nove Reais, e Noventa e Nove' +
          ' Centavos.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object lreferente: TQRLabel
        Left = 16
        Top = 183
        Width = 545
        Height = 44
        Size.Values = (
          116.416666666666700000
          42.333333333333330000
          484.187500000000000000
          1441.979166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'sdasdfasdf asdfasdf asdfas asdfas asdfas asdfas asdfas asdfas as' +
          'dfas asdfas asdfsa  asdf asdf  asdfs asdfas asdfs asdf eeeee'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object lcidade: TQRLabel
        Left = 16
        Top = 254
        Width = 545
        Height = 20
        Size.Values = (
          52.916666666666700000
          42.333333333333300000
          672.041666666667000000
          1441.979166666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'lcidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object lemitente: TQRLabel
        Left = 16
        Top = 318
        Width = 545
        Height = 20
        Size.Values = (
          52.916666666666700000
          42.333333333333300000
          841.375000000000000000
          1441.979166666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'lemitente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object lassinatura: TQRLabel
        Left = 16
        Top = 392
        Width = 545
        Height = 20
        Size.Values = (
          52.916666666666700000
          42.333333333333300000
          1037.166666666670000000
          1441.979166666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'lassinatura'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object lendereco: TQRLabel
        Left = 16
        Top = 100
        Width = 409
        Height = 20
        Size.Values = (
          52.916666666666670000
          42.333333333333330000
          264.583333333333300000
          1082.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'lendereco1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object lendereco1: TQRLabel
        Left = 16
        Top = 355
        Width = 545
        Height = 20
        Size.Values = (
          52.916666666666700000
          42.333333333333300000
          939.270833333333000000
          1441.979166666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'lendereco1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
    end
    object QRImage1: TQRImage
      Left = 464
      Top = 95
      Width = 140
      Height = 129
      Size.Values = (
        341.312500000000000000
        1227.666666666667000000
        251.354166666666700000
        370.416666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Stretch = True
      Visible = False
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 677
    Height = 541
    Align = alClient
    TabOrder = 0
    object Label4: TLabel
      Left = 17
      Top = 18
      Width = 127
      Height = 37
      Caption = 'RECIBO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 16
      Top = 160
      Width = 82
      Height = 13
      Caption = 'A import'#226'ncia de:'
    end
    object Label2: TLabel
      Left = 16
      Top = 216
      Width = 47
      Height = 13
      Caption = 'Referente'
    end
    object Label3: TLabel
      Left = 19
      Top = 20
      Width = 127
      Height = 37
      Caption = 'RECIBO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object SpeedButton1: TSpeedButton
      Left = 440
      Top = 26
      Width = 73
      Height = 30
      Caption = '&Imprimir...'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 160
      Top = 25
      Width = 121
      Height = 32
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'RECIBO N'#186
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit2: TLabeledEdit
      Left = 288
      Top = 25
      Width = 145
      Height = 32
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'VALOR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnExit = LabeledEdit2Exit
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit3: TLabeledEdit
      Left = 16
      Top = 80
      Width = 497
      Height = 21
      EditLabel.Width = 86
      EditLabel.Height = 13
      EditLabel.Caption = 'Recebi (emos) de:'
      TabOrder = 2
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit4: TLabeledEdit
      Left = 16
      Top = 128
      Width = 497
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Endere'#231'o'
      TabOrder = 3
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object Memo1: TMemo
      Left = 16
      Top = 175
      Width = 497
      Height = 32
      Enabled = False
      TabOrder = 4
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object Memo2: TMemo
      Left = 16
      Top = 232
      Width = 497
      Height = 32
      TabOrder = 5
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit5: TLabeledEdit
      Left = 16
      Top = 283
      Width = 185
      Height = 21
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = 'Cidade'
      TabOrder = 6
      OnExit = LabeledEdit5Exit
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit6: TLabeledEdit
      Left = 208
      Top = 283
      Width = 305
      Height = 21
      EditLabel.Width = 129
      EditLabel.Height = 13
      EditLabel.Caption = 'Dia/M'#234's/Ano (por extenso)'
      TabOrder = 7
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit7: TLabeledEdit
      Left = 16
      Top = 324
      Width = 297
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = 'Emitente'
      TabOrder = 8
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit8: TLabeledEdit
      Left = 320
      Top = 324
      Width = 193
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'CNPJ/CPF'
      TabOrder = 9
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
    object LabeledEdit9: TLabeledEdit
      Left = 16
      Top = 363
      Width = 497
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Endere'#231'o'
      TabOrder = 10
      OnKeyDown = LabeledEdit1KeyDown
      OnKeyPress = FormKeyPress
    end
  end
end
