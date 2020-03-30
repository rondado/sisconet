inherited FrmLancComanda: TFrmLancComanda
  Left = 294
  Top = 114
  Caption = 'Lan'#231'amentos de Comandas'
  ClientHeight = 550
  ClientWidth = 639
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox [0]
    Left = 8
    Top = 8
    Width = 622
    Height = 65
    TabOrder = 0
  end
  object GroupBox2: TGroupBox [1]
    Left = 8
    Top = 80
    Width = 622
    Height = 393
    Caption = ' Produtos '
    TabOrder = 1
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 484
    Width = 639
    Height = 66
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 2
    inline FrameBotaoHorizontal1: TFrameBotaoHorizontal
      Left = 0
      Top = 2
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
end
