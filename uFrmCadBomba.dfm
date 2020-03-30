inherited FrmCadBomba: TFrmCadBomba
  Left = 312
  Top = 175
  Caption = 'Cadastro de Bombas'
  ClientHeight = 295
  ClientWidth = 504
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox [0]
    Left = 0
    Top = 0
    Width = 362
    Height = 295
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 11
      Width = 11
      Height = 13
      Caption = 'ID'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 77
      Top = 11
      Width = 48
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 10
      Top = 51
      Width = 58
      Height = 13
      Caption = 'N'#250'm.Bomba'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 77
      Top = 51
      Width = 86
      Height = 13
      Caption = 'Modelo da Bomba'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 207
      Top = 51
      Width = 75
      Height = 13
      Caption = 'S'#233'rie da Bomba'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 10
      Top = 91
      Width = 101
      Height = 13
      Caption = 'Fabricante da Bomba'
      FocusControl = DBEdit6
    end
    object DBEdit1: TDBEdit
      Left = 10
      Top = 27
      Width = 57
      Height = 21
      DataField = 'ID'
      DataSource = DataWork
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 77
      Top = 27
      Width = 276
      Height = 21
      DataField = 'DESCRICAO'
      DataSource = DataWork
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 10
      Top = 67
      Width = 59
      Height = 21
      DataField = 'BOMBA_NUMERO'
      DataSource = DataWork
      TabOrder = 2
    end
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 265
      Width = 344
      Height = 25
      DataSource = DataWork
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 3
    end
    object DBEdit4: TDBEdit
      Left = 77
      Top = 67
      Width = 124
      Height = 21
      DataField = 'MODELO'
      DataSource = DataWork
      TabOrder = 4
    end
    object DBEdit5: TDBEdit
      Left = 207
      Top = 67
      Width = 146
      Height = 21
      DataField = 'SERIE'
      DataSource = DataWork
      TabOrder = 5
    end
    object DBEdit6: TDBEdit
      Left = 10
      Top = 107
      Width = 343
      Height = 21
      DataField = 'FABRICANTE'
      DataSource = DataWork
      TabOrder = 6
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 10
      Top = 134
      Width = 101
      Height = 51
      Caption = 'Tipo de Medi'#231#227'o '
      DataField = 'TIPO_MEDICAO'
      DataSource = DataWork
      Items.Strings = (
        '0 - Anal'#243'gico'
        '1 - Digital')
      TabOrder = 7
      Values.Strings = (
        '0'
        '1')
    end
    object GroupBox2: TGroupBox
      Left = 116
      Top = 133
      Width = 238
      Height = 126
      Caption = ' Lacres da Bomba '
      TabOrder = 8
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 234
        Height = 109
        Align = alClient
        DataSource = DataLacre
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
            FieldName = 'NUM_LACRE'
            Title.Caption = 'N'#250'm.Lacre'
            Width = 114
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_APLIC'
            Title.Caption = 'Data'
            Width = 79
            Visible = True
          end>
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 362
    Top = 0
    Width = 142
    Height = 295
    Align = alRight
    TabOrder = 1
    inline FrameBotaoVertical1: TFrameBotaoVertical
      Left = 4
      Top = 8
      Width = 135
      Height = 182
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
  inherited DataWork: TDataSource
    OnDataChange = DataWorkDataChange
    Left = 384
    Top = 208
  end
  inherited ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 448
    Top = 208
  end
  object DataLacre: TDataSource
    Left = 410
    Top = 248
  end
end
