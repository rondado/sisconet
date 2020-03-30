inherited FrmSelListaEstoque: TFrmSelListaEstoque
  Left = 266
  Top = 187
  Caption = 'Selecione Produtos Lista de Estoque'
  ClientHeight = 305
  ClientWidth = 530
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 530
    Height = 305
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 526
      Height = 288
      Align = alClient
      DataSource = DataLista
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
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
          FieldName = 'IDPRODUTO'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 364
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Unid'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 37
          Visible = True
        end>
    end
  end
  object ActionList1: TActionList
    Left = 152
    Top = 56
    object ActIncluir: TAction
      Caption = 'Incluir item'
      ShortCut = 45
      OnExecute = ActIncluirExecute
    end
    object ActExcluir: TAction
      Caption = 'Excluir Item'
      ShortCut = 46
      OnExecute = ActExcluirExecute
    end
  end
  object DataLista: TDataSource
    Left = 240
    Top = 64
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 128
    object InsIncluiritem1: TMenuItem
      Action = ActIncluir
    end
    object DelExcluirItem1: TMenuItem
      Action = ActExcluir
    end
  end
end
