object FrmWSCep: TFrmWSCep
  Left = 242
  Top = 175
  Width = 581
  Height = 366
  Caption = 'WEB Servi'#231'o - CEP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 573
    Height = 339
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 128
      Width = 42
      Height = 13
      Caption = 'Localizar'
    end
    object RadioOpcao: TRadioGroup
      Left = 8
      Top = 16
      Width = 185
      Height = 97
      Caption = ' Op'#231#227'o '
      ItemIndex = 0
      Items.Strings = (
        '0 - Por Cep'
        '1 - Por Descri'#231#227'o de Logradouro')
      TabOrder = 0
      OnClick = RadioOpcaoClick
    end
    object GroupBox2: TGroupBox
      Left = 242
      Top = 17
      Width = 322
      Height = 272
      Caption = ' Resultado da Busca '
      TabOrder = 1
      object Memo1: TMemo
        Left = 2
        Top = 15
        Width = 318
        Height = 255
        Align = alClient
        TabOrder = 0
      end
    end
    object EdLocalizar: TEdit
      Left = 8
      Top = 144
      Width = 222
      Height = 21
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 16
      Top = 264
      Width = 75
      Height = 25
      Caption = '&Buscar'
      TabOrder = 4
    end
    object PnUF: TPanel
      Left = 9
      Top = 183
      Width = 224
      Height = 64
      TabOrder = 3
      object Label2: TLabel
        Left = 8
        Top = 10
        Width = 17
        Height = 13
        Caption = 'UF:'
      end
      object Label3: TLabel
        Left = 8
        Top = 36
        Width = 102
        Height = 13
        Caption = 'N'#250'mero de Registros:'
      end
      object EdUF: TEdit
        Left = 114
        Top = 6
        Width = 34
        Height = 21
        TabOrder = 0
      end
      object EdNumRegistro: TEdit
        Left = 114
        Top = 28
        Width = 49
        Height = 21
        TabOrder = 1
      end
    end
  end
  object HTTPRIO1: THTTPRIO
    URL = 'http://desenvolvimento.setrem.com.br/wscep/wsCEP.exe/soap/ICEP'
    HTTPWebNode.Agent = 'Borland SOAP 1.2'
    HTTPWebNode.UseUTF8InHeader = False
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 298
    Top = 81
  end
  object ActionList1: TActionList
    Left = 314
    Top = 169
    object ActBuscaCep: TAction
      Caption = 'Pesquisa'
      ShortCut = 113
    end
  end
end
