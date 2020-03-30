inherited FrmContatosADC: TFrmContatosADC
  Left = 286
  Top = 186
  Caption = 'Contatos Adcionais'
  ClientWidth = 651
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl [0]
    Left = 0
    Top = 0
    Width = 651
    Height = 444
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Contatos Cadastrados'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 643
        Height = 416
        Align = alClient
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 639
          Height = 399
          Align = alClient
          DataSource = DataWork
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'NOME'
              Title.Alignment = taCenter
              Title.Caption = 'Nome do Contato'
              Width = 278
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TELEFONE'
              Title.Alignment = taCenter
              Title.Caption = 'Telefone'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RAMAL'
              Title.Alignment = taCenter
              Title.Caption = 'Ramal'
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMAIL1'
              Title.Alignment = taCenter
              Title.Caption = 'Email principal'
              Width = 194
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMAIL2'
              Title.Alignment = taCenter
              Title.Caption = 'Email Alternativo'
              Width = 99
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SITE'
              Title.Alignment = taCenter
              Title.Caption = 'Site'
              Width = 64
              Visible = True
            end>
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 643
        Height = 416
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 11
          Height = 13
          Caption = 'ID'
          FocusControl = DbID
        end
        object Label2: TLabel
          Left = 8
          Top = 56
          Width = 51
          Height = 13
          Caption = 'ID Contato'
          FocusControl = DbIDContato
        end
        object Label3: TLabel
          Left = 8
          Top = 96
          Width = 83
          Height = 13
          Caption = 'Nome do Contato'
          FocusControl = DbNome
        end
        object Label4: TLabel
          Left = 8
          Top = 136
          Width = 42
          Height = 13
          Caption = 'Telefone'
          FocusControl = DbTelefone
        end
        object Label5: TLabel
          Left = 8
          Top = 176
          Width = 30
          Height = 13
          Caption = 'Ramal'
          FocusControl = DbRamall
        end
        object Label6: TLabel
          Left = 8
          Top = 216
          Width = 68
          Height = 13
          Caption = 'Email Principal'
          FocusControl = DbEmail1
        end
        object Label7: TLabel
          Left = 8
          Top = 256
          Width = 78
          Height = 13
          Caption = 'Email Alternativo'
          FocusControl = DbEmail2
        end
        object Label8: TLabel
          Left = 8
          Top = 296
          Width = 18
          Height = 13
          Caption = 'Site'
          FocusControl = DbSite
        end
        object Panel1: TPanel
          Left = 2
          Top = 350
          Width = 639
          Height = 64
          Align = alBottom
          TabOrder = 0
          inline Frame: TFrameBotaoHorizontal
            Left = 0
            Top = 0
            Width = 637
            Height = 63
            TabOrder = 0
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
        object DbID: TDBEdit
          Left = 8
          Top = 32
          Width = 134
          Height = 21
          DataField = 'ID'
          DataSource = DataWork
          Enabled = False
          TabOrder = 1
          OnKeyPress = DbIDKeyPress
        end
        object DbIDContato: TDBEdit
          Left = 8
          Top = 72
          Width = 134
          Height = 21
          DataField = 'ID_CONTATO'
          DataSource = DataWork
          Enabled = False
          TabOrder = 2
          OnKeyPress = DbIDKeyPress
        end
        object DbNome: TDBEdit
          Left = 8
          Top = 112
          Width = 329
          Height = 21
          DataField = 'NOME'
          DataSource = DataWork
          TabOrder = 3
          OnKeyPress = DbIDKeyPress
        end
        object DbTelefone: TDBEdit
          Left = 8
          Top = 152
          Width = 160
          Height = 21
          DataField = 'TELEFONE'
          DataSource = DataWork
          TabOrder = 4
          OnKeyPress = DbIDKeyPress
        end
        object DbRamall: TDBEdit
          Left = 8
          Top = 192
          Width = 134
          Height = 21
          DataField = 'RAMAL'
          DataSource = DataWork
          TabOrder = 5
          OnKeyPress = DbIDKeyPress
        end
        object DbEmail1: TDBEdit
          Left = 8
          Top = 232
          Width = 400
          Height = 21
          DataField = 'EMAIL1'
          DataSource = DataWork
          TabOrder = 6
          OnKeyPress = DbIDKeyPress
        end
        object DbEmail2: TDBEdit
          Left = 8
          Top = 272
          Width = 400
          Height = 21
          DataField = 'EMAIL2'
          DataSource = DataWork
          TabOrder = 7
          OnKeyPress = DbIDKeyPress
        end
        object DbSite: TDBEdit
          Left = 8
          Top = 312
          Width = 400
          Height = 21
          DataField = 'SITE'
          DataSource = DataWork
          TabOrder = 8
          OnKeyPress = DbIDKeyPress
        end
      end
    end
  end
  inherited DataWork: TDataSource
    DataSet = DmClientes.CdsContatosADC
    Left = 392
    Top = 64
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 456
    Top = 64
  end
end
