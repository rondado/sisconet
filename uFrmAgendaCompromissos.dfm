inherited FrmAgendaCompromissos: TFrmAgendaCompromissos
  Top = 170
  Caption = 'Agenda de Compromissos'
  ClientHeight = 393
  ClientWidth = 659
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl [0]
    Left = 0
    Top = 0
    Width = 659
    Height = 393
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Compromissos'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 651
        Height = 365
        Align = alClient
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 5
          Top = 5
          Width = 640
          Height = 84
          TabOrder = 0
          object GrpPeriodo: TGroupBox
            Left = 8
            Top = 8
            Width = 129
            Height = 71
            Caption = ' Per'#237'odo '
            TabOrder = 0
            object Label8: TLabel
              Left = 8
              Top = 20
              Width = 17
              Height = 13
              Caption = 'De'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label9: TLabel
              Left = 8
              Top = 42
              Width = 8
              Height = 13
              Caption = #224
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Datai: TDateTimePicker
              Left = 32
              Top = 17
              Width = 88
              Height = 21
              Date = 39723.855672939810000000
              Time = 39723.855672939810000000
              TabOrder = 0
            end
            object Dataf: TDateTimePicker
              Left = 32
              Top = 39
              Width = 88
              Height = 21
              Date = 39723.855683958330000000
              Time = 39723.855683958330000000
              TabOrder = 1
            end
          end
          object RadioTipo: TRadioGroup
            Left = 144
            Top = 8
            Width = 201
            Height = 33
            Caption = ' Tipo de Pesquisa '
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Geral'
              'Por Executor')
            TabOrder = 1
          end
          object BtnLocalizar: TBitBtn
            Left = 517
            Top = 10
            Width = 115
            Height = 32
            Caption = 'Ctrl+F - Localizar'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33033333333333333F7F3333333333333000333333333333F777333333333333
              000333333333333F777333333333333000333333333333F77733333333333300
              033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
              33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
              3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
              33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
              333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
              333333773FF77333333333370007333333333333777333333333}
            NumGlyphs = 2
            TabOrder = 2
            OnClick = BtnLocalizarClick
          end
          object BtnEncerrar: TBitBtn
            Left = 517
            Top = 44
            Width = 115
            Height = 32
            Action = ActEncerrar
            Caption = 'F10 - &Encerrar'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
              03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
              0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
              0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
              0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
              0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
              0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
              0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
              0333337F777FFFFF7F3333000000000003333377777777777333}
            NumGlyphs = 2
            TabOrder = 3
          end
          object GrpLocalizar: TGroupBox
            Left = 144
            Top = 40
            Width = 361
            Height = 39
            Caption = ' Localizar '
            TabOrder = 4
            object ComboFuncionario: TDBLookupComboBox
              Left = 8
              Top = 14
              Width = 345
              Height = 21
              KeyField = 'ID'
              ListField = 'NOME;ID'
              ListSource = DataFuncionario
              TabOrder = 0
            end
          end
          object RadioConcluido: TRadioGroup
            Left = 352
            Top = 8
            Width = 153
            Height = 34
            Caption = ' Conclu'#237'do '
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              'Sim'
              'N'#227'o')
            TabOrder = 5
          end
        end
        object DBGrid1: TDBGrid
          Left = 0
          Top = 95
          Width = 647
          Height = 269
          DataSource = DataWork
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'DATA'
              Title.Alignment = taCenter
              Title.Caption = 'Data'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'HORA'
              Title.Alignment = taCenter
              Title.Caption = 'Hora'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COMPROMISSO'
              Title.Alignment = taCenter
              Title.Caption = 'Compromisso'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONCLUIDO'
              Title.Alignment = taCenter
              Title.Caption = 'Concluido'
              Visible = True
            end>
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Lan'#231'amentos'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 651
        Height = 365
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 6
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
          FocusControl = DbCodigo
        end
        object Label2: TLabel
          Left = 9
          Top = 46
          Width = 23
          Height = 13
          Caption = 'Data'
          FocusControl = DbData
        end
        object Label3: TLabel
          Left = 185
          Top = 46
          Width = 31
          Height = 13
          Caption = 'HORA'
          FocusControl = DbHora
        end
        object Label4: TLabel
          Left = 9
          Top = 86
          Width = 62
          Height = 13
          Caption = 'Compromisso'
          FocusControl = DbCompromisso
        end
        object Label5: TLabel
          Left = 9
          Top = 126
          Width = 37
          Height = 13
          Caption = 'Detalhe'
          FocusControl = DbDetalhe
        end
        object Label6: TLabel
          Left = 9
          Top = 166
          Width = 42
          Height = 13
          Caption = 'Executor'
        end
        object Label7: TLabel
          Left = 9
          Top = 206
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
          FocusControl = DbObservacao
        end
        object DbCodigo: TDBEdit
          Left = 9
          Top = 22
          Width = 134
          Height = 21
          DataField = 'ID'
          DataSource = DataWork
          Enabled = False
          TabOrder = 0
        end
        object DbData: TDBEdit
          Left = 9
          Top = 62
          Width = 134
          Height = 21
          DataField = 'DATA'
          DataSource = DataWork
          TabOrder = 1
        end
        object DbHora: TDBEdit
          Left = 185
          Top = 62
          Width = 134
          Height = 21
          DataField = 'HORA'
          DataSource = DataWork
          TabOrder = 2
        end
        object DbCompromisso: TDBEdit
          Left = 9
          Top = 102
          Width = 481
          Height = 21
          DataField = 'COMPROMISSO'
          DataSource = DataWork
          TabOrder = 3
        end
        object DbDetalhe: TDBEdit
          Left = 9
          Top = 142
          Width = 481
          Height = 21
          DataField = 'DETALHE'
          DataSource = DataWork
          TabOrder = 4
        end
        object DbObservacao: TDBMemo
          Left = 9
          Top = 222
          Width = 481
          Height = 81
          DataField = 'OBSERVACAO'
          DataSource = DataWork
          TabOrder = 6
        end
        object ChConcluido: TDBCheckBox
          Left = 9
          Top = 306
          Width = 81
          Height = 17
          Caption = 'Conclu'#237'do'
          DataField = 'CONCLUIDO'
          DataSource = DataWork
          TabOrder = 7
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object PnBotoes: TPanel
          Left = 510
          Top = 0
          Width = 141
          Height = 365
          Align = alRight
          BevelInner = bvLowered
          TabOrder = 8
          inline Frame: TFrameBotaoVertical
            Left = 4
            Top = 4
            Width = 136
            Height = 182
            TabOrder = 0
            ExplicitLeft = 4
            ExplicitTop = 4
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
        object ComboFuncCad: TDBLookupComboBox
          Left = 8
          Top = 184
          Width = 353
          Height = 21
          DataField = 'IDFUNC'
          DataSource = DataWork
          KeyField = 'ID'
          ListField = 'NOME'
          ListSource = DataFuncCad
          TabOrder = 5
        end
      end
    end
  end
  inherited DataWork: TDataSource
    DataSet = DmWorkCom.CdsAgenda
    Left = 144
    Top = 272
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 208
    Top = 272
  end
  object DataFuncionario: TDataSource
    Left = 300
    Top = 272
  end
  object DataFuncCad: TDataSource
    Left = 388
    Top = 272
  end
end
