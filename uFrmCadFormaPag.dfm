inherited FrmCadFormaPag: TFrmCadFormaPag
  Left = 303
  Top = 159
  Caption = 'Cadastro de Forma de Pagamento'
  ClientHeight = 337
  ClientWidth = 586
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 592
  ExplicitHeight = 366
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl [0]
    Left = 0
    Top = 0
    Width = 586
    Height = 337
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Consulta'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 578
        Height = 309
        Align = alClient
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 574
          Height = 292
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
              FieldName = 'ID'
              Title.Alignment = taCenter
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Alignment = taCenter
              Title.Caption = 'Descri'#231#227'o'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GERAR_CONTA'
              Title.Alignment = taCenter
              Title.Caption = 'Conta'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MOVIMENO_CAIXA'
              Title.Alignment = taCenter
              Title.Caption = 'Caixa'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ATIVO'
              Title.Alignment = taCenter
              Title.Caption = 'Ativo'
              Visible = True
            end>
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cadastrar'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 440
        Height = 309
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 10
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
          FocusControl = DbID
        end
        object Label2: TLabel
          Left = 8
          Top = 50
          Width = 48
          Height = 13
          Caption = 'Descri'#231#227'o'
          FocusControl = DbDescricao
        end
        object Label8: TLabel
          Left = 8
          Top = 263
          Width = 295
          Height = 13
          Caption = 'Forma de Pagamento (Quandidade de Dias separados por "/")'
          FocusControl = DbFormaPag
        end
        object Label3: TLabel
          Left = 8
          Top = 223
          Width = 65
          Height = 13
          Caption = 'Quant.Pagtos'
        end
        object DbID: TDBEdit
          Left = 8
          Top = 26
          Width = 65
          Height = 21
          DataField = 'ID'
          DataSource = DataWork
          Enabled = False
          TabOrder = 0
          OnKeyPress = DbIDKeyPress
        end
        object DbDescricao: TDBEdit
          Left = 8
          Top = 66
          Width = 415
          Height = 21
          CharCase = ecUpperCase
          DataField = 'DESCRICAO'
          DataSource = DataWork
          TabOrder = 1
          OnKeyPress = DbIDKeyPress
        end
        object DbFormaPag: TDBEdit
          Left = 8
          Top = 279
          Width = 400
          Height = 21
          DataField = 'FORMA_PAGTO'
          DataSource = DataWork
          TabOrder = 8
          OnKeyPress = DbIDKeyPress
        end
        object DbRadioTipoPag: TDBRadioGroup
          Left = 8
          Top = 90
          Width = 181
          Height = 75
          Caption = ' Tipo de Pagamento '
          DataField = 'TIPO_PAGTO'
          DataSource = DataWork
          Items.Strings = (
            '0 - A Vista'
            '1 - A Prazo'
            '2 - Contra-Apresenta'#231#227'o')
          TabOrder = 2
          Values.Strings = (
            '0'
            '1'
            '2')
        end
        object DbRadioTipoDoc: TDBRadioGroup
          Left = 197
          Top = 90
          Width = 226
          Height = 75
          Caption = ' Tipo de Documento '
          Columns = 2
          DataField = 'TIPO_DOCUMENTO'
          DataSource = DataWork
          Items.Strings = (
            '0 - Dinheiro'
            '1 - Cheque'
            '2 - Cartao'
            '3 - NP'
            '4 - Carne'
            '5 - Boleto'
            '6 - Outros')
          TabOrder = 3
          Values.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6')
          OnClick = DbRadioTipoDocClick
        end
        object DbChContas: TDBCheckBox
          Left = 8
          Top = 174
          Width = 177
          Height = 17
          Caption = 'Gerar Contas a Pagar / Receber'
          DataField = 'GERAR_CONTA'
          DataSource = DataWork
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnKeyPress = DbIDKeyPress
        end
        object DbChCaixa: TDBCheckBox
          Left = 8
          Top = 203
          Width = 177
          Height = 17
          Caption = 'Gerar Movimento de Caixa'
          DataField = 'MOVIMENO_CAIXA'
          DataSource = DataWork
          TabOrder = 5
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnKeyPress = DbIDKeyPress
        end
        object DbCHAtivo: TDBCheckBox
          Left = 8
          Top = 188
          Width = 177
          Height = 17
          Caption = 'Ativo'
          DataField = 'ATIVO'
          DataSource = DataWork
          TabOrder = 6
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          OnKeyPress = DbIDKeyPress
        end
        object DbQuantPagtos: TDBEdit
          Left = 8
          Top = 238
          Width = 81
          Height = 21
          DataField = 'QUANT_PAGTOS'
          DataSource = DataWork
          TabOrder = 7
        end
        object GrpOperadora: TGroupBox
          Left = 197
          Top = 168
          Width = 226
          Height = 49
          Caption = 'CNPJ da operadora de cart'#227'o'
          TabOrder = 9
          object DBEdit1: TDBEdit
            Left = 8
            Top = 17
            Width = 210
            Height = 21
            CharCase = ecUpperCase
            DataField = 'CNPJ_OPERADORA'
            DataSource = DataWork
            TabOrder = 0
            OnKeyPress = DbIDKeyPress
          end
        end
      end
      object Panel1: TPanel
        Left = 440
        Top = 0
        Width = 138
        Height = 309
        Align = alRight
        TabOrder = 1
        inline Frame: TFrameBotaoVertical
          Left = 1
          Top = 2
          Width = 136
          Height = 182
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 2
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
    DataSet = DmWorkCom.CdsFormaPag
    OnDataChange = DataWorkDataChange
    Left = 464
    Top = 224
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 528
    Top = 224
  end
end
