inherited FrmCupomDAVPV: TFrmCupomDAVPV
  Left = 246
  Top = 104
  Caption = 'Emitir Cupom Fiscal de DAV ou PV'
  ClientHeight = 562
  ClientWidth = 793
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 793
    Height = 521
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 789
      Height = 504
      Align = alClient
      DataSource = DataDavPV
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DATA_PEDIDO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Data'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IDCLIENTE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CLIENTE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Nome do Cliente'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 342
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Valor Total'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMDAV'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DAV N'#250'mero'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMPV'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'PV N'#250'mero'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 94
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 521
    Width = 793
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 169
      Height = 25
      Action = ActImprimir
      Caption = 'Enter - Imprimir DAV/PV'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 179
      Top = 8
      Width = 145
      Height = 25
      Action = ActCancelar
      Caption = 'Cancelar Pr'#233' Venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 632
      Top = 8
      Width = 148
      Height = 25
      Action = ActEncerrar
      Caption = 'Fechar sem Imprimir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object BitBtn4: TBitBtn
      Left = 326
      Top = 8
      Width = 134
      Height = 25
      Action = ActAtualizar
      Caption = 'Atualizar lista'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object BtnImpTXTDav: TBitBtn
      Left = 466
      Top = 8
      Width = 161
      Height = 25
      Action = ActImportarTXT
      Caption = 'Importar de arquivo texto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
  end
  object ActionList1: TActionList
    Left = 288
    Top = 136
    object ActImprimir: TAction
      Caption = 'Imprimir DAV/PV'
      ShortCut = 13
      OnExecute = ActImprimirExecute
    end
    object ActCancelar: TAction
      Caption = 'Cancelar PV'
      OnExecute = ActCancelarExecute
    end
    object ActEncerrar: TAction
      Caption = 'Encerrar'
      OnExecute = ActEncerrarExecute
    end
    object ActAtualizar: TAction
      Caption = 'Atualizar lista'
      OnExecute = ActAtualizarExecute
    end
  end
  object DataDavPV: TDataSource
    DataSet = DmWorkCom.CdsDavPV
    Left = 192
    Top = 136
  end
  object ActionList2: TActionList
    Left = 464
    Top = 144
    object ActMenuFiscal: TAction
      Caption = 'ActMenuFiscal'
      ShortCut = 49229
      OnExecute = ActMenuFiscalExecute
    end
    object ActImportarTXT: TAction
      Caption = 'Importar de arquivo texto'
      OnExecute = ActImportarTXTExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos Texto|*.txt|Todos os arquivos|*.*'
    Left = 352
    Top = 248
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 192
    Top = 248
  end
end
