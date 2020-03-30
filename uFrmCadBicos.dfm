inherited FrmCadBicos: TFrmCadBicos
  Left = 131
  Top = 88
  Caption = 'Cadastro de Bicos'
  ClientHeight = 352
  ClientWidth = 652
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 511
    Top = 0
    Width = 141
    Height = 352
    Align = alRight
    TabOrder = 0
    inline FrameBotaoVertical1: TFrameBotaoVertical
      Left = 3
      Top = 7
      Width = 135
      Height = 274
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 7
      ExplicitHeight = 274
      inherited BtnIncluir: TBitBtn
        Top = -1
        Action = ActIncluir
        Caption = 'F2 - &Incluir'
        ExplicitTop = -1
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
  object GroupBox1: TGroupBox [1]
    Left = 0
    Top = 0
    Width = 511
    Height = 352
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 11
      Height = 13
      Caption = 'ID'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 114
      Height = 13
      Caption = 'Tanque de Combust'#237'vel'
    end
    object Label3: TLabel
      Left = 16
      Top = 96
      Width = 110
      Height = 13
      Caption = 'Bomba de Combust'#237'vel'
    end
    object Label4: TLabel
      Left = 16
      Top = 136
      Width = 72
      Height = 13
      Caption = 'N'#250'mero L'#243'gico'
    end
    object Label6: TLabel
      Left = 16
      Top = 176
      Width = 28
      Height = 13
      Caption = 'Pre'#231'o'
      FocusControl = DBEdit6
    end
    object Label5: TLabel
      Left = 144
      Top = 136
      Width = 76
      Height = 13
      Caption = 'N'#250'mero do Bico'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 32
      Width = 134
      Height = 21
      DataField = 'ID'
      DataSource = DataWork
      Enabled = False
      TabOrder = 0
    end
    object DBEdit5: TDBEdit
      Left = 16
      Top = 152
      Width = 81
      Height = 21
      DataField = 'NUM_LOGICO'
      DataSource = DataWork
      TabOrder = 3
    end
    object DBEdit6: TDBEdit
      Left = 16
      Top = 192
      Width = 134
      Height = 21
      DataField = 'PRECO'
      DataSource = DataWork
      Enabled = False
      TabOrder = 4
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 16
      Top = 72
      Width = 313
      Height = 21
      DataField = 'ID_TANQUE'
      DataSource = DataWork
      KeyField = 'ID'
      ListField = 'DESCRICAO'
      ListSource = DataTanque
      TabOrder = 1
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 16
      Top = 112
      Width = 313
      Height = 21
      DataField = 'ID_BOMBA'
      DataSource = DataWork
      KeyField = 'ID'
      ListField = 'DESCRICAO'
      ListSource = DataBomba
      TabOrder = 2
    end
    object DBNavigator1: TDBNavigator
      Left = 16
      Top = 224
      Width = 312
      Height = 25
      DataSource = DataWork
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 5
    end
    object DBEdit2: TDBEdit
      Left = 144
      Top = 152
      Width = 81
      Height = 21
      DataField = 'BICO_CONCENTRADOR'
      DataSource = DataWork
      TabOrder = 6
    end
    object DBCheckBox1: TDBCheckBox
      Left = 172
      Top = 195
      Width = 97
      Height = 17
      Caption = 'Bico Ativo'
      DataField = 'ATIVO'
      DataSource = DataWork
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited DataWork: TDataSource
    DataSet = DmPosto.CdsBicos
    OnDataChange = DataWorkDataChange
    Left = 240
    Top = 16
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 296
    Top = 16
  end
  object DataTanque: TDataSource
    Left = 392
    Top = 208
  end
  object DataBomba: TDataSource
    Left = 448
    Top = 208
  end
end
