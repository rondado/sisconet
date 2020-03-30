unit uLibrary;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, Menus, ActnList, Buttons, ExtCtrls, ComCtrls, ImgList, DbClient,
     inifiles, dbtables, Db, StdCtrls, Registry,MMSYSTEM, Grids, DBGrids,dbctrls,
     ShellApi, DbxPress,SqlExpr, ADODB, Provider,Math,Winsock;

type
  TTypeLocalizar = (fsInteger, fsString);

var
  Transc : TTransactionDesc;
  ConexaoDados : TSQLConnection;
  sIDEmpresa,sIDPerfil : Integer;
  sTipoEmp,sGrupoPadrao : Integer;
  sIndiceTijolo,sIndiceIsopor,sIndiceOutros : Double;
  sTipoComissao:Integer;
  sMargemPadrao: Double;
  sTipoCalcPerc, sDiasAgenda, sModeloPedido : Integer;
  sAtualizaPrecos, sEditaCliPed : String;
  sEstoqueNegativo,sLancCaixa,sPrecoNegativo,sPedidoSeq, sContEstComp : String;
  sNomeEmpresa:String;
  sTotalDespesa,sTotalReceita : Currency;
  sCasasDecimais : Integer;
  sPathWindows, sPathSPED : String;
  pNumCli, pNumProd : Integer;
  lng: DWORD;
  Hwnd : THandle;
  delta: Double;

  procedure FilterCDS (aCds: TClientDataSet; aType: TTypeLocalizar; aBusca: string);
  procedure AbreForm(aClasseForm: TComponentClass; aForm: TForm);
  function IDTransaction: string;
  procedure RefreshCDS (aDataSet: TClientDataSet);
  Procedure GridOrdem(fCds:TClientDataSet;Grid:TDbGrid;Column:TColumn);
  procedure HAbilitaBotoes(fFrame:TFrame;fDataSet:TDataSet);
  procedure AbilitaFrame(auxFrame: TFrame ; auxDb: TDataSet);
  procedure Start;
  procedure Comit;
  procedure Rollback;
  procedure IniciaTransacao;
  procedure Grava_Dados(pDataDados: TDataSet);
  function FiltraNumero(fAux:String):string;
  procedure CancelRevertUpdates(DataSet: TDataSet);
  procedure CancelUpdates(DataSet: TDataSet);
  procedure TabEnter(auxForm:TForm;var Key: Char);
  function VerificaCNPJ(fCNPJ:String ):Boolean;
  function VerificaCpf(fCPF:String ):Boolean;
  Function PrimeiroDia(fData:TDateTime):TDateTime;
  Function UltimoDia(fData:TDateTime):TDateTime;
  function AnoBis(Data: TDateTime): Boolean;
  function Retorna_Data_AnteriorPosterior(fAP:Integer; fDataAtual:TDateTime):TDateTime;
  function ZeroEsquerda(fTermo:String;fQuant:Integer):String;
  function Retorna_QuantDias(fPosicao:Integer;fFormaPag:String):Integer;
  function Remove_CaracterEstranho(fTexto:String):String;
  function ArredondamentoDec(fValor:Currency;fDecimal:Integer):Currency;
  function AlinhaCampoValor(fValor:Double;fTamanho,fDecimal:Integer):String;
  function SVData: TDateTime;
  function SVHora: TDateTime;
  function RetornaIP:string; //--> Declare a Winsock na clausula uses da unit
  function VerificaMesPeriodo(fDatai,fDataf:TDateTime):Boolean;
  function VerificaMesPeriodoAtual(fDataPeriodo,fDataAtual:TDateTime):Boolean;
  function Criptografa(texto: string; chave: Byte): String;
  procedure AlterVirgulaPonto(auxForm:TForm;var Key: Char);
  function TruncaValor(pValor:Double;Decimais:Integer):Currency;
  function Retorna_DiaSemana(Data: TDateTime): String;
  function GenID(pGenerator: String): Integer;
  function AlinhaTXT(pTexto:String;pAlinha,pTamanho:Integer):String;
  function AlteraCaracter(pTexto,pOld,pNew:String):String;
  procedure ValorCampoFloat(DataSet:TDataSet);
  procedure GravaLogOperacao(pTexto,pUser:String;pModoLog:Integer);
  function RetornaQtdRegDBX(Qry:TSQLQuery):Integer;

  const
    MSG_OK = 'Informação cadastrada com sucesso!';
    MSG_PERMISSOES = 'Você não tem permissão para executar essa ação';
    MSG_CAMPO_OBR = 'Campo obrigatório';
    MSG_ERRO = 'Ocorreu um erro!';

implementation

uses DateUtils;

procedure FilterCDS (aCds: TClientDataSet; aType: TTypeLocalizar; aBusca: string);
begin
  aCds.Close;
  case aType of
    fsInteger: aCds.Params[0].AsInteger := StrToInt(aBusca);
    fsString: aCds.Params[0].AsString := UpperCase('%' + aBusca + '%');
  end;
  aCds.Open;
end;

procedure AbreForm(aClasseForm: TComponentClass; aForm: TForm);
begin
  Application.CreateForm(aClasseForm, aForm);
  try
    aForm.ShowModal;
  finally
    aForm.Free;
  end;
end;

function IDTransaction: string;
var i: integer;
const str = '0123456789';
begin
  for i := 1 to 2 do
  begin
    Randomize;
    Result := Result + str[Random(Length(str))+1];
  end;
end;

procedure RefreshCDS (aDataSet: TClientDataSet);
begin
  aDataSet.Close;
  aDataSet.Open;
end;

Procedure GridOrdem(fCds:TClientDataSet;Grid:TDbGrid;Column:TColumn);
var i : integer;
begin
  if fCds.Active then
  begin
    for i := 0 to Grid.FieldCount-1 do
      Grid.Columns.Items[i].Title.Color := clBtnFace;
    if not (Column.Field.DataType in [ftBlob, ftMemo]) then
    begin
      if (fCds.FieldByName(Column.Field.FieldName).FieldKind <> fkCalculated) and
         (fCds.FieldByName(Column.Field.FieldName).FieldKind <> fkLookup) then
      begin
        fCds.IndexFieldNames := Column.FieldName;
        Column.Title.Color  := $00FFBB77;
      end;
    end;
  end;
end;

procedure HAbilitaBotoes(fFrame:TFrame;fDataSet:TDataSet);
var Botao1,Botao2,Botao3,Botao4,Botao5,Botao6,Botao7 : Tcomponent;
begin
  if Assigned(fFrame) and Assigned(fDataSet) and (fDataSet.Active) then
  begin
    with fFrame do
    begin
      Botao1 := FindComponent('BtnIncluir');
      Botao2 := FindComponent('BtnExcluir');
      Botao3 := FindComponent('BtnConfirmar');
      Botao4 := FindComponent('BtnCancelar');
      Botao5 := FindComponent('BtnPesquisar');
      Botao6 := FindComponent('BtnRelatorio');
      Botao7 := FindComponent('BtnEncerrar');
      // Habilita todos
      TBitBtn(Botao1).Enabled := true;
      TBitBtn(Botao2).Enabled := true;
      TBitBtn(Botao3).Enabled := true;
      TBitBtn(Botao4).Enabled := true;
      TBitBtn(Botao5).Enabled := true;
      TBitBtn(Botao6).Enabled := true;
      TBitBtn(Botao7).Enabled := true;
      // efetua verificações
      if fDataSet.State in [dsInsert,dsEdit] then
      begin
        if Assigned(Botao1) then
        begin
          if TBitBtn(Botao1).Enabled then
             TBitBtn(Botao1).Enabled := false;
        end;
        if Assigned(Botao2) then
        begin
          if TBitBtn(Botao2).Enabled then
             TBitBtn(Botao2).Enabled := false;
        end;
        if Assigned(Botao5) then
        begin
          if TBitBtn(Botao5).Enabled then
             TBitBtn(Botao5).Enabled := false;
        end;
        if Assigned(Botao6) then
        begin
          if TBitBtn(Botao6).Enabled then
             TBitBtn(Botao6).Enabled := false;
        end;
        if Assigned(Botao7) then
        begin
          if TBitBtn(Botao7).Enabled then
             TBitBtn(Botao7).Enabled := false;
        end;
      end
      else
      begin
        if Assigned(Botao3) then
        begin
          if TBitBtn(Botao3).Enabled then
             TBitBtn(Botao3).Enabled := false;
        end;
        if Assigned(Botao4) then
        begin
          if TBitBtn(Botao4).Enabled then
             TBitBtn(Botao4).Enabled := false;
        end;
      end;
    end;
  end;

end;

procedure AbilitaFrame(auxFrame: TFrame ; auxDb: TDataSet);
  var Comp : Tcomponent;
      i:longint;
begin
  if Assigned(auxFrame) and Assigned(auxDb) and (AuxDb.Active) then
    with auxFrame do
    begin
      Comp := FindComponent('BtnExcluir');
      if Assigned(Comp) then
      begin
        i:=comp.componentIndex;

        if TBitBtn(Components[i]).Tag = 0 then
        begin
          if (auxDb.Recordcount) = 0 then
             TBitBtn(Components[i]).Enabled := false
          else
             TBitBtn(Components[i]).Enabled := true;
        end
      end;

      if auxDb.State in [dsInsert,dsEdit] then
      begin
        Comp := FindComponent('BtnCancelar');
        if Assigned(Comp) then
        begin
          i:=comp.componentIndex;
          TBitBtn(Components[i]).Enabled := true;
        end;
        Comp := FindComponent('BtnConfirmar');
        if Assigned(Comp) then
        begin
          i:=comp.componentIndex;
          if TBitBtn(Components[i]).Tag = 0 then
             TBitBtn(Components[i]).Enabled := true;
        end;
      end
      else
      begin
        Comp := FindComponent('BtnCancelar');
        IF Assigned(Comp) then
        begin
          i:=comp.componentIndex;
          TBitBtn(Components[i]).Enabled := false;
        end;
        Comp := FindComponent('BtnConfirmar');
        if Assigned(Comp) then
        begin
           i:=comp.componentIndex;
           if TBitBtn(Components[i]).Tag = 0 then
              TBitBtn(Components[i]).Enabled := false;
        end;
      end;
      Comp:= FindComponent('BtnIncluir');
      if Assigned(Comp) then
      begin
        i := comp.componentIndex;
        if TBitBtn(Components[i]).Tag = 0 then
        begin

          if auxDb.State in [dsInsert,dsEdit] then
            TBitBtn(Components[i]).Enabled := false
          else
            TBitBtn(Components[i]).Enabled := true;
        end;

      end;
{      Comp := FindComponent('BitEditar');
      if Assigned(Comp) then
      begin
        i := comp.componentIndex;
        if TBitBtn(Components[i]).Tag = 0 then
        begin
          if auxDb.RecordCount = 0 then
            TBitBtn(components[i]).Enabled := False
          else if AuxDb.State in [ dsInsert, dsEdit] then
            TBitBtn(components[i]).Enabled := False
          else
            TBitBtn(components[i]).Enabled := True;
        end;
      end;  }
    end;
end;

procedure Start;
begin
  Transc.IsolationLevel := xilREADCOMMITTED;
  Transc.TransactionID := StrToInt(IDTransaction);
  ConexaoDados.StartTransaction(Transc);

end;

procedure Comit;
begin
  ConexaoDados.Commit(Transc);

end;

procedure Rollback;
begin
  ConexaoDados.Rollback(Transc);
  raise Exception.Create(MSG_ERRO);

end;

procedure Grava_Dados(pDataDados: TDataSet);
begin
  Randomize;
  IniciaTransacao;
  if TClientDataSet(pDataDados).Active then
  begin
    if TClientDataSet(pDataDados).State in [dsInsert,dsEdit] then
       TClientDataSet(pDataDados).Post;
    if TClientDataSet(pDataDados).ChangeCount > 0 then
       TClientDataSet(pDataDados).ApplyUpdates(0);
  end;
  ConexaoDados.Commit(Transc);

end;


procedure IniciaTransacao;
begin
  Transc.TransactionID  := Random(65635);
  Transc.IsolationLevel :=  xilREADCOMMITTED;
  ConexaoDados.StartTransaction(Transc);
end;


function FiltraNumero(fAux:String):string;
var i:Integer;
begin
  Result := '';
  for i:=1 to length(fAux) do
  begin
    if (Copy(fAux,i,1) = '1') or
       (Copy(fAux,i,1) = '2') or
       (Copy(fAux,i,1) = '3') or
       (Copy(fAux,i,1) = '4') or
       (Copy(fAux,i,1) = '5') or
       (Copy(fAux,i,1) = '6') or
       (Copy(fAux,i,1) = '7') or
       (Copy(fAux,i,1) = '8') or
       (Copy(fAux,i,1) = '9') or
       (Copy(fAux,i,1) = '0') then
     begin
       Result := Result + Copy(fAux,i,1);
     end;
  end;
end;

procedure CancelRevertUpdates(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    CancelUpdates(DataSet);
    (DataSet as TClientDataSet).Refresh;
  end;
end;

procedure CancelUpdates(DataSet: TDataSet);
var ClientDataSet: TClientDataSet;
begin
  if (DataSet.Active)  then
  begin
    ClientDataSet := DataSet as TClientDataSet;
    if ClientDataSet.State in dsEditModes then
      ClientDataSet.Cancel;
    if ClientDataSet.ChangeCount > 0 then
       ClientDataSet.CancelUpdates;
  end
end;

procedure TabEnter(auxForm:TForm;var Key: Char);
begin
  with auxForm do
  begin
    if Key = #13 then
    begin
      if not (ActiveControl is TDBGrid) then
      begin
        Key:=#0;
        Perform(WM_NEXTDLGCTL,0,0);
      end
    end;
  end;
end;

function VerificaCNPJ(fCNPJ: String):Boolean;
Var
d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
Check : String;
begin
d1 := 0;
d4 := 0;
xx := 1;
for nCount := 1 to Length( fCNPJ )-2 do
    begin
    if Pos( Copy( fCNPJ, nCount, 1 ), '/-.' ) = 0 then
       begin
       if xx < 5 then
          begin
          fator := 6 - xx;
          end
       else
          begin
          fator := 14 - xx;
          end;
       d1 := d1 + StrToInt( Copy( fCNPJ, nCount, 1 ) ) * fator;
       if xx < 6 then
          begin
          fator := 7 - xx;
          end
       else
          begin
          fator := 15 - xx;
          end;
       d4 := d4 + StrToInt( Copy( fCNPJ, nCount, 1 ) ) * fator;
       xx := xx+1;
       end;
    end;
    resto := (d1 mod 11);
    if resto < 2 then
       begin
       digito1 := 0;
       end
   else
       begin
       digito1 := 11 - resto;
       end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
      begin
      digito2 := 0;
      end
   else
      begin
      digito2 := 11 - resto;
      end;
   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(fCNPJ,succ(length(fCNPJ)-2),2) then
      begin
      Result := False;
      end
   else
      begin
      Result := True;
      end;
end;

function VerificaCpf(fCPF:String ):Boolean;
Var
d1,d4,xx,nCount,resto,digito1,digito2 : Integer;
Check : String;
Begin
d1 := 0; d4 := 0; xx := 1;
for nCount := 1 to Length( fCPF )-2 do
    begin
    if Pos( Copy( fCPF, nCount, 1 ), '/-.' ) = 0 then
       begin
       d1 := d1 + ( 11 - xx ) * StrToInt( Copy( fCPF, nCount, 1 ) );
       d4 := d4 + ( 12 - xx ) * StrToInt( Copy( fCPF, nCount, 1 ) );
       xx := xx+1;
       end;
    end;
resto := (d1 mod 11);
if resto < 2 then
   begin
   digito1 := 0;
   end
else
   begin
   digito1 := 11 - resto;
   end;
d4 := d4 + 2 * digito1;
resto := (d4 mod 11);
if resto < 2 then
   begin
   digito2 := 0;
   end
else
   begin
   digito2 := 11 - resto;
   end;
Check := IntToStr(Digito1) + IntToStr(Digito2);
if Check <> copy(fCPF,succ(length(fCPF)-2),2) then
   begin
   Result := False;
   end
else
   begin
   Result := True;
   end;
end;

Function PrimeiroDia(fData:TDateTime):TDateTime;
var Dia,Mes,Ano,Hora,Min,Seg,Mseg: Word;
begin
  DecodeDateTime(fData,Ano,Mes,Dia,Hora,Min,Seg,Mseg);
  Result := EncodeDateTime(Ano,Mes,01,Hora,Min,Seg,Mseg);

end;

Function UltimoDia(fData:TDateTime):TDateTime;
var Dia,Mes,Ano,Hora,Min,Seg,Mseg: Word;
    Bis : Boolean;
begin
  Bis := AnoBis(fData);
  DecodeDateTime(fData,Ano,Mes,Dia,Hora,Min,Seg,Mseg);
  case Mes of
    01 : Dia := 31;
    02 : begin
           if Bis then Dia := 29
           else Dia := 28;
         end;
    03 : Dia := 31;
    04 : Dia := 30;
    05 : Dia := 31;
    06 : Dia := 30;
    07 : Dia := 31;
    08 : Dia := 31;
    09 : Dia := 30;
    10 : Dia := 31;
    11 : Dia := 30;
    12 : Dia := 31;
  end;
  Result := EncodeDateTime(Ano,Mes,Dia,Hora,Min,Seg,Mseg);

end;

function AnoBis(Data: TDateTime): Boolean;
var Dia,Mes,Ano : Word;
begin
  DecodeDate(Data,Ano,Mes,Dia);
  if Ano mod 4 <> 0 then AnoBis := False
  else if Ano mod 100 <> 0 then AnoBis := True
  else if Ano mod 400 <> 0 then AnoBis := False
  else AnoBis := True;

end;

function Retorna_Data_AnteriorPosterior(fAP:Integer; fDataAtual:TDateTime):TDateTime;
var Dia,Mes,Ano : Word;
begin
  // fAP = 0 - Anterior
  //       1 - Posterior
  DecodeDate(fDataAtual,Ano,Mes,Dia);
  if fAP = 0 then Mes := Mes - 1;
  if fAP = 1 then Mes := Mes + 1;
  // Monta Data
  if Mes > 12 then
  begin
    Mes := 1;
    Ano := Ano + 1;
  end;
  if Mes < 1 then
  begin
    Mes := 12;
    Ano := Ano - 1;
  end;
  // resultado
  Result := EncodeDate(Ano,Mes,01);
end;


function ZeroEsquerda(fTermo:String;fQuant:Integer):String;
var aux:String;
    i:Integer;
begin
  Result := '';
  aux := Trim(fTermo);
  for i:=1 to fQuant-length(aux) do
  begin
    Result := Result + '0';
  end;
  Result := Result + aux;

end;

function Retorna_QuantDias(fPosicao:Integer;fFormaPag:String):Integer;
var aux:String;
    i,Cont:Integer;
begin
  aux := '';
  Cont := 0;
  for i:=1 to length(fFormaPag) do
  begin
    if Copy(fFormaPag,i,1) <> '/' then
    begin
      aux := aux + Copy(fFormaPag,i,1)
    end
    else
    begin
      Inc(Cont);
      if Cont = fPosicao then
         Break
      else
         aux := '';
    end;
  end;
  Result := StrToInt(aux);

end;

function Remove_CaracterEstranho(fTexto:String):String;
var i:Integer;
begin
  Result := '';
  for i:=0 to length(fTexto) do
  begin
    if Copy(fTexto,i,1) <> '&' then
       Result := Result + Copy(fTexto,i,1);
  end;
end;

function ArredondamentoDec(fValor:Currency;fDecimal:Integer):Currency;
var aValor,aux:String;
    i:Integer;
begin
  Result := 0;
  aux := '0.';
  for i:=1 to fDecimal do aux := aux + '0';
  //
  aValor := FormatFloat(aux,fValor);
  Result := StrToFloat(aValor);

end;

function AlinhaCampoValor(fValor:Double;fTamanho,fDecimal:Integer):String;
var aux,Mask : String;
    I:Integer;
begin
  Mask := '0.';
  for i:=1 to fDecimal do Mask := Mask+'0';
  aux := FormatFloat(Mask,fValor);
  Result := '';
  for i:=1 to fTamanho-length(aux) do
    Result := Result+' ';
  Result := Result + aux;
end;





Function SVData: TDateTime;
begin
  Result := Trunc(now+delta);
end;

function SVHora: TDateTime;
begin
  Result := now+delta - Trunc(now+delta);
end;

function RetornaIP:string;
var WSAData: TWSAData;
    HostEnt: PHostEnt;
    Name:string;
begin
  WSAStartup(2, WSAData);
  SetLength(Name, 255);
  Gethostname(PChar(Name), 255);
  SetLength(Name, StrLen(PChar(Name)));
  HostEnt := gethostbyname(PChar(Name));
  with HostEnt^ do
    Result:=Format('%d.%d.%d.%d',[Byte(h_addr^[0]),
              Byte(h_addr^[1]),Byte(h_addr^[2]),Byte(h_addr^[3])]);
  WSACleanup;
end;

function VerificaMesPeriodo(fDatai,fDataf:TDateTime):Boolean;
var Dia,Mesi,Mesf,Ano:Word;
begin
  DecodeDate(fDatai,Ano,Mesi,Dia);
  DecodeDate(fDataf,Ano,Mesf,Dia);
  Result := true;
  if Mesi <> Mesf then
     Result := false;

end;

function VerificaMesPeriodoAtual(fDataPeriodo,fDataAtual:TDateTime):Boolean;
var Dia,MesP,MesA,Ano:Word;
begin
  DecodeDate(fDataPeriodo,Ano,Mesp,Dia);
  DecodeDate(fDataAtual,Ano,Mesa,Dia);
  Result := false;
  if Mesa = Mesp then
     Result := true;

end;


function Criptografa(texto: string; chave: Byte): String;
var buffer: array of byte;
  i: integer;
  resultado: String;
begin
  resultado:='';
  SetLength(buffer,Length(texto));
  for i:=1 to Length(texto) do
  begin
    buffer[i-1]:= ord(texto[i]);
    buffer[i-1]:= buffer[i-1] xor chave;
    resultado:= resultado + chr(buffer[i-1]);
  end;
  Result:= resultado;
end;

procedure AlterVirgulaPonto(auxForm:TForm;var Key: Char);
var i : Integer;
begin
  for i := 0 to auxForm.ComponentCount -1 do
  begin
    if auxForm.Components[i] is TEdit then
    begin
      with auxForm do
      begin
        if key in [',','.'] then
           key := decimalseparator;
      end;
    end;
  end;
end;

function TruncaValor(pValor:Double;Decimais:Integer):Currency;
var i, c :integer;
    Valor, aux : String;
    aDec : Boolean;
begin
  c := -1;
  aux := '';
  aDec := false;
  Result := 0;
  Valor := FloatToStr(pValor);
  for i := 1 to length(Valor) do
  begin
    if (copy(Valor,i,1) = ',') or (copy(Valor,i,1) = '.') then
       aDec := true;
    if c < Decimais then
       aux := aux + copy(Valor,i,1);
    if aDec then
       Inc(c);
  end;
  Result := StrToFloat(aux);

end;


// Retorna o dia da semana em Extenso de uma determinada data
function Retorna_DiaSemana(Data: TDateTime): String;
const Dias : Array[1..7] of String[07] = ('DOMINGO', 'SEGUNDA', 'TERCA','QUARTA','QUINTA', 'SEXTA','SABADO');
begin
  Result := Dias[DayOfWeek(Data)];

end;

function GenID(pGenerator: String): Integer;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Add('SELECT GEN_ID('+pGenerator+',1) FROM RDB$DATABASE');
    Q.Open;
    Result := Q.Fields[0].AsInteger;
  finally
    FreeAndNil(Q);
  end;

end;

function AlinhaTXT(pTexto:String;pAlinha,pTamanho:Integer):String;
var i, aux:Integer;
begin
  // pAlinha 0 = Esquerdo
  //         1 = Direito
  Result := pTexto;
  aux := pTamanho-length(pTexto);
  for i:=1 to aux do
  begin
    if pAlinha = 0 then
       Result := ' '+Result
    else if pAlinha = 1 then
       Result := Result+' ';
  end;

end;

function AlteraCaracter(pTexto,pOld,pNew:String):String;
var i:Integer;
begin
  Result := '';
  for i:=1 to length(pTexto) do
  begin
    if Copy(pTexto,i,1) = pOld then
    begin
      Result := Result + pNew;
    end
    else
    begin
      Result := Result + Copy(pTexto,i,1);
    end;
  end;

end;

procedure ValorCampoFloat(DataSet:TDataSet);
var i : Integer;
begin
  for i := 0 to DataSet.FieldCount-1 do
  begin
    if DataSet.Fields[i].DataType in [ftInteger,ftFloat,ftCurrency,ftFMTBcd] then
    begin
      if DataSet.Fields[i].IsNull then
      begin
         DataSet.Fields[i].AsInteger := 0;
      end;
    end;
   end;
end;

procedure GravaLogOperacao(pTexto,pUser:String;pModoLog:Integer);
var Arquivo: TextFile;
    aNomeArq, aConteudo, Linha, Dados : String;
begin
  // verifica modo de gravação do log
  if pModoLog = 0 then
  begin
    aNomeArq := ExtractFilePath(Application.ExeName)+'Log\DiskPizza.log';
  end
  else if pModoLog = 1 then
  begin
    aNomeArq := ExtractFilePath(Application.ExeName)+'Log\'+FormatDateTime('DDMMYYYY',SVData)+'.log';
  end
  else if pModoLog = 2 then
  begin
    aNomeArq := ExtractFilePath(Application.ExeName)+'Log\'+FormatDateTime('DDMMYYYY',SVData)+FormatDateTime('HHMMSS',SVHora)+'.log';
  end;
  // cria o diretorio de log
  if not DirectoryExists(ExtractFilePath(aNomeArq)) then
     CreateDir(ExtractFilePath(aNomeArq));
  // prepara a informação
  aConteudo := 'Data: '+FormatDateTime('DD/MM/YYYY',SVData)+' Hora:'+FormatDateTime('HH:MM:SS',SVHora);
  aConteudo := aConteudo + ' - '+pTexto+' - Usuario: '+pUser;
  if pModoLog < 2 then
  begin
    aConteudo := aConteudo +#13+#10+#13+#10;
  end;
  // lê as informação do arquvo
  Dados := '';
  if FileExists(aNomeArq) then
  begin
    AssignFile(Arquivo,aNomeArq);
    Reset(Arquivo);
    While not Eof(Arquivo) do
    begin
      Readln(Arquivo,Linha);
      if Linha <> '' then
         Dados := Dados + Linha +#13+#10+#13+#10+#13+#10;
    end;
    CloseFile(Arquivo);
  end;
  Dados := Dados + aConteudo;
  // grava a informação no arquvo
  AssignFile(Arquivo,aNomeArq);
  Rewrite(Arquivo);
  Writeln(Arquivo,Dados);
  CloseFile(Arquivo);


end;

function RetornaQtdRegDBX(Qry:TSQLQuery):Integer;
begin
  Qry.First;
  Result := 0;
  while not Qry.Eof do
  begin
    Inc(Result);
    Qry.Next;
  end;
  Qry.First;
    
end;



end.

