unit uLibrary;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, Menus, ActnList, Buttons, ExtCtrls, ComCtrls, ImgList, DbClient,
     inifiles, Db, StdCtrls, Registry,MMSYSTEM, Grids, DBGrids,dbctrls,
     ShellApi, SqlExpr, ADODB, Provider,Math,Winsock;

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
  sComIntSeg,sComIntTer,sComIntQua,sComIntQui,sComIntSex,sComIntSab,sComIntDom : Boolean;
  sNomeEmpresa:String;
  sTotalDespesa,sTotalReceita : Currency;
  sCasasDecimais : Integer;
  sPathWindows : String;
  pNumCli, pNumProd : Integer;
  lng: DWORD;
  Hwnd : THandle;
  delta: Double;
  pLogin : Boolean;
  pUsuario : String;

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
  function Retorna_TotalDebito_Contato(fIDContato:Integer):Double;
  function Retorna_Valor_Custo_ProdComposto(fID: Integer): Double;
  function Retorna_IndicePercentual(fPN:String;fPerc:Double):Double;
  function ZeroEsquerda(fTermo:String;fQuant:Integer):String;
  function Retorna_Total_Pedido(fIDPedido: Integer): Double;
  function Retorna_Custo_Pedido(fIDPedido: Integer): Double;
  function Grava_MovEstoque(fIDProduto:Integer;fQuant:Double):Boolean;
  function Retorna_EstoqueAtual(fIDProduto:Integer):Double;
  function Verifica_ContasQuitadas(fIDPedido:Integer):Boolean;
  function Apaga_Contas(pTipo,fIDPedido:Integer):Boolean;
  function Retorna_QuantDias(fPosicao:Integer;fFormaPag:String):Integer;
  function Remove_CaracterEstranho(fTexto:String):String;
  function Verifica_Permissao(fIDPerfil:Integer;fMenuItem:String):Boolean;
  function Retorna_Total_Compra(fIDCompra: Integer): Double;
  function Retorna_TipoProduto(fIDProduto:Integer):Integer;
  function Apaga_ComposicaoItem(fIDPed,fIDItemPed:Integer):Integer;
  // Procedure para atualizar preços dos produtos compostos e composição
  Procedure AtualizaPrecoProdutosComposto(fTipo:Integer);
  procedure GravaPrecoCustoVenda(fIDProd,fTipoCalc:Integer;fValor,fMargem:Currency);
  function Retorna_PrecoCustoProd(fIDProd:Integer):Currency;
  procedure Grava_CustoComposicao(fID,fIDProd:Integer;fValor:Currency);
  function ArredondamentoDec(fValor:Currency;fDecimal:Integer):Currency;
  procedure LocalizaDadosCombo(fCombo:TComboBox;fDados:String);
  function AlinhaCampoValor(fValor:Double;fTamanho,fDecimal:Integer):String;
  function RetornaPercComissaoItem(fIDProduto:Integer;fValorVenda:Currency):Double;
  procedure CalculaTotaisCaixaMov(fDataCaixa:TDateTime);
  function VerificaNumPedido(fNumped: String): Boolean;
  function VerificaContasQuitadas(fIDPedido:Integer):Boolean;
  function VerificaEstoqueProduto(fIDProd:Integer;fQuant:Double):Boolean;
  function SVData: TDateTime;
  function SVHora: TDateTime;
  function RetornaIP:string; //--> Declare a Winsock na clausula uses da unit
  function VerificaMesPeriodo(fDatai,fDataf:TDateTime):Boolean;
  function VerificaMesPeriodoAtual(fDataPeriodo,fDataAtual:TDateTime):Boolean;
  function Retorna_Total_Produtos: Integer;
  function Retorna_Total_Contatos: Integer;
  function Criptografa(texto: string; chave: Byte): String;
  procedure AlterVirgulaPonto(auxForm:TForm;var Key: Char);
  function TruncaValor(pValor:Double;Decimais:Integer):Currency;
  function VerificaMesFechado(fData:TDateTime):Boolean;
  function RetornaEstoqueAnterior(fData:TDateTime;fIDProd:Integer):Double;
  procedure ExcluiItensComposicao(fIDPed,fIDIten: Integer);
  function Retorna_DiaSemana(Data: TDateTime): String;
  function Retorna_ComissaoPedido(fIDPedido:Integer):Currency;
  function Retorna_PercComissaoProduto(fIDProduto:Integer):Double;
  procedure Grava_PrecoProduto(fIDProduto,fTipo:Integer;fValor:Currency);
  function Grava_EstoqueProduto(fIDProduto:Integer;fEstoque:Double):Boolean;
  function Retorna_DescricaoProduto(fIDProduto:Integer):String;
  function GenID(pTabela: String): Integer;
  function AlinhaTXT(pTexto:String;pAlinha,pTamanho:Integer):String;
  function RetornaHorasTrabalhada(pID:Integer):TDateTime;
  function RetornaServicoRealizado(pID:Integer):String;
  function RetornaCompromissosDias(pDias:Integer):Integer;
  procedure GravaDadosCompraFornecedor(pValor:Double;pData:TDateTime;pIDProd,pIDFor:Integer);
  function GeraEstoqueProduto(pIDProd,pIDEmpresa:Integer):Boolean;
  function AlteraCaracter(pTexto,pOld,pNew:String):String;
  function RetotornaTotalPagamentoCupom(pID:Integer):Double;
  function RetornaMD5Registro(DataSet:TDataSet):String;
  function Confirmacao(texto: string): boolean;
  function RetornaNumCartoesFechamento(pID:Integer):Integer;
  function VerificaSaldoProdutoPosto(pNumBico:String):Double;
  function RetornaTotalMesa(pID:Integer):Double;
  function VerificaMesaAberta(var IDMesa:Integer;pIDMesa:Integer):Boolean;
  procedure RetornaInformacaoAbastecimeneto(var Tanque,Bomba,Bico:string;
                                            var EI,EF:Double;
                                            pID:Integer);
  function RetornaNumeroMesa(pIDMesa:Integer):String;
  procedure AlteraStatusAbastecimento(pID, pStatus:Integer);
  procedure AlteraStatusMesa(pID, pStatus:Integer);
  function RetornaTotalAbastecimento(pIDProduto,pBico,pStatus:Integer;pData:TDateTime):Double;
  function RetornaTotalVespebBico(pData:TDateTime;pBico:Integer):Double;
  procedure LocalizaRemoveAssinaturaEAD(pNomeArquivo:String);
  function RetornaUltimoCupomEmitido(Caixa:String):Integer;
  function UFToInt(pUF: String): Integer;
  function RetornarIDFornecedor(pCNPJ:String):Integer;

  const
    MSG_OK = 'Informação cadastrada com sucesso!';
    MSG_PERMISSOES = 'Você não tem permissão para executar essa ação';
    MSG_CAMPO_OBR = 'Campo obrigatório';
    MSG_ERRO = 'Ocorreu um erro!';

implementation

uses DateUtils, MD5;

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

function Retorna_TotalDebito_Contato(fIDContato:Integer):Double;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Clear;
    Q.SQL.Add('select sum(contas.Valor_Conta) from contas');
    Q.SQL.Add('where contas.IDContato = :pID');
    Q.Params.ParamByName('pID').AsInteger := fIDContato;
    Q.Open;
    Result := Q.FieldByName('Sum').AsFloat;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function Retorna_Valor_Custo_ProdComposto(fID: Integer): Double;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select produto_composto.quantidade,');
    Q.SQL.Add('produtos.preco_compra from produto_composto');
    Q.SQL.Add('left outer join produtos on');
    Q.SQL.Add('produto_composto.id_produto = produtos.id');
    Q.SQL.Add('where produto_composto.id = :pID');
    Q.Params.ParamByName('pID').AsInteger := fID;
    Q.Open;
    // resultato
    Result := 0;
    if not Q.IsEmpty then
    begin
      Q.First;
      while not Q.Eof do
      begin
        Result := Result + (Q.FieldByname('quantidade').AsFloat * Q.FieldByname('preco_compra').AsFloat);
        Q.Next;
      end;
    end;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function Retorna_IndicePercentual(fPN:String;fPerc:Double):Double;
begin
  if fPN = 'P' then // Positovo
     Result := (100 + fPerc) / 100
  else if fPN = 'N' then // Negativo
     Result := (100 - fPerc) / 100

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

function Retorna_Total_Pedido(fIDPedido: Integer): Double;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select sum(pedido_itens.valor_total) as TotalPedido from pedido_itens');
    Q.SQL.Add('where pedido_itens.idpedido = :pIDPedido');
    Q.SQL.Add('and pedido_itens.cancelado = '+QuotedStr('N'));
    Q.Params.ParamByName('pIDPedido').AsInteger := fIDPedido;
    Q.Open;
    // resultato
    Result := Q.FieldByname('TotalPedido').AsFloat;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function Retorna_Custo_Pedido(fIDPedido: Integer): Double;
var Q : TSQLQuery;
    aTotal:Double;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select produtos.preco_compra,pedido_itens.quantidade');
    Q.SQL.Add('from produtos left outer join pedido_itens on');
    Q.SQL.Add('pedido_itens.idproduto = produtos.id');
    Q.SQL.Add('where pedido_itens.idpedido = :pIDPedido');
    Q.Params.ParamByName('pIDPedido').AsInteger := fIDPedido;
    Q.Open;
    aTotal := 0;
    while not Q.Eof do
    begin
      aTotal := aTotal + (Q.FieldByName('preco_compra').AsFloat*Q.FieldByName('quantidade').AsFloat);
      Q.Next;
    end;
    // resultato
    Result := aTotal;
  finally
    Q.Close;
    Q.Free;
  end;

end;


function Retorna_Total_Compra(fIDCompra: Integer): Double;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select sum(compras_itens.valor_total) as TotalCompra from compras_itens');
    Q.SQL.Add('where compras_itens.idcompra = :pIDCompra');
    Q.Params.ParamByName('pIDCompra').AsInteger := fIDCompra;
    Q.Open;
    // resultato
    Result := Q.FieldByname('TotalCompra').AsFloat;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function Grava_MovEstoque(fIDProduto:Integer;fQuant:Double):Boolean;
var Q : TSQLQuery;
begin
  Result := true;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('update estoque set');
    Q.SQL.Add('estoque.quantidade = :pQuant');
    Q.SQL.Add('where estoque.idproduto = :pIDProd');
    Q.SQL.Add('and estoque.idempresa = :pIDempresa');
    Q.Params.ParamByName('pIDProd').AsInteger    := fIDProduto;
    Q.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
    Q.Params.ParamByName('pQuant').AsFloat       := fQuant;
    Q.ExecSQL(false);
  finally
    Q.Close;
    Q.Free;
  end;
end;

function Retorna_EstoqueAtual(fIDProduto:Integer):Double;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select estoque.quantidade from estoque');
    Q.SQL.Add('where estoque.idproduto = :pIDProd');
    Q.SQL.Add('and estoque.idempresa = :pIDEmpresa');
    Q.Params.ParamByName('pIDprod').AsInteger    := fIDProduto;
    Q.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
    Q.Open;
    Result := Q.FieldByname('quantidade').AsFloat;
  finally
    Q.Close;
    Q.Free;
  end;
end;

function Verifica_ContasQuitadas(fIDPedido:Integer):Boolean;
var Q : TSQLQuery;
begin
  Result := false;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select * from contas');
    Q.SQL.Add('where contas.idpedido = :pID');
    Q.Params.ParamByName('pID').AsInteger := fIDPedido;
    Q.Open;
    Q.First;
    while not Q.Eof do
    begin
      if Q.FieldByName('STATUS').AsInteger > 0 then
      begin
        Result := true;
        Break;
      end;
      Q.Next;
    end;
  finally
    Q.Close;
    Q.Free;
  end;
end;

function Apaga_Contas(pTipo,fIDPedido:Integer):Boolean;
var Q : TSQLQuery;
begin
  // pTipo = 0 - Pedido / 1 - OS
  Result := true;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('delete from contas');
    if pTipo = 0 then
       Q.SQL.Add('where contas.idpedido = :pID')
    else if pTipo = 1 then
       Q.SQL.Add('where contas.idos = :pID');
    Q.Params.ParamByName('pID').AsInteger := fIDPedido;
    Q.ExecSQL(false);
  finally
    Q.Close;
    Q.Free;
  end;
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

function Verifica_Permissao(fIDPerfil:Integer;fMenuItem:String):Boolean;
var Q : TSQLQuery;
begin
  Result := true;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select usuarios_permissoes.menuitem,usuarios_permissoes.permite');
    Q.SQL.Add('from usuarios_permissoes');
    Q.SQL.Add('where usuarios_permissoes.menuitem = :pItemMenu');
    Q.SQL.Add('and usuarios_permissoes.id_perfil = :pIDPerfil');
    Q.Params.ParamByName('pIDPerfil').AsInteger := fIDPerfil;
    Q.Params.ParamByName('pItemMenu').AsString  := fMenuItem;
    Q.Open;
    if Q.FieldByName('permite').AsString <> 'S' then
    begin
      MessageDlg('Usuário não tem permissão nesse ponto do aplicativo. Verifique!!!', mtWarning, [mbOK], 0);
      Result := false;
    end;
  finally
    Q.Close;
    Q.Free;
  end;
end;

function Retorna_TipoProduto(fIDProduto:Integer):Integer;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select produtos.TIPOPROD from produtos');
    Q.SQL.Add('where produtos.id = :pID');
    Q.Params.ParamByName('pID').AsInteger := fIDProduto;
    Q.Open;
    Result := Q.FieldByname('TIPOPROD').AsInteger;
  finally
    Q.Close;
    Q.Free;
  end;
end;

function Apaga_ComposicaoItem(fIDPed,fIDItemPed:Integer):Integer;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('delete from pedido_composicao_item');
    Q.SQL.Add('where pedido_composicao_item.id_pedido = :pIDPed');
    Q.SQL.Add('and pedido_composicao_item.id_itempedido =:pIDItem');
    Q.Params.ParamByName('pIDPed').AsInteger  := fIDPed;
    Q.Params.ParamByName('pIDItem').AsInteger := fIDItemPed;
    Q.ExecSQL(false);
  finally
    Q.Free;
  end;
end;

Procedure AtualizaPrecoProdutosComposto(fTipo:Integer);
var QProd,QComp : TSQLQuery;
    aValorProd,aPrecoCusto:Currency;
begin
  // fTipo = 0 - Apenas Composto  1 - Todos
  QProd := TSQLQuery.Create(nil);
  QComp := TSQLQuery.Create(nil);
  try
    // produtos compostos
    QProd.SQLConnection := ConexaoDados;
    QComp.SQLConnection := ConexaoDados;
    QProd.Close;
    QProd.Params.Clear;
    QProd.SQL.Clear;
    QProd.SQL.Add('select * from produtos');
    if fTipo = 0 then
       QProd.SQL.Add('where produtos.tipoprod = '+QuotedStr('1'));
    QProd.Open;
    // composição
    QComp.Close;
    QComp.Params.Clear;
    QComp.SQL.Clear;
    QComp.SQL.Add('select * from produto_composto');
    QComp.SQL.Add('where produto_composto.id = :pIDProd');
    while not QProd.Eof do
    begin
      aValorProd := 0;
      // captura valor do produto
      if QProd.FieldByName('tipoprod').AsInteger = 1 then
         aValorProd := Retorna_Valor_Custo_ProdComposto(QProd.FieldByName('ID').AsInteger)
      else if QProd.FieldByName('tipoprod').AsInteger = 0 then
         aValorProd := QProd.FieldByName('PRECO_COMPRA').AsCurrency;
      // grava valor
      GravaPrecoCustoVenda(QProd.FieldByName('ID').AsInteger,
                           sTipoCalcPerc,
                           aValorProd,
                           QProd.FieldByName('MARGEM_LUCRO').AsFloat);
      // seleciona composicao
      QComp.Close;
      QComp.Params.ParamByName('pIDProd').AsInteger := QProd.FieldByName('ID').AsInteger;
      QComp.Open;
      // atualiza preco da composicao
      while not QComp.Eof do
      begin
        // retorna preco de custo do produto
        aPrecoCusto := Retorna_PrecoCustoProd(QComp.FieldByname('ID_PRODUTO').AsInteger);
        aPrecoCusto := aPrecoCusto*QComp.FieldByname('QUANTIDADE').AsCurrency;
        // grava novo preco de custo da composicao
        Grava_CustoComposicao(QComp.FieldByname('ID').AsInteger,
                              QComp.FieldByname('ID_PRODUTO').AsInteger,
                              aPrecoCusto);
        QComp.Next;
      end;
      // proximo produto
      QProd.Next;
    end;
  finally
    QProd.Close;
    QComp.Close;
    QProd.Free;
    QComp.Free;
  end;

end;

procedure GravaPrecoCustoVenda(fIDProd,fTipoCalc:Integer;fValor,fMargem:Currency);
var Q : TSQLQuery;
    aIndice,aValorVenda:Double;
begin
  Q := TSQLQuery.Create(nil);
  if fTipoCalc = 0 then // mutiplicação
  begin
    aIndice     := Retorna_IndicePercentual('P',fMargem);
    aValorVenda := fValor*aIndice;
  end
  else if fTipoCalc = 1 then // divisão
  begin
    aIndice     := Retorna_IndicePercentual('N',fMargem);
    aValorVenda := fValor/aIndice;
  end;

  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('update produtos set');
    Q.SQL.Add('produtos.preco_Compra = :pValorC,');
    Q.SQL.Add('produtos.preco_Venda = :pValorV');
    Q.SQL.Add('where produtos.id = :pID');
    Q.Params.ParamByName('pID').AsInteger      := fIDProd;
    Q.Params.ParamByName('pValorC').AsCurrency := fValor;
    Q.Params.ParamByName('pValorV').AsCurrency := aValorVenda;
    Q.ExecSQL(false);
  finally
    Q.Free;
  end;
end;

function Retorna_PrecoCustoProd(fIDProd:Integer):Currency;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select produtos.preco_compra from produtos');
    Q.SQL.Add('where produtos.id = :pIDProduto');
    Q.Params.ParamByName('pIDProduto').AsInteger := fIDProd;
    Q.Open;
    Result := Q.FieldByName('preco_compra').AsCurrency;
  finally
    Q.Close;
    Q.Free;
  end;
end;

procedure Grava_CustoComposicao(fID,fIDProd:Integer;fValor:Currency);
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('update produto_composto set');
    Q.SQL.Add('produto_composto.valor = :pValor');
    Q.SQL.Add('where produto_composto.id = :pID');
    Q.SQL.Add('and produto_composto.id_produto = :pIDProd');
    Q.Params.ParamByName('pID').AsInteger     := fID;
    Q.Params.ParamByName('pIDProd').AsInteger := fIDProd;
    Q.Params.ParamByName('pValor').AsCurrency := fValor;
    Q.ExecSQL(false);
  finally
    Q.Free;
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

procedure LocalizaDadosCombo(fCombo:TComboBox;fDados:String);
begin
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

function RetornaPercComissaoItem(fIDProduto:Integer;fValorVenda:Currency):Double;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select * from tabela_comissao');
    Q.SQL.Add('where tabela_comissao.idproduto = :pIDProd');
    Q.Params.ParamByName('pIDProd').AsInteger := fIDProduto;
    Q.Open;
    while not Q.Eof do
    begin
      if fValorVenda <= Q.FieldByName('FAIXA_FIM').AsCurrency then
      begin
        Result := Q.FieldByName('COMISSAO').AsCurrency;
        Break;
      end;
      q.Next;
    end;
    if Result = 0 then
       Result := Q.FieldByName('COMISSAO').AsCurrency;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function VerificaNumPedido(fNumped: String): Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select pedido.pedido_num from pedido');
    Q.SQL.Add('where pedido.pedido_num = :pNumPed');
    Q.Params.ParamByName('pNumPed').AsString := fNumped;
    Q.Open;
    // resultato
    Result := false;
    if not Q.IsEmpty then
       Result := true;
  finally
    Q.Close;
    Q.Free;
  end;

end;

Function VerificaContasQuitadas(fIDPedido:Integer):Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select count(contas.idpedido) as Contas from contas');
    Q.SQL.Add('where contas.idpedido =:pIDPed');
    Q.SQL.Add('and (contas.data_quit is not null or contas.data_quit <> 0)');
    Q.SQL.Add('and (contas.status = 1 or contas.status = 2)');
    Q.Params.ParamByName('pIDPed').AsInteger := fIDPedido;
    Q.Open;
    // resultato
    Result := false;
    if Q.FieldByname('Contas').AsInteger > 0 then
       Result := true;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function VerificaEstoqueProduto(fIDProd:Integer;fQuant:Double):Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select produtos.estoque from produtos');
    Q.SQL.Add('where produtos.id = :pIDProd');
    Q.Params.ParamByName('pIDProd').AsInteger := fIDProd;
    Q.Open;
    // resultato
    Result := true;
    if Q.FieldByname('estoque').AsFloat < fQuant then
       Result := false;
  finally
    Q.Close;
    Q.Free;
  end;

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

function Retorna_Total_Contatos: Integer;
var Q : TSQLQuery;
    aux : Integer;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select * from contato');
    Q.Open;
    aux := 0;
    while not Q.Eof do
    begin
      Inc(aux);
      Q.Next;
    end;
    // resultato
    Result := aux;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function Retorna_Total_Produtos: Integer;
var Q : TSQLQuery;
    aux:Integer;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select * from produtos');
    Q.Open;
    aux := 0;
    while not Q.Eof do
    begin
      Inc(aux);
      Q.Next;
    end;
    // resultato
    Result := aux;
  finally
    Q.Close;
    Q.Free;
  end;

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

procedure CalculaTotaisCaixaMov(fDataCaixa: TDateTime);
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select caixa_mov.dc,sum(caixa_mov.valor) from caixa_mov');
    Q.SQL.Add('where caixa_mov.data_mov = :pData');
    Q.SQL.Add('group by caixa_mov.dc');
    Q.Params.ParamByName('pData').AsDate := fDataCaixa;
    Q.Open;
    sTotalDespesa := 0;
    sTotalReceita := 0;
    Q.First;
    while not Q.Eof do
    begin
      if Q.FieldByName('DC').AsString = 'D' then
         sTotalDespesa := sTotalDespesa + Q.FieldByName('SUM').AsCurrency
      else if Q.FieldByName('DC').AsString = 'C' then
         sTotalReceita := sTotalReceita + Q.FieldByName('SUM').AsCurrency;
      Q.Next;
    end;
  finally
    Q.Close;
    Q.Free;
  end;

end;

function VerificaMesFechado(fData:TDateTime):Boolean;
var Q : TSQLQuery;
    dia,mes,ano : Word;
begin
  DecodeDate(fData,ano,mes,dia);
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select * from fechamento_est');
    Q.SQL.Add('where fechamento_est.mes = '+QuotedStr(ZeroEsquerda(IntToStr(mes),2)));
    Q.SQL.Add('and fechamento_est.ano = '+QuotedStr(IntToStr(ano)));
    Q.SQL.Add('and fechamento_est.idempresa = '+QuotedStr(IntToStr(sIDEmpresa)));
    Q.Open;
    Result := false;
    if not Q.IsEmpty then
       Result := true;
    Q.Close;
  finally
    Q.Free;
  end;

end;


function RetornaEstoqueAnterior(fData:TDateTime;fIDProd:Integer):Double;
var Q : TSQLQuery;
    dia,mes,ano : Word;
begin
  DecodeDate(fData,ano,mes,dia);
  Dec(mes);
  if mes < 1 then
  begin
    mes := 12;
    dec(ano); 
  end;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.Params.Clear;
    Q.SQL.Clear;
    Q.SQL.Add('select * from fechamento_est');
    Q.SQL.Add('where fechamento_est.mes = '+QuotedStr(ZeroEsquerda(IntToStr(mes),2)));
    Q.SQL.Add('and fechamento_est.ano = '+QuotedStr(IntToStr(ano)));
    Q.SQL.Add('and fechamento_est.id_produto = '+QuotedStr(IntToStr(fIDProd)));
    Q.Open;
    Result := 0;
    if not Q.IsEmpty then
       Result := Q.FieldByname('Quantidade').AsFloat;
    Q.Close;
  finally
    Q.Free;
  end;

end;

procedure ExcluiItensComposicao(fIDPed,fIDIten: Integer);
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Clear;
    Q.SQL.Add('delete from pedido_composicao_item');
    Q.SQL.Add('where pedido_composicao_item.id_pedido = :pIDPed');
    Q.SQL.Add('and pedido_composicao_item.id_itempedido = :pIDIten');
    Q.Params.ParamByName('pIDPed').AsInteger  := fIDPed;
    Q.Params.ParamByName('pIDIten').AsInteger := fIDIten;
    Q.ExecSQL(False);
  finally
    Q.Free;
  end;

end;

// Retorna o dia da semana em Extenso de uma determinada data
function Retorna_DiaSemana(Data: TDateTime): String;
const Dias : Array[1..7] of String[07] = ('DOMINGO', 'SEGUNDA', 'TERCA','QUARTA','QUINTA', 'SEXTA','SABADO');
begin
  Result := Dias[DayOfWeek(Data)];

end;

function Retorna_ComissaoPedido(fIDPedido:Integer):Currency;
var QPedido,QItens,QVendedor : TSQLQuery;
    aPercComissao,aComissao : Double;
    aDiaSemana : String;
begin
  QPedido   := TSQLQuery.Create(nil);
  QItens    := TSQLQuery.Create(nil);
  QVendedor := TSQLQuery.Create(nil);
  QPedido.SQLConnection   := ConexaoDados;
  QItens.SQLConnection    := ConexaoDados;
  QVendedor.SQLConnection := ConexaoDados;
  try
    QPedido.Close;
    QPedido.SQL.Clear;
    QPedido.SQL.Add('select * from pedido');
    QPedido.SQL.Add('where pedido.id = :pID');
    QPedido.Params.ParamByName('pID').AsInteger := fIDPedido;
    QPedido.Open;
    if not QPedido.IsEmpty then
    begin
      // seleciona vendedor
      QVendedor.Close;
      QVendedor.SQL.Clear;
      QVendedor.SQL.Add('select * from funcionario');
      QVendedor.SQL.Add('where funcionario.id = :pIDFunc');
      QVendedor.Params.ParamByName('pIDFunc').AsInteger := QPedido.FieldByName('ID_VENDEDOR').AsInteger;
      QVendedor.Open;
      // calcula comissão de acordo com o tipo configurado
      aPercComissao := 0;
      if sTipoComissao = 0 then // do funcionario
      begin
        // calcula comissao
        aDiaSemana := Retorna_DiaSemana(QPedido.FieldByName('DATA_PEDIDO').AsDateTime);
        if trim(aDiaSemana) = 'DOMINGO' then
        begin
          if sComIntDom then
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat
          else
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat/2;
        end
        else if trim(aDiaSemana) = 'SEGUNDA' then
        begin
          if sComIntSeg then
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat
          else
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat/2;
        end
        else if trim(aDiaSemana) = 'TERCA' then
        begin
          if sComIntTer then
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat
          else
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat/2;
        end
        else if trim(aDiaSemana) = 'QUARTA' then
        begin
          if sComIntQua then
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat
          else
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat/2;
        end
        else if trim(aDiaSemana) = 'QUINTA' then
        begin
          if sComIntQui then
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat
          else
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat/2;
        end
        else if trim(aDiaSemana) = 'SEXTA' then
        begin
          if sComIntSex then
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat
          else
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat/2;
        end
        else if trim(aDiaSemana) = 'SABADO' then
        begin
          if sComIntSab then
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat
          else
            aPercComissao := QVendedor.FieldByName('PERC_COMISSAO').AsFloat/2;
        end;
        // comissao do pedido
        Result := (QPedido.FieldByName('VALOR_TOTAL').AsCurrency*aPercComissao)/100
      end
      else if sTipoComissao <> 0 then // do produto e por faixa
      begin
        QItens.Close;
        QItens.SQL.Clear;
        QItens.SQL.Add('select * from pedido_itens');
        QItens.SQL.Add('where pedido_itens.idpedido = :pIDPed');
        QItens.SQL.Add('and pedido_itens.cancelado = '+QuotedStr('N'));
        QItens.Params.ParamByName('pIDPed').AsInteger := fIDPedido;
        QItens.Open;
        aComissao := 0;
        while not QItens.Eof do
        begin
          if sTipoComissao = 1 then // do produto
             aPercComissao := Retorna_PercComissaoProduto(QItens.FieldByName('IDPRODUTO').AsInteger)
          else if sTipoComissao = 2 then // por faixa
             aPercComissao := RetornaPercComissaoItem(QItens.FieldByName('IDPRODUTO').AsInteger,QItens.FieldByName('VALOR').AsCurrency);
          aComissao     := aComissao + (QItens.FieldByName('VALOR_TOTAL').AsCurrency*aPercComissao)/100;
          QItens.next
        end;
        Result := aComissao;
      end;

    end;
  finally
    QPedido.Close;
    QPedido.Destroy;
  end;

end;

function Retorna_PercComissaoProduto(fIDProduto:Integer):Double;
var Q : TSqlQuery;
begin
  Result := 0;
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select produtos.perc_com from produtos');
    Q.SQL.Add('where produtos.id = :pID');
    Q.Params.ParamByName('pID').AsInteger := fIDProduto;
    Q.Open;
    Result := Q.FieldByName('perc_com').AsFloat;
    Q.Close;
  finally
    Q.Destroy
  end;
end;

procedure Grava_PrecoProduto(fIDProduto,fTipo:Integer;fValor:Currency);
var Q : TSqlQuery;
begin
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('update produtos set');
    if fTipo = 0 then // preco de compra
       Q.SQL.Add('produtos.preco_compra = :pValor')
    else if fTipo = 1 then // preco de venda
       Q.SQL.Add('produtos.preco_venda = :pValor');
    Q.SQL.Add('where produtos.id = :pID');
    Q.Params.ParamByName('pID').AsInteger     := fIDProduto;
    Q.Params.ParamByName('pValor').AsCurrency := fValor;
    Q.ExecSQL(false);
  finally
    Q.Destroy
  end;
end;

function Grava_EstoqueProduto(fIDProduto:Integer;fEstoque:Double):Boolean;
var Q : TSqlQuery;
begin
  Result := true;
  try
    Q:= TSQLQuery.Create(nil);
    try
      Q.SQLConnection := ConexaoDados;
      Q.Close;
      Q.SQL.Clear;
      Q.SQL.Add('update estoque set');
      Q.SQL.Add('estoque.quantidade = :pEstoque');
      Q.SQL.Add('where estoque.idproduto = :pIDprod');
      Q.SQL.Add('and estoque.idempresa = :pIDempresa');
      Q.Params.ParamByName('pIDProd').AsInteger    := fIDProduto;
      Q.Params.ParamByName('pIDempresa').AsInteger := sIDEmpresa;
      Q.Params.ParamByName('pEstoque').AsFloat     := fEstoque;
      Q.ExecSQL(false);
    finally
      Q.Destroy
    end;
  except
    Result := false;
  end;
end;

function Retorna_DescricaoProduto(fIDProduto:Integer):String;
var Q : TSqlQuery;
begin
  Result := '';
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select produtos.descricao from produtos');
    Q.SQL.Add('where produtos.id = :pID');
    Q.Params.ParamByName('pID').AsInteger    := fIDProduto;
    Q.Open;
    Result := Q.FieldByName('DESCRICAO').AsString;
    Q.Close
  finally
    Q.Destroy
  end;
end;



function GenID(pTabela: String): Integer;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Add('SELECT GEN_ID('+pTabela+'_ID,1) FROM RDB$DATABASE');
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

function RetornaHorasTrabalhada(pID:Integer):TDateTime;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Clear;
    Q.SQL.Add('select os_horas.tempo_gasto from os_horas');
    Q.SQL.Add('where os_horas.id_os = :pID');
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Open;
    if not Q.IsEmpty then
    begin
      Q.First;
      while not Q.Eof do
      begin
        Result := Result + Q.FieldByName('tempo_gasto').AsDateTime;
        Q.Next;
      end;
    end;
  finally
    Q.Free;
  end;
end;

function RetornaServicoRealizado(pID:Integer):String;
var Q : TSQLQuery;
begin
  Result := '';
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Clear;
    Q.SQL.Add('select os_horas.realizado from os_horas');
    Q.SQL.Add('where os_horas.id_os = :pID');
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Open;
    if not Q.IsEmpty then
    begin
      Q.First;
      while not Q.Eof do
      begin
        Result := Result + Q.FieldByName('realizado').AsString;
        Q.Next;
      end;
    end;
  finally
    Q.Free;
  end;
end;

function RetornaCompromissosDias(pDias:Integer):Integer;
var Q : TSQLQuery;
    aDatai, aDataf : TDateTime;
begin
  Q := TSQLQuery.Create(nil);
  try
    aDatai := SVData;
    aDataf := aDatai+pDias;
    //
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Clear;
    Q.SQL.Add('select count(agenda.id) as total from agenda');
    Q.SQL.Add('where agenda.data between :pDatai and :pDataf');
    Q.SQL.Add('and agenda.concluido = '+QuotedStr('N'));
    Q.Params.ParamByName('pDatai').AsDate := aDatai;
    Q.Params.ParamByName('pDataf').AsDate := aDataf;
    Q.Open;
    Result := Q.FieldByName('total').AsInteger;
    Q.Close;
  finally
    Q.Free;
  end;
end;

procedure GravaDadosCompraFornecedor(pValor:Double;pData:TDateTime;pIDProd,pIDFor:Integer);
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Clear;
    Q.SQL.Add('update produto_fornecedor set');
    Q.SQL.Add('produto_fornecedor.valor_compra = :pValor,');
    Q.SQL.Add('produto_fornecedor.data_ultcompra = :pData');
    Q.SQL.Add('where produto_fornecedor.idproduto = :pIDProd');
    Q.SQL.Add('and produto_fornecedor.idfornecedor = :pIDFor');
    Q.Params.ParamByName('pValor').AsFloat    := pValor;
    Q.Params.ParamByName('pData').AsDate      := pData;
    Q.Params.ParamByName('pIDProd').AsInteger := pIDProd;
    Q.Params.ParamByName('pIDFor').AsInteger  := pIDFor;
    Q.ExecSQL(false);
  finally
    Q.Free;
  end;

end;

function GeraEstoqueProduto(pIDProd,pIDEmpresa:Integer):Boolean;
var Q,E,V : TSQLQuery;
begin
  Result := true;
  // seleciona os produts
  Q := TSQLQuery.Create(nil);
  Q.SQLConnection := ConexaoDados;
  Q.Close;
  Q.SQL.Clear;
  Q.SQL.Add('select produtos.id,produtos.estoque from produtos');
  if pIDProd > 0 then
  begin
     Q.SQL.Add('where produtos.id = :pIDProd');
     Q.Params.ParamByName('pIDProd').AsInteger := pIDProd;
  end;
  Q.Open;
  //
  V := TSQLQuery.Create(nil);
  V.SQLConnection := ConexaoDados;
  V.Close;
  V.SQL.Clear;
  V.SQL.Add('select * from estoque');
  V.SQL.Add('where estoque.idproduto = :pIDProd');
  V.SQL.Add('and estoque.idempresa = :pIDEmpresa');
  //
  if not Q.IsEmpty then
  begin
    E := TSQLQuery.Create(nil);
    E.SQLConnection := ConexaoDados;
    E.Close;
    E.SQL.Clear;
    E.SQL.Add('insert into estoque(id,idempresa,idproduto,quantidade)');
    E.SQL.Add('values(gen_id(estoque_id,1),:pIDEmpresa,:pidProd,:pQuant)');
    while not Q.Eof do
    begin
      V.Params.ParamByName('pIDEmpresa').AsInteger := pIDEmpresa;
      V.Params.ParamByName('pIDProd').AsInteger    := Q.FieldByName('id').AsInteger;
      V.Open;
      if V.IsEmpty then
      begin
        E.Params.ParamByName('pIDEmpresa').AsInteger := pIDEmpresa;
        E.Params.ParamByName('pIDProd').AsInteger    := Q.FieldByName('id').AsInteger;
        E.Params.ParamByName('pQuant').AsFloat       := Q.FieldByName('estoque').AsInteger;
        E.ExecSQL(false);
      end;
      V.Close;
      Q.Next;
    end;
    E.Free;
  end;
  V.Free;
  Q.Close;
  Q.Free;

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

function RetotornaTotalPagamentoCupom(pID:Integer):Double;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select sum(f.valor) as valor from pedido_formapag f');
    Q.SQL.Add('where f.idpedido = :pIDPedido');
    Q.Params.ParamByName('pIDPedido').AsInteger := pID;
    Q.Open;
    Result := Q.FieldByName('valor').AsFloat;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;  

end;

function RetornaMD5Registro(DataSet:TDataSet):String;
var i : Integer;
    AuxSTR, NomeCampo, TipoCampo : String;
begin
  // efetua um loop nos registros da tabela somando uma variávei string
  // para gerar o MF5
  AuxSTR := '';
  for i:=0 to DataSet.Fields.Count - 1 do
  begin
    NomeCampo := UpperCase(DataSet.Fields.Fields[i].FieldName);
    TipoCampo := FieldTypeNames[DataSet.Fields.Fields[i].DataType];
//    if (NomeCampo <> 'MD5REGISTRO') and (NomeCampo <> 'REDUCAO_BASE') then
    if (NomeCampo <> 'MD5REGISTRO') then
    begin
      if (TipoCampo = 'String') or (TipoCampo = 'ftMemo') then
         AuxSTR := AuxSTR + DataSet.FieldByName(NomeCampo).AsString;
      if TipoCampo = 'Integer' then
         AuxSTR := AuxSTR + IntToStr(DataSet.FieldByName(NomeCampo).AsInteger);
      if (TipoCampo = 'Float') or (TipoCampo = 'Currency') then
         AuxSTR := AuxSTR + FloatToStr(DataSet.FieldByName(NomeCampo).AsFloat);
      if TipoCampo = 'Date' then
         AuxSTR := AuxSTR + DateTimeToStr(DataSet.FieldByName(NomeCampo).AsDateTime);
      if TipoCampo = 'Time' then
         AuxSTR := AuxSTR + DateTimeToStr(DataSet.FieldByName(NomeCampo).AsDateTime);
      if TipoCampo = 'DateTime' then
         AuxSTR := AuxSTR + DateTimeToStr(DataSet.FieldByName(NomeCampo).AsDateTime);
      if TipoCampo = 'SQLDate' then
         AuxSTR := AuxSTR + DateTimeToStr(DataSet.FieldByName(NomeCampo).AsDateTime);
      if TipoCampo = 'SQLTime' then
         AuxSTR := AuxSTR + DateTimeToStr(DataSet.FieldByName(NomeCampo).AsDateTime);
      if TipoCampo = 'SQLDateTime' then
         AuxSTR := AuxSTR + DateTimeToStr(DataSet.FieldByName(NomeCampo).AsDateTime);
      if TipoCampo = 'SQLTimeStamp' then
         AuxSTR := AuxSTR + DateTimeToStr(DataSet.FieldByName(NomeCampo).AsDateTime);
    end;
  end;
  // retorna o resultado
  Result :=  MD5Print(MD5String(AuxSTR));

end;

function Confirmacao(texto: string): boolean;
begin
  Result := Application.MessageBox(PChar(texto),'Confirmação',MB_ICONQUESTION + MB_YESNO) = ID_YES;

end;

function RetornaNumCartoesFechamento(pID:Integer):Integer;
var Q : TSQLQuery;
begin
  Result := 0;
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.SQL.Clear;
    Q.SQL.Add('select count(p.id) from pedido_formapag p');
    Q.SQL.Add('where p.idpedido = :pID');
    Q.SQL.Add('and p.tipo_documento = 2');
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Open;
    Result := Q.FieldByName('Count').AsInteger;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

function VerificaSaldoProdutoPosto(pNumBico:String):Double;
var Q : TSqlQuery;
begin
  Result := 0;
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select estoque.quantidade from');
    Q.SQL.Add('estoque,tanques_abastec,bicos_abastec');
    Q.SQL.Add('where estoque.idproduto = tanques_abastec.id_produto');
    Q.SQL.Add('and tanques_abastec.id = bicos_abastec.id_tanque');
    Q.SQL.Add('and bicos_abastec.bico_concentrador = :pNumBico');
    Q.Params.ParamByName('pNumBico').AsString := pNumBico;
    Q.Open;
    Result := Q.FieldByName('quantidade').AsFloat;
    Q.Close
  finally
    Q.Destroy
  end;
end;

function RetornaTotalMesa(pID:Integer):Double;
var Q : TSqlQuery;
begin
  Result := 0;
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select sum(i.preco_total) from mesas_itens i');
    Q.SQL.Add('where i.id_mesa = :pIDMesa');
    Q.SQL.Add('and i.cancelado = '+QuotedStr('N'));
    Q.Params.ParamByName('pIDMesa').AsInteger := pID;
    Q.Open;
    Result := Q.FieldByName('Sum').AsFloat;
    Q.Close;
  finally
    Q.Destroy;
  end;

end;

function VerificaMesaAberta(var IDMesa:Integer;pIDMesa:Integer):Boolean;
var Q : TSqlQuery;
begin
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select * from mesas_abertas');
    Q.SQL.Add('where mesas_abertas.status = 0');
    Q.SQL.Add('and mesas_abertas.id_mesa = :pIDMesa');
    Q.Params.ParamByName('pIDMesa').AsInteger := pIDMesa;
    Q.Open;
    IDMesa := 0;
    Result := false;
    if not Q.IsEmpty then
    begin
      Result := true;
      IDMesa := Q.FieldByName('ID').AsInteger;
    end;
    Q.Close;
  finally
    Q.Destroy;
  end;

end;

procedure RetornaInformacaoAbastecimeneto(var Tanque,Bomba,Bico:string;
  var EI,EF:Double;pID:Integer);
var Q : TSqlQuery;
begin
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select  t.tanque_numero,bo.bomba_numero,');
    Q.SQL.Add('bi.bico_concentrador,i.ei, i.ef');
    Q.SQL.Add('from pedido_itens i, tanques_abastec t,');
    Q.SQL.Add('bombas_abastec bo, bicos_abastec bi');
    Q.SQL.Add('where t.id = i.id_tanque');
    Q.SQL.Add('and bo.id = i.id_bomba');
    Q.SQL.Add('and bi.id = i.id_bico');
    Q.SQL.Add('and i.idpedido = :pID');
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Open;
    if not Q.IsEmpty then
    begin
      Tanque := Q.FieldByName('tanque_numero').AsString;
      Bomba  := Q.FieldByName('bomba_numero').AsString;
      Bico   := Q.FieldByName('bico_concentrador').AsString;
      EI     := Q.FieldByName('ei').AsFloat;
      EF     := Q.FieldByName('ef').AsFloat;
    end;
    Q.Close;
  finally
    Q.Destroy;
  end;

end;

function RetornaNumeroMesa(pIDMesa:Integer):String;
var Q : TSQLQuery;
begin
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select m.numero_mesa from mesas_abertas m');
    Q.SQL.Add('where m.id = :pID');
    Q.Params.ParamByName('pID').AsInteger := pIDMesa;
    Q.Open;
    if not Q.IsEmpty then
    begin
      Result := Q.FieldByName('numero_mesa').AsString;
    end;
    Q.Close;
  finally
    Q.Destroy;
  end;

end;

procedure AlteraStatusAbastecimento(pID, pStatus:Integer);
var Q : TSQLQuery;
begin
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('update pedido set');
    Q.SQL.Add('pedido.STATUS_ABASTEC = :pStatus');
    Q.SQL.Add('where pedido.id = :pID');
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Params.ParamByName('pStatus').AsInteger := pStatus;
    Q.ExecSQL;
  finally
    Q.Destroy;
  end;

end;

procedure AlteraStatusMesa(pID, pStatus:Integer);
var Q : TSQLQuery;
begin
  Q:= TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('update mesas_abertas set');
    Q.SQL.Add('mesas_abertas.STATUS = :pStatus');
    Q.SQL.Add('where mesas_abertas.id = :pID');
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Params.ParamByName('pStatus').AsInteger := pStatus;
    Q.ExecSQL;
  finally
    Q.Destroy;
  end;

end;

function RetornaTotalAbastecimento(pIDProduto,pBico,pStatus:Integer;
  pData:TDateTime):Double;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Add('select coalesce(sum(i.quantidade),0) as quant');
    Q.SQL.Add('from pedido p, pedido_itens i');
    Q.SQL.Add('where p.id = i.idpedido');
    Q.SQL.Add('and p.data_pedido = :pData');
    Q.SQL.Add('and i.id_bico = :pBico');
    Q.SQL.Add('and i.idproduto = :pIdProd');
    Q.SQL.Add('and p.status_abastec = :pStatus');
    Q.Params.ParamByName('pData').AsDate      := pData;
    Q.Params.ParamByName('pBico').AsInteger   := pBico;
    Q.Params.ParamByName('pIDProd').AsInteger := pIDProduto;
    Q.Params.ParamByName('pStatus').AsInteger := pStatus;
    Q.Open;
    Result := Q.FieldByName('quant').AsFloat;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

function RetornaTotalVespebBico(pData:TDateTime;pBico:Integer):Double;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Add('select coalesce(sum(p.vespeb),0) as quant');
    Q.SQL.Add('from placas_abastec p');
    Q.SQL.Add('where p.data = :pData');
    Q.SQL.Add('and p.id_bico = :pBico');
    Q.Params.ParamByName('pData').AsDate    := pData;
    Q.Params.ParamByName('pBico').AsInteger := pBico;
    Q.Open;
    Result := Q.FieldByName('quant').AsFloat;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

procedure LocalizaRemoveAssinaturaEAD(pNomeArquivo:String);
var cLinhaArquivo, aConteudo: string;
    cArquivo  : TextFile;
begin
  if FileExists(pNomeArquivo) then
  begin
    aConteudo := '';
    AssignFile(cArquivo,pNomeArquivo);
    Reset(cArquivo);
    while not System.EOF(cArquivo) do
    begin
      ReadLn(cArquivo,cLinhaArquivo);
      if Copy(cLinhaArquivo,1,3) <> 'EAD' then
      begin
        aConteudo := aConteudo + cLinhaArquivo+#13+#10;
      end;
    end;
    CloseFile(cArquivo);
    Sleep(2000);
    // grava novo arquivo sem a assinatura EAD
    if aConteudo <> '' then
    begin
      if DeleteFile(pNomeArquivo) then
      begin
        AssignFile(cArquivo,pNomeArquivo);
        ReWrite(cArquivo);
        WriteLn(cArquivo,aConteudo);
        CloseFile(cArquivo);
      end;
    end;
  end;

end;

function RetornaUltimoCupomEmitido(Caixa:String):Integer;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Add('select max(pedido.coo) as coo from pedido');
    Q.SQL.Add('where pedido.idempresa = :pEmpresa');
    Q.SQL.Add('and pedido.caixa = :pCaixa');
    Q.Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Q.Params.ParamByName('pCaixa').AsString    := Caixa;
    Q.Open;
    Result := Q.FieldByName('coo').AsInteger;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

function UFToInt(pUF: String): Integer;
begin
  Result := 0;
  if pUF = 'RO' then Result := 11;
  if pUF = 'AC' then Result := 12;
  if pUF = 'AM' then Result := 13;
  if pUF = 'RR' then Result := 14;
  if pUF = 'PA' then Result := 15;
  if pUF = 'AP' then Result := 16;
  if pUF = 'TO' then Result := 17;
  if pUF = 'MA' then Result := 21;
  if pUF = 'PI' then Result := 22;
  if pUF = 'CE' then Result := 23;
  if pUF = 'RN' then Result := 24;
  if pUF = 'PB' then Result := 25;
  if pUF = 'PE' then Result := 26;
  if pUF = 'AL' then Result := 27;
  if pUF = 'SE' then Result := 28;
  if pUF = 'BA' then Result := 29;
  if pUF = 'MG' then Result := 31;
  if pUF = 'ES' then Result := 32;
  if pUF = 'RJ' then Result := 33;
  if pUF = 'SP' then Result := 35;
  if pUF = 'PR' then Result := 41;
  if pUF = 'SC' then Result := 42;
  if pUF = 'RS' then Result := 43;
  if pUF = 'MS' then Result := 50;
  if pUF = 'MT' then Result := 51;
  if pUF = 'GO' then Result := 52;
  if pUF = 'DF' then Result := 53;

end;

function RetornarIDFornecedor(pCNPJ:String):Integer;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select contato.id from contato');
    Q.SQL.Add('where contato.cnpj_cpf = :pCNPJ');
    Q.Params.ParamByName('pCNPJ').AsString := pCNPJ;
    Q.Open;
    Result := Q.FieldByName('ID').AsInteger;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

end.

