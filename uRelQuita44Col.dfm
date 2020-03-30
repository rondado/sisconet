object FRelQuita44Col: TFRelQuita44Col
  Left = 0
  Top = 0
  Caption = 'FRelQuita44Col'
  ClientHeight = 540
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RlQuitacao: TRLReport
    Left = 4
    Top = 8
    Width = 280
    Height = 529
    Margins.LeftMargin = 0.610000000000000000
    Margins.TopMargin = 2.000000000000000000
    Margins.RightMargin = 0.610000000000000000
    Margins.BottomMargin = 0.000000000000000000
    AllowedBands = [btHeader]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PageSetup.PaperSize = fpCustom
    PageSetup.PaperWidth = 74.000000000000000000
    PageSetup.PaperHeight = 140.000000000000000000
    object RLBand1: TRLBand
      Left = 2
      Top = 97
      Width = 276
      Height = 292
      BandType = btTitle
      object RLLabel1: TRLLabel
        Left = 4
        Top = 15
        Width = 269
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Recibo de quita'#231#227'o de fatura'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LbLocalData: TRLLabel
        Left = 7
        Top = 264
        Width = 60
        Height = 15
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial Narrow'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LbTexto: TRLMemo
        Left = 3
        Top = 45
        Width = 268
        Height = 204
        AutoSize = False
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          
            'Recebemos de <nome do cliente>, a import'#226'ncia de R$<valor> (<val' +
            'or extenso>), referente a quita'#231#227'o do documento N'#186' <id_fatu>, co' +
            'm vencimento em <data_venc>.')
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 2
      Top = 8
      Width = 276
      Height = 89
      BandType = btTitle
      object LbRazao: TRLLabel
        Left = 4
        Top = 13
        Width = 46
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object LbEndereco: TRLLabel
        Left = 4
        Top = 30
        Width = 61
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object LbCidadeUF: TRLLabel
        Left = 4
        Top = 48
        Width = 61
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object LbCNPJ: TRLLabel
        Left = 4
        Top = 67
        Width = 40
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
