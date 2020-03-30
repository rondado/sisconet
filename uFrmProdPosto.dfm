inherited FrmProdPosto: TFrmProdPosto
  Left = 276
  Top = 191
  Caption = 'Lista de produtos combustivel'
  ClientHeight = 288
  ClientWidth = 549
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 549
    Height = 288
    Align = alClient
    DataSource = DsDescontinuidade
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyPress = DBGrid1KeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'bico_concentrador'
        Title.Caption = 'Num. Bico'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_produto'
        Title.Caption = 'Cod.Prod'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 332
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ativo'
        Title.Caption = 'Ativo'
        Width = 34
        Visible = True
      end>
  end
  object DsDescontinuidade: TDataSource
    Left = 96
    Top = 88
  end
end
