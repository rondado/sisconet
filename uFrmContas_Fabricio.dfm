inherited FrmContas: TFrmContas
  Caption = 'Controle de contas a receber'
  ClientHeight = 661
  ClientWidth = 1370
  Position = poDesktopCenter
  PrintScale = poNone
  WindowState = wsNormal
  OnCreate = FormCreate
  ExplicitWidth = 1386
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnConsulta: TPanel
    Width = 1370
    Height = 95
    ExplicitWidth = 1370
    ExplicitHeight = 95
    inherited GrpTipoPesq: TGroupBox
      Width = 1368
      Height = 93
      Align = alTop
      ExplicitWidth = 1368
      ExplicitHeight = 93
      inherited Label1: TLabel
        Left = 215
        Top = 9
        ExplicitLeft = 215
        ExplicitTop = 9
      end
      inherited Label2: TLabel
        Left = 215
        Top = 48
        ExplicitLeft = 215
        ExplicitTop = 48
      end
      object Label7: TLabel [2]
        Left = 847
        Top = 24
        Width = 109
        Height = 13
        Caption = 'Total Geral Quitado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbgeralquitado: TLabel [3]
        Left = 847
        Top = 43
        Width = 62
        Height = 19
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel [4]
        Left = 1023
        Top = 24
        Width = 123
        Height = 13
        Caption = 'Total Geral Negociado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel [5]
        Left = 1180
        Top = 24
        Width = 104
        Height = 13
        Caption = 'Total Geral Devido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbgeralnegociado: TLabel [6]
        Left = 1023
        Top = 43
        Width = 62
        Height = 19
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbgeraldevido: TLabel [7]
        Left = 1180
        Top = 43
        Width = 62
        Height = 19
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited CbxTipoPesq: TComboBox
        Left = 215
        Top = 24
        Width = 310
        ItemIndex = -1
        Text = 'Nome do contato'
        Items.Strings = (
          'Nome do contato')
        ExplicitLeft = 215
        ExplicitTop = 24
        ExplicitWidth = 310
      end
      inherited EdtLocalizar: TEdit
        Left = 215
        Top = 64
        Width = 310
        OnKeyPress = EdtLocalizarKeyPress
        ExplicitLeft = 215
        ExplicitTop = 64
        ExplicitWidth = 310
      end
      inherited SbLocalizar: TBitBtn
        Left = 526
        Top = 24
        Width = 315
        Height = 64
        Font.Style = [fsBold]
        ExplicitLeft = 526
        ExplicitTop = 24
        ExplicitWidth = 315
        ExplicitHeight = 64
      end
    end
  end
  inherited Panel2: TPanel
    Top = 629
    Width = 1370
    ExplicitTop = 629
    ExplicitWidth = 1370
    object BitBtn2: TBitBtn
      Left = 656
      Top = 4
      Width = 109
      Height = 26
      Action = ActQuitar
      Caption = 'Quitar conta'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00F9FCFB00D2E9DF00A1D3BD007DC2A4008BCAB000C5E4
        D500EDF7F300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00E2F2EA003EA17400007E420000784000027A4500007642000072
        3900168C5A0082C6A900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00DBEFE6002B9D6E00088D500009905600007E4200B4DDCE0000641F00138A
        5D000D82510000723C0094D0B400FF00FF00FF00FF00FF00FF00FF00FF00F9FD
        FB0063BB96000B9258001FA66B0078C2A300F9FAF900FF00FF00BFDACB000988
        54000D8857001287580006804E00C1E8D700FF00FF00FF00FF00FF00FF00CEEB
        DE00199E640033AD7A0035AD7800189A63000085430000600A009AD3BC00C7E4
        D8000F8E590019916000047F4F006FB89B00FF00FF00FF00FF00FF00FF00B6E1
        CE0025A76F0043B584003DB17D00109B60003EAD7D007DC5A800CBE7DB0070BD
        9C0010925C001C9563000D88550050A98400F1FBF600FF00FF00FF00FF00B6E1
        CE0031AC770050BB8D0040B3800057B88E00BFE3D4009ED6BF003FAD7C000E96
        5C001E9C66001E9B65000F8D59004EA98300F1FBF700FF00FF00FF00FF00D2EE
        E20037AF7A005DC2940049B9880093D2B700CEEADE000087380016A0640035A8
        77001D9F6700229E69000189510077BA9F00FF00FF00FF00FF00FF00FF00F9FD
        FA0081CEAC003DB4810070CCA30031AE770081CAA900FF00FF00EAF3EE0058B9
        8E00149F62000F9C5F0039A17500FEFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00E8F6F0005FC2960052BD8D0063C69A0016A36600DCDFE000008A35001FA6
        6D0019A165002DA67200ECFAF400FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00EFF9F50064C3990045BB86003CBD840082C1A30082BBA3001FA9
        6D006FC79F00DFF3EB00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00F5FCF900A0DDC00078B4990089B8A2008AA29900C7D9
        D100FBFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00F4EDF10093B0A40097C8B200C1C0C000F2F2
        F200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FEFEFE0092DBBA0044C28B0062CB9C002AB77900B6E9
        D100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FDFEFE0095D9BB0051C08D0065C69C0046B6840054BE
        8E00DAF2E800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FAFDFB00E2F5ED00C5ECDA009ADBBD0096DA
        BB00E5F7EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      TabOrder = 5
    end
    object BitBtn3: TBitBtn
      Left = 769
      Top = 4
      Width = 130
      Height = 26
      Action = ActRemoveQuit
      Caption = 'Remover Quita'#231#227'o'
      TabOrder = 6
    end
  end
  inherited GroupBox1: TGroupBox
    Top = 95
    Width = 1370
    Height = 534
    ExplicitTop = 95
    ExplicitWidth = 1370
    ExplicitHeight = 534
    object Label3: TLabel [0]
      Left = 1157
      Top = 6
      Width = 157
      Height = 13
      Caption = 'Qtde clientes encontrados:  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel [1]
      Left = 1157
      Top = 329
      Width = 147
      Height = 13
      Caption = 'Total do D'#233'bito Restante: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel [2]
      Left = 1157
      Top = 178
      Width = 66
      Height = 13
      Caption = 'Total Pago: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbClientes: TLabel [3]
      Left = 1157
      Top = 33
      Width = 30
      Height = 19
      Caption = '000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbConta: TLabel [4]
      Left = 1157
      Top = 348
      Width = 62
      Height = 19
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbQuitado: TLabel [5]
      Left = 1157
      Top = 197
      Width = 62
      Height = 19
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [6]
      Left = 1157
      Top = 242
      Width = 93
      Height = 13
      Caption = 'Total Negociado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbnegociado: TLabel [7]
      Left = 1157
      Top = 261
      Width = 62
      Height = 19
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited GridDados: TDBGrid
      Left = 1
      Top = 144
      Width = 1150
      Height = 258
      Align = alNone
      OnDblClick = GridDadosDblClick
      OnKeyPress = GridDadosKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'NUMCONTA'
          Title.Caption = 'Conta'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PEDIDO_NUM'
          Title.Caption = 'Pedido'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_LANC'
          Title.Caption = 'Data emiss'#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_VENC'
          Title.Caption = 'Data Vencimento'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_CONTA'
          Title.Caption = 'Valor da conta'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS'
          Title.Caption = 'Status'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_QUIT'
          Title.Caption = 'Data Quita'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_QUITATO'
          Title.Caption = 'Valor Quitado'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTATO'
          Title.Caption = 'Nome'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'SERIE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'IDPEDIDO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ID_1'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DATA_PEDIDO'
          Title.Caption = 'Data do Pedido'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Title.Caption = 'Valor'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCONTO'
          Title.Caption = 'Desconto'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ACRESCIMO'
          Title.Caption = 'Acr'#233'scimo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OUTRAS_DESPESAS'
          Title.Caption = 'Outras Despesas'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Caption = 'Valor Total'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
    object StatusBar1: TStatusBar
      Left = 2
      Top = 514
      Width = 1366
      Height = 18
      Panels = <
        item
          Text = 'Total a receber no per'#237'odo informado'
          Width = 250
        end
        item
          Width = 180
        end
        item
          Text = 'Total quitado no per'#237'odo informado'
          Width = 240
        end
        item
          Width = 180
        end
        item
          Width = 50
        end>
    end
  end
  object GrpPeriodo: TGroupBox [3]
    Left = 0
    Top = 8
    Width = 124
    Height = 79
    Caption = ' Per'#237'odo '
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    object Label16: TLabel
      Left = 10
      Top = 17
      Width = 13
      Height = 13
      Caption = 'De'
      Color = clWindowText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label17: TLabel
      Left = 10
      Top = 37
      Width = 6
      Height = 13
      Caption = #224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Datai: TDateTimePicker
      Left = 26
      Top = 14
      Width = 85
      Height = 19
      Date = 43160.956834641210000000
      Time = 43160.956834641210000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Dataf: TDateTimePicker
      Left = 26
      Top = 35
      Width = 85
      Height = 19
      Date = 43160.956846562500000000
      Time = 43160.956846562500000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ChPeriodo: TCheckBox
      Left = 3
      Top = 60
      Width = 118
      Height = 15
      Caption = 'Data de Vencimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object RadioStatusConsulta: TRadioGroup [4]
    Left = 115
    Top = 8
    Width = 91
    Height = 79
    Caption = ' Status '
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      '0 - Em Aberto'
      '1 - Quitado'
      '2 - Renegociado'
      '3 - Todos')
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 4
  end
  object DBGrid2: TDBGrid [5]
    Left = 1
    Top = 503
    Width = 1150
    Height = 120
    DataSource = DataItens
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'EAN13'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IDPRODUTO'
        Title.Caption = 'C'#243'digo'
        Width = 98
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
        FieldName = 'QUANTIDADE'
        Title.Caption = 'Qtde'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Caption = 'Valor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCONTO'
        Title.Caption = 'Desconto'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACRESCIMO'
        Title.Caption = 'Acrescimo'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Title.Caption = 'Total'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOPROD'
        Title.Caption = 'Tipo'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CANCELADO'
        Title.Caption = 'Cancelado'
        Width = 68
        Visible = True
      end>
  end
  object DBGrid1: TDBGrid [6]
    Left = 1
    Top = 101
    Width = 1150
    Height = 133
    DataSource = DataCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnKeyUp = DBGrid1KeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 
          'Nome                                                            ' +
          '                                                                ' +
          '       '
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ_CPF'
        Title.Caption = 'CPF/CNPJ'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 158
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CIDADE_END'
        Title.Caption = 'Cidade'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 173
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF_END'
        Title.Caption = 'UF'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Title.Caption = 'Telefone'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATIVO'
        Title.Caption = 'Ativo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_CONTATO'
        Title.Caption = 'Tipo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 54
        Visible = True
      end>
  end
  inherited QryConsulta: TSQLQuery
    Active = True
    DataSource = DataCliente
    SQL.Strings = (
      'select contas.data_lanc,contas.data_venc,Contas.ID,'
      
        'contas.numconta,contas.idcontato,contas.contato,contas.valor_con' +
        'ta, contas.idpedido, contas.status,'
      'contas.data_quit,contas.valor_quitato,Contas.Serie ,'
      
        'pedido.id, pedido.pedido_num, pedido.data_pedido, pedido.valor, ' +
        'pedido.desconto,pedido.acrescimo,pedido.outras_despesas, pedido.' +
        'valor_total'
      ', pedido.coo, pedido.ccf'
      ' from contas inner join pedido on pedido.id = contas.idpedido'
      ' order by contas.idcontato')
    Left = 96
    Top = 424
    object QryConsultaDATA_LANC: TSQLTimeStampField
      FieldName = 'DATA_LANC'
    end
    object QryConsultaDATA_VENC: TSQLTimeStampField
      FieldName = 'DATA_VENC'
    end
    object QryConsultaID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryConsultaNUMCONTA: TStringField
      FieldName = 'NUMCONTA'
      Size = 10
    end
    object QryConsultaCONTATO: TStringField
      FieldName = 'CONTATO'
      Size = 50
    end
    object QryConsultaVALOR_CONTA: TFloatField
      FieldName = 'VALOR_CONTA'
      currency = True
    end
    object QryConsultaDATA_QUIT: TSQLTimeStampField
      FieldName = 'DATA_QUIT'
    end
    object QryConsultaVALOR_QUITATO: TFloatField
      FieldName = 'VALOR_QUITATO'
      currency = True
    end
    object QryConsultaSERIE: TIntegerField
      FieldName = 'SERIE'
    end
    object QryConsultaIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
    end
    object QryConsultaSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object QryConsultaID_1: TIntegerField
      FieldName = 'ID_1'
      Required = True
    end
    object QryConsultaPEDIDO_NUM: TStringField
      FieldName = 'PEDIDO_NUM'
      Size = 10
    end
    object QryConsultaDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
    end
    object QryConsultaVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object QryConsultaDESCONTO: TFloatField
      FieldName = 'DESCONTO'
    end
    object QryConsultaACRESCIMO: TFloatField
      FieldName = 'ACRESCIMO'
    end
    object QryConsultaOUTRAS_DESPESAS: TFloatField
      FieldName = 'OUTRAS_DESPESAS'
    end
    object QryConsultaVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
    object QryConsultaIDCONTATO: TIntegerField
      FieldName = 'IDCONTATO'
      Required = True
    end
  end
  inherited DspConsulta: TDataSetProvider
    Left = 96
    Top = 376
  end
  inherited CdsConsulta: TClientDataSet
    Active = True
    IndexFieldNames = 'IDCONTATO'
    MasterFields = 'ID'
    MasterSource = DataCliente
    PacketRecords = 0
    AfterOpen = CdsConsultaAfterOpen
    Left = 96
    Top = 328
    object CdsConsultaDATA_LANC: TSQLTimeStampField
      FieldName = 'DATA_LANC'
    end
    object CdsConsultaDATA_VENC: TSQLTimeStampField
      FieldName = 'DATA_VENC'
    end
    object CdsConsultaID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsConsultaNUMCONTA: TStringField
      FieldName = 'NUMCONTA'
      Size = 10
    end
    object CdsConsultaCONTATO: TStringField
      FieldName = 'CONTATO'
      Size = 50
    end
    object CdsConsultaVALOR_CONTA: TFloatField
      FieldName = 'VALOR_CONTA'
      currency = True
    end
    object CdsConsultaDATA_QUIT: TSQLTimeStampField
      FieldName = 'DATA_QUIT'
    end
    object CdsConsultaVALOR_QUITATO: TFloatField
      FieldName = 'VALOR_QUITATO'
      currency = True
    end
    object CdsConsultaSERIE: TIntegerField
      FieldName = 'SERIE'
    end
    object CdsConsultaIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
    end
    object CdsConsultaSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object CdsConsultaID_1: TIntegerField
      FieldName = 'ID_1'
      Required = True
    end
    object CdsConsultaPEDIDO_NUM: TStringField
      FieldName = 'PEDIDO_NUM'
      Size = 10
    end
    object CdsConsultaDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
    end
    object CdsConsultaVALOR: TFloatField
      FieldName = 'VALOR'
      currency = True
    end
    object CdsConsultaDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      currency = True
    end
    object CdsConsultaACRESCIMO: TFloatField
      FieldName = 'ACRESCIMO'
      currency = True
    end
    object CdsConsultaOUTRAS_DESPESAS: TFloatField
      FieldName = 'OUTRAS_DESPESAS'
      currency = True
    end
    object CdsConsultaVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      currency = True
    end
    object CdsConsultaIDCONTATO: TIntegerField
      FieldName = 'IDCONTATO'
      Required = True
    end
  end
  inherited DataConsulta: TDataSource
    Left = 96
    Top = 280
  end
  inherited ImageList1: TImageList
    Left = 232
    Top = 328
    Bitmap = {
      494C01010B009800E80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      000000000000000000000000000000000000FFFEFEFFFEFDFDFFFDFDFDFFFDFE
      FEFFF6F8F8FFCFCFCFFF9D9B9BFFB3AEAFFFDDDBDCFFB8B4B4FFA8A7A7FFD3D3
      D3FFEFF1F1FFFEFEFEFFFFFFFFFFFFFFFFFFFDFFFFFFFBFEFEFFFBFFFFFFF9FE
      FFFFFAFFFFFFFBFFFFFFFDFFFFFFFEFEFEFFFFFFFFFFFEFFFFFFFCFEFFFFFBFD
      FFFFF2F4FAFFF3F4F5FFFDFDFDFFFFFFFFFFFFFFFFFFFEFDFDFFDFDAD7FFC3B9
      B7FFC3BAB7FFC2BAB7FFC2B9B6FFC2B9B6FFC2B8B7FFC2B8B7FFC2B9B7FFC2B9
      B6FFC3BAB7FFC4BDBCFFEDECECFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFEFDFDFFFDFDFDFFD2D4
      D4FF9EA0A0FF9C9C9CFF8D8A8BFF6D6869FF7C7778FF888485FFA6A5A5FF9595
      95FF909292FFB9B9B9FFE9E9E9FFFDFDFDFFFBFFFEFFF9FEFEFFF2F7F8FFF5FB
      FDFFF9FFFFFFF9FEFFFFFBFFFFFFFEFFFFFFFDFEFEFFFDFFFFFFFBFDFFFFE9ED
      F3FFA6A9B2FFA3A4A6FFEAEAEAFFFFFFFFFFFFFFFFFFF8F6F4FFDAC6BDFFD2B2
      A5FFD2B1A4FFD2B0A2FFD0AFA0FFD0AD9FFFD0AE9FFFD1AD9FFFD1AE9EFFD1AD
      9CFFD2AF9DFFAB8F88FFD9D4D4FFFFFEFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFEFFFFF1F0F0FFA9A8A8FF9E9F
      9FFFD4D4D4FFE7E7E7FFC4C2C3FFB0ADAEFF555252FF6B6868FF989696FFB3B3
      B3FFC9CBCBFFA8AAAAFF989999FFEAECECFFF8FFFFFFE7F2F3FF99AAB0FF778C
      94FF94ABB3FFB9CED6FFDBECF2FFEFFCFEFFF6FEFFFFF7FEFFFFE2E8F1FF9CA6
      B8FF737E8FFF81858AFFDCDCDEFFFDFDFDFFFFFFFFFFF6F5F4FFE5D9D2FFF9DF
      CFFFFCDEC9FFFDDEC7FFFBDCC3FFFBDAC0FFFBDABDFFFCD7BBFFFBD7B8FFFBD4
      B5FFFFD8BEFFBB9C91FFDAD5D4FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFEFFBAB6B5FFC9C6C6FFFCF9
      FBFFF3F2F4FFECECEEFFBBBCBEFFB1B0B3FFA6A5A7FF8F8E8FFF787676FF7E7C
      7BFFAEAFADFFA0A5A4FF909594FFE8ECECFFF3FFFFFFCFEDF0FF98CAD6FF78B7
      CBFF42859EFF28667FFF285E73FF497686FF96B1BFFFCEDDEFFF98A6C3FF5776
      9FFF9ABEE4FFB1BDCAFFF8FAFDFFFBFDFEFFFFFFFFFFF6F5F4FFE5DAD5FFF8E1
      D0FFFBE0CAFFFBDEC8FFFBDDC5FFFADCC1FFF8DABEFFFBD8BBFFFAD7B9FFFBD5
      B6FFFFD7BDFFBA9B91FFDAD4D3FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFFFEFFC2C1C1FFF1F1F1FFE5E5
      E5FFBEBEBFFFA0A0A1FF868787FF868788FF959898FFA9ABABFFB3B4B4FFB3B5
      B4FF696D6BFF8F9594FF868B8AFFEBEFEFFFEFFFFFFFC5E9F1FF8ED0E1FF99E3
      FAFF9AE5FBFF9ADCEFFF93CFDDFF84B5C0FF6E90A0FF51718AFF5B82A5FF75AE
      D8FF5288ABFFDAEFFAFFF5FCFEFFFCFEFFFFFFFFFFFFF6F5F5FFE7DED7FFF9E3
      D5FFFCE4D1FFFBE1CDFFFCE0C9FFFBDEC5FFFADDC3FFFADBC1FFFADABEFFFAD7
      BAFFFFDAC2FFBB9A92FFDBD5D4FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBFEFEFFA6A9A8FFBABBBBFFB9BA
      B9FFBFC0BEFFD3D4D1FFD1D1CFFFBCBDBAFFA7AAA8FF989B9AFF929696FF999F
      9EFF999F9EFF7A807FFF848A89FFEAEFEEFFF0FCFFFFC2E8F4FF7EC2DAFFA5E5
      F4FF9DD2DBFFA9D3D5FFB2D7D2FFACCCC8FFABC7CEFF76A1B6FF6EB1D2FF7CCC
      E7FF266A7BFFAFC9D1FFF5FDFFFFFAFEFFFFFEFFFFFFF7F6F5FFE9E0DAFFFAE6
      D8FFFCE6D4FFFCE4D1FFFCE3CCFFFBE0C9FFFBDFC7FFFADCC5FFFBDCC2FFFBDA
      BFFFFFDCC4FFB99A92FFDAD5D4FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFCFCFFA2A5A5FFD2D4D4FFDADD
      DBFFD3D5D3FFDADCDAFFD2D5D2FFC9CBC9FFD0D4D2FFCFD4D2FFC6CBCAFFB6BB
      BAFFA5ABAAFF838887FF888D8CFFECEEEEFFEFFDFFFFC3EBF7FF7BBFD9FF99CB
      DAFFB0CECFFFE1F3EBFFE5F7E2FFE5F2DBFFCBD2C2FF94B3B5FF9DE2F5FF92E4
      F8FF78BECBFF6D8C93FFEBF9FBFFF8FEFFFFFDFFFFFFF7F6F6FFEBE1DCFFF9EA
      DCFFFCE8D7FFFCE7D4FFFDE5D1FFFCE3CEFFFBE1CCFFFBDFC9FFFCDDC6FFFBDC
      C3FFFFDDC6FFB99A91FFDAD5D4FFFFFEFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFFFFFFADAFAFFFE3E4E4FFD8D9
      D7FFDBDCDAFFDFE0DEFFE4E5E3FFF4F7F5FFDDE0DEFFCFD2D0FFC2C4C4FFC1C3
      C3FFD7DCDBFFBBC0BFFFA0A4A3FFF5F7F7FFF1FFFFFFC2ECF6FF7DC0D8FF7CA3
      AEFFFAFFF9FFFEFFEDFFFFFFE4FFF3F3CEFFFDEFCBFFCAD8C7FFABE6EAFF97E4
      F0FFB7FBFFFF577C82FFC5D6D9FFF5FFFFFFFFFFFFFFF8F7F6FFEDE3DCFFFCEB
      DFFFFBEADBFFFBE8D8FFFDE7D5FFFDE5D3FFFBE3D1FFFCE2CDFFFCE0C9FFFBDE
      C6FFFFDEC9FFB99A91FFDAD5D3FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFFFFFFDCDEDEFFB4B3B3FFC1BC
      BCFFCCC5C6FFAEA6A7FFCBC3C3FFD2CACBFFE4DEDEFFE7E4E4FFE8E6E6FFE6E5
      E5FFAFB1B1FFACAEAEFFE1E3E3FFFCFEFEFFF1FFFFFFC1E9F3FF85C3D8FFA1C1
      C3FFFDFFEAFFFEFEDBFFFEFED9FFFAF4CEFFEFD8B3FFE1E2C8FFBAE8E0FFA5EA
      EFFFB9FEFFFF92BABFFF8BA2A7FFECFAFBFFFFFFFFFFF9F7F6FFF0E7E0FFFDEF
      E3FFFCECDFFFFDEBDDFFFCEADAFFFBE8D7FFFCE6D3FFFCE4D1FFFBE3CEFFFDE1
      CCFFFFE0CAFFB79A91FFDAD5D3FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9FFFFFFFAFDFDFFE6E3E2FFCAC1
      BFFFF2E2E0FFD4C2BEFFCCB7B3FFD4C0BCFFCCBCBAFFC8BEBDFFBCB9B7FFC0C1
      C0FFC3C7C7FFE0E2E2FFFDFFFFFFFCFEFEFFEDFFFFFFBFEAF4FF94D3E5FF93B6
      B6FFF6FCE4FFFAF6CEFFF9F2CBFFEEE3C4FFF7EBD0FFE2E3D0FFC7EBE4FFB3EB
      ECFFC6FFFFFFB8E0E2FF779094FFD7E5E7FFFFFFFFFFF9F8F7FFF0E9E2FFFDF1
      E7FFFDEEE4FFFDEEE1FFFDECDEFFFCEADBFFFDE8D8FFFCE6D5FFFDE5D2FFFEE4
      CFFFFFE1CEFFB89A91FFDAD5D3FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7FFFFFFFBFFFEFFFDFDF9FFDACE
      C8FFDCC7BEFFE5C9BDFFE9CABFFFE8CBC0FFE7CFC6FFD6C8C1FFC5C0BDFFCDD0
      CFFF727778FF757777FFCCCECEFFFBFDFDFFE9FFFFFFB7E4ECFF9EE0F0FFA1D0
      D3FFB1C4B4FFEDEBCAFFEBE4C2FFF2EFD7FFF2F6EAFFB8CCC7FFCCF6F5FFBBEE
      F0FFD2FFFFFFD6F9F9FF8CA4A8FFB3C0C4FFFFFFFFFFFAF9F7FFF2EBE4FFFDF4
      EAFFFCF2E8FFFCF1E5FFFDEFE2FFFDECDFFFFCEBDCFFFCE9D9FFFDE8D6FFFDE6
      D3FFFFE3CFFFB79A90FFDAD5D3FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFFFFFFFEFFFEFFFFFFFAFFCEC2
      B7FFEED8C6FFFADEC8FFF8DAC2FFF6DAC4FFF0DAC8FFB9AB9FFFBDB7B0FF3130
      2FFF000001FF000000FF1F1F1FFFCFCFCFFFEDFFFFFFBEE8EDFFABF0FBFFB5F5
      FFFFA0D0D1FFA5BEACFFC5D8C0FFB1CBB7FF90BCB5FFA0E0E0FF97E3E5FF8AD0
      D6FF86BEC3FFB6D9DCFFB1C5C7FFC5D2D4FFFFFFFFFFFAF9F7FFF4EDE6FFFEF5
      EDFFFFF4ECFFFDF2EAFFFDF0E7FFFDEEE3FFFDEDE0FFFCEBDEFFFCE9DAFFFEE9
      D9FFFFE7D6FFB89A92FFDBD5D3FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFFFFFFFFFEFFFEFAF4FFCFC2
      B4FFFEEDD9FFFAE6CDFFFDE9CEFFFBE7CFFFFDF0DCFFB3A799FF79736DFF3230
      30FFC3C4C5FF7D7D7DFF101010FF717171FFF2FEFEFFC7E9ECFFB2F0F4FFB3FA
      FFFFBAF9FFFFD1FDF7FFD2F4E9FFCEF3EBFFBCF5F3FFB3FBFDFFACFAFDFF91D6
      DCFF4D7F86FFE4FDFDFFECFAFBFFF7FEFFFFFFFFFFFFFBF9F8FFF5EFE8FFFEF7
      F3FFFDF7F1FFFEF6EEFFFEF4EBFFFCF2E8FFFDF0E4FFFDEEE2FFFCE8D7FFF4CF
      B4FFF3BEA7FFB59388FFDAD6D5FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFDFFFFFFFEFEFFF0ECE6FFD2C9
      BDFFFDF1E2FFFCF1DEFFFDF0DCFFFDF2E0FFECE1D2FFB1ABA0FF837F7AFF5450
      50FF100E0FFF868686FF5F5F5FFF666666FFF8FCFFFFDBF1F4FFB0E0E1FFACE9
      ECFFB4F0F4FFBCECECFFACD3CFFFC4E7E4FFC2ECF0FFB5E8EEFFB1E8EDFFABD8
      DEFFACCBCEFFEFFEFFFFF8FEFFFFFDFFFFFFFDFFFFFFFCFAF9FFF7F3EBFFFEFB
      F6FFFDF9F5FFFEF7F2FFFFF6EFFFFEF4ECFFFEF3E8FFFEF2E7FFF5DCC0FFEAAE
      67FFC08348FFB5A191FFEDECECFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFDFEFFFEFDFCFFD7D3D0FFE5E2
      DDFFFFF9F3FFFFF8F1FFFFFAF3FFFFFCF6FFBEB5AFFFE3DFDAFFB5B6B2FF1F1F
      1DFF020101FF111010FF302E2EFFAEACACFFFDFEFFFFF0FBFBFFD7F2F1FFD3F4
      F5FFC6E8ECFFCAE8E8FFDBF3F2FFEDFFFFFFECFBFFFFE4F7F9FFE1F5F7FFE3F2
      F6FFF6FEFFFFF9FDFEFFFCFDFEFFFEFDFDFFFFFFFEFFFDFBF9FFF9F6EDFFFFFE
      F9FFFFFEF7FFFFFCF6FFFFFBF3FFFFF8F0FFFFF6EDFFFFF5E9FFF8E5CCFFD7AE
      7CFFB19F89FFF1EEEBFFFFFFFFFFFEFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFEFFF3F3F1FFCAC6C5FFDDD6
      D7FFD3CBCCFFDED1D3FFDCCFD1FFD2C6C8FFEBE3E4FFFFFEFFFFFEFFFEFFC9CB
      CAFF393C3AFF3C3C3CFFB1AFAFFFFCFAFAFFFFFFFEFFF8FEFDFFF3FFFFFFEFFB
      FEFFF3FFFFFFF3FFFFFFF3FFFFFFF6FDFFFFFFFBFFFFFFFDFFFFFEFEFEFFFFFD
      FFFFFFFCFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFFFFFFFBFAF7FFF2E6D5FFEFE0
      D0FFE9DDCEFFE7D9C9FFE4D5C6FFE2D0C4FFDECCBFFFDBCABCFFD6C1B0FFBFB3
      A8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFD5E4
      DFFFFFFFFFFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFE1EC
      E8FFC0D7D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFBFBFFE2DCD8FFBEB5
      ADFFBAB2ADFFC8C1BDFFD5CFCBFFDED9D7FFE8E4E1FFF1EEEDFFF5F3F3FFF9F8
      F7FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F7FFE2DDDBFFB8B0
      ADFFACA2A0FFADA2A1FFACA3A1FFAAA2A1FFAAA1A0FFABA1A0FFAAA1A0FFA9A0
      A0FFA99FA0FFA89F9EFFC9C7C7FFFAFAFAFFFFFFF7FFFFFEFBFFFEF9FEFFF3F0
      FDFFC2C0DAFF7374AAFF303278FF161868FF121064FF1A185DFF42416CFF9091
      A0FFE2E2E2FFFDFDFDFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFF217358FF2568
      4BFFFFFFFFFFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF7F7F7FFA6C6
      BBFF004B28FF60907BFFFFFFFFFFFFFFFFFFFFFFFFFFF3F1EFFFD3CDBEFFCCCB
      B0FFBCB9ABFFB8B4A8FFB1AE9EFFAEA89EFFACA29AFFADA39DFFACA4A0FFB7B0
      ADFFEDEAEAFFFEFDFDFFFFFFFFFFFFFFFFFFFBFBFBFFB5B4B9FFAC9794FFCCAE
      A5FFD0B2A5FFCFB0A4FFCEAEA2FFCDACA0FFCBAA9EFFCAA89CFFC8A59AFFC7A4
      97FFC6A296FFB08B83FFA39896FFF5F5F5FFFBFFF7FFFAFEFEFFE0DEF3FF847F
      B8FF211D6DFF090866FF060770FF040676FF050477FF08056CFF0A0759FF0908
      41FF464661FFB9B9C1FFFEFEFEFFFEFEFEFFFFFFFFFF91B3A5FF005737FF2B75
      5AFFFFFFFFFFEFEFEFFFEEEEEEFFEFEFEFFFEFEFEFFFEEEEEEFFECECECFFAAC8
      BFFF005636FF005535FFADCCC2FFFFFFFFFFFFFFFFFFEDEAE6FFD1CAB3FFE8F6
      CBFFDDF0C6FFD8E8C1FFD9E6C3FFDEE6CFFFE0E4D1FFD9DCCBFFDBDACFFFB0AB
      A4FFC5C0BCFFFCFBFBFFFFFFFFFFFFFFFFFFEBEEF0FF6F84A4FF85819CFFE1CE
      CFFFFFEBD7FFFFE7D0FFFFE3CAFFFFE1C5FFFEDEC0FFFFDCBCFFFED9B6FFFFD7
      B0FFFED4ADFFD8AE9AFFA39893FFF4F5F5FFF2FFFDFFDFE8F8FF6E6FAFFF1612
      71FF090479FF070587FF020390FF010395FF010294FF050389FF0A0678FF0C07
      6BFF0B084FFF31314CFFC2C2C9FFFEFEFFFFFFFFFFFF669782FF005E3FFF2B77
      5BFFFFFFFFFFE4E4E4FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE1E1E1FFAAC9
      BFFF005635FF005B3BFF2A795EFFFFFFFFFFFFFFFFFFEDEAE6FFCBC4ABFFCFE0
      B2FFCCE2B6FFE5ECC2FFF5FAD4FFEFFADCFFD9ECCEFFDAEED1FFDBF0D3FFA6AF
      9CFFB8B3AEFFFCFAFAFFFFFFFFFFFFFFFFFFEFFDFFFF7EBCF0FF567EBBFF938C
      A6FFFFF2E3FFFFEBD5FFFFE6CDFFFFE3C7FFFFE0C1FFFFDEBBFFFFDBB6FFFFD7
      B0FFFFD6ABFFD7AE99FFA29793FFF4F5F5FFF8F6FFFFA4A3DBFF0F0D75FF0909
      6FFF35379DFF040584FF04079BFF0004A5FF00039BFF0C0C89FF201B7FFF0F0A
      78FF0A0774FF09084FFF565774FFE7EBEFFFFFFFFFFF689D88FF056745FF2D7E
      60FFFFFFFFFFF4F4F4FFF4F4F4FFF5F5F5FFF5F5F5FFF4F4F4FFF3F3F3FFABCC
      C1FF005E3BFF02613FFF328165FFFFFFFFFFFFFFFFFFEDE9E6FFD0C7B0FFEAF4
      CDFFF3F7D7FFCDB194FFC6B286FFD2D4A6FFDBEAC8FFDAF0D1FFE1F5DBFFAEB5
      A4FFB8B3AEFFFEFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFDFF7FEFF86BFEEFF537E
      BEFF938BA3FFF2DED6FFFDE8D3FFFBE2C9FFFCE0C6FFFDE0C2FFFFDEBCFFFEDB
      B6FFFED9B1FFD9B19DFFA39794FFF4F4F5FFE4DFFFFF2D2A88FF0B098AFF3E40
      A3FFE3E7FFFF8E8EDEFF191A91FF080B96FF0E108AFF6260B2FFE4DFFFFF716C
      C5FF080383FF090670FF161653FFB5B7CCFFFFFFFFFF68A18BFF086F49FF046B
      44FFF9FCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7CB2
      9DFF056B47FF046945FF348668FFFFFFFFFFFFFFFFFFEEEAE7FFD3C6B2FFE6EC
      C8FFDBE7C7FFD3BCA8FFC69374FFE0B17CFFECDBACFFE7EFCDFFE1F1DCFFAFB4
      A5FFB8B3AFFFFDFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFC8DCE8FF7EB3
      E3FF6D7FA6FFC2B4B2FFE5CDB5FFE7D0B5FFE9D4BAFFEAD0B8FFF8D9BEFFFFDE
      BCFFFFDBB6FFDAB39FFFA49894FFF4F5F5FF9596F3FF090A83FF0C0C9DFF3E3F
      ABFFC4C4F1FFE7E6FAFF8A89C9FF212080FF7875BDFFDCDAF9FFDCD9F2FF716D
      C9FF08038EFF0A0788FF0A085EFF7C7AA9FFFFFFFFFF69AB91FF107E54FF0F7D
      53FF09764AFF31916BFF33916DFF34916DFF34916DFF33906DFF308D69FF0973
      4AFF0B754DFF077149FF378B6CFFFFFFFFFFFFFFFFFFEDE9E7FFD1C6B2FFE3EE
      CAFFDDF2CFFFEAEED3FFC9A07CFFBD7532FFE1A564FFD9BB8DFFE5E6D0FFAFB3
      A6FFB7B3AFFFFBFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDAD6FFD3DF
      E7FFC8C8CEFFC5B19CFFF4E9C1FFF7F3D0FFF7F5DEFFEDE4D9FFE4CBB6FFFBDE
      C0FFFFDEBCFFDBB6A2FFA49A95FFF4F5F5FF454CD4FF0308A0FF080CB6FF090C
      A4FF3736A5FFBFBEEAFFE6E6FAFFBABCDFFFEAEBFFFFDFDFF8FF696ABAFF1315
      97FF0304A3FF05079BFF070771FF535293FFFFFFFFFF6AB395FF178B5DFF178B
      5CFF168A5BFF168A5BFF16885AFF138257FF117F54FF117F55FF107E53FF107E
      53FF0F7C52FF0B784FFF3A8F6FFFFFFFFFFFFFFFFFFFEDEAE7FFCDC6B2FFE0F0
      CBFFD8F1CAFFD7EDC7FFD3C794FFC78235FFBF6812FFEAB275FFF1E1C6FFBABC
      AEFFB7B5AEFFFCFBFBFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4DBD5FFF2EA
      E4FFE5C9BCFFF4E2BAFFFCF4C2FFFFFFDBFFFFFFF3FFFFFFF7FFDFD1BEFFEFD9
      BDFFFFE0C0FFDCB9A6FFA59A97FFF4F5F5FF151AC3FF0206BBFF0306C6FF0507
      C5FF1112AAFF4F4F97FFE3E6FAFFFAFEFFFFF6F9FFFF8A8DCCFF0D128DFF060B
      ADFF0309BAFF0206AAFF090A7FFF4C4D97FFFFFFFFFF6CB698FF1A9261FF1A90
      60FF19905FFF158D5CFF108A58FF108958FF0E8657FF0D8455FF118457FF1485
      59FF138358FF0F8054FF3C9372FFFFFFFFFFFFFFFFFFEDEAE7FFCEC6B2FFE1F0
      CCFFDAF0CEFFDFEFD4FFECF4D7FFD7B984FFC87626FFC67220FFDA9C61FFAA8D
      6CFFA49B93FFF3F0EEFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFE6DDD5FFF2EE
      E8FFDABFA8FFFBEEC1FFF8EAB8FFFFFED7FFFFFFE8FFFFFFE5FFE8DFC0FFECD3
      BAFFFFE6C9FFDDBBA9FFA79C97FFF4F5F5FF1514CBFF110FCFFF1510DBFF100C
      CEFF0D0EA6FF6365AEFFDFE1F4FFFAFBFFFFF6F7FFFF8586C5FF1B1DA3FF080C
      B7FF090BC6FF0509B7FF0A0D87FF53569FFFFFFFFFFF6DBA9AFF1D9764FF1D96
      63FF189460FF5DA88CFFA0C4B7FF97BDAEFFA1C7B7FFADD0C1FF429575FF1089
      58FF16895CFF128658FF409776FFFFFFFFFFFFFFFFFFEDE9E7FFCEC7B5FFE5F0
      D2FFE1EFD4FFE5F0DAFFE6F0DCFFEAECD4FFCBAA74FFC57B3BFFCF814CFFB47C
      50FF7A6256FFC8BEBBFFFBF8F8FFFFFFFFFFFDFFFFFFFFFFFFFFE7DFD7FFF3EF
      ECFFDBC5B2FFFCF1CBFFF7E7BBFFFDF3C5FFFFFACFFFFEFACFFFE3D5B2FFEED6
      BFFFFFE8CEFFDEBEABFFA89D99FFF4F4F5FF3A3DE6FF1917CDFF221DDDFF1D18
      B9FF6768CFFFD4D7FBFFDEDCF9FFA59ECEFFD7D4F7FFE0E2FDFF8486DCFF1B1D
      B0FF1012C7FF0C0CC0FF0F108DFF7478BDFFFFFFFFFF6FBD9DFF209C67FF1E9B
      66FF2A996CFFFDFDFDFFF0EEEFFFE9E6E6FFAECBBFFF5A957DFFFEF3F7FF3997
      71FF1A9160FF168E5DFF459C7AFFFFFFFFFFFFFFFFFFEDE9E7FFCFC3B3FFE4EB
      D1FFE3F2D7FFE2F0DAFFDDEED9FFDAEDD8FFE9F4DDFFDBBB9FFFC8885AFFBB74
      33FF855C40FF907A71FFDCD6D2FFFDFCFCFFFFFFFFFFFFFFFEFFE9E1D8FFF4F0
      ECFFE8DFD8FFEBE3D6FFFBF3DEFFF9E6B9FFF8E4B1FFF7E7BAFFDEC5A8FFF6E2
      CDFFFFE9D1FFE0BFADFFAA9F9AFFF4F4F4FF7379FBFF2528C7FF342FE0FF6B66
      E4FFD9DAFFFFDADEF7FF706BC4FF2E229FFF4A46A4FFB5B6E8FFE2E2FDFF7D7F
      ECFF1111BFFF1916C3FF242397FFAEB1DDFFFFFFFFFF71C09FFF22A06AFF1F9F
      68FF48AA81FFFBFBFBFFEBEBEBFFE7E4E5FF7BB29CFF1C7E58FFFCF0F2FF4BA0
      7CFF1D9563FF199461FF4DA381FFFFFFFFFFFFFFFFFFECE8E6FFD8CDC0FFF4FA
      E4FFE8F6E0FFDDEED8FFDBEDD8FFD8EDD9FFDDF8DEFFE1EFD2FFD3B278FFD288
      36FF824A09FF7D5941FFAEA29DFFF7F6F5FFFFFFFFFFFFFFFEFFEAE2D8FFF5F1
      EDFFFFFFFFFFD9CAC4FFE4DCC7FFFFF8D0FFFFF1C6FFD9BBA0FFE7D3C3FFFFEC
      DBFFFFEDD7FFE0C0B1FFAB9F9BFFF4F4F4FFC4C5FFFF3C3BBCFF433FE4FF595A
      D2FFE1E6FFFF6369D4FF0D0FADFF0B0BCDFF1212BEFF322FACFFA8A3F6FF6A67
      E7FF2523C9FF1F1BAEFF504FA8FFDCE0F4FFFFFFFFFF86C5ABFF23A66CFF20A3
      6AFF4AB085FFFBFBFBFFEBEBEBFFE6E4E4FF83BCA4FF208D5FFFFAEEF1FF4CA3
      7FFF1C9663FF1E9A66FF90C2AFFFFFFFFFFFFEFEFEFFEDEAE8FFCBC2B5FFD6E4
      CFFFD3E6CFFFDBEFDCFFE0F2E0FFE1F4E2FFE0EDE1FFE0EFE0FFECF3DEFFC8AB
      74FFC47A2CFFB68967FFC9BAB4FFF8F7F7FFFFFFFFFFFFFFFEFFECE5DAFFF5F1
      EEFFFFFFFFFFFEFCFCFFE3DBD9FFD3C8C2FFDED1C9FFF8EEE4FFFDF6EBFFEDDA
      CCFFEDB9ADFFD39E93FFB3A5A2FFF5F5F5FFEEF2FFFF8888DBFF504CD8FF6362
      DFFF575AC6FF484ECEFF2F35DAFF1B20E0FF2125DEFF3738D1FF4542C4FF3C39
      D1FF3736D3FF4340ADFFB5B5E0FFF8FAFFFFFFFFFFFFF3F8F6FF249B69FF2EAC
      75FF48B284FFFCFCFCFFEBEBEBFFDFE0DFFFFBF7F5FFE4F1E8FFE7E4E3FF45A2
      7AFF27A06DFF57B28CFFFFFFFFFFFFFFFFFFFFFFFFFFEFE8E8FFD1BCB9FFC4C7
      C9FFFFF9F7FFD0D6DAFFE7E6E8FFE0E8EBFFEEECE9FFDCE4E1FFEAF1EEFFC1BA
      AEFFB59061FFCDB599FFECE5DFFFFEFDFEFFFFFFFFFFFFFFFEFFEEE6DBFFF7F2
      EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFFFFFBF6FFF4ECE3FFCDAA
      9AFFC68F74FFB58D81FFD6CDCBFFFCFCFCFFF5FDFFFFD9DCF7FF7C79D4FF635F
      D7FF807DFAFF8485FBFF787BF8FF6469F3FF6269F8FF5D61F4FF5556EEFF4546
      E1FF3A3CBEFFA0A1D8FFF1F2FFFFFEFFFEFFFFFFFFFFFFFFFFFFF9FBFAFFB1DE
      CAFFBEE4D3FFF4F2F3FFF1F1F1FFF1F1F1FFF2F1F2FFF3F2F3FFF4F2F3FFC6E6
      D8FFB1DECBFFE7F3EEFFFFFFFFFFFFFFFFFFFFFFFFFFF5F0F1FFB7AFB4FF7A8D
      9CFFA79EA6FF7B8A98FF9194A0FF7E97A6FFABA6AFFF8BA1AEFF9FB5C2FF8D96
      9DFFD5D0C9FFFBF8F3FFFFFEFDFFFFFEFFFFFFFFFFFFFFFFFEFFF0E8DCFFF8F4
      EFFFFFFFFEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFBFFF4EEE6FFCCAB
      98FFC49D86FFDFCFC7FFFBFAF9FFFFFFFFFFFAFDFFFFF8F8FFFFDBD7F7FF908E
      D9FF6869CCFF7E80E9FF9194FFFF9093FFFF7D7DFFFF6969F3FF5254D4FF6264
      C8FFC2C5EDFFEFF2FFFFFCFBFFFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFC3ECF4FF9FDC
      ECFF9ADCECFF99D6E8FF98CFE4FF99CEDFFF7CA7C5FF90BDD6FF87AFC8FFBCD0
      DAFFFAFAFBFFFFFEFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFEFFEFE3D6FFE4D0
      BCFFE3D3BDFFE0CEBDFFDCCABBFFD7C5B9FFD1C0B6FFCEBDB2FFC6B1A7FFB892
      85FFEEE2DBFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFFFFFCFFFFFDF8FFFFF1F1
      FFFFBDC2FFFF8F92F5FF6D70E0FF6969E4FF6760E9FF7A76F7FFA8AAFFFFE3E7
      FFFFF8FAFFFFFBFCFFFFFEFDFFFFFFFBFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2EFFC00000000000000
      0000000000000000000000000000000000000000000000000000CFE0DB00D0E1
      DC00D1E2DD00D1E2DC00E0EBE800000000000000000000000000000000000000
      000000000000E7F3FD000000000000000000FAFCFE00E8F4FD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9FCFB00D2E9DF00A1D3BD007DC2A4008BCAB000C5E4D500EDF7F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000004C9CED00000000000000
      0000000000000000000000000000000000000000000000000000007A44000180
      4D0003824E0004844F0000784100D6E6E1000000000000000000000000000000
      0000000000003EA1F1000000000000000000DAECFC0051A9F100000000000000
      0000C6E4D70045AE81000000000000000000000000000000000000000000E2F2
      EA003EA17400007E420000784000027A45000076420000723900168C5A0082C6
      A900000000000000000000000000000000000000000000000000000000000000
      80000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000005AAAF100000000000000
      0000000000000000000000000000000000000000000000000000CCDED800148E
      5C001E9A65001F9A66000B925900D3E7E0000000000000000000000000000000
      000000000000459FEE000000000000000000DAEBFB0053A0EF008CCDB10035AF
      7A0036AE7B002EAB740060B29000000000000000000000000000DBEFE6002B9D
      6E00088D500009905600007E4200B4DDCE0000641F00138A5D000D8251000072
      3C0094D0B4000000000000000000000000000000000000000000000000000000
      8000000080000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000005AADF100000000000000
      00000000000000000000000000000000000000000000F2F3F3000F915A001E9C
      6700219E6900229E69000F975D00D4E8E0000000000000000000000000000000
      000000000000449DED000000000000000000F9FBFF00DDE8FF0039B27D0039B0
      7D0030AB760026A76F00068E5500F6F8F80000000000F9FDFB0063BB96000B92
      58001FA66B0078C2A300F9FAF90000000000BFDACB00098854000D8857001287
      580006804E00C1E8D70000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000005BB0F400000000000000
      0000000000000000000000000000FCFAFC0063AC8F00048B5200209F690022A0
      6A0022A26B001EA26900149C6200D6E9E1000000000000000000000000000000
      000000000000449AED000000000000000000F9FBF90058BB8B0039B07C0031AC
      770027A770001EA36900DAE8E3000000000000000000CEEBDE00199E640033AD
      7A0035AD7800189A63000085430000600A009AD3BC00C7E4D8000F8E59001991
      6000047F4F006FB89B0000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000005CB2F300000000000000
      000000000000000000008FC1AD0014905D0015996100219F690023A26B001FA3
      6A00189F640064B7940019A16600D7EBE3000000000000000000000000000000
      0000000000004095EB0000000000E3F1EC0045B383003FB4810032AC760028A8
      71001AA267002C9D6E00000000000000000000000000B6E1CE0025A76F0043B5
      84003DB17D00109B60003EAD7D007DC5A800CBE7DB0070BD9C0010925C001C95
      63000D88550050A98400F1FBF600000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000063B5F300000000000000
      000000000000000000001799620023A26B0024A46D0024A56E0081C3A8000000
      000000000000000000008ACBAF00E2F2EB000000000000000000000000000000
      0000000000000000000034AE79003BB37E0037AE7A002EAC7500149D62006BB6
      98000000000000000000000000000000000000000000B6E1CE0031AC770050BB
      8D0040B3800057B88E00BFE3D4009ED6BF003FAD7C000E965C001E9C66001E9B
      65000F8D59004EA98300F1FBF700000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000068B8F300000000000000
      00000000000000000000209C670022A46C0027A76F002BAA7200B1DAC9000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000083C9AB0039B07C0034AD78002CAA720023A66E009BCAB8000000
      00000000000000000000000000000000000000000000D2EEE20037AF7A005DC2
      940049B9880093D2B700CEEADE000087380016A0640035A877001D9F6700229E
      69000189510077BA9F0000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFFFE006EBBF500000000000000
      000000000000D7E8E10023A66D002AA9710031AC770037AF7A0060BB94000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F6F9F8003CAE7C002EAB750029A8700023A56C00209E6900000000000000
      00000000000000000000000000000000000000000000F9FDFA0081CEAC003DB4
      810070CCA30031AE770081CAA90000000000EAF3EE0058B98E00149F62000F9C
      5F0039A17500FEFFFF0000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFFFE0075BEF600000000000000
      0000ACD3C400189B63002CA9730034AE79003AB07D0036B07B00000000000000
      000000000000000000000000000000000000EDF6F20000000000000000000000
      0000000000009ECFBB0025A66E0024A56D001FA26A0048A57F00000000000000
      0000000000000000000000000000000000000000000000000000E8F6F0005FC2
      960052BD8D0063C69A0016A36600DCDFE000008A35001FA66D0019A165002DA6
      7200ECFAF4000000000000000000000000000000000000000000000000000000
      8000000080000000800000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000C5E4FE005BAE8C00139D
      610025A76F0030AB76003FB4800038AF7B00B2DDCA0000000000000000000000
      0000000000000000000000000000000000008CCBB1001BA56900B6DACB0023A0
      6A001DA3690022A36C0022A069001E9E67000A915700389A7300000000000000
      000000000000000000000000000000000000000000000000000000000000EFF9
      F50064C3990045BB86003CBD840082C1A30082BBA3001FA96D006FC79F00DFF3
      EB00000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000017A1650026A7
      6F0030AC760038AF7B003CB07E00CBE8DC000000000000000000000000000000
      0000000000000000000000000000000000008BC8AF001CA469001C9F670021A3
      6B0022A16B0022A06A0010965D00148C5C00B6D5CA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F5FCF900A0DDC00078B4990089B8A2008AA29900C7D9D100FBFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000F4F7F6001F95650026A76E002FAB
      750038B07B003CB37F00F3F8F600000000000000000000000000000000000000
      00000000000000000000000000000000000087C5AB001AA0660021A06A00229F
      6A00209D680012965E0091C1B000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F4EDF10093B0A40097C8B200C1C0C000F2F2F200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000FFFF0000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000C7E1D7000A965A002DAA740036AF
      7A0037B17B005DBB930000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084C1A800189C6300209C67001F9B
      66001E9565007CB9A00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE0092DBBA0044C28B0062CB9C002AB77900B6E9D100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000020A46A008FCD
      B300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080BBA3000A8F560013905C00128F
      5B000D8C5700037D4D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFEFE0095D9BB0051C08D0065C69C0046B6840054BE8E00DAF2E8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DBEDE6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6E6E0005BA7890063A98E0063A8
      8D0061A68D0058A2860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFDFB00E2F5ED00C5ECDA009ADBBD0096DABB00E5F7EF000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C007BFC1FB3FF01FC007BFC0FB33E00F
      C007BFC0FB01C007C007BF80FB008103C007BE00FB018003C007BC00FA038001
      C007BC1CFC0F8001C007BC1FF81F8003C007381FF03F8103C007303F783FC007
      C007807F003FE00FC007C0FF007FF01FC00701FF01FFF83FC00703FF03FFF03F
      C007CFFF03FFF01FC007DFFF03FFF81F00000000000000000000000000000000
      000000000000}
  end
  inherited ActionList1: TActionList
    Left = 232
    Top = 280
    object ActQuitar: TAction
      Caption = 'Quitar conta'
      ImageIndex = 1
      OnExecute = ActQuitarExecute
    end
    object ActRemoveQuit: TAction
      Caption = 'Remover Quita'#231#227'o'
      ImageIndex = 2
      OnExecute = ActRemoveQuitExecute
    end
  end
  object frxReport1: TfrxReport
    Version = '5.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42313.403034398200000000
    ReportOptions.LastChange = 43186.737890416670000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      'periodo: string;                                 '
      'iddopedido: integer;'
      'valor_conta, valor_quitado: currency;'
      ''
      'procedure DetailData1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '//   if <frxDBDataset2.eof> then'
      '//   begin'
      '//      memo3.text:= CurrToStr(valor_conta);'
      ''
      ''
      '//   end;'
      'end;'
      ''
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  iddopedido:=0;'
      ''
      'end;'
      ''
      'procedure DetailData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      '  if <frxDBDataset2."STATUS"> = 0 then'
      '  begin'
      
        '      valor_conta := <frxDBDataset2."VALOR_CONTA"> + valor_conta' +
        ';'
      '      subdetaildata1.visible:=true;'
      '//      memo13.text := '#39'teste'#39';'
      '  end'
      '  else'
      '  begin'
      '  if <frxDBDataset2."STATUS"> = 1 then'
      
        '      valor_quitado := <frxDBDataset2."VALOR_QUITATO"> + valor_q' +
        'uitado;'
      '       subdetaildata1.visible:=false;'
      '  end;'
      '{'
      '  if (iddopedido = <frxDBDataset2."IDPEDIDO">) then'
      '  begin'
      '       subdetaildata1.visible:=false;'
      '  end'
      '  else'
      '  begin'
      '     if iddopedido <> 0 then'
      '     begin'
      '       subdetaildata1.visible:=true;'
      '       iddopedido:=<frxDBDataset2."IDPEDIDO">;'
      '     end'
      '     else'
      '       iddopedido:=<frxDBDataset2."IDPEDIDO">;'
      '  end;'
      '}'
      'end;'
      ''
      'procedure DetailData2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Valor_conta := 0;'
      '  valor_quitado :=0;'
      ''
      'end;'
      ''
      'procedure Memo15OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure PageFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//      memo14.text := FormatFloat('#39'###,##0.00'#39',Valor_conta);   ' +
        '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 352
    Top = 280
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end
      item
        DataSet = frxDBDataset2
        DataSetName = 'frxDBDataset2'
      end
      item
        DataSet = frxDBDataset3
        DataSetName = 'frxDBDataset3'
      end
      item
        DataSet = frxDBDataset4
        DataSetName = 'frxDBDataset4'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 279.000000000000000000
      PaperHeight = 216.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object Titulo: TfrxReportTitle
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 978.898270000000000000
        object Shape1: TfrxShapeView
          Left = 1.000000000000000000
          Width = 975.118740000000000000
          Height = 45.354360000000000000
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.559060000000000000
          Width = 963.780150000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Relatorio de Contas')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Fill.BackColor = clScrollBar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 49.133890000000000000
        ParentFont = False
        Top = 404.409710000000000000
        Width = 978.898270000000000000
        OnBeforePrint = 'PageFooter1OnBeforePrint'
        object Memo1: TfrxMemoView
          Left = 899.528140000000000000
          Top = 30.236240000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page#]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 404.409710000000000000
          Top = 3.779530000000000000
          Width = 257.008040000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Pago: [SUM(<frxDBDataset2."VALOR_QUITATO">,DetailData1,1)]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 706.772110000000000000
          Top = 3.779530000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              'Total Devido: [SUM(IIF(<frxDBDataset2."STATUS">=0,<frxDBDataset2' +
              '."VALOR_CONTA">,0),DetailData1,1)] ')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 11.338590000000000000
          Top = 3.779530000000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Total Renegociado: [SUM(IIF(<frxDBDataset2."STATUS">=2,<frxDBDat' +
              'aset2."VALOR_CONTA">,0),DetailData1,1)] ')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 26.456692910000000000
        Top = 86.929190000000000000
        Width = 978.898270000000000000
        Stretched = True
        object Memo6: TfrxMemoView
          Left = -9.354360000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial Narrow'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo de')
          ParentFont = False
        end
        object frxDBDataset4data_inicio: TfrxMemoView
          Left = 90.708720000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'data_inicio'
          DataSet = frxDBDataset4
          DataSetName = 'frxDBDataset4'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial Narrow'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset4."data_inicio"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 188.976500000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial Narrow'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'at'#233)
          ParentFont = False
        end
        object frxDBDataset4data_final: TfrxMemoView
          Left = 226.771800000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'data_final'
          DataSet = frxDBDataset4
          DataSetName = 'frxDBDataset4'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial Narrow'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset4."data_final"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 691.653990000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Status:     0 - Aberto     1 - Houve Pgto     2 - Renegociado')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 359.055350000000000000
        Width = 978.898270000000000000
        object frxDBDataset4totalconta: TfrxMemoView
          Left = 706.772110000000000000
          Top = 3.779530000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset4
          DataSetName = 'frxDBDataset4'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral Devido: [frxDBDataset4."totalconta"]')
          ParentFont = False
        end
        object frxDBDataset4totalquitado: TfrxMemoView
          Left = 404.409710000000000000
          Top = 3.779530000000000000
          Width = 257.008040000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset4
          DataSetName = 'frxDBDataset4'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total Geral Pago: [frxDBDataset4."totalquitado"]')
          ParentFont = False
        end
        object frxDBDataset4totalnegociado: TfrxMemoView
          Left = 11.338590000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset4
          DataSetName = 'frxDBDataset4'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total Geral Negociado: [frxDBDataset4."totalnegociado"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Fill.BackColor = cl3DDkShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 35.905524020000000000
        ParentFont = False
        Top = 173.858380000000000000
        Width = 978.898270000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        StartNewPage = True
        object frxDBDataset1NOME: TfrxMemoView
          Left = 7.559060000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            'Nome: [frxDBDataset1."NOME"]')
        end
        object frxDBDataset1CNPJ_CPF: TfrxMemoView
          Left = 419.527830000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            'CPF/CNPJ: '
            '[frxDBDataset1."CNPJ_CPF"]')
        end
        object frxDBDataset1TELEFONE: TfrxMemoView
          Left = 623.622450000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            'Telefone: [frxDBDataset1."TELEFONE"]')
        end
        object Memo3: TfrxMemoView
          Left = 7.559060000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Conta')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 124.724490000000000000
          Top = 18.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Pedido')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 257.008040000000000000
          Top = 18.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Emiss'#227'o')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 563.149970000000000000
          Top = 18.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 816.378480000000000000
          Top = 18.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Conta R$')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 404.409710000000000000
          Top = 18.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Pago R$')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 706.772110000000000000
          Top = 18.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Status')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 234.330860000000000000
        Width = 978.898270000000000000
        OnAfterPrint = 'DetailData1OnAfterPrint'
        OnBeforePrint = 'DetailData1OnBeforePrint'
        DataSet = frxDBDataset2
        DataSetName = 'frxDBDataset2'
        FooterAfterEach = True
        KeepFooter = True
        RowCount = 0
        object frxDBDataset2NUMCONTA: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'NUMCONTA'
          DataSet = frxDBDataset2
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset2."NUMCONTA"]')
          ParentFont = False
        end
        object frxDBDataset2DATA_LANC: TfrxMemoView
          Left = 257.008040000000000000
          Top = 3.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset2
          DataSetName = 'frxDBDataset2'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset2."DATA_LANC"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 563.149970000000000000
          Top = 3.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset2
          DataSetName = 'frxDBDataset2'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset2."DATA_VENC"]')
          ParentFont = False
        end
        object frxDBDataset2PEDIDO_NUM: TfrxMemoView
          Left = 124.724490000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PEDIDO_NUM'
          DataSet = frxDBDataset2
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset2."PEDIDO_NUM"]')
          ParentFont = False
        end
        object frxDBDataset2VALOR_CONTA: TfrxMemoView
          Left = 816.378480000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset2
          DataSetName = 'frxDBDataset2'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset2."VALOR_CONTA"]')
          ParentFont = False
        end
        object frxDBDataset2VALOR_QUITATO: TfrxMemoView
          Left = 404.409710000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset2
          DataSetName = 'frxDBDataset2'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset2."VALOR_QUITATO"]')
          ParentFont = False
        end
        object frxDBDataset2STATUS: TfrxMemoView
          Left = 706.772110000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset2
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset2."STATUS"]')
          ParentFont = False
        end
      end
      object SubdetailData1: TfrxSubdetailData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 275.905690000000000000
        Width = 978.898270000000000000
        DataSet = frxDBDataset3
        DataSetName = 'frxDBDataset3'
        RowCount = 0
        object frxDBDataset3EAN13: TfrxMemoView
          Left = 124.724490000000000000
          Top = 3.779530000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'EAN13'
          DataSet = frxDBDataset3
          DataSetName = 'frxDBDataset3'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset3."EAN13"]')
          ParentFont = False
        end
        object frxDBDataset3DESCRICAO: TfrxMemoView
          Left = 257.008040000000000000
          Top = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBDataset3
          DataSetName = 'frxDBDataset3'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset3."DESCRICAO"]')
          ParentFont = False
        end
        object frxDBDataset3QUANTIDADE: TfrxMemoView
          Left = 706.772110000000000000
          Top = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          DataField = 'QUANTIDADE'
          DataSet = frxDBDataset3
          DataSetName = 'frxDBDataset3'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset3."QUANTIDADE"]')
          ParentFont = False
        end
        object frxDBDataset3VALOR_TOTAL: TfrxMemoView
          Left = 816.378480000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset3
          DataSetName = 'frxDBDataset3'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset3."VALOR_TOTAL"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'NOME=NOME'
      'CNPJ_CPF=CNPJ_CPF'
      'CIDADE_END=CIDADE_END'
      'UF_END=UF_END'
      'TELEFONE=TELEFONE'
      'ATIVO=ATIVO'
      'TIPO_CONTATO=TIPO_CONTATO')
    DataSource = DataCliente
    BCDToCurrency = False
    Left = 352
    Top = 336
  end
  object DataItens: TDataSource
    DataSet = CdsItens
    Left = 168
    Top = 279
  end
  object DspItens: TDataSetProvider
    DataSet = QryItens
    UpdateMode = upWhereKeyOnly
    Left = 168
    Top = 383
  end
  object QryItens: TSQLQuery
    DataSource = DataConsulta
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select pedido_itens.*, pedido.coo, pedido.ccf'
      
        'from pedido_itens inner join pedido on pedido.id = pedido_itens.' +
        'idpedido')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 168
    Top = 432
    object QryItensID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryItensIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
      Required = True
    end
    object QryItensIDPRODUTO: TIntegerField
      FieldName = 'IDPRODUTO'
      Required = True
    end
    object QryItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object QryItensQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object QryItensVALOR: TFloatField
      FieldName = 'VALOR'
      currency = True
    end
    object QryItensDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      currency = True
    end
    object QryItensACRESCIMO: TFloatField
      FieldName = 'ACRESCIMO'
      currency = True
    end
    object QryItensVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      currency = True
    end
    object QryItensMARGEM: TFloatField
      FieldName = 'MARGEM'
    end
    object QryItensVALOR_REAL: TFloatField
      FieldName = 'VALOR_REAL'
      currency = True
    end
    object QryItensTIPOPROD: TIntegerField
      FieldName = 'TIPOPROD'
    end
    object QryItensCANCELADO: TStringField
      FieldName = 'CANCELADO'
      FixedChar = True
      Size = 1
    end
    object QryItensNUM_ITEM: TIntegerField
      FieldName = 'NUM_ITEM'
    end
    object QryItensEAN13: TStringField
      FieldName = 'EAN13'
      Size = 14
    end
    object QryItensCST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object QryItensCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object QryItensALIQ_ICMS: TFloatField
      FieldName = 'ALIQ_ICMS'
    end
    object QryItensBASE_ICMS: TFloatField
      FieldName = 'BASE_ICMS'
    end
    object QryItensVALOR_ICMS: TFloatField
      FieldName = 'VALOR_ICMS'
    end
    object QryItensREDUCAO_BASE: TFloatField
      FieldName = 'REDUCAO_BASE'
    end
    object QryItensALIQ_ICMS_ST: TFloatField
      FieldName = 'ALIQ_ICMS_ST'
    end
    object QryItensBASE_ICMS_ST: TFloatField
      FieldName = 'BASE_ICMS_ST'
    end
    object QryItensVALOR_ICMS_ST: TFloatField
      FieldName = 'VALOR_ICMS_ST'
    end
    object QryItensVALOR_PIS: TFloatField
      FieldName = 'VALOR_PIS'
    end
    object QryItensVALOR_COFINS: TFloatField
      FieldName = 'VALOR_COFINS'
    end
    object QryItensVALOR_IPI: TFloatField
      FieldName = 'VALOR_IPI'
    end
    object QryItensMD5REGISTRO: TStringField
      FieldName = 'MD5REGISTRO'
      Size = 32
    end
    object QryItensID_BICO: TIntegerField
      FieldName = 'ID_BICO'
    end
    object QryItensID_TANQUE: TIntegerField
      FieldName = 'ID_TANQUE'
    end
    object QryItensID_BOMBA: TIntegerField
      FieldName = 'ID_BOMBA'
    end
    object QryItensEI: TFloatField
      FieldName = 'EI'
    end
    object QryItensEF: TFloatField
      FieldName = 'EF'
    end
    object QryItensMVA: TFloatField
      FieldName = 'MVA'
    end
    object QryItensID_VENDEDOR: TIntegerField
      FieldName = 'ID_VENDEDOR'
    end
    object QryItensCOO: TIntegerField
      FieldName = 'COO'
    end
    object QryItensCCF: TIntegerField
      FieldName = 'CCF'
    end
    object QryItensGNF: TIntegerField
      FieldName = 'GNF'
    end
    object QryItensNUMSERIEECF: TStringField
      FieldName = 'NUMSERIEECF'
      Size = 30
    end
    object QryItensID_ABASTECIMENTO: TIntegerField
      FieldName = 'ID_ABASTECIMENTO'
    end
    object QryItensALIQ_PIS: TFloatField
      FieldName = 'ALIQ_PIS'
    end
    object QryItensALIQ_COFINS: TFloatField
      FieldName = 'ALIQ_COFINS'
    end
    object QryItensBASE_PIS: TFloatField
      FieldName = 'BASE_PIS'
    end
    object QryItensBASE_COFINS: TFloatField
      FieldName = 'BASE_COFINS'
    end
    object QryItensALIQ_IPI: TFloatField
      FieldName = 'ALIQ_IPI'
    end
    object QryItensBASE_IPI: TFloatField
      FieldName = 'BASE_IPI'
    end
    object QryItensCST_IPI: TStringField
      FieldName = 'CST_IPI'
      FixedChar = True
      Size = 2
    end
    object QryItensCST_PIS: TStringField
      FieldName = 'CST_PIS'
      FixedChar = True
      Size = 2
    end
    object QryItensCST_COFINS: TStringField
      FieldName = 'CST_COFINS'
      FixedChar = True
      Size = 2
    end
    object QryItensALIQ_ISS: TFloatField
      FieldName = 'ALIQ_ISS'
    end
    object QryItensBASE_ISS: TFloatField
      FieldName = 'BASE_ISS'
    end
    object QryItensVALOR_ISS: TFloatField
      FieldName = 'VALOR_ISS'
    end
    object QryItensUNIDADE: TStringField
      FieldName = 'UNIDADE'
      FixedChar = True
      Size = 3
    end
    object QryItensVALOR_REENBOLSO: TFloatField
      FieldName = 'VALOR_REENBOLSO'
    end
    object QryItensVALOR_SUBSIDIO: TFloatField
      FieldName = 'VALOR_SUBSIDIO'
    end
    object QryItensID_BICO_PERDA: TIntegerField
      FieldName = 'ID_BICO_PERDA'
    end
    object QryItensID_COR: TIntegerField
      FieldName = 'ID_COR'
    end
    object QryItensID_TAMANHO: TIntegerField
      FieldName = 'ID_TAMANHO'
    end
    object QryItensCSOSN: TStringField
      FieldName = 'CSOSN'
      FixedChar = True
      Size = 3
    end
    object QryItensDESCONTO_TOTAL: TFloatField
      FieldName = 'DESCONTO_TOTAL'
    end
    object QryItensPERC_FCP: TFloatField
      FieldName = 'PERC_FCP'
    end
    object QryItensALIQ_INTERNO: TFloatField
      FieldName = 'ALIQ_INTERNO'
    end
    object QryItensPERC_DIFAL: TFloatField
      FieldName = 'PERC_DIFAL'
    end
    object QryItensPERC_PART_DIFAL: TFloatField
      FieldName = 'PERC_PART_DIFAL'
    end
    object QryItensVALOR_FCP: TFloatField
      FieldName = 'VALOR_FCP'
    end
    object QryItensVALOR_ICMS_INTERNO: TFloatField
      FieldName = 'VALOR_ICMS_INTERNO'
    end
    object QryItensVALOR_ICMS_DEST: TFloatField
      FieldName = 'VALOR_ICMS_DEST'
    end
  end
  object CdsItens: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'IDPEDIDO'
    MasterFields = 'IDPEDIDO'
    MasterSource = DataConsulta
    PacketRecords = 0
    Params = <>
    ProviderName = 'DspItens'
    ReadOnly = True
    Left = 168
    Top = 335
    object CdsItensID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsItensIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
      Required = True
    end
    object CdsItensIDPRODUTO: TIntegerField
      FieldName = 'IDPRODUTO'
      Required = True
    end
    object CdsItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object CdsItensQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '0.000'
    end
    object CdsItensVALOR: TFloatField
      FieldName = 'VALOR'
      currency = True
    end
    object CdsItensDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      currency = True
    end
    object CdsItensACRESCIMO: TFloatField
      FieldName = 'ACRESCIMO'
      currency = True
    end
    object CdsItensVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      currency = True
    end
    object CdsItensMARGEM: TFloatField
      FieldName = 'MARGEM'
    end
    object CdsItensVALOR_REAL: TFloatField
      FieldName = 'VALOR_REAL'
      currency = True
    end
    object CdsItensTIPOPROD: TIntegerField
      FieldName = 'TIPOPROD'
    end
    object CdsItensCANCELADO: TStringField
      FieldName = 'CANCELADO'
      FixedChar = True
      Size = 1
    end
    object CdsItensNUM_ITEM: TIntegerField
      FieldName = 'NUM_ITEM'
    end
    object CdsItensEAN13: TStringField
      FieldName = 'EAN13'
      Size = 14
    end
    object CdsItensCST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object CdsItensCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object CdsItensALIQ_ICMS: TFloatField
      FieldName = 'ALIQ_ICMS'
    end
    object CdsItensBASE_ICMS: TFloatField
      FieldName = 'BASE_ICMS'
    end
    object CdsItensVALOR_ICMS: TFloatField
      FieldName = 'VALOR_ICMS'
    end
    object CdsItensREDUCAO_BASE: TFloatField
      FieldName = 'REDUCAO_BASE'
    end
    object CdsItensALIQ_ICMS_ST: TFloatField
      FieldName = 'ALIQ_ICMS_ST'
    end
    object CdsItensBASE_ICMS_ST: TFloatField
      FieldName = 'BASE_ICMS_ST'
    end
    object CdsItensVALOR_ICMS_ST: TFloatField
      FieldName = 'VALOR_ICMS_ST'
    end
    object CdsItensVALOR_PIS: TFloatField
      FieldName = 'VALOR_PIS'
    end
    object CdsItensVALOR_COFINS: TFloatField
      FieldName = 'VALOR_COFINS'
    end
    object CdsItensVALOR_IPI: TFloatField
      FieldName = 'VALOR_IPI'
    end
    object CdsItensMD5REGISTRO: TStringField
      FieldName = 'MD5REGISTRO'
      Size = 32
    end
    object CdsItensID_BICO: TIntegerField
      FieldName = 'ID_BICO'
    end
    object CdsItensID_TANQUE: TIntegerField
      FieldName = 'ID_TANQUE'
    end
    object CdsItensID_BOMBA: TIntegerField
      FieldName = 'ID_BOMBA'
    end
    object CdsItensEI: TFloatField
      FieldName = 'EI'
    end
    object CdsItensEF: TFloatField
      FieldName = 'EF'
    end
    object CdsItensMVA: TFloatField
      FieldName = 'MVA'
    end
    object CdsItensID_VENDEDOR: TIntegerField
      FieldName = 'ID_VENDEDOR'
    end
    object CdsItensCOO: TIntegerField
      FieldName = 'COO'
    end
    object CdsItensCCF: TIntegerField
      FieldName = 'CCF'
    end
    object CdsItensGNF: TIntegerField
      FieldName = 'GNF'
    end
    object CdsItensNUMSERIEECF: TStringField
      FieldName = 'NUMSERIEECF'
      Size = 30
    end
    object CdsItensID_ABASTECIMENTO: TIntegerField
      FieldName = 'ID_ABASTECIMENTO'
    end
    object CdsItensALIQ_PIS: TFloatField
      FieldName = 'ALIQ_PIS'
    end
    object CdsItensALIQ_COFINS: TFloatField
      FieldName = 'ALIQ_COFINS'
    end
    object CdsItensBASE_PIS: TFloatField
      FieldName = 'BASE_PIS'
    end
    object CdsItensBASE_COFINS: TFloatField
      FieldName = 'BASE_COFINS'
    end
    object CdsItensALIQ_IPI: TFloatField
      FieldName = 'ALIQ_IPI'
    end
    object CdsItensBASE_IPI: TFloatField
      FieldName = 'BASE_IPI'
    end
    object CdsItensCST_IPI: TStringField
      FieldName = 'CST_IPI'
      FixedChar = True
      Size = 2
    end
    object CdsItensCST_PIS: TStringField
      FieldName = 'CST_PIS'
      FixedChar = True
      Size = 2
    end
    object CdsItensCST_COFINS: TStringField
      FieldName = 'CST_COFINS'
      FixedChar = True
      Size = 2
    end
    object CdsItensALIQ_ISS: TFloatField
      FieldName = 'ALIQ_ISS'
    end
    object CdsItensBASE_ISS: TFloatField
      FieldName = 'BASE_ISS'
    end
    object CdsItensVALOR_ISS: TFloatField
      FieldName = 'VALOR_ISS'
    end
    object CdsItensUNIDADE: TStringField
      FieldName = 'UNIDADE'
      FixedChar = True
      Size = 3
    end
    object CdsItensVALOR_REENBOLSO: TFloatField
      FieldName = 'VALOR_REENBOLSO'
    end
    object CdsItensVALOR_SUBSIDIO: TFloatField
      FieldName = 'VALOR_SUBSIDIO'
    end
    object CdsItensID_BICO_PERDA: TIntegerField
      FieldName = 'ID_BICO_PERDA'
    end
    object CdsItensID_COR: TIntegerField
      FieldName = 'ID_COR'
    end
    object CdsItensID_TAMANHO: TIntegerField
      FieldName = 'ID_TAMANHO'
    end
    object CdsItensCSOSN: TStringField
      FieldName = 'CSOSN'
      FixedChar = True
      Size = 3
    end
    object CdsItensDESCONTO_TOTAL: TFloatField
      FieldName = 'DESCONTO_TOTAL'
    end
    object CdsItensPERC_FCP: TFloatField
      FieldName = 'PERC_FCP'
    end
    object CdsItensALIQ_INTERNO: TFloatField
      FieldName = 'ALIQ_INTERNO'
    end
    object CdsItensPERC_DIFAL: TFloatField
      FieldName = 'PERC_DIFAL'
    end
    object CdsItensPERC_PART_DIFAL: TFloatField
      FieldName = 'PERC_PART_DIFAL'
    end
    object CdsItensVALOR_FCP: TFloatField
      FieldName = 'VALOR_FCP'
    end
    object CdsItensVALOR_ICMS_INTERNO: TFloatField
      FieldName = 'VALOR_ICMS_INTERNO'
    end
    object CdsItensVALOR_ICMS_DEST: TFloatField
      FieldName = 'VALOR_ICMS_DEST'
    end
  end
  object frxDBDataset2: TfrxDBDataset
    UserName = 'frxDBDataset2'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DATA_LANC=DATA_LANC'
      'DATA_VENC=DATA_VENC'
      'ID=ID'
      'NUMCONTA=NUMCONTA'
      'CONTATO=CONTATO'
      'VALOR_CONTA=VALOR_CONTA'
      'DATA_QUIT=DATA_QUIT'
      'VALOR_QUITATO=VALOR_QUITATO'
      'SERIE=SERIE'
      'IDPEDIDO=IDPEDIDO'
      'STATUS=STATUS'
      'ID_1=ID_1'
      'PEDIDO_NUM=PEDIDO_NUM'
      'DATA_PEDIDO=DATA_PEDIDO'
      'VALOR=VALOR'
      'DESCONTO=DESCONTO'
      'ACRESCIMO=ACRESCIMO'
      'OUTRAS_DESPESAS=OUTRAS_DESPESAS'
      'VALOR_TOTAL=VALOR_TOTAL'
      'IDCONTATO=IDCONTATO')
    DataSource = DataConsulta
    BCDToCurrency = False
    Left = 352
    Top = 392
  end
  object frxDBDataset3: TfrxDBDataset
    UserName = 'frxDBDataset3'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'IDPEDIDO=IDPEDIDO'
      'IDPRODUTO=IDPRODUTO'
      'DESCRICAO=DESCRICAO'
      'QUANTIDADE=QUANTIDADE'
      'VALOR=VALOR'
      'DESCONTO=DESCONTO'
      'ACRESCIMO=ACRESCIMO'
      'VALOR_TOTAL=VALOR_TOTAL'
      'MARGEM=MARGEM'
      'VALOR_REAL=VALOR_REAL'
      'TIPOPROD=TIPOPROD'
      'CANCELADO=CANCELADO'
      'NUM_ITEM=NUM_ITEM'
      'EAN13=EAN13'
      'CST=CST'
      'CFOP=CFOP'
      'ALIQ_ICMS=ALIQ_ICMS'
      'BASE_ICMS=BASE_ICMS'
      'VALOR_ICMS=VALOR_ICMS'
      'REDUCAO_BASE=REDUCAO_BASE'
      'ALIQ_ICMS_ST=ALIQ_ICMS_ST'
      'BASE_ICMS_ST=BASE_ICMS_ST'
      'VALOR_ICMS_ST=VALOR_ICMS_ST'
      'VALOR_PIS=VALOR_PIS'
      'VALOR_COFINS=VALOR_COFINS'
      'VALOR_IPI=VALOR_IPI'
      'MD5REGISTRO=MD5REGISTRO'
      'ID_BICO=ID_BICO'
      'ID_TANQUE=ID_TANQUE'
      'ID_BOMBA=ID_BOMBA'
      'EI=EI'
      'EF=EF'
      'MVA=MVA'
      'ID_VENDEDOR=ID_VENDEDOR'
      'COO=COO'
      'CCF=CCF'
      'GNF=GNF'
      'NUMSERIEECF=NUMSERIEECF'
      'ID_ABASTECIMENTO=ID_ABASTECIMENTO'
      'ALIQ_PIS=ALIQ_PIS'
      'ALIQ_COFINS=ALIQ_COFINS'
      'BASE_PIS=BASE_PIS'
      'BASE_COFINS=BASE_COFINS'
      'ALIQ_IPI=ALIQ_IPI'
      'BASE_IPI=BASE_IPI'
      'CST_IPI=CST_IPI'
      'CST_PIS=CST_PIS'
      'CST_COFINS=CST_COFINS'
      'ALIQ_ISS=ALIQ_ISS'
      'BASE_ISS=BASE_ISS'
      'VALOR_ISS=VALOR_ISS'
      'UNIDADE=UNIDADE'
      'VALOR_REENBOLSO=VALOR_REENBOLSO'
      'VALOR_SUBSIDIO=VALOR_SUBSIDIO'
      'ID_BICO_PERDA=ID_BICO_PERDA'
      'ID_COR=ID_COR'
      'ID_TAMANHO=ID_TAMANHO'
      'CSOSN=CSOSN'
      'DESCONTO_TOTAL=DESCONTO_TOTAL'
      'PERC_FCP=PERC_FCP'
      'ALIQ_INTERNO=ALIQ_INTERNO'
      'PERC_DIFAL=PERC_DIFAL'
      'PERC_PART_DIFAL=PERC_PART_DIFAL'
      'VALOR_FCP=VALOR_FCP'
      'VALOR_ICMS_INTERNO=VALOR_ICMS_INTERNO'
      'VALOR_ICMS_DEST=VALOR_ICMS_DEST')
    DataSource = DataItens
    BCDToCurrency = False
    Left = 352
    Top = 440
  end
  object DataCliente: TDataSource
    DataSet = CdsCliente
    Left = 24
    Top = 280
  end
  object CdsCliente: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DspCliente'
    AfterOpen = CdsClienteAfterOpen
    Left = 24
    Top = 327
    object CdsClienteID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object CdsClienteCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object CdsClienteCIDADE_END: TStringField
      FieldName = 'CIDADE_END'
    end
    object CdsClienteUF_END: TStringField
      FieldName = 'UF_END'
      FixedChar = True
      Size = 2
    end
    object CdsClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 12
    end
    object CdsClienteATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CdsClienteTIPO_CONTATO: TStringField
      FieldName = 'TIPO_CONTATO'
      Size = 1
    end
  end
  object DspCliente: TDataSetProvider
    DataSet = QryCliente
    Left = 24
    Top = 375
  end
  object QryCliente: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select contato.id,contato.nome,contato.cnpj_cpf,'
      'contato.cidade_end,contato.uf_end,contato.telefone,'
      'contato.ativo, contato.tipo_contato from contato'
      'where 1<0')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 24
    Top = 423
    object QryClienteID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object QryClienteCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
    end
    object QryClienteCIDADE_END: TStringField
      FieldName = 'CIDADE_END'
    end
    object QryClienteUF_END: TStringField
      FieldName = 'UF_END'
      FixedChar = True
      Size = 2
    end
    object QryClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 12
    end
    object QryClienteATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryClienteTIPO_CONTATO: TStringField
      FieldName = 'TIPO_CONTATO'
      Size = 1
    end
  end
  object CdsPeriodo: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 560
    Top = 360
    object CdsPeriododata_inicio: TDateField
      FieldName = 'data_inicio'
    end
    object CdsPeriododata_final: TDateField
      FieldName = 'data_final'
    end
    object CdsPeriodototalconta: TCurrencyField
      FieldName = 'totalconta'
    end
    object CdsPeriodototalquitado: TCurrencyField
      FieldName = 'totalquitado'
    end
    object CdsPeriodototalnegociado: TCurrencyField
      FieldName = 'totalnegociado'
    end
  end
  object frxDBDataset4: TfrxDBDataset
    UserName = 'frxDBDataset4'
    CloseDataSource = False
    FieldAliases.Strings = (
      'data_inicio=data_inicio'
      'data_final=data_final'
      'totalconta=totalconta'
      'totalquitado=totalquitado'
      'totalnegociado=totalnegociado')
    DataSet = CdsPeriodo
    BCDToCurrency = False
    Left = 440
    Top = 448
  end
  object DataSource1: TDataSource
    DataSet = CdsPeriodo
    Left = 592
    Top = 360
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = CdsPeriodo
    Left = 616
    Top = 415
  end
end
