inherited FrmAbreRegistra2: TFrmAbreRegistra2
  Left = 227
  Top = 32
  Align = alClient
  Caption = 'Registro de Itens'
  ClientHeight = 625
  ClientWidth = 992
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 998
  ExplicitHeight = 654
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 992
    Height = 625
    Align = alClient
    Color = clGray
    ParentColor = False
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 2
      Top = 210
      Width = 988
      Height = 372
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' Itens da Comanda '
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 984
        Height = 355
        Align = alClient
        DataSource = DsItensMesa
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
            FieldName = 'ID_PRODUTO'
            Title.Caption = 'C'#243'd.Prod.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Alignment = taCenter
            Title.Caption = 'Descri'#231#227'o'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 316
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_UNIT'
            Title.Alignment = taCenter
            Title.Caption = 'Vr.Unit'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANT'
            Title.Alignment = taCenter
            Title.Caption = 'Quant'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_TOTAL'
            Title.Alignment = taCenter
            Title.Caption = 'Vr.Total'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CANCELADO'
            Title.Caption = 'Canc.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TRANSFERIDA'
            Title.Caption = 'Transf.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 162
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMERO_MESA_ORIG'
            Title.Caption = 'Comanda Origem'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 113
            Visible = True
          end>
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 582
      Width = 988
      Height = 41
      Align = alBottom
      Color = clGray
      TabOrder = 1
      DesignSize = (
        988
        41)
      object Label4: TLabel
        Left = 527
        Top = 12
        Width = 190
        Height = 20
        Anchors = []
        Caption = 'Valor total da Comanda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LbValor: TLabel
        Left = 715
        Top = 7
        Width = 265
        Height = 29
        Alignment = taRightJustify
        Anchors = []
        AutoSize = False
        Caption = 'R$0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 164
      Width = 988
      Height = 46
      Align = alBottom
      BevelInner = bvLowered
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      object Label3: TLabel
        Left = 508
        Top = 6
        Width = 66
        Height = 13
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton1: TSpeedButton
        Left = 120
        Top = 20
        Width = 22
        Height = 21
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Label2: TLabel
        Left = 9
        Top = 6
        Width = 45
        Height = 13
        Caption = 'Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BtnConfirmar: TBitBtn
        Left = 696
        Top = 12
        Width = 141
        Height = 29
        Caption = 'Confirmar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 3
        OnClick = BtnConfirmarClick
      end
      object BtnCancelar: TBitBtn
        Left = 841
        Top = 12
        Width = 141
        Height = 29
        Caption = 'Cancelar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 4
        OnClick = BtnCancelarClick
      end
      object DbQuant: TDBEdit
        Left = 507
        Top = 20
        Width = 68
        Height = 21
        DataField = 'QUANT'
        DataSource = DataAuxiliar
        TabOrder = 2
        OnKeyDown = DbQuantKeyDown
        OnKeyPress = EdtComandaKeyPress
      end
      object EdtProduto: TMaskEdit
        Left = 151
        Top = 20
        Width = 344
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = ''
        OnKeyPress = EdtComandaKeyPress
      end
      object EdtCodPro: TEdit
        Left = 9
        Top = 20
        Width = 108
        Height = 21
        TabOrder = 0
        OnExit = EdtCodProExit
        OnKeyPress = EdtComandaKeyPress
      end
    end
    object GroupBox3: TGroupBox
      Left = 2
      Top = 15
      Width = 988
      Height = 149
      Align = alClient
      TabOrder = 3
      object Label1: TLabel
        Left = 11
        Top = 14
        Width = 95
        Height = 13
        Caption = 'Mesa/Comandas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 11
        Top = 54
        Width = 59
        Height = 13
        Caption = 'Atendente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton2: TSpeedButton
        Left = 392
        Top = 68
        Width = 22
        Height = 21
        Caption = '...'
        OnClick = SpeedButton2Click
      end
      object Label6: TLabel
        Left = 435
        Top = 54
        Width = 63
        Height = 13
        Caption = 'Entregador'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton3: TSpeedButton
        Left = 816
        Top = 68
        Width = 22
        Height = 21
        Caption = '...'
        OnClick = SpeedButton3Click
      end
      object Label7: TLabel
        Left = 11
        Top = 94
        Width = 97
        Height = 13
        Caption = 'Local de entrega'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object EdtComanda: TEdit
        Left = 11
        Top = 29
        Width = 104
        Height = 21
        TabOrder = 0
        OnExit = EdtComandaExit
        OnKeyPress = EdtComandaKeyPress
      end
      object EdtMesa: TEdit
        Left = 120
        Top = 29
        Width = 375
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object BitBtn1: TBitBtn
        Left = 508
        Top = 29
        Width = 109
        Height = 21
        Caption = 'Selecionar Mesa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = BitBtn1Click
      end
      object ChEntregar: TCheckBox
        Left = 657
        Top = 31
        Width = 97
        Height = 17
        Caption = 'Entregar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object EdtAtendente: TEdit
        Left = 11
        Top = 68
        Width = 374
        Height = 21
        ReadOnly = True
        TabOrder = 3
      end
      object EdtEntregador: TEdit
        Left = 435
        Top = 68
        Width = 374
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object EdtLocalEntrega: TEdit
        Left = 11
        Top = 108
        Width = 826
        Height = 21
        TabOrder = 6
      end
    end
  end
  object DataMesa: TDataSource
    DataSet = DmWorkCom.CdsMesas
    Left = 176
    Top = 304
  end
  object CdsAuxiliar: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 304
    object CdsAuxiliarID_MESA: TIntegerField
      FieldName = 'ID_MESA'
    end
    object CdsAuxiliarID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object CdsAuxiliarQUANT: TFloatField
      FieldName = 'QUANT'
    end
    object CdsAuxiliarPRECO: TFloatField
      FieldName = 'PRECO'
    end
  end
  object DataAuxiliar: TDataSource
    DataSet = CdsAuxiliar
    Left = 248
    Top = 304
  end
  object DsItensMesa: TDataSource
    DataSet = DmWorkCom.CdsMesasItens
    Left = 103
    Top = 300
  end
end
