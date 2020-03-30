{------------------------------------------------------------------------}
{                                                                        }
{  Extenso.pas                                                           }
{  Classes de transcrição de valores e números por extenso.              }
{                                                                        }
{  Copyright (c) 2001-2003. Emerson de Almeida Carneiro.                 }
{  http://www.fteam.com      e.carneiro@fteam.com                        }
{                                                                        }
{------------------------------------------------------------------------}
unit Extenso;

interface

uses
  {$IFNDEF CLX_VERSION}Windows,{$ENDIF} Classes, SysUtils, Messages;

type

  {----------------------------------------------------------------------}
  { Tipos de dados personalizados                                        }
  {----------------------------------------------------------------------}

  TTipoExtenso = (
    teMasculino,
    teFeminino
  );

  TDigito = 0..9;

  {----------------------------------------------------------------------}
  { Estruturas de dados                                                  }
  {----------------------------------------------------------------------}

  TNumeroInfo = packed record
    Centena: TDigito;
    Dezena: TDigito;
    Unidade: TDigito;
  end;

  TExtensoInfo = packed record
    NumeroStr: String[3];
    NumeroInt: SmallInt;
  end;

  {----------------------------------------------------------------------}
  { Rotinas de extenso                                                   }
  {----------------------------------------------------------------------}
  function MontaExtensoBase(AValor: Int64; ATipo: TTipoExtenso): String;

  {----------------------------------------------------------------------}
  { derivações                                                           }
  {----------------------------------------------------------------------}
  function ValorPorExtenso(AValor: Currency): String;
  function NumeroPorExtensoMasculino(ANumero: Int64): String;
  function NumeroPorExtensoFeminino(ANumero: Int64): String;


resourcestring
  {----------------------------------------------------------------------}
  { MOEDAS                                                               }
  {----------------------------------------------------------------------}
  {$IFDEF PADRAO_PORTUGAL}
  SFctMoeda_IS = 'euro';
  SFctMoeda_IP = 'euros';
  SFctMoeda_DS = 'cêntimo';
  SFctMoeda_DP = 'cêntimos';
  {$ELSE}
  SFctMoeda_IS = 'real';
  SFctMoeda_IP = 'reais';
  SFctMoeda_DS = 'centavo';
  SFctMoeda_DP = 'centavos';
  {$ENDIF}
  SFctMoeda_E  = 'e';
  SFctMoeda_DE = 'de';

  SFctMoeda_TS = 'trilhão';
  SFctMoeda_TP = 'trilhões';
  SFctMoeda_BS = 'bilhão';
  SFctMoeda_BP = 'bilhões';
  SFctMoeda_MS = 'milhão';
  SFctMoeda_MP = 'milhões';
  SFctMoeda_ML = 'mil';

  SFctMoeda_1M = 'um';
  SFctMoeda_1F = 'uma';
  SFctMoeda_2M = 'dois';
  SFctMoeda_2F = 'duas';
  SFctMoeda_3M = 'três';
  SFctMoeda_4M = 'quatro';
  SFctMoeda_5M = 'cinco';
  SFctMoeda_6M = 'seis';
  SFctMoeda_7M = 'sete';
  SFctMoeda_8M = 'oito';
  SFctMoeda_9M = 'nove';

  SFctMoeda_10 = 'dez';
  SFctMoeda_20 = 'vinte';
  SFctMoeda_30 = 'trinta';
  SFctMoeda_40 = 'quarenta';
  SFctMoeda_50 = 'cinquenta';
  SFctMoeda_60 = 'sessenta';
  SFctMoeda_70 = 'setenta';
  SFctMoeda_80 = 'oitenta';
  SFctMoeda_90 = 'noventa';

  SFctMoeda_11 = 'onze';
  SFctMoeda_12 = 'doze';
  SFctMoeda_13 = 'treze';
  SFctMoeda_14 = 'quatorze';
  SFctMoeda_15 = 'quinze';
  SFctMoeda_16 = 'dezesseis';
  SFctMoeda_17 = 'dezessete';
  SFctMoeda_18 = 'dezoito';
  SFctMoeda_19 = 'dezenove';

  SFctMoeda_C00M = 'cento';
  SFctMoeda_100M = 'cem';
  SFctMoeda_200M = 'duzentos';
  SFctMoeda_200F = 'duzentas';
  SFctMoeda_300M = 'trezentos';
  SFctMoeda_300F = 'trezentas';
  SFctMoeda_400M = 'quatrocentos';
  SFctMoeda_400F = 'quatrocentas';
  SFctMoeda_500M = 'quinhentos';
  SFctMoeda_500F = 'quinhentas';
  SFctMoeda_600M = 'seiscentos';
  SFctMoeda_600F = 'seiscentas';
  SFctMoeda_700M = 'setecentos';
  SFctMoeda_700F = 'setecentas';
  SFctMoeda_800M = 'oitocentos';
  SFctMoeda_800F = 'oitocentas';
  SFctMoeda_900M = 'novecentos';
  SFctMoeda_900F = 'novecentas';

implementation

const
  _lim_ext = 5;    // limite para trilhões
  _trilhao = 1;
  _bilhao = 2;
  _milhao = 3;
  _milhar = 4;
  _centena = 5;


function MontaExtensoBase(AValor: Int64; ATipo: TTipoExtenso): String;
const
  // descrição das casas
  _mm: array[1.._lim_ext, 1..2] of String = (
    (SFctMoeda_TS, SFctMoeda_TP),
    (SFctMoeda_BS, SFctMoeda_BP),
    (SFctMoeda_MS, SFctMoeda_MP),
    (SFctMoeda_ML, SFctMoeda_ML),
    ('', '')
  );
  // centena - MASCULINO
  _cm: array[0..9] of String = (
    SFctMoeda_C00M, SFctMoeda_100M, SFctMoeda_200M,
    SFctMoeda_300M, SFctMoeda_400M, SFctMoeda_500M,
    SFctMoeda_600M, SFctMoeda_700M, SFctMoeda_800M,
    SFctMoeda_900M
  );
  // centena - FEMININO
  _cf: array[0..9] of String = (
    SFctMoeda_C00M, SFctMoeda_100M, SFctMoeda_200F,
    SFctMoeda_300F, SFctMoeda_400F, SFctMoeda_500F,
    SFctMoeda_600F, SFctMoeda_700F, SFctMoeda_800F,
    SFctMoeda_900F
  );
  // dezena (11 a 19)
  _dd: array[1..9] of String = (
    SFctMoeda_11, SFctMoeda_12, SFctMoeda_13,
    SFctMoeda_14, SFctMoeda_15, SFctMoeda_16,
    SFctMoeda_17, SFctMoeda_18, SFctMoeda_19
  );
  // dezena inteira
  _di: array[1..9] of String = (
    SFctMoeda_10, SFctMoeda_20, SFctMoeda_30,
    SFctMoeda_40, SFctMoeda_50, SFctMoeda_60,
    SFctMoeda_70, SFctMoeda_80, SFctMoeda_90
  );
  // unidades - MASCULINO
  _um: array[1..9] of String = (
    SFctMoeda_1M, SFctMoeda_2M, SFctMoeda_3M,
    SFctMoeda_4M, SFctMoeda_5M, SFctMoeda_6M,
    SFctMoeda_7M, SFctMoeda_8M, SFctMoeda_9M
  );
  // unidades - FEMININO
  _uf: array[1..9] of String = (
    SFctMoeda_1F, SFctMoeda_2F, SFctMoeda_3M,
    SFctMoeda_4M, SFctMoeda_5M, SFctMoeda_6M,
    SFctMoeda_7M, SFctMoeda_8M, SFctMoeda_9M
  );
var
  Numero: TNumeroInfo;
  tmpStr: ShortString;
  tmpNum: String[3];
  tmpExt: ShortString;
  tmpPar: SmallInt;
  i: Integer;
  iNum: Byte;
  ExtInfo: array[1.._lim_ext] of TExtensoInfo;
  //----------------------------------------------------------------------
  function TextoCentena(AIndex: Integer): ShortString;
  begin
    case ATipo of
      teMasculino:
        Result := _cm[AIndex];
      teFeminino:
        Result := _cf[AIndex];
    end;
  end;
  //----------------------------------------------------------------------
  function TextoUnidade(AIndex: Integer): ShortString;
  begin
    case ATipo of
      teMasculino:
        Result := _um[AIndex];
      teFeminino:
        Result := _uf[AIndex];
    end;
  end;
  //----------------------------------------------------------------------
begin
  Result := '';
  if AValor <= 0 then Exit;
  // compõe a string de formatação
  tmpStr := IntToStr(AValor);
  while (Length(tmpStr) < (_lim_ext * 3)) do
  begin
    tmpStr := '0' + tmpStr;
  end;
  // obtém as partes do número
  for i := 1 to _lim_ext do
  begin
    tmpNum := Copy(tmpStr, ((i - 1) * 3) + 1, 3);
    ExtInfo[i].NumeroStr := tmpNum;
    tmpExt := '';
    iNum := 1;
    while (iNum <= 3) do
    begin
      if tmpNum[iNum] in ['0'..'9'] then
        tmpExt := tmpExt + tmpNum;
      iNum := iNum + 1;
    end;
    if tmpExt = '' then tmpExt := '0';
    ExtInfo[i].NumeroInt := StrToInt(tmpExt);
  end;
  // inicia o processamento
  for i := 1 to _lim_ext do
  begin
    tmpNum := ExtInfo[i].NumeroStr;
    // armazena o número já devidamente fragmentado para análise
    Numero.Centena := StrToInt(tmpNum[1]);
    Numero.Dezena := StrToInt(tmpNum[2]);
    Numero.Unidade := StrToInt(tmpNum[3]);
    // constrói o extenso do número (parcial)
    tmpExt := '';
    tmpPar := StrToInt(tmpNum);
    if tmpPar > 0 then
    begin
      // trata a centena
      if (Numero.Centena > 0) then
      begin
        if (Numero.Centena = 1) and
          ((Numero.Dezena + Numero.Unidade) > 0) then
          tmpExt := tmpExt + #32 + TextoCentena(0)
        else
          tmpExt := tmpExt + #32 + TextoCentena(Numero.Centena);
      end;
      // trata a dezena
      if (Numero.Dezena > 0) then
      begin
        if (Numero.Centena > 0) then
          tmpExt := tmpExt + #32 + SFctMoeda_E;
        if (Numero.Dezena = 1) and (Numero.Unidade > 0) then
          tmpExt := tmpExt + #32 + _dd[Numero.Unidade]
        else
          tmpExt := tmpExt + #32 + _di[Numero.Dezena];
      end;
      // trata a unidade
      if (Numero.Unidade > 0) and (Numero.Dezena <> 1) then
      begin
        if (Numero.Centena > 0) or (Numero.Dezena > 0) then
          tmpExt := tmpExt + #32 + SFctMoeda_E;
        tmpExt := tmpExt + #32 + TextoUnidade(Numero.Unidade);
      end;
      if (tmpPar = 1) then
        tmpExt := tmpExt + #32 + _mm[i][1]
      else
        tmpExt := tmpExt + #32 + _mm[i][2];
    end;
    // adiciona o texto do extenso da parte analisada
    if Length(tmpExt) > 0 then
    begin
      if Result <> '' then
      begin
        if (Numero.Centena > 0) and
          ((Numero.Dezena > 0) or (Numero.Unidade > 0)) then
          Result := Result + ','
        else
          Result := Result + #32 + SFctMoeda_E;
      end;
      Result := Result + #32 + TrimLeft(TrimRight(tmpExt));
    end;
    // inicia reprocessamento
  end;
  Result := TrimLeft(TrimRight(Result));
end;


function ValorPorExtenso(AValor: Currency): String;
var
  NumInt: Int64;
  NumDec: LongWord;
  tmpStr: ShortString;
  ExtInt: String;
  ExtDec: String;
  p: Byte;
begin
  Result := '';
  tmpStr := FormatFloat('0.00', AValor);
  p := Pos(DecimalSeparator, tmpStr);
  NumInt := StrToInt64Def(Copy(tmpStr, 1, p - 1), 0);
  NumDec := StrToIntDef(Copy(tmpStr, p + 1, 2), 0);
  if NumInt > 0 then
  begin
    ExtInt := MontaExtensoBase(NumInt, teMasculino);
    if NumInt = 1 then
      Result := ExtInt + #32 + SFctMoeda_IS
    else
      Result := ExtInt + #32 + SFctMoeda_IP;
  end;
  if NumDec > 0 then
  begin
    if NumInt > 0 then ExtDec := SFctMoeda_E;
    ExtDec := ExtDec + #32 + MontaExtensoBase(NumDec, teMasculino);
    if NumDec = 1 then
      Result := Result + #32 + ExtDec + #32 + SFctMoeda_DS
    else
      Result := Result + #32 + ExtDec + #32 + SFctMoeda_DP;
  end;
end;


function NumeroPorExtensoMasculino(ANumero: Int64): String;
begin
  Result := MontaExtensoBase(ANumero, teMasculino);
end;


function NumeroPorExtensoFeminino(ANumero: Int64): String;
begin
  Result := MontaExtensoBase(ANumero, teFeminino);
end;


end.
