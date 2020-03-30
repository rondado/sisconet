inherited FrmCancItensMesa: TFrmCancItensMesa
  Left = 264
  Top = 174
  Caption = 'Cancelamento de itens da Comanda'
  ClientHeight = 375
  ClientWidth = 660
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 660
    Height = 39
    Align = alTop
    TabOrder = 0
    object Comanda: TLabel
      Left = 17
      Top = 13
      Width = 53
      Height = 13
      Caption = 'Comanda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbValor: TLabel
      Left = 357
      Top = 8
      Width = 229
      Height = 27
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'R$0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdtComanda: TEdit
      Left = 73
      Top = 10
      Width = 121
      Height = 21
      TabOrder = 0
      OnExit = EdtComandaExit
      OnKeyPress = EdtComandaKeyPress
    end
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 39
    Width = 660
    Height = 336
    Align = alClient
    DataSource = DataMesaItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid2DrawColumnCell
    OnKeyPress = DBGrid2KeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_PRODUTO'
        Title.Caption = 'Produto'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 388
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANT'
        Title.Caption = 'Quant.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRECO_TOTAL'
        Title.Caption = 'Total'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object DataMesaItens: TDataSource
    DataSet = DmWorkCom.CdsMesasItens
    Left = 152
    Top = 112
  end
  object DataMesasAbertas: TDataSource
    DataSet = DmWorkCom.CdsMesasAbertas
    Left = 248
    Top = 113
  end
  object DataMesa: TDataSource
    DataSet = DmWorkCom.CdsMesas
    Left = 80
    Top = 112
  end
end
