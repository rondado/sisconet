inherited FrmMovFinanceiro: TFrmMovFinanceiro
  Left = 353
  Top = 162
  Caption = 'Movimento Financeiro'
  ClientHeight = 182
  ClientWidth = 205
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 211
  ExplicitHeight = 207
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 105
    Caption = ' Per'#237'odo '
    TabOrder = 0
    object Label1: TLabel
      Left = 19
      Top = 29
      Width = 14
      Height = 13
      Caption = 'De'
    end
    object Label2: TLabel
      Left = 19
      Top = 55
      Width = 6
      Height = 13
      Caption = #224
    end
    object Datai: TDateTimePicker
      Left = 43
      Top = 29
      Width = 117
      Height = 21
      Date = 40146.382808275460000000
      Time = 40146.382808275460000000
      TabOrder = 0
    end
    object Dataf: TDateTimePicker
      Left = 43
      Top = 53
      Width = 117
      Height = 21
      Date = 40146.382826539350000000
      Time = 40146.382826539350000000
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 117
    Width = 205
    Height = 65
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 203
    inline FrameConfirmaCancela1: TFrameConfirmaCancela
      Left = 0
      Top = 3
      Width = 203
      Height = 62
      TabOrder = 0
      ExplicitTop = 3
      inherited BtnConfirmar: TBitBtn
        Action = ActConfirmar
      end
      inherited BtnCancelar: TBitBtn
        Action = ActCancelar
      end
    end
  end
  object ActionList1: TActionList
    Left = 88
    Top = 125
    object ActCancelar: TAction
      Caption = 'Cancelar'
      OnExecute = ActCancelarExecute
    end
    object ActConfirmar: TAction
      Caption = 'Confirmar'
      OnExecute = ActConfirmarExecute
    end
  end
  object QryMovto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DmConexao.ConexaoDBX
    Left = 248
    Top = 128
  end
  object frxReport1: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42313.403034398200000000
    ReportOptions.LastChange = 42742.551194328710000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 176
    Top = 24
    Datasets = <
      item
        DataSet = frxDbMovto
        DataSetName = 'frxDbMovto'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 216.000000000000000000
      PaperHeight = 279.000000000000000000
      PaperSize = 121
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Titulo: TfrxReportTitle
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 740.787880000000000000
        object Shape1: TfrxShapeView
          Left = 1.000000000000000000
          Width = 737.008350000000000000
          Height = 45.354360000000000000
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.559060000000000000
          Width = 729.449290000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Movimento financeiro do per'#237'odo')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 170.078850000000000000
        Width = 740.787880000000000000
        DataSet = frxDbMovto
        DataSetName = 'frxDbMovto'
        RowCount = 0
        object frxDbMovtoDESCRICAO: TfrxMemoView
          Left = 27.236240000000000000
          Top = 1.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDbMovto
          DataSetName = 'frxDbMovto'
          Memo.UTF8W = (
            '[frxDbMovto."DESCRICAO"]')
        end
        object frxDbMovtoVALOR: TfrxMemoView
          Left = 517.795610000000000000
          Top = 3.779530000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR'
          DataSet = frxDbMovto
          DataSetName = 'frxDbMovto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbMovto."VALOR"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 253.228510000000000000
        Width = 740.787880000000000000
        object Memo1: TfrxMemoView
          Left = 665.197280000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page#]')
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 86.929190000000000000
        Width = 740.787880000000000000
        object Memo4: TfrxMemoView
          Left = 24.897650000000000000
          Top = 1.000000000000000000
          Width = 325.039580000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 519.236550000000000000
          Top = 1.000000000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Acumulado')
          ParentFont = False
        end
      end
    end
  end
  object frxDbMovto: TfrxDBDataset
    UserName = 'frxDbMovto'
    CloseDataSource = False
    DataSet = CdsMovto
    BCDToCurrency = False
    Left = 320
    Top = 16
  end
  object DspMovimento: TDataSetProvider
    DataSet = QryMovto
    Left = 248
    Top = 72
  end
  object CdsMovto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspMovimento'
    Left = 320
    Top = 72
    object CdsMovtoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object CdsMovtoVALOR: TFloatField
      FieldName = 'VALOR'
    end
  end
  object DataMovto: TDataSource
    DataSet = CdsMovto
    Left = 320
    Top = 128
  end
end
