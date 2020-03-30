inherited FrmEstoqueFisico: TFrmEstoqueFisico
  Left = 240
  Top = 148
  Caption = 'Estoque Fisico'
  ClientHeight = 408
  ClientWidth = 554
  OldCreateOrder = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 554
    Height = 370
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 550
      Height = 353
      Align = alClient
      DataSource = DataEstFisico
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
          FieldName = 'TANQUE_NUMERO'
          Title.Caption = 'Tanque N'#186
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID_PRODUTO'
          Title.Caption = 'C'#243'd.Prod'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EST_FISICO'
          Title.Caption = 'Est. Fisico'
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 370
    Width = 554
    Height = 38
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 464
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object DataEstFisico: TDataSource
    Left = 288
    Top = 120
  end
end
