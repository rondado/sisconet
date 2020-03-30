inherited FrmCadPlacasAbastec: TFrmCadPlacasAbastec
  Left = 310
  Top = 139
  Caption = 'Cadastro de Troca de Placas'
  ClientHeight = 502
  ClientWidth = 792
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 792
    Height = 54
    Align = alTop
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 43
      Height = 16
      Caption = 'Bomba'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 180
      Top = 20
      Width = 47
      Height = 16
      Caption = 'Tanque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 348
      Top = 20
      Width = 26
      Height = 16
      Caption = 'Bico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnConsultar: TBitBtn
      Left = 618
      Top = 12
      Width = 156
      Height = 36
      Caption = 'Localizar Anteriores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000006E6E6E6E6E6E6E6E6E0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000006E6E6E5656566262623E3E3E6E6E6E0000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000006E6E6E7A7A7A6E6E6E9E9E9E6E6E6E3E3E3E6E6E6E0000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000009E9E9E6B8FFF4873FF6E6E6E9E9E9E6E6E6E3E3E3E6E6E6E0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000B1C7FF6BC6FF48B8FF4873FF6E6E6E9E9E9E7A7A7A3E3E3E6E6E
        6E00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000006BC6FF6BC6FF48B8FF4873FF6E6E6E9E9E9E6E6E6E3E3E
        3E6E6E6E00000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000006BC6FF6BC6FF48B8FF4873FF6E6E6E9E9E9E6E6E
        6E3E3E3E6E6E6E00000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000006BC6FF6BC6FF48B8FF4873FF6E6E6E9E9E
        9E7A7A7A3E3E3E00000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000006BC6FF6BC6FF48B8FF4873FF6E6E
        6E9E9E9E6262620000000000008686867A7A7A7A7A7A6262626E6E6E7A7A7A00
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000006BC6FF6BC6FF48B8FF4873
        FF6E6E6E6262626262626E6E6E6262626E6E6E7A7A7A9292927A7A7A6262624A
        4A4A626262000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000006BC6FF6BC6FF8EAB
        FF868686929292868686929292F0CAA6FFE2B1FFFFD4FFFFD4FFE3D4F0CAA686
        86865656564A4A4A000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00868686868686FFAB8EFFE2B1FFFFD4FFFFD4FFFFD4FFFFD4FFFFD4FFFFD4FF
        F0D4A4A0A05656564A4A4A000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00A4A0A0FFAB8EFFE2B1FFF0D4FFF0D4FFFFD4FFFFD4FFFFD4FFFFD4FFFFFFFF
        FFFFF2F2F29292924A4A4A6E6E6E000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00FFAB8EFFE2B1FFF0D4FFE2B1FFFFD4FFFFD4FFFFD4FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE3D46262624A4A4A000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000AAAA
        AAF0CAA6FFFFD4FFE2B1FFE2B1FFFFD4FFFFD4FFFFD4FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFD4FFFFD49292924A4A4A000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFB1
        B1FFE2B1FFF0D4FFE2B1FFE2B1FFFFD4FFFFD4FFFFD4FFFFD4FFFFFFFFFFFFFF
        FFFFFFFFD4FFFFD4B6B6B64A4A4A000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFB1
        B1FFF0D4FFE2B1FFD48EFFE2B1FFF0D4FFFFD4FFFFD4FFFFD4FFFFD4FFFFD4FF
        FFD4FFFFD4FFFFD4F0CAA6565656000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFB1
        B1FFF0D4FFE2B1FFD48EFFE2B1FFE2B1FFFFD4FFFFD4FFFFD4FFFFD4FFFFD4FF
        FFD4FFFFD4FFFFD4F0CAA6565656000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000B6B6
        B6FFE2B1FFFFD4FFE2B1FFE2B1FFE2B1FFE2B1FFFFD4FFFFD4FFFFD4FFFFD4FF
        FFD4FFFFD4FFFFD4FFAB8E565656000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000AAAA
        AAF0CAA6FFFFD4FFF0D4FFF0D4FFE2B1FFE2B1FFE2B1FFE2B1FFF0D4FFF0D4FF
        E2B1FFFFD4FFE2B17A7A7A000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00AAAAAAFFF0D4FFFFFFFFFFFFFFF0D4FFE2B1FFE2B1FFE2B1FFE2B1FFE2B1FF
        F0D4FFF0D4FFAB8E6E6E6E000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00AAAAAAF0CAA6FFFFFFFFFFFFFFFFD4FFF0D4FFE2B1FFE2B1FFE2B1FFF0D4FF
        F0D4F0CAA67A7A7A000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000AAAAAAAAAAAAFFE3D4FFFFD4FFFFD4FFFFD4FFFFD4FFFFD4FFE2B1FF
        AB8E868686000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000AAAAAAA4A0A0A4A0A0F0CAA6F0CAA6F0CAA6F0CAA6A4A0A086
        8686000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      TabOrder = 0
      OnClick = BtnConsultarClick
    end
    object CbxBombas: TDBLookupComboBox
      Left = 63
      Top = 19
      Width = 98
      Height = 21
      DropDownWidth = 300
      KeyField = 'BOMBA_NUMERO'
      ListField = 'BOMBA_NUMERO;DESCRICAO'
      ListSource = DsBombas
      TabOrder = 1
      OnKeyPress = CbxBombasKeyPress
    end
    object CbxTanques: TDBLookupComboBox
      Left = 232
      Top = 19
      Width = 97
      Height = 21
      DropDownWidth = 300
      KeyField = 'TANQUE_NUMERO'
      ListField = 'TANQUE_NUMERO;DESCRICAO'
      ListSource = DsTanques
      TabOrder = 2
      OnExit = CbxTanquesExit
      OnKeyPress = CbxBombasKeyPress
    end
    object CbxBicos: TDBLookupComboBox
      Left = 379
      Top = 19
      Width = 89
      Height = 21
      DropDownWidth = 300
      KeyField = 'ID'
      ListField = 'BICO_CONCENTRADOR'
      ListSource = DsBicos
      TabOrder = 3
      OnKeyPress = CbxBombasKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 54
    Width = 792
    Height = 415
    Align = alClient
    Caption = ' Bicos da Bomba '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 788
      Height = 398
      Align = alClient
      DataSource = DsPlacas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'BICO_CONCENTRADOR'
          Title.Caption = 'N'#186' Bico'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Data'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HORA'
          Title.Caption = 'hora'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJ'
          Title.Caption = 'CNPJ Empresa'
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPF'
          Title.Caption = 'CPF T'#233'cnico'
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENCERRANTE_OUT'
          Title.Caption = 'Enc. Placa Antiga'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENCERRANTE_IN'
          Title.Caption = 'Enc. Placa Nova'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUM_LACRE_OUT'
          Title.Caption = 'N'#186' Lacre removido'
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUM_LACRE_IN'
          Title.Caption = 'N'#186' Lacre Novo'
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MOTIVO'
          Title.Caption = 'Motivo da troca'
          Width = 384
          Visible = True
        end>
    end
    object PnDadosBasico: TPanel
      Left = 101
      Top = 27
      Width = 572
      Height = 356
      BevelWidth = 3
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object Label8: TLabel
        Left = 32
        Top = 129
        Width = 84
        Height = 16
        Caption = 'Motivo Troca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 25
        Top = 62
        Width = 91
        Height = 16
        Caption = 'Data da Troca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 219
        Top = 64
        Width = 91
        Height = 16
        Caption = 'Hora da Troca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 37
        Top = 151
        Width = 78
        Height = 16
        Caption = 'Justificativa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 60
        Top = 217
        Width = 53
        Height = 16
        Caption = 'Medidas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 15
        Top = 107
        Width = 102
        Height = 16
        Caption = 'Enc. Ocore'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 249
        Top = 107
        Width = 65
        Height = 16
        Caption = 'Enc. Atual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 194
        Top = 87
        Width = 43
        Height = 16
        Caption = 'Bomba'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 318
        Top = 85
        Width = 61
        Height = 16
        Caption = 'Num. Bico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 68
        Top = 85
        Width = 47
        Height = 16
        Caption = 'Tanque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object EdtMotivo: TEdit
        Left = 123
        Top = 126
        Width = 414
        Height = 21
        MaxLength = 44
        TabOrder = 7
      end
      object Panel1: TPanel
        Left = 3
        Top = 288
        Width = 566
        Height = 65
        Align = alBottom
        TabOrder = 14
        inline FrameConfirmaCancela1: TFrameConfirmaCancela
          Left = 195
          Top = 2
          Width = 203
          Height = 62
          TabOrder = 0
          ExplicitLeft = 195
          ExplicitTop = 2
          inherited BtnConfirmar: TBitBtn
            OnClick = FrameConfirmaCancela1BtnConfirmarClick
          end
          inherited BtnCancelar: TBitBtn
            OnClick = FrameConfirmaCancela1BtnCancelarClick
          end
        end
      end
      object EdtData: TMaskEdit
        Left = 123
        Top = 60
        Width = 75
        Height = 21
        Enabled = False
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
      end
      object EdtHora: TMaskEdit
        Left = 326
        Top = 60
        Width = 73
        Height = 21
        Enabled = False
        EditMask = '!90:00:00;1;_'
        MaxLength = 8
        TabOrder = 1
        Text = '  :  :  '
      end
      object EdtJustificativa2: TEdit
        Left = 123
        Top = 192
        Width = 414
        Height = 21
        MaxLength = 44
        TabOrder = 10
      end
      object EdtMedidas: TEdit
        Left = 123
        Top = 214
        Width = 414
        Height = 21
        MaxLength = 44
        TabOrder = 11
      end
      object EdtJustificativa: TEdit
        Left = 123
        Top = 148
        Width = 414
        Height = 21
        MaxLength = 44
        TabOrder = 8
      end
      object EdtJustificativa1: TEdit
        Left = 123
        Top = 170
        Width = 414
        Height = 21
        MaxLength = 44
        TabOrder = 9
      end
      object EdtMedidas1: TEdit
        Left = 123
        Top = 236
        Width = 414
        Height = 21
        MaxLength = 44
        TabOrder = 12
      end
      object EdtMedidas2: TEdit
        Left = 123
        Top = 258
        Width = 414
        Height = 21
        MaxLength = 44
        TabOrder = 13
      end
      object EdtEncFinal: TEdit
        Left = 123
        Top = 104
        Width = 86
        Height = 21
        Enabled = False
        MaxLength = 20
        TabOrder = 5
        OnExit = EdtEncFinalExit
      end
      object EdtEncAtual: TEdit
        Left = 317
        Top = 104
        Width = 86
        Height = 21
        Enabled = False
        MaxLength = 20
        TabOrder = 6
      end
      object EdtBico: TEdit
        Left = 382
        Top = 83
        Width = 57
        Height = 21
        Enabled = False
        MaxLength = 20
        TabOrder = 4
      end
      object EdtBomba: TEdit
        Left = 243
        Top = 82
        Width = 57
        Height = 21
        Enabled = False
        MaxLength = 20
        TabOrder = 3
      end
      object EdtTanque: TEdit
        Left = 123
        Top = 82
        Width = 57
        Height = 21
        Enabled = False
        MaxLength = 20
        TabOrder = 2
      end
      object PnDadosTecnico: TPanel
        Left = 3
        Top = 3
        Width = 566
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 15
        object Label4: TLabel
          Left = 26
          Top = 18
          Width = 89
          Height = 16
          Caption = 'CNPJ Empresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 41
          Top = 39
          Width = 74
          Height = 16
          Caption = 'CPF T'#233'cnico'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 296
          Top = 18
          Width = 103
          Height = 16
          Caption = 'Lacre Removido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 296
          Top = 40
          Width = 95
          Height = 16
          Caption = 'Lacre Aplicado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EdtCPF: TEdit
          Left = 120
          Top = 35
          Width = 114
          Height = 21
          MaxLength = 20
          TabOrder = 1
        end
        object EdtCNPJ: TEdit
          Left = 120
          Top = 13
          Width = 158
          Height = 21
          MaxLength = 20
          TabOrder = 0
        end
        object EdtLacreOld: TEdit
          Left = 403
          Top = 13
          Width = 132
          Height = 21
          MaxLength = 20
          TabOrder = 2
        end
        object EdtLacreNew: TEdit
          Left = 403
          Top = 35
          Width = 132
          Height = 21
          MaxLength = 20
          TabOrder = 3
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 469
    Width = 792
    Height = 33
    Align = alBottom
    TabOrder = 2
    object BtnRegistro: TBitBtn
      Left = 6
      Top = 4
      Width = 216
      Height = 25
      Caption = 'Efetuar novo registro '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnRegistroClick
    end
    object BtnContigencia: TBitBtn
      Left = 445
      Top = 4
      Width = 196
      Height = 25
      Caption = 'Lan'#231'ar nota em contig'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnContigenciaClick
    end
    object BtnCadPlaca: TBitBtn
      Left = 225
      Top = 4
      Width = 216
      Height = 25
      Caption = 'Efetuar troca de placas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BtnCadPlacaClick
    end
  end
  object QryPlacas: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pTanque'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pBomba'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select p.id,bi.bico_concentrador,p.data,p.hora,'
      '       p.cnpj,p.cpf,p.encerrante_out,p.encerrante_in,'
      '       p.num_lacre_out,p.num_lacre_in,p.motivo'
      'from placas_abastec p, bombas_abastec b,'
      '     tanques_abastec t, bicos_abastec bi'
      'where p.id_tanque = t.id'
      'and p.id_bomba = b.id'
      'and p.id_bico = bi.id'
      'and t.tanque_numero = :pTanque'
      'and b.bomba_numero = :pBomba')
    SQLConnection = DmConexao.ConexaoDBX
    Left = 488
    Top = 382
    object QryPlacasID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object QryPlacasBICO_CONCENTRADOR: TStringField
      FieldName = 'BICO_CONCENTRADOR'
      Required = True
      Size = 2
    end
    object QryPlacasDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object QryPlacasHORA: TSQLTimeStampField
      FieldName = 'HORA'
    end
    object QryPlacasCNPJ: TStringField
      FieldName = 'CNPJ'
    end
    object QryPlacasCPF: TStringField
      FieldName = 'CPF'
    end
    object QryPlacasENCERRANTE_OUT: TFloatField
      FieldName = 'ENCERRANTE_OUT'
    end
    object QryPlacasENCERRANTE_IN: TFloatField
      FieldName = 'ENCERRANTE_IN'
    end
    object QryPlacasNUM_LACRE_OUT: TStringField
      FieldName = 'NUM_LACRE_OUT'
    end
    object QryPlacasNUM_LACRE_IN: TStringField
      FieldName = 'NUM_LACRE_IN'
    end
    object QryPlacasMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 50
    end
  end
  object DspPlacas: TDataSetProvider
    DataSet = QryPlacas
    UpdateMode = upWhereKeyOnly
    Left = 488
    Top = 430
  end
  object CdsPlacas: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pTanque'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pBomba'
        ParamType = ptInput
      end>
    ProviderName = 'DspPlacas'
    Left = 640
    Top = 422
    object CdsPlacasID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CdsPlacasBICO_CONCENTRADOR: TStringField
      FieldName = 'BICO_CONCENTRADOR'
      Required = True
      Size = 2
    end
    object CdsPlacasDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object CdsPlacasHORA: TSQLTimeStampField
      FieldName = 'HORA'
    end
    object CdsPlacasCNPJ: TStringField
      FieldName = 'CNPJ'
    end
    object CdsPlacasCPF: TStringField
      FieldName = 'CPF'
    end
    object CdsPlacasENCERRANTE_OUT: TFloatField
      FieldName = 'ENCERRANTE_OUT'
    end
    object CdsPlacasENCERRANTE_IN: TFloatField
      FieldName = 'ENCERRANTE_IN'
    end
    object CdsPlacasNUM_LACRE_OUT: TStringField
      FieldName = 'NUM_LACRE_OUT'
    end
    object CdsPlacasNUM_LACRE_IN: TStringField
      FieldName = 'NUM_LACRE_IN'
    end
    object CdsPlacasMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 50
    end
  end
  object DsPlacas: TDataSource
    DataSet = CdsPlacas
    Left = 600
    Top = 430
  end
  object DsBombas: TDataSource
    Left = 32
    Top = 190
  end
  object DsTanques: TDataSource
    Left = 24
    Top = 246
  end
  object DsBicos: TDataSource
    Left = 32
    Top = 318
  end
  object ActionList1: TActionList
    Left = 624
    Top = 200
    object ActMenuFiscal: TAction
      Caption = 'ActMenuFiscal'
      ShortCut = 49229
      OnExecute = ActMenuFiscalExecute
    end
  end
end
