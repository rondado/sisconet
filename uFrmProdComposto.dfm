inherited FrmProdComposto: TFrmProdComposto
  Left = 363
  Top = 247
  Caption = 'Composi'#231#227'o do Produto'
  ClientHeight = 230
  ClientWidth = 525
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl [0]
    Left = 0
    Top = 0
    Width = 525
    Height = 230
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Composi'#231#227'o'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 517
        Height = 202
        Align = alClient
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 513
          Height = 185
          Align = alClient
          DataSource = DataWork
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
              FieldName = 'ID_PRODUTO'
              Title.Alignment = taCenter
              Title.Caption = 'C'#243'digo'
              Width = 47
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Alignment = taCenter
              Title.Caption = 'Descri'#231#227'o'
              Width = 254
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QUANTIDADE'
              Title.Alignment = taCenter
              Title.Caption = 'Quant.'
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UNIDADE'
              Title.Alignment = taCenter
              Title.Caption = 'Unid.'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Title.Alignment = taCenter
              Title.Caption = 'Valor'
              Width = 78
              Visible = True
            end>
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 380
        Height = 202
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 19
          Width = 11
          Height = 13
          Caption = 'ID'
          FocusControl = DbID
        end
        object Label2: TLabel
          Left = 8
          Top = 59
          Width = 51
          Height = 13
          Caption = 'ID Produto'
          FocusControl = DbIDProduto
        end
        object Label3: TLabel
          Left = 8
          Top = 140
          Width = 55
          Height = 13
          Caption = 'Quantidade'
          FocusControl = DbQuantidade
        end
        object Label4: TLabel
          Left = 8
          Top = 100
          Width = 48
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object Label5: TLabel
          Left = 96
          Top = 140
          Width = 40
          Height = 13
          Caption = 'Unidade'
        end
        object Label6: TLabel
          Left = 160
          Top = 140
          Width = 24
          Height = 13
          Caption = 'Valor'
        end
        object DbID: TDBEdit
          Left = 8
          Top = 35
          Width = 73
          Height = 21
          DataField = 'ID'
          DataSource = DataWork
          TabOrder = 0
          OnKeyPress = DbIDKeyPress
        end
        object DbIDProduto: TDBEdit
          Left = 8
          Top = 75
          Width = 73
          Height = 21
          DataField = 'ID_PRODUTO'
          DataSource = DataWork
          TabOrder = 1
          OnKeyPress = DbIDKeyPress
        end
        object DbQuantidade: TDBEdit
          Left = 8
          Top = 156
          Width = 73
          Height = 21
          DataField = 'QUANTIDADE'
          DataSource = DataWork
          TabOrder = 3
          OnKeyPress = DbIDKeyPress
        end
        object ComboProduto: TDBLookupComboBox
          Left = 8
          Top = 116
          Width = 284
          Height = 21
          DataField = 'ID_PRODUTO'
          DataSource = DataWork
          KeyField = 'ID'
          ListField = 'DESCRICAO'
          ListSource = Dataproduto
          TabOrder = 2
          OnKeyPress = DbIDKeyPress
        end
        object DbUnidade: TDBEdit
          Left = 96
          Top = 156
          Width = 49
          Height = 21
          DataField = 'UNIDADE'
          DataSource = DataWork
          Enabled = False
          TabOrder = 4
        end
        object DbValor: TDBEdit
          Left = 160
          Top = 156
          Width = 81
          Height = 21
          DataField = 'VALOR'
          DataSource = DataWork
          Enabled = False
          TabOrder = 5
        end
      end
      object Panel1: TPanel
        Left = 380
        Top = 0
        Width = 137
        Height = 202
        Align = alRight
        TabOrder = 1
        inline Frame: TFrameBotaoVertical
          Left = 0
          Top = 0
          Width = 136
          Height = 182
          TabOrder = 0
          ExplicitWidth = 136
          ExplicitHeight = 182
          inherited BtnIncluir: TBitBtn
            Action = ActIncluir
            Caption = 'F2 - &Incluir'
          end
          inherited BtnExcluir: TBitBtn
            Action = ActExcluir
            Caption = 'F3 - &Excluir'
          end
          inherited BtnConfirmar: TBitBtn
            Action = ActConfirmar
            Caption = 'F4 - &Confirmar'
          end
          inherited BtnCancelar: TBitBtn
            Action = ActCancelar
            Caption = 'F5 - C&ancelar'
          end
          inherited BtnPesquisar: TBitBtn
            Action = ActPesquisar
            Caption = 'F6 - &Pesquisar'
          end
          inherited BtnRelatorio: TBitBtn
            Action = ActRelatorio
            Caption = 'F7 - &Relatorio'
          end
          inherited BtnEncerrar: TBitBtn
            Action = ActEncerrar
            Caption = 'F10 - &Encerrar'
          end
        end
      end
    end
  end
  inherited DataWork: TDataSource
    Left = 136
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 200
  end
  object Dataproduto: TDataSource
    DataSet = DmWorkCom.CdsConsulta
    Left = 144
    Top = 88
  end
end
