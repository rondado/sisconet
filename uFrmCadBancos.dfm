inherited FrmCadBancos: TFrmCadBancos
  Left = 284
  Top = 135
  Caption = 'Cadastro de Bancos'
  ClientHeight = 440
  ClientWidth = 638
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 644
  ExplicitHeight = 465
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 376
    Width = 638
    Height = 64
    Align = alBottom
    TabOrder = 0
    inline Frame1: TFrameBotaoHorizontal
      Left = 0
      Top = 0
      Width = 637
      Height = 63
      TabOrder = 0
      ExplicitWidth = 637
      ExplicitHeight = 63
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
      inherited BtnEncerrar: TBitBtn
        Action = ActEncerrar
        Caption = 'F10 - &Encerrar'
      end
      inherited BtnRelatorio: TBitBtn
        Action = ActRelatorio
        Caption = 'F7 - &Relatorio'
      end
    end
  end
  object PageControl1: TPageControl [1]
    Left = 0
    Top = 0
    Width = 638
    Height = 376
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Dados Principais'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 630
        Height = 348
        Align = alClient
        TabOrder = 0
        ExplicitTop = -2
        object Label1: TLabel
          Left = 14
          Top = 19
          Width = 11
          Height = 13
          Caption = 'ID'
          FocusControl = DbID
        end
        object Label3: TLabel
          Left = 99
          Top = 21
          Width = 60
          Height = 13
          Caption = 'N'#186' do banco'
          FocusControl = DBEdit2
        end
        object Label4: TLabel
          Left = 167
          Top = 21
          Width = 19
          Height = 13
          Caption = 'Dig.'
          FocusControl = DBEdit3
        end
        object Label5: TLabel
          Left = 211
          Top = 21
          Width = 76
          Height = 13
          Caption = 'Nome do banco'
          FocusControl = DBEdit4
        end
        object Label6: TLabel
          Left = 15
          Top = 69
          Width = 84
          Height = 13
          Caption = 'Nome da ag'#234'ncia'
          FocusControl = DBEdit5
        end
        object Label7: TLabel
          Left = 231
          Top = 69
          Width = 68
          Height = 13
          Caption = 'N'#186' da ag'#234'ncia'
          FocusControl = DBEdit6
        end
        object Label9: TLabel
          Left = 317
          Top = 69
          Width = 19
          Height = 13
          Caption = 'Dig.'
          FocusControl = DBEdit7
        end
        object Label10: TLabel
          Left = 15
          Top = 116
          Width = 57
          Height = 13
          Caption = 'N'#186' da conta'
          FocusControl = DBEdit8
        end
        object Label11: TLabel
          Left = 119
          Top = 116
          Width = 19
          Height = 13
          Caption = 'Dig.'
          FocusControl = DBEdit9
        end
        object Label12: TLabel
          Left = 176
          Top = 116
          Width = 74
          Height = 13
          Caption = 'Cidade ag'#234'ncia'
          FocusControl = DBEdit10
        end
        object Label13: TLabel
          Left = 453
          Top = 116
          Width = 33
          Height = 13
          Caption = 'UF Ag.'
        end
        object Label14: TLabel
          Left = 15
          Top = 164
          Width = 68
          Height = 13
          Caption = 'Nosso n'#250'mero'
          FocusControl = DBEdit12
        end
        object Label15: TLabel
          Left = 15
          Top = 205
          Width = 40
          Height = 13
          Caption = 'Cedente'
          FocusControl = DBEdit13
        end
        object Label16: TLabel
          Left = 453
          Top = 205
          Width = 65
          Height = 13
          Caption = 'C'#243'd. Cedente'
          FocusControl = DBEdit14
        end
        object Label17: TLabel
          Left = 15
          Top = 250
          Width = 84
          Height = 13
          Caption = 'Tipo de cobran'#231'a'
        end
        object Label18: TLabel
          Left = 263
          Top = 250
          Width = 79
          Height = 13
          Caption = 'Layout Remessa'
        end
        object DbID: TDBEdit
          Left = 14
          Top = 35
          Width = 59
          Height = 21
          DataField = 'ID'
          DataSource = DataWork
          Enabled = False
          TabOrder = 0
          OnKeyPress = DbIDKeyPress
        end
        object ComboEstado: TDBLookupComboBox
          Left = 453
          Top = 132
          Width = 49
          Height = 21
          DataField = 'UF_AGENCIA'
          DataSource = DataWork
          KeyField = 'UF'
          ListField = 'UF'
          ListSource = DataUF
          TabOrder = 1
          OnKeyPress = DbIDKeyPress
        end
        object DBEdit2: TDBEdit
          Left = 99
          Top = 37
          Width = 65
          Height = 21
          DataField = 'NUMERO_BANCO'
          DataSource = DataWork
          TabOrder = 2
        end
        object DBEdit3: TDBEdit
          Left = 167
          Top = 37
          Width = 17
          Height = 21
          DataField = 'DIGITO_NUMERO_BANCO'
          DataSource = DataWork
          TabOrder = 3
        end
        object DBEdit4: TDBEdit
          Left = 209
          Top = 37
          Width = 400
          Height = 21
          DataField = 'NOME_BANCO'
          DataSource = DataWork
          TabOrder = 4
        end
        object DBEdit5: TDBEdit
          Left = 15
          Top = 85
          Width = 189
          Height = 21
          DataField = 'NOME_AGENCIA'
          DataSource = DataWork
          TabOrder = 5
        end
        object DBEdit6: TDBEdit
          Left = 231
          Top = 85
          Width = 80
          Height = 21
          DataField = 'NUMERO_AGENCIA'
          DataSource = DataWork
          TabOrder = 6
        end
        object DBEdit7: TDBEdit
          Left = 317
          Top = 85
          Width = 17
          Height = 21
          DataField = 'DIGITO_AGENCIA'
          DataSource = DataWork
          TabOrder = 7
        end
        object DBEdit8: TDBEdit
          Left = 15
          Top = 132
          Width = 97
          Height = 21
          DataField = 'NUMERO_CONTA'
          DataSource = DataWork
          TabOrder = 8
        end
        object DBEdit9: TDBEdit
          Left = 119
          Top = 132
          Width = 17
          Height = 21
          DataField = 'DIGITO_CONTA'
          DataSource = DataWork
          TabOrder = 9
        end
        object DBEdit10: TDBEdit
          Left = 176
          Top = 132
          Width = 264
          Height = 21
          DataField = 'CIADE_AGENCIA'
          DataSource = DataWork
          TabOrder = 10
        end
        object DBEdit12: TDBEdit
          Left = 15
          Top = 180
          Width = 134
          Height = 21
          DataField = 'NOSSO_NUMERO'
          DataSource = DataWork
          TabOrder = 11
        end
        object DBEdit13: TDBEdit
          Left = 15
          Top = 221
          Width = 425
          Height = 21
          DataField = 'CEDENTE'
          DataSource = DataWork
          TabOrder = 12
        end
        object DBEdit14: TDBEdit
          Left = 453
          Top = 221
          Width = 123
          Height = 21
          DataField = 'COD_CEDENTE'
          DataSource = DataWork
          TabOrder = 13
        end
        object CbxTipoCob: TComboBox
          Left = 15
          Top = 266
          Width = 225
          Height = 21
          TabOrder = 14
          Items.Strings = (
            'cobNenhum'
            'cobBancoDoBrasil'
            'cobSantander'
            'cobCaixaEconomica'
            'cobCaixaSicob'
            'cobBradesco'
            'cobItau'
            'cobBancoMercantil'
            'cobSicred'
            'cobBancoob'
            'cobBanrisul'
            'cobBanestes'
            'cobHSBC'
            'cobBancoDoNordeste'
            'cobBRB'
            'cobBicBanco'
            'cobBradescoSICOOB'
            'cobBancoSafra'
            'cobSafraBradesco'
            'cobBancoCECRED')
        end
        object DBComboBox1: TDBComboBox
          Left = 263
          Top = 266
          Width = 145
          Height = 21
          DataField = 'LAYOUT_REMESSA'
          DataSource = DataWork
          Items.Strings = (
            'c240'
            'c400')
          TabOrder = 15
        end
      end
    end
    object TbsConsulta: TTabSheet
      Caption = 'Selecionar Banco'
      ImageIndex = 2
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 630
        Height = 348
        Align = alClient
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 626
          Height = 331
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
              FieldName = 'NUMERO_BANCO'
              Title.Alignment = taCenter
              Title.Caption = 'N'#186' do Banco'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME_BANCO'
              Title.Alignment = taCenter
              Title.Caption = 'Nome do Banco'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME_AGENCIA'
              Title.Alignment = taCenter
              Title.Caption = 'Agencia'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_AGENCIA'
              Title.Alignment = taCenter
              Title.Caption = 'N'#186' Agencia'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_CONTA'
              Title.Alignment = taCenter
              Title.Caption = 'N'#186' da Conta'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DIGITO_CONTA'
              Title.Alignment = taCenter
              Title.Caption = 'Dig.Conta'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end>
        end
      end
    end
  end
  inherited DataWork: TDataSource
    DataSet = DmWorkCom.CdsBancos
    OnDataChange = DataWorkDataChange
    Left = 552
    Top = 296
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 440
    Top = 296
    inherited ActPesquisar: TAction
      OnExecute = ActPesquisarExecute
    end
  end
  object DataUF: TDataSource
    Left = 500
    Top = 296
  end
end
