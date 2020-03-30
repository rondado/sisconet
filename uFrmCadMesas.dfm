inherited FrmCadMesas: TFrmCadMesas
  Left = 262
  Top = 172
  Caption = 'Cadastro de Mesas'
  ClientHeight = 227
  ClientWidth = 487
  OnShow = FormShow
  ExplicitWidth = 493
  ExplicitHeight = 252
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox [0]
    Left = 0
    Top = 0
    Width = 344
    Height = 227
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 211
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 11
      Height = 13
      Caption = 'ID'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 84
      Height = 13
      Caption = 'NUMERO_MESA'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 16
      Top = 104
      Width = 62
      Height = 13
      Caption = 'DESCRICAO'
      FocusControl = DBEdit3
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 40
      Width = 49
      Height = 21
      DataField = 'ID'
      DataSource = DataWork
      Enabled = False
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 80
      Width = 185
      Height = 21
      DataField = 'NUMERO_MESA'
      DataSource = DataWork
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 16
      Top = 120
      Width = 300
      Height = 21
      DataField = 'DESCRICAO'
      DataSource = DataWork
      TabOrder = 2
    end
    object DBNavigator1: TDBNavigator
      Left = 16
      Top = 167
      Width = 300
      Height = 25
      DataSource = DataWork
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 3
    end
  end
  object Panel1: TPanel [1]
    Left = 344
    Top = 0
    Width = 143
    Height = 227
    Align = alRight
    TabOrder = 1
    ExplicitHeight = 211
    inline FrameBotaoVertical1: TFrameBotaoVertical
      Left = 5
      Top = 8
      Width = 135
      Height = 182
      TabOrder = 0
      ExplicitLeft = 5
      ExplicitTop = 8
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
  inherited DataWork: TDataSource
    DataSet = DmWorkCom.CdsMesas
    Left = 184
    Top = 32
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 248
    Top = 32
  end
end
