unit uRotinas_EFD;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ActnList, Buttons, StdCtrls, CheckLst,
  ACBrSpedFiscal, ACBrEFDBlocos, ACBrUtil, ACBrTXTClass, SqlExpr, DB,
  DBClient, ACBrSpedPisCofins, uDmAcBr, uLibrary;

type
  TSPED_EFD = class(TObject)
  protected
    { Protected declarations }
  private
    { Private declarations }
    procedure InsereItemInventario(var CdsInventario:TClientDataSet; pCod: Integer; pUnid: String; pQuant, pValor: Double);
    function VerificaIPIProdutosNota(pID, pES: Integer): Boolean;
    procedure InsereRegistroUFST(var CdsUFST:TClientDataSet; pUF: String; pCredito,pDebito:Double);
    function VerificaNotaDevolucao(fCodigo: Integer): Boolean;
    function VerificaSTProdutosNota(pID, pES: Integer): Boolean;
    function RetornaTotalInventario(CdsInventario:TClientDataSet): Double;
    function RetornaUFCliFor(pCodigo, pTipo: Integer): String;
    function RetornaSaldoInventario(pCDProduto, pEmpresa: Integer; pDataBase:TDateTime;pQuantAtual:Double):Double;
    function VerificaItemCupom(ID:Integer):Boolean;
    function RetornaNumeroTanque(pIDProduto:Integer):String;
  public
    { Public declarations }
    sNotasEntrada : Boolean;
    sDebitos, sCreditos : Double;
    sDebitosST, sCreditosST : Double;
    sControleBlocoG : Boolean;
    sLbMensagem,sLBBlocos : TLabel;
    sProgressBar1,sProgressBar2 : TProgressBar;
    sCNPJEmpresa, sUFEmpresa : String;
    procedure DadosBloco_0(var CdsInventario,
                           CdsUFST,
                           CdsEmpresa,
                           CdsContabil:TClientDataSet;
                           Datai,Dataf:TDateTime;
                           CodEmp:String;
                           ListaBlocosG,
                           ListaBlocosH:Boolean;
                           pCOD_VER,
                           pPERFIL,
                           pINDICADOR,
                           pCOD_FIN:Integer;
                           pTipoProdBensConsumo:Boolean;
                           pDataInventario:TDateTime);
    procedure DadosBloco_C(var CdsUFST:TClientDataSet;
                           Notas,BufNotas,CodEmp:String;
                           Datai,Dataf:TDateTime;
                           VerificaSTIPI,CalcularIndiceDespesasAcessorias:Boolean;
                           pPerfil:Integer);
    procedure DadosBloco_D;
    procedure DadosBloco_E(CdsUFST:TClientDataSet; Datai,Dataf:TDateTime;
                           CodRec,CodEmp:String;
                           pTruncado:Boolean;
                           pINDICADOR:Integer);
    procedure DadosBloco_G(Datai,Dataf:TDateTime;CodEmp:String);
    procedure DadosBloco_H(var CdsInventario:TClientDataSet; Processar:Boolean; Datai,Dataf:TDateTime);
    procedure DadosBloco_1(pDatai, pDataf: TDateTime);
    procedure DadosBloco_9;

    constructor CrieInstancia;
    destructor DestruaInstancia;
  end;



implementation

uses ACBrEFDBloco_H, ACBrEFDBloco_C, ACBrEFDBloco_1, ACBrEFDBloco_1_Class,
  ACBrEFDBloco_C_Class;

procedure TSPED_EFD.DadosBloco_0(var CdsInventario,CdsUFST,CdsEmpresa,CdsContabil:TClientDataSet;
  Datai,Dataf:TDateTime;CodEmp:String;ListaBlocosG,ListaBlocosH:Boolean;pCOD_VER,pPERFIL,
  pINDICADOR,pCOD_FIN:Integer;pTipoProdBensConsumo:Boolean;pDataInventario:TDateTime);
var aCodVersao : TACBrVersaoLeiaute;
    aPerfil : TACBrPerfil;
    aIndicador : TACBrAtividade;
    aCodFin : TACBrCodFinalidade;
    aControle : Boolean;
    Query : TSQLQuery;
    aSaldoEstoque : Double;
    aNumReg, aRegAtual : Integer;
begin
   CdsInventario.EmptyDataSet;
   CdsUFST.EmptyDataSet;
   Query := TSqlQuery.Create(nil);
   Query.SQLConnection := ConexaoDados;
   // captura versão
   case pCOD_VER of
      0 : aCodVersao := vlVersao100;
      1 : aCodVersao := vlVersao101;
      2 : aCodVersao := vlVersao102;
      3 : aCodVersao := vlVersao103;
      4 : aCodVersao := vlVersao104;
      5 : aCodVersao := vlVersao105;
      6 : aCodVersao := vlVersao106;
      7 : aCodVersao := vlVersao107;
      8 : aCodVersao := vlVersao108;
      9 : aCodVersao := vlVersao109;
     10 : aCodVersao := vlVersao110;
   end;
   // captura perfil apresentação
   case pPERFIL of
     0 : aPerfil := pfPerfilA;
     1 : aPerfil := pfPerfilB;
     2 : aPerfil := pfPerfilC;
   end;
   // captura indicador de movimento
   case pINDICADOR of
     0 : aIndicador := atIndustrial;
     1 : aIndicador := atOutros;
   end;
   // captura codigo da finalidade
   case pCOD_FIN of
     0 : aCodFin := raOriginal;
     1 : aCodFin := raSubstituto;
   end;
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 0.
   with DmAcBr.ACBrSpedFiscal1.Bloco_0 do
   begin
      // Dados da Empresa
      with Registro0000New do
      begin
         COD_VER    := aCodVersao;
         COD_FIN    := aCodFin;
         NOME       := CdsEmpresa.FieldByName('RAZAO_SOCIAL').AsString;
         CNPJ       := CdsEmpresa.FieldByName('CNPJ_CPF').AsString;
         CPF        := '';
         UF         := CdsEmpresa.FieldByName('UF').AsString;
         IE         := FiltraNumero(CdsEmpresa.FieldByName('INSCRICAO_RG').AsString);
         if CdsEmpresa.FieldByName('COD_MUNICIPIO').AsString <> '' then
            COD_MUN    := StrToInt(CdsEmpresa.FieldByName('COD_MUNICIPIO').AsString)
         else
            COD_MUN    := 0;
         IM         := CdsEmpresa.FieldByName('INSC_MUNIC').AsString;
         SUFRAMA    := CdsEmpresa.FieldByName('COD_SUFRAMA').AsString;
         IND_PERFIL := aPerfil;
         IND_ATIV   := aIndicador;
      end;
      with Registro0001New do
      begin
         IND_MOV := imComDados;
         // Dados complementares da Empresa
         with Registro0005New do
         begin
            FANTASIA   := Trim(CdsEmpresa.FieldByName('FANTASIA').AsString);
            CEP        := Trim(FiltraNumero(CdsEmpresa.FieldByName('CEP').AsString));
            ENDERECO   := Trim(CdsEmpresa.FieldByName('ENDERECO').AsString);
            NUM        := Trim(CdsEmpresa.FieldByName('NUMERO').AsString);
            COMPL      := Trim(CdsEmpresa.FieldByName('COMPLEMENTO').AsString);
            BAIRRO     := Trim(CdsEmpresa.FieldByName('BAIRRO').AsString);
            FONE       := Trim(FiltraNumero(CdsEmpresa.FieldByName('TELEFONE').AsString));
            FAX        := Trim(FiltraNumero(CdsEmpresa.FieldByName('TELEFAX').AsString));
            EMAIL      := Trim(CdsEmpresa.FieldByName('EMAIL').AsString);
         end;
         // Dados do contador.
         with Registro0100New do
         begin
            NOME       := Trim(CdsContabil.FieldByName('CONTABILIDADE').AsString);
            CPF        := Trim(CdsContabil.FieldByName('CPF_CONTADOR').AsString); // Deve ser uma informação valida
            CRC        := Trim(CdsContabil.FieldByName('CRC_CONTADOR').AsString);
            CNPJ       := Trim(CdsContabil.FieldByName('CNPJ').AsString);
            CEP        := Trim(FiltraNumero(CdsContabil.FieldByName('CEP').AsString));
            ENDERECO   := Trim(CdsContabil.FieldByName('ENDERECO').AsString);
            NUM        := Trim(CdsContabil.FieldByName('END_NUM').AsString);
            COMPL      := Trim(CdsContabil.FieldByName('END_COMPL').AsString);
            BAIRRO     := Trim(CdsContabil.FieldByName('BAIRRO').AsString);
            FONE       := Trim(FiltraNumero(CdsContabil.FieldByName('FONE').AsString));
            FAX        := Trim(FiltraNumero(CdsContabil.FieldByName('FAX').AsString));
            EMAIL      := Trim(CdsContabil.FieldByName('EMAIL').AsString);
            if CdsContabil.FieldByName('COD_MUNICIPIO').AsString <> '' then
               COD_MUN    := StrToInt(CdsContabil.FieldByName('COD_MUNICIPIO').AsString)
            else
               COD_MUN    := 0;
         end;
         // Registro 0150
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select contato.id ,contato.nome,contato.cnpj_cpf,contato.insc_rg,');
         Query.SQL.Add('contato.codcidade,contato.endereco,contato.num_end,');
         Query.SQL.Add('contato.bairro_end,contato.uf_end,pedido.status_nfe,');
         Query.SQL.Add('pedido.chave_nfe from pedido');
         Query.SQL.Add('left outer join contato on contato.id = pedido.idcliente');
         Query.SQL.Add('where pedido.data_entrega between :pDatai and :pDataf');
         Query.SQL.Add('and pedido.status_nfe = '+QuotedStr('100'));
         Query.SQL.Add('and pedido.cancelado = '+QuotedStr('N'));
         Query.SQL.Add('and pedido.idempresa = :pEmpresa');
         Query.SQL.Add('and pedido.numero_doc is not null');
         Query.SQL.Add('group by contato.id ,contato.nome,contato.cnpj_cpf,contato.insc_rg,');
         Query.SQL.Add('contato.codcidade,contato.endereco,contato.num_end,');
         Query.SQL.Add('contato.bairro_end,contato.uf_end,pedido.status_nfe,pedido.chave_nfe');
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
           if Copy(Query.FieldByName('chave_nfe').AsString,21,2) <> '65' then
           begin
             if not Registro0150.LocalizaRegistro('C'+IntToStrZero(Query.FieldByName('ID').AsInteger,5)) then
             begin
               // Clientes
               with Registro0150New do
               begin
                  COD_PART := 'C'+IntToStrZero(Query.FieldByName('ID').AsInteger,5);
                  NOME     := Trim(Query.FieldByName('nome').AsString);
                  COD_PAIS := '01058';
                  if Length(FiltraNumero(Query.FieldByName('cnpj_cpf').AsString)) <= 11 then
                  begin
                    CNPJ   := '';
                    CPF    := FiltraNumero(Query.FieldByName('cnpj_cpf').AsString);
                  end
                  else
                  begin
                    CNPJ   := FiltraNumero(Query.FieldByName('cnpj_cpf').AsString);
                    CPF    := '';
                  end;
                  if Trim(Query.FieldByName('insc_rg').AsString) <> 'ISENTO' then
                     IE       := Trim(Query.FieldByName('insc_rg').AsString)
                  else
                     IE       := '';
                  if Query.FieldByName('codcidade').AsString <> '' then
                     COD_MUN  := StrToInt(Query.FieldByName('codcidade').AsString)
                  else
                     COD_MUN  := 0;
                  SUFRAMA  := '';
                  ENDERECO := Copy(Trim(Query.FieldByName('endereco').AsString),1,60);
                  NUM      := Trim(Query.FieldByName('num_end').AsString);
                  COMPL    := '';
                  BAIRRO   := Trim(Query.FieldByName('bairro_end').AsString);
               end;
             end;
           end;  
           Query.Next;
         end;
         // fornecedores
         if sNotasEntrada then
         begin
           Query.Close;
           Query.SQL.Clear;
           Query.SQL.Add('select contato.id ,contato.nome,contato.cnpj_cpf,contato.insc_rg,');
           Query.SQL.Add('contato.codcidade,contato.endereco,contato.num_end,');
           Query.SQL.Add('contato.bairro_end,contato.uf_end,compras.status_nfe from compras');
           Query.SQL.Add('left outer join contato on contato.id = compras.idfornecedor');
           Query.SQL.Add('where compras.data_compra between :pDatai and :pDataf');
           Query.SQL.Add('and (compras.status_nfe = '+QuotedStr('100')+' or compras.status_nfe is null)');
           Query.SQL.Add('and compras.cancelado = '+QuotedStr('N'));
           Query.SQL.Add('and compras.idempresa = :pEmpresa');
           Query.SQL.Add('and compras.nota is not null');
           Query.SQL.Add('group by contato.id ,contato.nome,contato.cnpj_cpf,contato.insc_rg,');
           Query.SQL.Add('contato.codcidade,contato.endereco,contato.num_end,');
           Query.SQL.Add('contato.bairro_end,contato.uf_end,compras.status_nfe');
           Query.Params.ParamByName('pDatai').AsDate      := Datai;
           Query.Params.ParamByName('pDataf').AsDate      := Dataf;
           Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
           Query.Open;
           while not Query.Eof do
           begin
             if not Registro0150.LocalizaRegistro('F'+IntToStrZero(Query.FieldByName('id').AsInteger,5)) then
             begin
               with Registro0150New do
               begin
                  COD_PART := 'F'+IntToStrZero(Query.FieldByName('id').AsInteger,5);
                  NOME     := Trim(Query.FieldByName('nome').AsString);
                  COD_PAIS := '01058';
                  if Length(FiltraNumero(Query.FieldByName('cnpj_cpf').AsString)) <= 11 then
                  begin
                    CNPJ   := '';
                    CPF    := FiltraNumero(Query.FieldByName('cnpj_cpf').AsString);
                  end
                  else
                  begin
                    CNPJ   := FiltraNumero(Query.FieldByName('cnpj_cpf').AsString);
                    CPF    := '';
                  end;
                  if Trim(Query.FieldByName('insc_rg').AsString) <> 'ISENTO' then
                     IE       := Trim(Query.FieldByName('insc_rg').AsString)
                  else
                     IE       := '';
                  if Query.FieldByName('codcidade').AsString <> '' then
                     COD_MUN  := StrToInt(Query.FieldByName('codcidade').AsString)
                  else
                     COD_MUN  := 0;
                  SUFRAMA  := '';
                  ENDERECO := Trim(Query.FieldByName('endereco').AsString);
                  NUM      := Trim(Query.FieldByName('num_end').AsString);
                  COMPL    := '';
                  BAIRRO   := Trim(Query.FieldByName('bairro_end').AsString);
               end;
             end;
             Query.Next;
           end;
         end;
         // Unidades de Medida entrada
         if sNotasEntrada then
         begin
           Query.Close;
           Query.SQL.Clear;
           Query.SQL.Add('select p.unidade,c.status_nfe from compras c');
           Query.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
           Query.SQL.Add('left outer join produtos p on p.id = i.idproduto');
           Query.SQL.Add('where c.data_compra between :pDatai and :pDataf');
           Query.SQL.Add('and c.cancelado = '+QuotedStr('N'));
           Query.SQL.Add('and c.nota is not null');
           Query.SQL.Add('and c.idempresa = :pEmpresa');
           Query.SQL.Add('and p.unidade <> '+QuotedStr(''));
           Query.Params.ParamByName('pDatai').AsDate      := Datai;
           Query.Params.ParamByName('pDataf').AsDate      := Dataf;
           Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
           Query.Open;
           while not Query.Eof do
           begin
             if (Query.FieldByName('STATUS_NFE').AsString = '100') or
                (Query.FieldByName('STATUS_NFE').AsString = '') then
             begin
               if not Registro0190.LocalizaRegistro(Trim(Query.FieldByName('UNIDADE').AsString)) then
               begin
                  with Registro0190New do
                  begin
                     UNID  := Trim(Query.FieldByName('UNIDADE').AsString);
                     DESCR := 'Descricao ' + Trim(Query.FieldByName('UNIDADE').AsString);
                  end;
               end;
             end;
             Query.Next;
           end;
         end;
         // Unidades de Medida saida
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select pr.unidade,p.status_nfe,p.chave_nfe from pedido p');
         Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
         Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
         Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
         Query.SQL.Add('and p.cancelado = '+QuotedStr('N'));
         Query.SQL.Add('and p.numero_doc is not null');
         Query.SQL.Add('and p.idempresa = :pEmpresa');
         Query.SQL.Add('and pr.unidade <> '+QuotedStr(''));
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
           if Copy(Query.FieldByName('chave_nfe').AsString,21,2) <> '65' then
           begin
             if Query.FieldByName('STATUS_NFE').AsString = '100' then
             begin
               if Query.FieldByName('chave_nfe').AsString = '' then
               begin
                 if not Registro0190.LocalizaRegistro(Trim(Query.FieldByName('UNIDADE').AsString)) then
                 begin
                    with Registro0190New do
                    begin
                       UNID  := Trim(Query.FieldByName('UNIDADE').AsString);
                       DESCR := 'Descricao ' + Trim(Query.FieldByName('UNIDADE').AsString);
                    end;
                 end;
               end;
             end;
           end;
           Query.Next;
         end;
         // Unidades de Medida saida nota manual
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select p.unidade from registro61 r');
         Query.SQL.Add('left outer join produtos p on r.idproduto = p.id');
         Query.SQL.Add('where r.data_emissao between :pDatai and :pDataf');
         Query.SQL.Add('and r.idempresa = :pEmpresa');
         Query.SQL.Add('and p.unidade <> '+QuotedStr(''));
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
           if not Registro0190.LocalizaRegistro(Trim(Query.FieldByName('unidade').AsString)) then
           begin
              with Registro0190New do
              begin
                 UNID  := Trim(Query.FieldByName('unidade').AsString);
                 DESCR := 'Descricao ' + Trim(Query.FieldByName('unidade').AsString);
              end;
           end;
           Query.Next;
         end;

         // Unidades de Medida saida nota manual cupom
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select pr.unidade from pedido p');
         Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
         Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
         Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
         Query.SQL.Add('and p.idempresa = :pempresa');
         Query.SQL.Add('and (p.numero_doc is not null or p.numero_doc <> '+QuotedStr('')+')');
         Query.SQL.Add('and p.modelo = '+QuotedStr('2D'));
         Query.SQL.Add('and p.notamanual = '+QuotedStr('S'));
         Query.SQL.Add('and p.coo > 0');
         Query.SQL.Add('and pr.unidade <> '+QuotedStr(''));
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
           if not Registro0190.LocalizaRegistro(Trim(Query.FieldByName('UNIDADE').AsString)) then
           begin
              with Registro0190New do
              begin
                 UNID  := Trim(Query.FieldByName('UNIDADE').AsString);
                 DESCR := 'Descricao ' + Trim(Query.FieldByName('UNIDADE').AsString);
              end;
           end;
           Query.Next;
         end;

         // Unidades de Medida saida ECF
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select distinct pr.unidade,p.status_nfe,p.chave_nfe from pedido p');
         Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
         Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
         Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
         Query.SQL.Add('and p.cancelado = '+QuotedStr('N'));
         Query.SQL.Add('and p.coo > 0');
         Query.SQL.Add('and p.idempresa = :pEmpresa');
         Query.SQL.Add('and pr.unidade is not null');
         Query.SQL.Add('and i.aliq_icms > 0');
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
            if not Registro0190.LocalizaRegistro(Trim(Query.FieldByName('UNIDADE').AsString)) then
            begin
               with Registro0190New do
               begin
                  UNID  := Trim(Query.FieldByName('UNIDADE').AsString);
                  DESCR := 'Descricao ' + Trim(Query.FieldByName('UNIDADE').AsString);
               end;
            end;
            Query.Next;
         end;
         // produtos entradas
         if sNotasEntrada then
         begin
           Query.Close;
           Query.SQL.Clear;
           Query.SQL.Add('select i.idproduto,pr.unidade,i.descricao,pr.ean13,');
           Query.SQL.Add('i.aliq_icms,i.quantidade,i.valor,c.status_nfe,c.chave_nfe,');
           Query.SQL.Add('pr.codigo_ncm from compras c');
           Query.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
           Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
           Query.SQL.Add('where c.data_compra between :pDatai and :pDataf');
           Query.SQL.Add('and c.cancelado = '+QuotedStr('N'));
           Query.SQL.Add('and c.nota is not null');
           Query.SQL.Add('and c.idempresa = :pEmpresa');
           Query.SQL.Add('and i.idproduto > 0');
           Query.Params.ParamByName('pDatai').AsDate      := Datai;
           Query.Params.ParamByName('pDataf').AsDate      := Dataf;
           Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
           Query.Open;
           while not Query.Eof do
           begin
             if (Query.FieldByName('STATUS_NFE').AsString = '100') or
                (Query.FieldByName('STATUS_NFE').AsString = '') then
             begin
  //             if Query.FieldByName('chave_nfe').AsString = '' then
               begin
                 if not Registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
                 begin
                    with Registro0200New do
                    begin
                       COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                       DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                       COD_BARRA    := Query.FieldByName('ean13').AsString;
                       COD_ANT_ITEM := '';
                       UNID_INV     := Trim(Query.FieldByName('unidade').AsString);
                       TIPO_ITEM    := tiMercadoriaRevenda;
                       COD_NCM      := Trim(Query.FieldByName('codigo_ncm').AsString);
                       EX_IPI       := '';
                       COD_GEN      := '';
                       COD_LST      := '';
                       ALIQ_ICMS    := Query.FieldByName('aliq_icms').AsCurrency;
                    end;
                 end;
               end;
             end;
             Query.Next;
           end;
         end;
         // produtos saidas
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select i.idproduto,pr.unidade,i.descricao,i.ean13,');
         Query.SQL.Add('i.aliq_icms,i.quantidade,i.valor,p.status_nfe,p.chave_nfe,');
         Query.SQL.Add('pr.codigo_ncm from pedido p');
         Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
         Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
         Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
         Query.SQL.Add('and p.cancelado = '+QuotedStr('N'));
         Query.SQL.Add('and p.numero_doc is not null');
         Query.SQL.Add('and p.idempresa = :pEmpresa');
         Query.SQL.Add('and i.idproduto > 0');
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
           if Copy(Query.FieldByName('chave_nfe').AsString,21,2) <> '65' then
           begin
             if Query.FieldByName('STATUS_NFE').AsString = '100' then
             begin
               if Query.FieldByName('chave_nfe').AsString = '' then
               begin
                 if not Registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
                 begin
                    with Registro0200New do
                    begin
                       COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                       DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                       COD_BARRA    := Query.FieldByName('ean13').AsString;
                       COD_ANT_ITEM := '';
                       UNID_INV     := Trim(Query.FieldByName('unidade').AsString);
                       TIPO_ITEM    := tiMercadoriaRevenda;
                       COD_NCM      := Trim(Query.FieldByName('codigo_ncm').AsString);
                       EX_IPI       := '';
                       COD_GEN      := '';
                       COD_LST      := '';
                       ALIQ_ICMS    := Query.FieldByName('aliq_icms').AsCurrency;
                    end;
                 end;
               end;
             end;
           end;  
           Query.Next;
         end;
         // produtos saidas nota manual com cupom
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select i.idproduto,pr.unidade,i.descricao,i.ean13,');
         Query.SQL.Add('i.aliq_icms,i.quantidade,i.valor,p.status_nfe,p.chave_nfe,');
         Query.SQL.Add('pr.codigo_ncm from pedido p');
         Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
         Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
         Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
         Query.SQL.Add('and p.idempresa = :pempresa');
         Query.SQL.Add('and (p.numero_doc is not null or p.numero_doc <> '+QuotedStr('')+')');
         Query.SQL.Add('and p.modelo = '+QuotedStr('2D'));
         Query.SQL.Add('and p.notamanual = '+QuotedStr('S'));
         Query.SQL.Add('and p.coo > 0');
         Query.SQL.Add('and i.idproduto > 0');
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
           if not Registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
           begin
              with Registro0200New do
              begin
                 COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                 DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                 COD_BARRA    := Query.FieldByName('ean13').AsString;
                 COD_ANT_ITEM := '';
                 UNID_INV     := Trim(Query.FieldByName('unidade').AsString);
                 TIPO_ITEM    := tiMercadoriaRevenda;
                 COD_NCM      := Trim(Query.FieldByName('codigo_ncm').AsString);
                 EX_IPI       := '';
                 COD_GEN      := '';
                 COD_LST      := '';
                 ALIQ_ICMS    := Query.FieldByName('aliq_icms').AsCurrency;
              end;
           end;
           Query.Next;
         end;
         // produtos saidas nota manual
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select r.idproduto,pr.unidade,pr.descricao,pr.ean13,');
         Query.SQL.Add('r.aliq_icms,r.quantidade,r.total,');
         Query.SQL.Add('pr.codigo_ncm from registro61 r');
         Query.SQL.Add('left outer join produtos pr on r.idproduto = pr.id');
         Query.SQL.Add('where r.data_emissao between :pDatai and :pDataf');
         Query.SQL.Add('and r.idempresa = :pEmpresa');
         Query.SQL.Add('and r.id > 0');
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
           if not Registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
           begin
              with Registro0200New do
              begin
                 COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                 DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                 COD_BARRA    := Query.FieldByName('ean13').AsString;
                 COD_ANT_ITEM := '';
                 UNID_INV     := Trim(Query.FieldByName('unidade').AsString);
                 TIPO_ITEM    := tiMercadoriaRevenda;
                 COD_NCM      := Trim(Query.FieldByName('codigo_ncm').AsString);
                 EX_IPI       := '';
                 COD_GEN      := '';
                 COD_LST      := '';
                 ALIQ_ICMS    := Query.FieldByName('aliq_icms').AsCurrency;
              end;
           end;
           Query.Next;
         end;




         // produtos saidas ECF
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('select i.idproduto,pr.unidade,i.descricao,i.ean13,');
         Query.SQL.Add('i.aliq_icms,i.quantidade,i.valor,p.status_nfe,p.chave_nfe,');
         Query.SQL.Add('pr.codigo_ncm from pedido p');
         Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
         Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
         Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
         Query.SQL.Add('and p.cancelado = '+QuotedStr('N'));
         Query.SQL.Add('and p.coo > 0');
         Query.SQL.Add('and p.idempresa = :pEmpresa');
         Query.SQL.Add('and i.idproduto > 0');
         Query.SQL.Add('and i.aliq_icms > 0');
         Query.Params.ParamByName('pDatai').AsDate      := Datai;
         Query.Params.ParamByName('pDataf').AsDate      := Dataf;
         Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
         Query.Open;
         while not Query.Eof do
         begin
            if not Registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
            begin
               with Registro0200New do
               begin
                  COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                  DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                  COD_BARRA    := '';
                  COD_ANT_ITEM := '';
                  UNID_INV     := Query.FieldByName('unidade').AsString;
                  TIPO_ITEM    := tiMercadoriaRevenda;
                  COD_NCM      := Trim(Query.FieldByName('codigo_ncm').AsString);
                  EX_IPI       := '';
                  COD_GEN      := '';
                  COD_LST      := '';
                  ALIQ_ICMS    := Query.FieldByName('aliq_icms').AsCurrency;
               end;
            end;
            Query.Next;
         end;
         // Unidades de Medida Inventário
         if ListaBlocosH then
         begin
           // Selecona produtos no cadastro
           Query.Close;
           Query.SQL.Clear;
           Query.SQL.Add('select p.id,p.unidade,p.descricao,p.codigo_ncm,');
           Query.SQL.Add('p.aliquota_icms,e.quantidade,p.preco_compra,p.ean13');
           Query.SQL.Add('from produtos p, estoque e');
           Query.SQL.Add('where p.id = e.idproduto');
           Query.SQL.Add('and e.idempresa = :pEmpresa');
           if not pTipoProdBensConsumo then
              Query.SQL.Add('and p.bens_consumo = '+QuotedStr('N'));
           Query.SQL.Add('order by p.id');
           Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
           Query.Open;
           //
           aNumReg := RetornaQtdRegDBX(Query);
           sLbMensagem.Caption := 'Processando o inventário';
           sProgressBar1.Max := aNumReg;
           Application.ProcessMessages;
           aRegAtual := 0;
           //
           while not Query.Eof do
           begin
              aSaldoEstoque := RetornaSaldoInventario(Query.FieldByName('id').AsInteger,
                                                      StrToInt(CodEmp),
                                                      pDataInventario,
                                                      Query.FieldByName('quantidade').AsFloat);
              if aSaldoEstoque > 0 then
              begin
                // registra a unidade caso não tenha
                if not Registro0190.LocalizaRegistro(Trim(Query.FieldByName('unidade').AsString)) then
                begin
                   with Registro0190New do
                   begin
                      UNID  := Trim(Query.FieldByName('unidade').AsString);
                      DESCR := 'Descricao ' + Trim(Query.FieldByName('unidade').AsString);
                   end;
                end;
                // registra o produto caso não tenha
                if not Registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('id').AsInteger)) then
                begin
                   with Registro0200New do
                   begin
                      COD_ITEM     := IntToStr(Query.FieldByName('id').AsInteger);
                      DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                      COD_BARRA    := Query.FieldByName('ean13').AsString;
                      COD_ANT_ITEM := '';
                      UNID_INV     := Query.FieldByName('unidade').AsString;
                      TIPO_ITEM    := tiMercadoriaRevenda;
                      COD_NCM      := Trim(Query.FieldByName('codigo_ncm').AsString);
                      EX_IPI       := '';
                      COD_GEN      := '';
                      COD_LST      := '';
                      ALIQ_ICMS    := Query.FieldByName('aliquota_icms').AsCurrency;
                   end;
                end;
                // adiciona produto ao inventário
                InsereItemInventario(CdsInventario,
                                     Query.FieldByName('id').AsInteger,
                                     Query.FieldByName('unidade').AsString,
                                     aSaldoEstoque,
                                     Query.FieldByName('preco_compra').AsFloat);
              end;
              Inc(aRegAtual);
              sLbMensagem.Caption := 'Processando o inventário:' + IntToStrZero(aRegAtual,6)+'/'+IntToStrZero(aNumReg,6);
              sProgressBar1.Position := aRegAtual;
              Application.ProcessMessages;
              Query.Next;
           end;
         end;
         //
         sControleBlocoG := false;
         if ListaBlocosG then
         begin
           // Registro 0300
           Query.Close;
           Query.SQL.Clear;
           Query.SQL.Add('select i.idproduto,i.descricao,');
           Query.SQL.Add('p.bens_consumo,p.prod_componente,');
           Query.SQL.Add('p.idprodprincipal,c.idplanoconta,c.idcentrocusto,');
           Query.SQL.Add('p.prod_finalidade,p.vidautil_meses from compras c');
           Query.SQL.Add('left outer join classificacao x on c.id_classificacao = x.id');
           Query.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
           Query.SQL.Add('left outer join produtos p on i.idproduto = p.id');
           Query.SQL.Add('where c.data_compra between :pDatai and :pDataf');
           Query.SQL.Add('and c.cancelado = '+QuotedStr('N'));
           Query.SQL.Add('and c.nota is not null');
           Query.SQL.Add('and c.idempresa = :pEmpresa');
           Query.SQL.Add('and x.apropriar_icms_ap = '+QuotedStr('S'));
           Query.Params.ParamByName('pDatai').AsDate      := Datai;
           Query.Params.ParamByName('pDataf').AsDate      := Dataf;
           Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
           Query.Open;
           aControle := false;
           while not Query.Eof do
           begin
             sControleBlocoG := true;
             aControle := true;
             with Registro0300New do
             begin
                COD_IND_BEM := IntToStr(Query.FieldByName('idproduto').AsInteger);
                if Query.FieldByName('bens)consumo').AsString = 'S' then
                   IDENT_MERC  := 1
                else if Query.FieldByName('prod_componente').AsString = 'S' then
                   IDENT_MERC  := 0;
                DESCR_ITEM  := Query.FieldByName('descricao').AsString;
                COD_PRNC    := IntToStr(Query.FieldByName('idprodprincipal').AsInteger);
                COD_CTA     := IntToStrZero(Query.FieldByName('idplanoconta').AsInteger,6);
                NR_PARC     := 1;
                // adiciona registro 0305
                with Registro0305New do
                begin
                  COD_CCUS  := IntToStrZero(Query.FieldByName('idcentrocusto').AsInteger,3);
                  FUNC      := Query.FieldByName('prod_finalidade').AsString;
                  VIDA_UTIL := Query.FieldByName('vidautil_meses').AsInteger;
                end;
             end;
             Query.Next;
           end;
           // verifica se teve registro 0300
           if aControle then
           begin
             // registro 0500
             Query.Close;
             Query.SQL.Clear;
             Query.SQL.Add('select p.id,p.codigo,p.idcontamaster,');
             Query.SQL.Add('p.descricao,p.tipo_conta from planoconta P');
             Query.SQL.Add('order by p.id,p.idcontamaster');
             Query.Open;
             while not Query.Eof do
             begin
               with Registro0500New do
               begin
                 DT_ALT     := Datai;
                 if Query.FieldByName('tipo_conta').AsString = 'C' then
                    COD_NAT_CC := '01'
                 else if Query.FieldByName('tipo_conta').AsString = 'D' then
                    COD_NAT_CC := '02'
                 else
                    COD_NAT_CC := '09';
                 //
                 if Query.FieldByName('idcontamaster').AsInteger = 0 then
                 begin
                   IND_CTA := 'S';
                   NIVEL   := '01';
                 end
                 else if Query.FieldByName('idcontamaster').AsInteger = 1 then
                 begin
                   IND_CTA := 'S';
                   NIVEL   := '02';
                 end
                 else if Query.FieldByName('idcontamaster').AsInteger > 1 then
                 begin
                   IND_CTA := 'A';
                   NIVEL   := '03';
                 end;
                 //
                 COD_CTA    := Query.FieldByName('codigo').AsString;
                 NOME_CTA   := Query.FieldByName('descricao').AsString;
               end;
               Query.Next;
             end;
             // registro 0600 - Centro de Custo
             Query.Close;
             Query.SQL.Clear;
             Query.SQL.Add('select cc.id,cc.descricao from compras c');
             Query.SQL.Add('left outer join centrocusto cc on cc.id = c.idcentrocusto');
             Query.SQL.Add('left outer join classificacao x on c.id_classificacao = x.id');
             Query.SQL.Add('where c.data_compra between :pDatai and :pDataf');
             Query.SQL.Add('and c.cancelado = '+QuotedStr('N'));
             Query.SQL.Add('and c.nota is not null');
             Query.SQL.Add('and c.idempresa = :pEmpresa');
             Query.SQL.Add('and x.apropriar_icms_ap = '+QuotedStr('S'));
             Query.Params.ParamByName('pDatai').AsDate      := Datai;
             Query.Params.ParamByName('pDataf').AsDate      := Dataf;
             Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
             Query.Open;
             while not Query.Eof do
             begin
               with Registro0600New do
               begin
                 DT_ALT   := Datai;
                 COD_CCUS := IntToStrZero(Query.FieldByName('id').AsInteger,3);
                 CCUS     := Query.FieldByName('descricao').AsString;
               end;
               Query.Next;
             end;
           end;
         end;
      end;
   end;

end;

procedure TSPED_EFD.DadosBloco_1(pDatai, pDataf: TDateTime);
var Q1300, Q1310, Q1320, Q1350, Q1360, Q1370, QTANQ : TSQLQuery;
begin
  Q1300 := TSQLQuery.Create(nil);
  Q1310 := TSQLQuery.Create(nil);
  Q1320 := TSQLQuery.Create(nil);
  Q1350 := TSQLQuery.Create(nil);
  Q1360 := TSQLQuery.Create(nil);
  Q1370 := TSQLQuery.Create(nil);
  QTANQ := TSQLQuery.Create(nil);
  try
    Q1300.SQLConnection := ConexaoDados;
    Q1310.SQLConnection := ConexaoDados;
    Q1320.SQLConnection := ConexaoDados;
    Q1350.SQLConnection := ConexaoDados;
    Q1360.SQLConnection := ConexaoDados;
    Q1370.SQLConnection := ConexaoDados;
    QTANQ.SQLConnection := ConexaoDados;
    // Alimenta o componente com informações para gerar todos os registros do
    // Bloco 1.
    with DmAcBr.ACBrSpedFiscal1.Bloco_1 do
    begin
      with Registro1001New do
      begin
        IND_MOV := imComDados;
        //
        Q1300.Close;
        Q1300.SQL.Clear;
        Q1300.SQL.Add('select * from retorna_mov_combustivel(:pDatai,:PDataf,:pEmpresa)');
        Q1300.Params.ParamByName('pDatai').AsDate := pDatai;
        Q1300.Params.ParamByName('pDataf').AsDate := pDataf;
        Q1300.Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
        Q1300.Open;
        if not Q1300.IsEmpty then
        begin
          // grava registro 1001 - Abertura do Bloco
          with Registro1010New do
          begin
            IND_EXP := 'N';
            IND_CCRF := 'N';
            IND_COMB := 'S';
            IND_USINA := 'N';
            IND_VA := 'N';
            IND_EE := 'N';
            IND_CART := 'N';
            IND_FORM := 'N';
            IND_AER := 'N';
          end;
          // registro 1300
          while not Q1300.Eof do
          begin
            with Registro1300New do
            begin
              COD_ITEM     := Q1300.FieldByName('ID_PRODUTO').AsString;
              DT_FECH      := Q1300.FieldByName('DATA_EMISSAO').AsDateTime;
              ESTQ_ABERT   := Q1300.FieldByName('EST_ABERTURA').AsFloat;
              VOL_ENTR     := Q1300.FieldByName('VOL_ENTRADA').AsFloat;
              VOL_DISP     := Q1300.FieldByName('VOL_DISPONIVEL').AsFloat;
              VOL_SAIDAS   := Q1300.FieldByName('VOL_SAIDA').AsFloat;
              ESTQ_ESCR    := Q1300.FieldByName('EST_ESCRITURAL').AsFloat;
              VAL_AJ_PERDA := Q1300.FieldByName('VAL_AJUSTE_PERDA').AsFloat;
              VAL_AJ_GANHO := Q1300.FieldByName('VAL_AJUSTE_GANHO').AsFloat;
              FECH_FISICO  := Q1300.FieldByName('FECH_FISICO').AsFloat;
            end;
            // registro 1310
            Q1310.Close;
            Q1310.SQL.Clear;
            Q1310.SQL.Add('select * from retorna_mov_combustivel_tq(:pdata,:pIDProduto,:pempresa)');
            Q1310.Params.ParamByName('pData').AsDate         := Q1300.FieldByName('DATA_EMISSAO').AsDateTime;
            Q1310.Params.ParamByName('pIDProduto').AsInteger := Q1300.FieldByName('ID_PRODUTO').AsInteger;
            Q1310.Params.ParamByName('pEmpresa').AsInteger   := sIDEmpresa;
            Q1310.Open;
            while not Q1310.Eof do
            begin
              with Registro1310New do
              begin
                NUM_TANQUE   := Q1310.FieldByName('NUM_TANQUE').AsString;
                ESTQ_ABERT   := Q1310.FieldByName('EST_ABERTURA').AsFloat;
                VOL_ENTR     := Q1310.FieldByName('VOL_ENTRADA').AsFloat;
                VOL_DISP     := Q1310.FieldByName('VOL_DISPONIVEL').AsFloat;
                VOL_SAIDAS   := Q1310.FieldByName('VOL_SAIDA').AsFloat;
                ESTQ_ESCR    := Q1310.FieldByName('EST_ESCRITURAL').AsFloat;
                VAL_AJ_PERDA := Q1310.FieldByName('VAL_AJUSTE_PERDA').AsFloat;
                VAL_AJ_GANHO := Q1310.FieldByName('VAL_AJUSTE_GANHO').AsFloat;
                FECH_FISICO  := Q1310.FieldByName('FECH_FISICO').AsFloat;
              end;
              // registro 1320
              Q1320.Close;
              Q1320.SQL.Clear;
              Q1320.SQL.Add('select * from retorna_mov_combustivel_bc(:Num_Tanque,:pData)');
              Q1320.Params.ParamByName('Num_Tanque').AsInteger := Q1310.FieldByName('ID_TANQUE').AsInteger;
              Q1320.Params.ParamByName('pData').AsDate         := Q1300.FieldByName('DATA_EMISSAO').AsDateTime;
              Q1320.Open;
              while not Q1320.Eof do
              begin
                with Registro1320New do
                begin
                  NUM_BICO    := Q1320.FieldByName('NUM_BICO').AsString;
                  NR_INTERV   := Q1320.FieldByName('NR_INTERV').AsString;
                  MOT_INTERV  := Q1320.FieldByName('MOT_INTERV').AsString;
                  NOM_INTERV  := Q1320.FieldByName('NOM_INTERV').AsString;
                  CNPJ_INTERV := Q1320.FieldByName('CNPJ_INTERV').AsString;
                  CPF_INTERV  := Q1320.FieldByName('CPF_INTERV').AsString;
                  VAL_FECHA   := Q1320.FieldByName('VAL_FECHA').AsFloat;
                  VAL_ABERT   := Q1320.FieldByName('VAL_ABERT').AsFloat;
                  VOL_AFERI   := Q1320.FieldByName('VOL_AFERI').AsFloat;
                  VOL_VENDAS  := Q1320.FieldByName('VOL_VENDAS').AsFloat;
                end;
                Q1320.Next;
              end;
              Q1310.Next;
            end;
            Q1310.Close;
            Q1320.Close;

            // informa registros de bombas 1350
            Q1350.Close;
            Q1350.SQL.Clear;
            Q1350.SQL.Add('select distinct b.id,b.serie,b.fabricante,b.modelo,');
            Q1350.SQL.Add('b.tipo_medicao from pedido p');
            Q1350.SQL.Add('inner join pedido_itens i on p.id = i.idpedido');
            Q1350.SQL.Add('inner join produtos pr on i.idproduto = pr.id');
            Q1350.SQL.Add('inner join bombas_abastec b on i.id_bomba = b.id');
            Q1350.SQL.Add('where p.data_entrega >= :pDatai');
            Q1350.SQL.Add('and p.data_entrega <= :pDataf');
            Q1350.SQL.Add('and p.idempresa = :pEmpresa');
            Q1350.SQL.Add('and p.cancelado = '+QuotedStr('N'));
            Q1350.SQL.Add('and p.confirmada = '+QuotedStr('S'));
            Q1350.SQL.Add('and i.cancelado = '+QuotedStr('N'));
            Q1350.SQL.Add('and pr.combustivel = '+QuotedStr('S'));
            Q1350.Params.ParamByName('pDatai').AsDate := pDatai;
            Q1350.Params.ParamByName('pDataf').AsDate := pDataf;
            Q1350.Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
            Q1350.Open;
            while not Q1350.Eof do
            begin
              with Registro1350New do
              begin
                SERIE        := Q1350.FieldByName('SERIE').AsString;
                FABRICANTE   := Q1350.FieldByName('FABRICANTE').AsString;
                MODELO       := Q1350.FieldByName('MODELO').AsString;
                case Q1350.FieldByName('TIPO_MEDICAO').AsInteger of
                  0: TIPO_MEDICAO := medAnalogico;
                  1: TIPO_MEDICAO := medDigital;
                end;
              end;
              // Registro 1360
              Q1360.Close;
              Q1360.SQL.Clear;
              Q1360.SQL.Add('select * from bombas_lacres b');
              Q1360.SQL.Add('where b.id_bomba = :pIDBomba');
              Q1360.Params.ParamByName('pIDBomba').AsInteger := Q1350.FieldByName('ID').AsInteger;
              Q1360.Open;
              while not Q1360.Eof do
              begin
                with Registro1360New do
                begin
                  NUM_LACRE    := Q1360.FieldByName('NUM_LACRE').AsString;
                  DT_APLICACAO := Q1360.FieldByName('DATA_APLIC').AsDateTime;
                end;
                Q1360.Next;
              end;
              // Registro 1370
              Q1370.Close;
              Q1370.SQL.Clear;
              Q1370.SQL.Add('select * from bicos_abastec b');
              Q1370.SQL.Add('where b.id_bomba = :pIDBomba');
              Q1370.Params.ParamByName('pIDBomba').AsInteger := Q1350.FieldByName('ID').AsInteger;
              Q1370.Open;
              while not Q1370.Eof do
              begin
                QTANQ.Close;
                QTANQ.SQL.Clear;
                QTANQ.SQL.Add('select * from tanques_abastec t');
                QTANQ.SQL.Add('where t.id = :pIDTanque');
                QTANQ.Params.ParamByName('pIDTanque').AsInteger := Q1370.FieldByName('ID_TANQUE').AsInteger;
                QTANQ.Open;
                if not QTANQ.IsEmpty then
                begin
                  with Registro1370New do
                  begin
                    NUM_BICO   := Q1370.FieldByName('BICO_CONCENTRADOR').AsString;
                    COD_ITEM   := QTANQ.FieldByName('ID_PRODUTO').AsString;
                    NUM_TANQUE := QTANQ.FieldByName('TANQUE_NUMERO').AsString;
                  end;
                end;
                Q1370.Next;
              end;
              Q1350.Next;
            end;
            Q1350.Close;
            Q1360.Close;
            Q1370.Close;
            QTANQ.Close;
            //
            Q1300.Next;
          end;
          Q1300.Close;
        end
        else
        begin
          with Registro1010New do
          begin
            IND_EXP := 'N';
            IND_CCRF := 'N';
            IND_COMB := 'N';
            IND_USINA := 'N';
            IND_VA := 'N';
            IND_EE := 'N';
            IND_CART := 'N';
            IND_FORM := 'N';
            IND_AER := 'N';
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(Q1300);
    FreeAndNil(Q1310);
    FreeAndNil(Q1320);
    FreeAndNil(Q1350);
  end;

end;

procedure TSPED_EFD.DadosBloco_9;
begin
   DmAcBr.ACBrSPEDFiscal1.WriteBloco_9;

end;

procedure TSPED_EFD.DadosBloco_C(var CdsUFST:TClientDataSet; Notas,BufNotas,CodEmp:String;
  Datai,Dataf:TDateTime; VerificaSTIPI,CalcularIndiceDespesasAcessorias:Boolean;
  pPerfil:Integer);
var AuxStr, aUF, aSitTribIPI, aSitTribPis, aSitTribCofins, aCST : String;
    AuxAliq, AuxValor, aValBaseICMS, aValICMS, aIndiceDespAcess : Double;
    AuxFrete, AuxSeguro, AuxDespesas, aICMS : Double;
    aContador, AuxInt, IItens, NNotas, BNotas, i: Integer;
    QNota,QItem,QTrib : TSQLQuery;
    Q300,Q310,Q320,Q321, Q350,Q370,Q390 : TSQLQuery;
    Q400,Q405,Q420, Q425,Q460,Q470,Q490 : TSQLQuery;
    aControle, GerarRegistro100, GeraCampo170 : Boolean;
    aNumReg, aRegAtual, aNumItem : Integer;
    CdsRegistroC490 : TClientDataset;
    aModeloNFe, aPriNum,aUltNum : String;
    aDescCupom, aAcresCupom, aTotalItem : Double;
begin
  // prepara clientDataSet para registro75
  CdsRegistroC490 := TClientDataSet.Create(nil);
  try
    CdsRegistroC490.FieldDefs.Add('CST', ftString, 3, False);
    CdsRegistroC490.FieldDefs.Add('CFOP', ftString, 4, False);
    CdsRegistroC490.FieldDefs.Add('Aliq', ftFloat, 0, False);
    CdsRegistroC490.FieldDefs.Add('Val_Oper', ftFloat, 0, False);
    CdsRegistroC490.FieldDefs.Add('Val_Base', ftFloat, 0, False);
    CdsRegistroC490.FieldDefs.Add('Val_ICMS', ftFloat, 0, False);
    if not CdsRegistroC490.Active then
       CdsRegistroC490.CreateDataSet;
  finally
    CdsRegistroC490.EmptyDataSet;
  end;
   //
  try
    QNota := TSqlQuery.Create(nil);
    QItem := TSqlQuery.Create(nil);
    QTrib := TSqlQuery.Create(nil);
    Q300 := TSqlQuery.Create(nil);
    Q310 := TSqlQuery.Create(nil);
    Q320 := TSqlQuery.Create(nil);
    Q321 := TSqlQuery.Create(nil);
    Q350 := TSqlQuery.Create(nil);
    Q370 := TSqlQuery.Create(nil);
    Q390 := TSqlQuery.Create(nil);
    Q400 := TSqlQuery.Create(nil);
    Q405 := TSqlQuery.Create(nil);
    Q420 := TSqlQuery.Create(nil);
    Q425 := TSqlQuery.Create(nil);
    Q460 := TSqlQuery.Create(nil);
    Q470 := TSqlQuery.Create(nil);
    Q490 := TSqlQuery.Create(nil);
    QNota.SQLConnection := ConexaoDados;
    QItem.SQLConnection := ConexaoDados;
    QTrib.SQLConnection := ConexaoDados;
    Q300.SQLConnection := ConexaoDados;
    Q310.SQLConnection := ConexaoDados;
    Q320.SQLConnection := ConexaoDados;
    Q321.SQLConnection := ConexaoDados;
    Q350.SQLConnection := ConexaoDados;
    Q370.SQLConnection := ConexaoDados;
    Q390.SQLConnection := ConexaoDados;
    Q400.SQLConnection := ConexaoDados;
    Q405.SQLConnection := ConexaoDados;
    Q420.SQLConnection := ConexaoDados;
    Q425.SQLConnection := ConexaoDados;
    Q460.SQLConnection := ConexaoDados;
    Q470.SQLConnection := ConexaoDados;
    Q490.SQLConnection := ConexaoDados;
    // zera dados da apuração
    sDebitos := 0;
    sCreditos := 0;
    sDebitosST := 0;
    sCreditosST := 0;
    // Alimenta o componente com informações para gerar todos os registros do
    // Bloco C.
    NNotas := StrToInt64Def(Notas,1);
    BNotas := StrToInt64Def(BufNotas,1);

    try
      with DmAcBr.ACBrSpedFiscal1.Bloco_C do
      begin
        with RegistroC001New do
        begin
           IND_MOV := imComDados;
           if sNotasEntrada then
           begin
             // notas de entrada
             QNota.Close;
             QNota.SQL.Clear;
             QNota.SQL.Add('select distinct c.id,c.idfornecedor,c.nota,c.data_compra,');
             QNota.SQL.Add('c.tipo_frete,c.status_nfe,c.valor_total,c.desconto,');
             QNota.SQL.Add('c.valor,c.base_icms,c.valor_icms,c.base_icms_st,c.devolucao,');
             QNota.SQL.Add('c.valor_icms_st,c.valor_ipi,c.valor_pis,c.valor_cofins,');
             QNota.SQL.Add('c.chave_nfe,c.valor_frete,c.valor_outros,c.valor_seguro from compras c');
             QNota.SQL.Add('left outer join classificacao cf on c.id_classificacao = cf.id');
             QNota.SQL.Add('where c.data_compra between :pDatai and :pDataf');
             QNota.SQL.Add('and c.cancelado = '+QuotedStr('N'));
             QNota.SQL.Add('and c.nota is not null');
             QNota.SQL.Add('and c.idempresa = :pEmpresa');
             QNota.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
             // SQL Itens
             QItem.Close;
             QItem.SQL.Clear;
             QItem.SQL.Add('select i.idproduto,p.unidade,i.aliq_icms,');
             QItem.SQL.Add('i.aliq_icms_st,i.aliq_ipi,i.aliq_pis,');
             QItem.SQL.Add('i.aliq_cofins,I.cst,i.cfop,i.cst_ipi,i.cst_pis,');
             QItem.SQL.Add('i.cst_cofins,p.combustivel,');
             QItem.SQL.Add('sum(i.quantidade) as qtd_produto,');
             QItem.SQL.Add('avg(i.valor) as val_custo ,');
             QItem.SQL.Add('sum(i.valor_total) as total_produto,');
             QItem.SQL.Add('sum(i.desconto) as val_desc,');
             QItem.SQL.Add('sum(i.base_icms) as val_base_icms,');
             QItem.SQL.Add('sum(i.valor_icms) as val_icms,');
             QItem.SQL.Add('sum(i.base_icms_st) as val_base_icms_sub,');
             QItem.SQL.Add('sum(i.valor_icms_st) as val_icms_sub,');
             QItem.SQL.Add('sum(i.base_ipi) as val_base_ipi,');
             QItem.SQL.Add('sum(i.valor_ipi) as val_ipi,');
             QItem.SQL.Add('sum(i.base_pis) as val_base_pis,');
             QItem.SQL.Add('sum(i.valor_pis) as val_pis,');
             QItem.SQL.Add('sum(i.base_cofins) as val_base_cofins,');
             QItem.SQL.Add('sum(i.valor_cofins) as val_cofins from compras c');
             QItem.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
             QItem.SQL.Add('left outer join produtos p on i.idproduto = p.id');
             QItem.SQL.Add('where c.id = :pCD_Entrada');
             QItem.SQL.Add('group by i.idproduto,p.unidade,i.aliq_icms,');
             QItem.SQL.Add('i.aliq_icms_st,i.aliq_ipi,i.aliq_pis,');
             QItem.SQL.Add('i.aliq_cofins,I.cst,i.cfop,i.cst_ipi,i.cst_pis,');
             QItem.SQL.Add('i.cst_cofins,p.combustivel');
             // SQL Tributação
             QTrib.Close;
             QTrib.SQL.Clear;
             QTrib.SQL.Add('select i.cst,i.cfop,i.aliq_icms,');
             QTrib.SQL.Add('sum(i.valor_total) as total_produto,');
             QTrib.SQL.Add('sum(i.base_icms) as val_base_icms,');
             QTrib.SQL.Add('sum(i.valor_icms) as val_icms,');
             QTrib.SQL.Add('sum(i.base_icms_st) as val_base_icms_sub,');
             QTrib.SQL.Add('sum(i.valor_icms_st) as val_icms_sub,');
             QTrib.SQL.Add('sum(i.valor_ipi) as val_ipi from compras c');
             QTrib.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
             QTrib.SQL.Add('where c.id = :pCD_Entrada');
             QTrib.SQL.Add('group by i.cst,i.cfop,i.aliq_icms');
             // seleciona Dados
             QNota.Params.ParamByName('pDatai').AsDate      := Datai;
             QNota.Params.ParamByName('pDataf').AsDate      := Dataf;
             QNota.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
             QNota.Open;
             aNumReg := RetornaQtdRegDBX(QNota);
             sLbMensagem.Caption := 'Registros de Entrada';
             sProgressBar1.Max := aNumReg;
             Application.ProcessMessages;
             aRegAtual := 0;
             while not QNota.Eof do
             begin
               AuxFrete    := 0;
               AuxSeguro   := 0;
               AuxDespesas := 0;
               if (QNota.FieldByName('STATUS_NFE').AsString = '100') or
                  (QNota.FieldByName('STATUS_NFE').AsString = '') then
               begin
                 aModeloNFe := Copy(QNota.FieldByName('CHAVE_NFE').AsString,21,2);
                 GerarRegistro100 := true;
  //               if QNota.FieldByName('STATUS_NFE').AsString = '' then
  //                  GerarRegistro100 := false;
                 // adicionar o regisotro
                 if GerarRegistro100 then
                 begin
                   AuxFrete    := QNota.FieldByName('valor_Frete').AsFloat;
                   AuxSeguro   := QNota.FieldByName('valor_seguro').AsFloat;
                   AuxDespesas := QNota.FieldByName('valor_outros').AsFloat;
                   with RegistroC100New do
                   begin
                     COD_PART      := 'F'+IntToStrZero(QNota.FieldByName('idfornecedor').AsInteger,5);
                     if QNota.FieldByName('devolucao').AsString = 'N' then
                        IND_EMIT   := edTerceiros
                     else
                        IND_EMIT   := edEmissaoPropria;
                     NUM_DOC       := IntToStr(QNota.FieldByName('nota').AsInteger);
                     IND_OPER      := tpEntradaAquisicao;
                     if QNota.FieldByName('CHAVE_NFE').AsString <> '' then
                        COD_MOD    := aModeloNFe
                     else
                        COD_MOD    := '01';
                     COD_SIT       := sdRegular;
                     SER           := '';
                     CHV_NFE       := QNota.FieldByName('CHAVE_NFE').AsString;
                     DT_DOC        := QNota.FieldByName('data_compra').AsDateTime;
                     DT_E_S        := QNota.FieldByName('data_compra').AsDateTime;
                     if (VerificaSTIPI) and
                        (not VerificaSTProdutosNota(QNota.FieldByName('id').AsInteger,0)) then
                     begin
                       AuxValor := ((QNota.FieldByName('valor_total').AsFloat - QNota.FieldByName('valor_icms_st').AsFloat) - QNota.FieldByName('valor_ipi').AsFloat);
                       VL_DOC        := AuxValor;
                       VL_BC_ICMS_ST := 0;
                       VL_ICMS_ST    := 0;
                     end
                     else
                     begin
                       AuxValor := (QNota.FieldByName('valor_total').AsFloat - QNota.FieldByName('valor_ipi').AsFloat);
                       VL_DOC        := AuxValor;
                       VL_BC_ICMS_ST := QNota.FieldByName('base_icms_st').AsFloat;
                       VL_ICMS_ST    := QNota.FieldByName('valor_icms_st').AsFloat;
                     end;
                     IND_PGTO      := tpPrazo;
                     VL_DESC       := QNota.FieldByName('DESCONTO').AsFloat;
                     VL_ABAT_NT    := 0;
                     VL_MERC       := QNota.FieldByName('VALOR').AsFloat;
                     IND_FRT       := tfSemCobrancaFrete;
                     VL_FRT        := QNota.FieldByName('valor_frete').AsFloat;
                     VL_SEG        := QNota.FieldByName('valor_seguro').AsFloat;
                     VL_OUT_DA     := QNota.FieldByName('valor_outros').AsFloat;
                     aIndiceDespAcess := 1;
                     if QNota.FieldByName('valor_outros').AsFloat > 0 then
                     begin
                       if CalcularIndiceDespesasAcessorias then
                          aIndiceDespAcess := (((QNota.FieldByName('BASE_ICMS').AsFloat * 100)/ QNota.FieldByName('valor_total').AsFloat)/100);
                     end;
                     VL_BC_ICMS    := QNota.FieldByName('BASE_ICMS').AsFloat;
                     VL_ICMS       := QNota.FieldByName('VALOR_ICMS').AsFloat;
                     //
                     if (VerificaSTIPI) and
                        (not VerificaIPIProdutosNota(QNota.FieldByName('ID').AsInteger,0)) then
                        VL_IPI     := 0
                     else
                        VL_IPI     := QNota.FieldByName('valor_ipi').AsFloat;
                     VL_PIS        := QNota.FieldByName('valor_pis').AsFloat;
                     VL_COFINS     := QNota.FieldByName('valor_Cofins').AsFloat;
                     VL_PIS_ST     := 0;
                     VL_COFINS_ST  := 0;
                     // Registro C170
                     GeraCampo170 := false;
                     if QNota.FieldByName('CHAVE_NFE').AsString = '' then
                     begin
                       GeraCampo170 := true;
                     end
                     else
                     begin
                       if IND_EMIT = edTerceiros then
                          GeraCampo170 := true;
                     end;
                     //
                     if GeraCampo170 then
                     begin
                       QItem.Close;
                       QItem.Params.ParamByName('pCD_Entrada').AsInteger := QNota.FieldByName('ID').AsInteger;
                       QItem.Open;
                       IItens := 0;
                       while not QItem.Eof do
                       begin
                         Inc(IItens);
                         with RegistroC170New do   //Inicio Adicionar os Itens:
                         begin
                            NUM_ITEM         := FormatFloat('000', IItens);
                            COD_ITEM         := IntToStr(QItem.FieldByName('idproduto').AsInteger);
                            DESCR_COMPL      := '';
                            QTD              := QItem.FieldByName('qtd_produto').AsFloat;
                            UNID             := QItem.FieldByName('unidade').AsString;
  //                          AuxValor         := QItem.FieldByName('val_custo').AsFloat;
                            VL_ITEM          := QItem.FieldByName('total_produto').AsFloat;
                            VL_DESC          := QItem.FieldByName('val_desc').AsFloat;
                            IND_MOV          := mfNao;
                            CST_ICMS         := Trim(QItem.FieldByName('cst').AsString);
                            CFOP             := FiltraNumero(QItem.FieldByName('cfop').AsString);
                            COD_NAT          := '';
                            VL_BC_ICMS       := QItem.FieldByName('val_base_icms').AsFloat*aIndiceDespAcess;
                            ALIQ_ICMS        := QItem.FieldByName('aliq_icms').AsFloat;
                            VL_ICMS          := QItem.FieldByName('val_icms').AsFloat*aIndiceDespAcess;
                            VL_BC_ICMS_ST    := QItem.FieldByName('val_base_icms_sub').AsFloat;
                            ALIQ_ST          := QItem.FieldByName('aliq_icms_st').AsFloat;
                            VL_ICMS_ST       := QItem.FieldByName('val_icms_sub').AsFloat;
                            IND_APUR         := iaMensal;
                            aSitTribIPI      := '49';
                            if QItem.FieldByName('CST_IPI').AsString <> '' then
                               aSitTribIPI := QItem.FieldByName('CST_IPI').AsString;
                            CST_IPI          := aSitTribIPI;
                            COD_ENQ          := '';
                            VL_BC_IPI        := QItem.FieldByName('val_base_ipi').AsFloat;
                            ALIQ_IPI         := QItem.FieldByName('aliq_ipi').AsFloat;
                            VL_IPI           := QItem.FieldByName('val_ipi').AsFloat;
                            aSitTribPis      := '99';
                            if QItem.FieldByName('CST_PIS').AsString <> '' then
                               aSitTribPis := QItem.FieldByName('CST_PIS').AsString;
                            CST_PIS := aSitTribPis;
                            VL_BC_PIS        := QItem.FieldByName('val_base_pis').AsFloat;
                            ALIQ_PIS_PERC    := QItem.FieldByName('aliq_pis').AsFloat;
                            QUANT_BC_PIS     := 0;
                            ALIQ_PIS_R       := 0;
                            VL_PIS           := QItem.FieldByName('val_pis').AsFloat;
                            aSitTribCofins      := '99';
                            if QItem.FieldByName('CST_COFINS').AsString <> '' then
                               aSitTribCofins := QItem.FieldByName('CST_COFINS').AsString;
                            CST_COFINS := aSitTribCofins;
                            VL_BC_COFINS     := QItem.FieldByName('val_base_cofins').AsFloat;
                            ALIQ_COFINS_PERC := QItem.FieldByName('aliq_cofins').AsFloat;
                            QUANT_BC_COFINS  := 0;
                            ALIQ_COFINS_R    := 0;
                            VL_COFINS        := QItem.FieldByName('val_cofins').AsFloat;
                            COD_CTA          := '';
                            // registro C171
                            if QItem.FieldByName('combustivel').AsString = 'S' then
                            begin
                              with RegistroC171New do
                              begin
                                NUM_TANQUE := RetornaNumeroTanque(QItem.FieldByName('idproduto').AsInteger);
                                QTDE       := QItem.FieldByName('qtd_produto').AsFloat;
                              end;
                            end;
                         end; //Fim dos Itens;
                         QItem.Next;
                       end;
                     end;
                     //c190
                     QTrib.Close;
                     QTrib.Params.ParamByName('pCD_Entrada').AsInteger := QNota.FieldByName('ID').AsInteger;
                     QTrib.Open;
                     while not QTrib.Eof do
                     begin
                       with RegistroC190New do
                       begin
                          // calcula valor operacao
                          AuxValor := QTrib.FieldByName('total_produto').AsFloat;
                          AuxValor := AuxValor + QTrib.FieldByName('val_icms_sub').AsFloat;
                          if AuxFrete > 0 then
                          begin
                            AuxValor := AuxValor + AuxFrete;
                            AuxFrete := 0;
                          end;
                          if AuxSeguro > 0 then
                          begin
                            AuxValor := AuxValor + AuxSeguro;
                            AuxSeguro := 0;
                          end;
                          if AuxDespesas > 0 then
                          begin
                            AuxValor := AuxValor + AuxDespesas;
                            AuxDespesas := 0;
                          end;
                          CST_ICMS      := QTrib.FieldByName('cst').AsString;
                          CFOP          := QTrib.FieldByName('cfop').AsString;
                          VL_OPR        := AuxValor*aIndiceDespAcess;
                          ALIQ_ICMS     := QTrib.FieldByName('aliq_icms').AsFloat;
                          VL_BC_ICMS    := QTrib.FieldByName('val_base_icms').AsFloat*aIndiceDespAcess;
                          VL_ICMS       := QTrib.FieldByName('val_icms').AsFloat*aIndiceDespAcess;
                          VL_BC_ICMS_ST := QTrib.FieldByName('val_base_icms_sub').AsFloat;
                          VL_ICMS_ST    := QTrib.FieldByName('val_icms_sub').AsFloat;
                          if (QTrib.FieldByName('cst').AsString = '20') or
                             (QTrib.FieldByName('cst').AsString = '70') then
                          begin
                            VL_RED_BC     := ((AuxValor*aIndiceDespAcess) - (QTrib.FieldByName('val_base_icms').AsFloat*aIndiceDespAcess));
                          end
                          else
                          begin
                            VL_RED_BC     := 0;
                          end;
                          VL_IPI        := QTrib.FieldByName('val_ipi').AsFloat;
                          COD_OBS       := '';
                          // soma ao total de creditos
                          if (QTrib.FieldByName('cst').AsString = '00') or
                             (QTrib.FieldByName('cst').AsString = '10') or
                             (QTrib.FieldByName('cst').AsString = '20') or
                             (QTrib.FieldByName('cst').AsString = '70') then
                          begin
                            sCreditos := sCreditos + (QTrib.FieldByName('val_icms').AsFloat*aIndiceDespAcess);
                          end;
                          // soma ao total de creditos ST
                          if (QTrib.FieldByName('cst').AsString = '10') or
                             (QTrib.FieldByName('cst').AsString = '30') or
                             (QTrib.FieldByName('cst').AsString = '60') or
                             (QTrib.FieldByName('cst').AsString = '70') then
                          begin
                            sCreditosST := sCreditosST + QTrib.FieldByName('val_icms_sub').AsFloat;
                            aUF := RetornaUFCliFor(QNota.FieldByname('idfornecedor').AsInteger,0);
                            InsereRegistroUFST(CdsUFST,aUF,QTrib.FieldByName('val_icms_sub').AsFloat,0);
                          end;
                       end;
                       QTrib.Next;
                     end;
                   end;
                 end;
               end;
               Inc(aRegAtual);
               sProgressBar1.Position := aRegAtual;
               Application.ProcessMessages;
               //
               QNota.Next;
             end;
           end;
  // ************************************************************************************** //
           // notas de saidas
           QNota.Close;
           QNota.SQL.Clear;
           QNota.SQL.Add('select distinct p.id,p.idcliente,p.status_nfe,');
           QNota.SQL.Add('p.numero_doc,p.data_entrega,p.tipo_frete,');
           QNota.SQL.Add('p.valor_total,p.desconto,p.valor,p.base_icms,p.valor_icms,');
           QNota.SQL.Add('p.base_icms_st,p.valor_icms_st,p.valor_ipi,');
           QNota.SQL.Add('p.valor_pis,p.valor_cofins,p.chave_nfe,p.valor_frete,');
           QNota.SQL.Add('p.valor_seguro,p.valor_outros from pedido p');
           QNota.SQL.Add('left outer join classificacao x on p.id_classificacao = x.id');
           QNota.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
           QNota.SQL.Add('and p.cancelado = '+QuotedStr('N'));
           QNota.SQL.Add('and p.numero_doc is not null');
           QNota.SQL.Add('and p.idempresa = :pEmpresa');
           QNota.SQL.Add('and x.apropriar_icms_ap = '+QuotedStr('N'));
           // SQL Itens
           QItem.Close;
           QItem.SQL.Clear;
           QItem.SQL.Add('select i.idproduto,pr.unidade,i.aliq_icms,');
           QItem.SQL.Add('i.aliq_icms_st,i.aliq_ipi,i.aliq_pis,i.aliq_cofins,');
           QItem.SQL.Add('i.cst,i.cfop,i.cst_ipi,');
           QItem.SQL.Add('sum(i.quantidade) as qtd_produto,');
           QItem.SQL.Add('avg(i.valor) as val_venda,');
           QItem.SQL.Add('sum(i.valor_total) as total_produto,');
           QItem.SQL.Add('sum(i.desconto) as val_desc,');
           QItem.SQL.Add('sum(i.base_icms) as val_base_icms,');
           QItem.SQL.Add('sum(i.valor_icms) as val_icms,');
           QItem.SQL.Add('sum(i.base_icms_st) as val_base_icms_sub,');
           QItem.SQL.Add('sum(i.valor_icms_st) as val_icms_sub,');
           QItem.SQL.Add('sum(i.base_ipi) as val_base_ipi,');
           QItem.SQL.Add('sum(i.valor_ipi) val_ipi,');
           QItem.SQL.Add('sum(i.base_pis) as val_base_pis,');
           QItem.SQL.Add('sum(i.valor_pis) as val_pis,');
           QItem.SQL.Add('sum(i.base_cofins) as val_base_cofins,');
           QItem.SQL.Add('sum(i.valor_cofins) as val_cofins from pedido p');
           QItem.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
           QItem.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
           QItem.SQL.Add('where p.id = :pCD_Saida');
           QItem.SQL.Add('group by i.idproduto,pr.unidade,i.aliq_icms,');
           QItem.SQL.Add('i.aliq_icms_st,i.aliq_ipi,i.aliq_pis,i.aliq_cofins,');
           QItem.SQL.Add('i.cst,i.cfop,i.cst_ipi');
           // SQL Tributação
           QTrib.Close;
           QTrib.SQL.Clear;
           QTrib.SQL.Add('select i.cst,i.cfop,i.aliq_icms,');
           QTrib.SQL.Add('sum(i.valor_total) as total_produto,');
           QTrib.SQL.Add('sum(i.base_icms) as val_base_icms,');
           QTrib.SQL.Add('sum(i.valor_icms) as val_icms,');
           QTrib.SQL.Add('sum(i.base_icms_st) as val_base_icms_sub,');
           QTrib.SQL.Add('sum(i.valor_icms_st) as val_icms_sub,');
           QTrib.SQL.Add('sum(i.valor_ipi) as val_ipi from pedido p');
           QTrib.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
           QTrib.SQL.Add('where p.id = :pCD_Saida');
           QTrib.SQL.Add('group by i.cst,i.cfop,i.aliq_icms');
           // seleciona Dados
           QNota.Params.ParamByName('pDatai').AsDate      := Datai;
           QNota.Params.ParamByName('pDataf').AsDate      := Dataf;
           QNota.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
           QNota.Open;
           //
           aNumReg := RetornaQtdRegDBX(QNota);
           sLbMensagem.Caption := 'Registros de Saidas';
           sProgressBar1.Max := aNumReg;
           Application.ProcessMessages;
           aRegAtual := 0;
           while not QNota.Eof do
           begin
             AuxFrete    := 0;
             AuxSeguro   := 0;
             AuxDespesas := 0;
             if (QNota.FieldByName('STATUS_NFE').AsString = '100') or
                (QNota.FieldByName('STATUS_NFE').AsString = '') then
             begin
               aModeloNFe := Copy(QNota.FieldByName('CHAVE_NFE').AsString,21,2);
               GerarRegistro100 := true;
               // verifica em caso de falta de chave se tem registro de lançamento na tabela nfemsg
               if QNota.FieldByName('STATUS_NFE').AsString = '' then
                  GerarRegistro100 := false;
               // adicionar o regisotro
               if GerarRegistro100 then
               begin
                 AuxFrete    := QNota.FieldByName('valor_Frete').AsFloat;
                 AuxSeguro   := QNota.FieldByName('valor_seguro').AsFloat;
                 AuxDespesas := QNota.FieldByName('valor_outros').AsFloat;
                 with RegistroC100New do
                 begin
                   if aModeloNFe <> '65' then
                      COD_PART   := 'C'+IntToStrZero(QNota.FieldByName('idcliente').AsInteger,5)
                   else
                      COD_PART   := '';
                   IND_EMIT      := edEmissaoPropria;
                   IND_OPER      := tpSaidaPrestacao;
                   if QNota.FieldByName('CHAVE_NFE').AsString <> '' then
                   begin
                      COD_MOD    := aModeloNFe
                   end
                   else
                      COD_MOD    := '01';
                   COD_SIT       := sdRegular;
                   SER           := '';
                   NUM_DOC       := IntToStr(QNota.FieldByName('numero_doc').AsInteger);
                   CHV_NFE       := QNota.FieldByName('CHAVE_NFE').AsString;
                   DT_DOC        := QNota.FieldByName('data_entrega').AsDateTime;
                   DT_E_S        := QNota.FieldByName('data_entrega').AsDateTime;
                   if (VerificaSTIPI) and
                      (not VerificaSTProdutosNota(QNota.FieldByName('ID').AsInteger,1)) then
                   begin
                     AuxValor := ((QNota.FieldByName('valor_total').AsFloat - QNota.FieldByName('valor_icms_st').AsFloat) - QNota.FieldByName('valor_ipi').AsFloat);
                     AuxValor := AuxValor;
                     VL_DOC        := AuxValor;
                     VL_BC_ICMS_ST := 0;
                     VL_ICMS_ST    := 0;
                   end
                   else
                   begin
                     AuxValor := (QNota.FieldByName('valor_Total').AsFloat - QNota.FieldByName('valor_ipi').AsFloat);
                     AuxValor := AuxValor;
                     VL_DOC        := AuxValor;
                     VL_BC_ICMS_ST := QNota.FieldByName('base_icms_st').AsFloat;
                     VL_ICMS_ST    := QNota.FieldByName('valor_icms_st').AsFloat;
                   end;
                   IND_PGTO      := tpPrazo;
                   VL_DESC       := QNota.FieldByName('DESCONTO').AsFloat;
                   VL_ABAT_NT    := 0;
                   VL_MERC       := QNota.FieldByName('VALOR').AsFloat;
                   IND_FRT       := tfSemCobrancaFrete;
                   VL_FRT        := QNota.FieldByName('valor_frete').AsFloat;
                   VL_SEG        := QNota.FieldByName('valor_seguro').AsFloat;
                   VL_OUT_DA     := QNota.FieldByName('valor_outros').AsFloat;
                   aIndiceDespAcess := 1;
                   if QNota.FieldByName('valor_outros').AsFloat > 0 then
                   begin
                     if CalcularIndiceDespesasAcessorias then
                        aIndiceDespAcess := (((QNota.FieldByName('BASE_ICMS').AsFloat * 100)/ QNota.FieldByName('valor').AsFloat)/100);
                   end;
                   // se não for NFCe lanca
                   if aModeloNFe <> '65' then
                   begin
                     VL_BC_ICMS    := QNota.FieldByName('BASE_ICMS').AsFloat;
                     VL_ICMS       := QNota.FieldByName('VALOR_ICMS').AsFloat;
                   end
                   else
                   begin
                     VL_BC_ICMS    := 0;
                     VL_ICMS       := 0;
                   end;

                   if (VerificaSTIPI) and
                      (not VerificaIPIProdutosNota(QNota.FieldByName('ID').AsInteger,1)) then
                      VL_IPI     := 0
                   else
                      VL_IPI     := QNota.FieldByName('valor_ipi').AsFloat;
                   //
                   VL_PIS        := QNota.FieldByName('valor_pis').AsFloat;
                   VL_COFINS     := QNota.FieldByName('valor_Cofins').AsFloat;
                   VL_PIS_ST     := 0;
                   VL_COFINS_ST  := 0;
                   // Registro C170
                   if QNota.FieldByName('CHAVE_NFE').AsString = '' then
                   begin
                     QItem.Close;
                     QItem.Params.ParamByName('pCD_Saida').AsInteger := QNota.FieldByName('ID').AsInteger;
                     QItem.Open;
                     IItens := 0;
                     while not QItem.Eof do
                     begin
                       Inc(IItens);
                       with RegistroC170New do   //Inicio Adicionar os Itens:
                       begin
                          NUM_ITEM    := FormatFloat('000', IItens);
                          COD_ITEM    := IntToStr(QItem.FieldByName('cd_produto').AsInteger);
                          DESCR_COMPL := '';
                          QTD         := QItem.FieldByName('qtd_produto').AsFloat;
                          UNID        := QItem.FieldByName('unidade').AsString;
  //                        AuxValor    := QItem.FieldByName('val_venda').AsFloat;
                          VL_ITEM          := QItem.FieldByName('total_produto').AsFloat;
                          VL_DESC          := QItem.FieldByName('val_desc').AsFloat;
                          IND_MOV          := mfNao;
                          CST_ICMS         := QItem.FieldByName('cst').AsString;
                          CFOP             := QItem.FieldByName('cfop').AsString;
                          COD_NAT          := '';
                          VL_BC_ICMS       := QItem.FieldByName('val_base_icms').AsFloat*aIndiceDespAcess;
                          ALIQ_ICMS        := QItem.FieldByName('aliq_icms').AsFloat;
                          VL_ICMS          := QItem.FieldByName('val_icms').AsFloat*aIndiceDespAcess;
                          VL_BC_ICMS_ST    := QItem.FieldByName('val_base_icms_sub').AsFloat;
                          ALIQ_ST          := QItem.FieldByName('aliq_icm_st').AsFloat;
                          VL_ICMS_ST       := QItem.FieldByName('val_icms_sub').AsFloat;
                          IND_APUR         := iaMensal;
                          aSitTribIPI      := '99';
                          if QItem.FieldByName('CST_IPI').AsString <> '' then
                             aSitTribIPI := QItem.FieldByName('CST_IPI').AsString;
                          CST_IPI          := aSitTribIPI;
                          COD_ENQ          := '';
                          VL_BC_IPI        := QItem.FieldByName('val_base_ipi').AsFloat;
                          ALIQ_IPI         := QItem.FieldByName('aliq_ipi').AsFloat;
                          VL_IPI           := QItem.FieldByName('val_ipi').AsFloat;
                          aSitTribPis      := '49';
                          if QItem.FieldByName('CST_PIS').AsString <> '' then
                             aSitTribPis := QItem.FieldByName('CST_PIS').AsString;
                          CST_PIS := aSitTribPis;
                          VL_BC_PIS        := QItem.FieldByName('val_base_pis').AsFloat;
                          ALIQ_PIS_PERC    := QItem.FieldByName('aliq_pis').AsFloat;
                          QUANT_BC_PIS     := 0;
                          ALIQ_PIS_R       := 0;
                          VL_PIS           := QItem.FieldByName('val_pis').AsFloat;
                          aSitTribCofins      := '49';
                          if QItem.FieldByName('CST_COFINS').AsString <> '' then
                             aSitTribCofins := QItem.FieldByName('CST_COFINS').AsString;
                          CST_COFINS := aSitTribCofins;
                          VL_BC_COFINS     := QItem.FieldByName('val_base_cofins').AsFloat;
                          ALIQ_COFINS_PERC := QItem.FieldByName('aliq_cofins').AsFloat;
                          QUANT_BC_COFINS  := 0;
                          ALIQ_COFINS_R    := 0;
                          VL_COFINS        := QItem.FieldByName('val_cofins').AsFloat;
                          COD_CTA          := '';
                        end; //Fim dos Itens;
                        QItem.Next;
                     end;
                   end;
                   //c190
                   QTrib.Close;
                   QTrib.Params.ParamByName('pCD_Saida').AsInteger := QNota.FieldByName('ID').AsInteger;
                   QTrib.Open;
                   while not QTrib.Eof do
                   begin
                     with RegistroC190New do
                     begin
                        // calcula valor operacao
                        AuxValor := QTrib.FieldByName('total_produto').AsFloat;
                        AuxValor := AuxValor + QTrib.FieldByName('val_icms_sub').AsFloat;
                        if AuxFrete > 0 then
                        begin
                          AuxValor := AuxValor + AuxFrete;
                          AuxFrete := 0;
                        end;
                        if AuxSeguro > 0 then
                        begin
                          AuxValor := AuxValor + AuxSeguro;
                          AuxSeguro := 0;
                        end;
                        if AuxDespesas > 0 then
                        begin
                          AuxValor := AuxValor + AuxDespesas;
                          AuxDespesas := 0;
                        end;
                        //
                        // c190
                        CST_ICMS := QTrib.FieldByName('cst').AsString;
                        CFOP     := QTrib.FieldByName('cfop').AsString;
                        VL_OPR   := AuxValor*aIndiceDespAcess;
                        if aModeloNFe <> '65' then
                        begin
                          ALIQ_ICMS     := QTrib.FieldByName('aliq_icms').AsFloat;
                          VL_BC_ICMS    := QTrib.FieldByName('val_base_icms').AsFloat*aIndiceDespAcess;
                          VL_ICMS       := QTrib.FieldByName('val_icms').AsFloat*aIndiceDespAcess;
                          VL_BC_ICMS_ST := QTrib.FieldByName('val_base_icms_sub').AsFloat;
                          VL_ICMS_ST    := QTrib.FieldByName('val_icms_sub').AsFloat;
                          VL_RED_BC     := 0;
                          VL_IPI        := QTrib.FieldByName('val_ipi').AsFloat;
                          // soma ao total de debitos
                          if (copy(QTrib.FieldByName('cst').AsString,2,2) = '00') or
                             (copy(QTrib.FieldByName('cst').AsString,2,2) = '10') or
                             (copy(QTrib.FieldByName('cst').AsString,2,2) = '20') or
                             (copy(QTrib.FieldByName('cst').AsString,2,2) = '70') then
                          begin
                            sDebitos := sDebitos + QTrib.FieldByName('val_icms').AsFloat*aIndiceDespAcess;
                          end;
                          // soma ao total de debitos ST
                          if (copy(QTrib.FieldByName('cst').AsString,2,2) = '10') or
                             (copy(QTrib.FieldByName('cst').AsString,2,2) = '30') or
                             (copy(QTrib.FieldByName('cst').AsString,2,2) = '60') or
                             (copy(QTrib.FieldByName('cst').AsString,2,2) = '70') then
                          begin
                            sDebitosST := sDebitosST + QTrib.FieldByName('val_icms_sub').AsFloat;
                            aUF := RetornaUFCliFor(QNota.FieldByname('idcliente').AsInteger,1);
                            InsereRegistroUFST(CdsUFST,aUF,0,QTrib.FieldByName('val_icms_sub').AsFloat);
                          end;
                        end
                        else
                        begin
                          ALIQ_ICMS     := 0;
                          VL_BC_ICMS    := 0;
                          VL_ICMS       := 0;
                          VL_BC_ICMS_ST := 0;
                          VL_ICMS_ST    := 0;
                          VL_RED_BC     := 0;
                          VL_IPI        := 0;
                        end;
                        COD_OBS       := '';
                     end;
                     QTrib.Next;
                   end;
                 end;
               end;
             end;
             Inc(aRegAtual);
             sProgressBar1.Position := aRegAtual;
             Application.ProcessMessages;
             //
             QNota.Next;
           end;

           //
           if pPerfil = 1 then // B
           begin
             // Notas manuais
             // registros C300
             Q300.Close;
             Q300.SQL.Clear;
             Q300.SQL.Add('select r.modelo,r.serie,r.data_emissao,');
             Q300.SQL.Add('       sum(r.total) as total,');
             Q300.SQL.Add('       sum(r.valor_pis) as valor_pis,');
             Q300.SQL.Add('       sum(r.valor_cofins) as valor_cofins');
             Q300.SQL.Add('from registro61 r');
             Q300.SQL.Add('where r.data_emissao between :pDatai and :pDataf');
             Q300.SQL.Add('and r.idempresa = :pIDEmpresa');
             Q300.SQL.Add('group by r.modelo,r.serie,r.data_emissao');
             // registros C310
             Q310.Close;
             Q310.SQL.Clear;
             Q310.SQL.Add('select r.num_ordem from registro61 r');
             Q310.SQL.Add('where 1 < 0');
             // registros C320
             Q320.Close;
             Q320.SQL.Clear;
             Q320.SQL.Add('select r.cst,r.cfop,r.aliq_icms,');
             Q320.SQL.Add('       sum(r.total) as total,');
             Q320.SQL.Add('       sum(r.base_icms) as base_icms,');
             Q320.SQL.Add('       sum(r.valor_icms) as valor_icms,');
             Q320.SQL.Add('       sum(r.total - r.base_icms) as Red_Base');
             Q320.SQL.Add('from registro61 r');
             Q320.SQL.Add('where r.data_emissao = :pData');
             Q320.SQL.Add('and r.idempresa = :pIDEmpresa');
             Q320.SQL.Add('group by r.cst,r.cfop,r.aliq_icms');
             // registros C321
             Q321.Close;
             Q321.SQL.Clear;
             Q321.SQL.Add('select r.idproduto,r.quantidade,p.unidade,');
             Q321.SQL.Add('       r.valor,r.base_icms,r.valor_icms,');
             Q321.SQL.Add('       r.valor_pis,r.valor_cofins');
             Q321.SQL.Add('from registro61 r');
             Q321.SQL.Add('left outer join produtos p on r.idproduto = p.id');
             Q321.SQL.Add('where r.data_emissao = :pData');
             Q321.SQL.Add('and r.idempresa = :pIDEmpresa');
             // inicia o processo
             Q300.Close;
             Q300.Params.ParamByName('pDatai').AsDate := Datai;
             Q300.Params.ParamByName('pDataf').AsDate := Dataf;
             Q300.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
             Q300.Open;
             while not Q300.eof do
             begin
               RetornaNumOrdem(aPriNum,aUltNum,Q300.FieldByName('data_emissao').AsDateTime);
               with RegistroC300New do
               begin
                 COD_MOD     := Q300.FieldByName('modelo').AsString;
                 SER         := Q300.FieldByName('serie').AsString;
                 SUB         := '';
                 NUM_DOC_INI := aPriNum;
                 NUM_DOC_FIN := aUltNum;
                 DT_DOC      := Q300.FieldByName('data_emissao').AsDateTime;
                 VL_DOC      := Q300.FieldByName('total').AsFloat;
                 VL_PIS      := Q300.FieldByName('valor_pis').AsFloat;
                 VL_COFINS   := Q300.FieldByName('valor_cofins').AsFloat;
                 COD_CTA     := '';
                 // registro C310
                 Q310.Close;
                 Q310.Open;
                 while not Q310.Eof do
                 begin
                   with RegistroC310New do
                   begin
                     NUM_DOC_CANC := '';
                   end;
                   Q310.Next;
                 end;
                 // registro C320
                 Q320.Close;
                 Q320.Params.ParamByName('pData').AsDate         := Q300.FieldByName('data_emissao').AsDateTime;
                 Q320.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
                 Q320.Open;
                 while not Q320.Eof do
                 begin
                   with RegistroC320New do
                   begin
                     CST_ICMS   := Q320.FieldByName('cst').AsString;
                     CFOP       := Q320.FieldByName('cfop').AsString;
                     ALIQ_ICMS  := Q320.FieldByName('aliq_icms').AsFloat;
                     VL_OPR     := Q320.FieldByName('total').AsFloat;
                     VL_BC_ICMS := Q320.FieldByName('base_icms').AsFloat;
                     VL_ICMS    := Q320.FieldByName('valor_icms').AsFloat;
                     VL_RED_BC  := Q320.FieldByName('red_base').AsFloat;
                     COD_OBS    := '';
                     // registro C321
                     Q321.Close;
                     Q321.Params.ParamByName('pData').AsDate         := Q300.FieldByName('data_emissao').AsDateTime;
                     Q321.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
                     Q321.Open;
                     while not Q321.Eof do
                     begin
                       with RegistroC321New do
                       begin
                         COD_ITEM   := Q321.FieldByName('idproduto').AsString;
                         QTD        := Q321.FieldByName('quantidade').AsFloat;
                         UNID       := Q321.FieldByName('unidade').AsString;
                         VL_ITEM    := Q321.FieldByName('valor').AsFloat;
                         VL_DESC    := 0;
                         VL_BC_ICMS := Q321.FieldByName('base_icms').AsFloat;
                         VL_ICMS    := Q321.FieldByName('valor_icms').AsFloat;
                         VL_PIS     := Q321.FieldByName('valor_pis').AsFloat;
                         VL_COFINS  := Q321.FieldByName('valor_cofins').AsFloat;
                       end;
                       Q321.Next;
                     end;
                   end;
                   Q320.Next;
                 end;
               end;
               Q300.Next;
             end;
           end;
           //
           if pPerfil = 0 then // A
           begin
             // Notas Manuais
             // registros C350
             Q350.Close;
             Q350.SQL.Clear;
             Q350.SQL.Add('select r.serie,r.num_ordem,r.data_emissao,c.cnpj_cpf,');
             Q350.SQL.Add('       sum(r.total) as total,');
             Q350.SQL.Add('       sum(r.valor_pis) as valor_pis,');
             Q350.SQL.Add('       sum(r.valor_cofins) as valor_cofins');
             Q350.SQL.Add('from registro61 r');
             Q350.SQL.Add('left outer join contato c on r.id_cliente = c.id');
             Q350.SQL.Add('where r.data_emissao between :pDatai and :pDataf');
             Q350.SQL.Add('and r.idempresa = :pIDEmpresa');
             Q350.SQL.Add('group by r.serie,r.num_ordem,r.data_emissao,c.cnpj_cpf');
             // registros C370
             Q370.Close;
             Q370.SQL.Clear;
             Q370.SQL.Add('select r.idproduto,r.quantidade,p.unidade,r.valor');
             Q370.SQL.Add('from registro61 r');
             Q370.SQL.Add('left outer join produtos p on r.idproduto = p.id');
             Q370.SQL.Add('where r.num_ordem = :numordem');
             // registros C390
             Q390.Close;
             Q390.SQL.Clear;
             Q390.SQL.Add('select r.cst,r.cfop,r.aliq_icms,');
             Q390.SQL.Add('       sum(r.total) as total,');
             Q390.SQL.Add('       sum(r.base_icms) as base_icms,');
             Q390.SQL.Add('       sum(r.valor_icms) as valor_icms,');
             Q390.SQL.Add('       sum(r.total - r.base_icms) as Red_Base');
             Q390.SQL.Add('from registro61 r');
             Q390.SQL.Add('where r.data_emissao between :pDatai and :pDataf');
             Q390.SQL.Add('and r.idempresa = :pIDEmpresa');
             Q390.SQL.Add('group by r.cst,r.cfop,r.aliq_icms');
             //
             Q350.Close;
             Q350.Params.ParamByName('pDatai').AsDate := Datai;
             Q350.Params.ParamByName('pDataf').AsDate := Dataf;
             Q350.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
             Q350.Open;
             while not Q350.Eof do
             begin
               CdsRegistroC490.EmptyDataSet;
               with RegistroC350New do
               begin
                 SER        := Q350.FieldByName('serie').AsString;
                 SUB_SER    := '';
                 NUM_DOC    := Q350.FieldByName('num_ordem').AsString;
                 DT_DOC     := Q350.FieldByName('data_emissao').AsDateTime;
                 CNPJ_CPF   := Q350.FieldByName('cnpj_cpf').AsString;
                 VL_MERC    := Q350.FieldByName('total').AsFloat;
                 VL_DOC     := Q350.FieldByName('total').AsFloat;
                 VL_DESC    := 0;
                 VL_PIS     := Q350.FieldByName('valor_pis').AsFloat;
                 VL_COFINS  := Q350.FieldByName('valor_cofins').AsFloat;
                 COD_CTA    := '';
                 // registro C370
                 Q370.Close;
                 Q370.Params.ParamByName('numordem').AsString := Q350.FieldByName('num_ordem').AsString;
                 Q370.Open;
                 aNumItem := 0;
                 while not Q370.Eof do
                 begin
                   Inc(aNumItem);
                   with RegistroC370New do
                   begin
                     NUM_ITEM  := IntToStr(aNumItem);
                     COD_ITEM  := Q370.FieldByName('idproduto').AsString;
                     QTD       := Q370.FieldByName('quantidade').AsFloat;
                     UNID      := Q370.FieldByName('unidade').AsString;
                     VL_ITEM   := Q370.FieldByName('valor').AsFloat;
                     VL_DESC   := 0;
                   end;
                   Q370.Next;
                 end;
                 // registro C370
                 Q390.Close;
                 Q390.Params.ParamByName('pDatai').AsDate := Datai;
                 Q390.Params.ParamByName('pDataf').AsDate := Dataf;
                 Q390.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
                 Q390.Open;
                 while not Q390.Eof do
                 begin
                   with RegistroC390New do
                   begin
                     CST_ICMS   := Q390.FieldByName('cst').AsString;
                     CFOP       := Q390.FieldByName('cfop').AsString;
                     ALIQ_ICMS  := Q390.FieldByName('aliq_icms').AsFloat;
                     VL_OPR     := Q390.FieldByName('total').AsFloat;
                     VL_BC_ICMS := Q390.FieldByName('base_icms').AsFloat;
                     VL_ICMS    := Q390.FieldByName('valor_icms').AsFloat;
                     VL_RED_BC  := Q390.FieldByName('Red_Base').AsFloat;
                     COD_OBS    := '';
                   end;
                   //
                   if (copy(Q390.FieldByName('cst').AsString,2,2) = '00') or
                      (copy(Q390.FieldByName('cst').AsString,2,2) = '10') or
                      (copy(Q390.FieldByName('cst').AsString,2,2) = '20') or
                      (copy(Q390.FieldByName('cst').AsString,2,2) = '70') then
                   begin
                     sDebitos := sDebitos + Q390.FieldByName('valor_icms').AsFloat;
                   end;
                   Q390.Next;
                 end;
               end;
               Q350.Next;
             end;


             // Notas Manuais com cupom
             // registros C350
             Q350.Close;
             Q350.SQL.Clear;
             Q350.SQL.Add('select p.id,p.numero_doc,p.data_entrega,p.cnpjcpf,');
             Q350.SQL.Add('       sum(p.valor_total) as total,');
             Q350.SQL.Add('       sum(p.valor_pis) as valor_pis,');
             Q350.SQL.Add('       sum(p.valor_cofins) as valor_cofins');
             Q350.SQL.Add('from pedido p');
             Q350.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
             Q350.SQL.Add('and p.idempresa = :pIDEmpresa');
             Q350.SQL.Add('and (p.numero_doc is not null or p.numero_doc <> '+QuotedStr('')+')');
             Q350.SQL.Add('and p.modelo = '+QuotedStr('2D'));
             Q350.SQL.Add('and p.notamanual = '+QuotedStr('S'));
             Q350.SQL.Add('group by p.id,p.numero_doc,p.data_entrega,p.cnpjcpf');
             // registros C370
             Q370.Close;
             Q370.SQL.Clear;
             Q370.SQL.Add('select i.idproduto,i.quantidade,p.unidade,i.valor_total');
             Q370.SQL.Add('from pedido_itens i');
             Q370.SQL.Add('left outer join produtos p on i.idproduto = p.id');
             Q370.SQL.Add('where i.idpedido = :pID');
             // registros C390
             Q390.Close;
             Q390.SQL.Clear;
             Q390.SQL.Add('select i.cst,i.aliq_icms,');
             Q390.SQL.Add('       sum(i.valor_total) as total,');
             Q390.SQL.Add('       sum(i.base_icms) as base_icms,');
             Q390.SQL.Add('       sum(i.valor_icms) as valor_icms,');
             Q390.SQL.Add('       sum(i.reducao_base) as Red_Base');
             Q390.SQL.Add('from pedido p');
             Q390.SQL.Add('inner join pedido_itens i on p.id = i.idpedido');
             Q390.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
             Q390.SQL.Add('and p.idempresa = :pempresa');
             Q390.SQL.Add('and (p.numero_doc is not null or p.numero_doc <> '+QuotedStr('')+')');
             Q390.SQL.Add('and p.modelo = '+QuotedStr('2D'));
             Q390.SQL.Add('and p.notamanual = '+QuotedStr('S'));
             Q390.SQL.Add('group by i.cst,i.aliq_icms');
             //
             Q350.Close;
             Q350.Params.ParamByName('pDatai').AsDate := Datai;
             Q350.Params.ParamByName('pDataf').AsDate := Dataf;
             Q350.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
             Q350.Open;
             while not Q350.Eof do
             begin
               CdsRegistroC490.EmptyDataSet;
               with RegistroC350New do
               begin
                 SER        := 'D';
                 SUB_SER    := '';
                 NUM_DOC    := Q350.FieldByName('numero_doc').AsString;
                 DT_DOC     := Q350.FieldByName('data_entrega').AsDateTime;
                 if (Trim(Q350.FieldByName('cnpjcpf').AsString) <> '') and
                    (Trim(Q350.FieldByName('cnpjcpf').AsString) <> '11111111111') then
                 begin
                   CNPJ_CPF := Q350.FieldByName('cnpjcpf').AsString
                 end
                 else
                 begin
                   CNPJ_CPF := '';
                 end;
                 VL_MERC    := Q350.FieldByName('total').AsFloat;
                 VL_DOC     := Q350.FieldByName('total').AsFloat;
                 VL_DESC    := 0;
                 VL_PIS     := Q350.FieldByName('valor_pis').AsFloat;
                 VL_COFINS  := Q350.FieldByName('valor_cofins').AsFloat;
                 COD_CTA    := '';
                 // registro C370
                 Q370.Close;
                 Q370.Params.ParamByName('pID').AsInteger := Q350.FieldByName('id').AsInteger;
                 Q370.Open;
                 aNumItem := 0;
                 while not Q370.Eof do
                 begin
                   Inc(aNumItem);
                   with RegistroC370New do
                   begin
                     NUM_ITEM  := IntToStr(aNumItem);
                     COD_ITEM  := Q370.FieldByName('idproduto').AsString;
                     QTD       := Q370.FieldByName('quantidade').AsFloat;
                     UNID      := Q370.FieldByName('unidade').AsString;
                     VL_ITEM   := Q370.FieldByName('valor_total').AsFloat;
                     VL_DESC   := 0;
                   end;
                   Q370.Next;
                 end;
                 // registro C370
                 Q390.Close;
                 Q390.Params.ParamByName('pDatai').AsDate := Datai;
                 Q390.Params.ParamByName('pDataf').AsDate := Dataf;
                 Q390.Params.ParamByName('pempresa').AsInteger := sIDEmpresa;
                 Q390.Open;
                 while not Q390.Eof do
                 begin
                   with RegistroC390New do
                   begin
                     CST_ICMS   := Q390.FieldByName('cst').AsString;
                     CFOP       := '5929';
                     ALIQ_ICMS  := Q390.FieldByName('aliq_icms').AsFloat;
                     VL_OPR     := Q390.FieldByName('total').AsFloat;
                     VL_BC_ICMS := 0;
                     VL_ICMS    := 0;
                     VL_RED_BC  := 0;
  //                   VL_BC_ICMS := Q390.FieldByName('base_icms').AsFloat;
  //                   VL_ICMS    := Q390.FieldByName('valor_icms').AsFloat;
  //                   VL_RED_BC  := Q390.FieldByName('Red_Base').AsFloat;
                     COD_OBS    := '';
                   end;
                   //
  //                 if (copy(Q390.FieldByName('cst').AsString,2,2) = '00') or
  //                    (copy(Q390.FieldByName('cst').AsString,2,2) = '10') or
  //                    (copy(Q390.FieldByName('cst').AsString,2,2) = '20') or
  //                    (copy(Q390.FieldByName('cst').AsString,2,2) = '70') then
  //                 begin
  //                   sDebitos := sDebitos + Q390.FieldByName('valor_icms').AsFloat;
  //                 end;
                   Q390.Next;
                 end;
               end;
               Q350.Next;
             end;
  {
             // Notas Manuais com cupom
             // registros C350
             Q350.Close;
             Q350.SQL.Clear;
             Q350.SQL.Add('select p.id,p.numero_doc,p.data_entrega,p.cnpjcpf,');
             Q350.SQL.Add('       sum(p.valor_total) as total,');
             Q350.SQL.Add('       sum(p.valor_pis) as valor_pis,');
             Q350.SQL.Add('       sum(p.valor_cofins) as valor_cofins');
             Q350.SQL.Add('from pedido p');
             Q350.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
             Q350.SQL.Add('and p.idempresa = :pempresa');
             Q350.SQL.Add('and (p.numero_doc is not null or p.numero_doc <> '+QuotedStr('')+')');
             Q350.SQL.Add('and p.modelo = '+QuotedStr('65'));
             Q350.SQL.Add('and p.status_nfe = '+QuotedStr('100'));
             Q350.SQL.Add('and p.cancelado = '+QuotedStr('N'));
             Q350.SQL.Add('group by p.id,p.numero_doc,p.data_entrega,p.cnpjcpf');
             // registros C370
             Q370.Close;
             Q370.SQL.Clear;
             Q370.SQL.Add('select i.idproduto,i.quantidade,p.unidade,i.valor_total');
             Q370.SQL.Add('from pedido_itens i');
             Q370.SQL.Add('left outer join produtos p on i.idproduto = p.id');
             Q370.SQL.Add('where i.idpedido = :pID');
             // registros C390
             Q390.Close;
             Q390.SQL.Clear;
             Q390.SQL.Add('select i.cst,i.aliq_icms,');
             Q390.SQL.Add('       sum(i.valor_total) as total,');
             Q390.SQL.Add('       sum(i.base_icms) as base_icms,');
             Q390.SQL.Add('       sum(i.valor_icms) as valor_icms,');
             Q390.SQL.Add('       sum(i.reducao_base) as Red_Base');
             Q390.SQL.Add('from pedido p');
             Q390.SQL.Add('inner join pedido_itens i on p.id = i.idpedido');
             Q390.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
             Q390.SQL.Add('and p.idempresa = :pempresa');
             Q390.SQL.Add('and (p.numero_doc is not null or p.numero_doc <> '+QuotedStr('')+')');
             Q390.SQL.Add('and p.modelo = '+QuotedStr('2D'));
             Q390.SQL.Add('and p.notamanual = '+QuotedStr('S'));
             Q390.SQL.Add('group by i.cst,i.aliq_icms');
             //
             Q350.Close;
             Q350.Params.ParamByName('pDatai').AsDate := Datai;
             Q350.Params.ParamByName('pDataf').AsDate := Dataf;
             Q350.Params.ParamByName('pempresa').AsInteger := sIDEmpresa;
             Q350.Open;
             while not Q350.Eof do
             begin
               CdsRegistroC490.EmptyDataSet;
               with RegistroC350New do
               begin
                 SER        := 'D';
                 SUB_SER    := '';
                 NUM_DOC    := Q350.FieldByName('numero_doc').AsString;
                 DT_DOC     := Q350.FieldByName('data_entrega').AsDateTime;
                 if (Trim(Q350.FieldByName('cnpjcpf').AsString) <> '') and
                    (Trim(Q350.FieldByName('cnpjcpf').AsString) <> '11111111111') then
                 begin
                   CNPJ_CPF := Q350.FieldByName('cnpjcpf').AsString
                 end
                 else
                 begin
                   CNPJ_CPF := '';
                 end;
                 VL_MERC    := Q350.FieldByName('total').AsFloat;
                 VL_DOC     := Q350.FieldByName('total').AsFloat;
                 VL_DESC    := 0;
                 VL_PIS     := Q350.FieldByName('valor_pis').AsFloat;
                 VL_COFINS  := Q350.FieldByName('valor_cofins').AsFloat;
                 COD_CTA    := '';
                 // registro C370
                 Q370.Close;
                 Q370.Params.ParamByName('pID').AsInteger := Q350.FieldByName('id').AsInteger;
                 Q370.Open;
                 aNumItem := 0;
                 while not Q370.Eof do
                 begin
                   Inc(aNumItem);
                   with RegistroC370New do
                   begin
                     NUM_ITEM  := IntToStr(aNumItem);
                     COD_ITEM  := Q370.FieldByName('idproduto').AsString;
                     QTD       := Q370.FieldByName('quantidade').AsFloat;
                     UNID      := Q370.FieldByName('unidade').AsString;
                     VL_ITEM   := Q370.FieldByName('valor_total').AsFloat;
                     VL_DESC   := 0;
                   end;
                   Q370.Next;
                 end;
                 // registro C370
                 Q390.Close;
                 Q390.Params.ParamByName('pDatai').AsDate := Datai;
                 Q390.Params.ParamByName('pDataf').AsDate := Dataf;
                 Q390.Params.ParamByName('pempresa').AsInteger := sIDEmpresa;
                 Q390.Open;
                 while not Q390.Eof do
                 begin
                   with RegistroC390New do
                   begin
                     CST_ICMS   := Q390.FieldByName('cst').AsString;
                     CFOP       := '5929';
                     ALIQ_ICMS  := Q390.FieldByName('aliq_icms').AsFloat;
                     VL_OPR     := Q390.FieldByName('total').AsFloat;
                     VL_BC_ICMS := 0;
                     VL_ICMS    := 0;
                     VL_RED_BC  := 0;
  //                   VL_BC_ICMS := Q390.FieldByName('base_icms').AsFloat;
  //                   VL_ICMS    := Q390.FieldByName('valor_icms').AsFloat;
  //                   VL_RED_BC  := Q390.FieldByName('Red_Base').AsFloat;
                     COD_OBS    := '';
                   end;
                   //
  //                 if (copy(Q390.FieldByName('cst').AsString,2,2) = '00') or
  //                    (copy(Q390.FieldByName('cst').AsString,2,2) = '10') or
  //                    (copy(Q390.FieldByName('cst').AsString,2,2) = '20') or
  //                    (copy(Q390.FieldByName('cst').AsString,2,2) = '70') then
  //                 begin
  //                   sDebitos := sDebitos + Q390.FieldByName('valor_icms').AsFloat;
  //                 end;
                   Q390.Next;
                 end;
               end;
               Q350.Next;
             end;

  }

           end;
           // registro C400
           Q400.Close;
           Q400.SQL.Clear;
           Q400.SQL.Add('select registro60m.seriaecf,registro60m.caixa from registro60m');
           Q400.SQL.Add('where registro60m.data_movimento between :pDatai and :pDataf');
           Q400.SQL.Add('and registro60m.idempresa = :pEmpresa');
           Q400.SQL.Add('group by registro60m.seriaecf,registro60m.caixa');
           // SQL Registro C405
           Q405.Close;
           Q405.SQL.Clear;
           Q405.SQL.Add('select registro60m.id,registro60m.data_movimento,');
           Q405.SQL.Add('registro60m.coo_final,registro60m.contador_reducao,');
           Q405.SQL.Add('registro60m.venda_bruta,registro60m.contador_reinicio,');
           Q405.SQL.Add('registro60m.grande_total,registro60m.coo_inicial from registro60m');
           Q405.SQL.Add('where registro60m.seriaecf = :pSerial');
           Q405.SQL.Add('and registro60m.data_movimento between :pDatai and :pDataf');
           Q405.SQL.Add('and registro60m.idempresa = :pEmpresa');
           Q405.SQL.Add('group by registro60m.id,registro60m.data_movimento,');
           Q405.SQL.Add('registro60m.coo_final,registro60m.contador_reducao,');
           Q405.SQL.Add('registro60m.venda_bruta,registro60m.contador_reinicio,');
           Q405.SQL.Add('registro60m.grande_total,registro60m.coo_inicial');
           // SQL Registro C420
           Q420.Close;
           Q420.SQL.Clear;
           Q420.SQL.Add('select registro60a.aliquota_trib,registro60a.totalizador from registro60m');
           Q420.SQL.Add('left outer join registro60a on registro60m.id = registro60a.id_reg60m');
           Q420.SQL.Add('where registro60m.id = :pCodigo');
           // SQL Registro C425
           Q425.Close;
           Q425.SQL.Clear;
           Q425.SQL.Add('select i.idproduto,i.unidade,');
           Q425.SQL.Add('sum(i.quantidade) as quantidade,');
           Q425.SQL.Add('sum(i.valor_total) as valor_total,');
           Q425.SQL.Add('sum(i.valor_pis) as valor_pis,');
           Q425.SQL.Add('sum(i.valor_cofins) as valor_cofins from pedido p');
           Q425.SQL.Add('inner join pedido_itens i on i.idpedido = p.id');
           Q425.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
           Q425.SQL.Add('and p.cancelado = '+QuotedStr('N'));
           Q425.SQL.Add('and p.coo > 0');
           Q425.SQL.Add('and p.idempresa = :pEmpresa');
           Q425.SQL.Add('and i.cancelado = '+QuotedStr('N'));
           Q425.SQL.Add('and i.cst = :pCST');
           Q425.SQL.Add('and i.aliq_icms = :pAliq');
           Q425.SQL.Add('group by i.idproduto,i.unidade');
           // SQL Registro C460
           Q460.Close;
           Q460.SQL.Clear;
           Q460.SQL.Add('select p.coo,p.data_entrega,p.valor_total,');
           Q460.SQL.Add('p.valor_pis,p.valor_cofins,p.cnpjcpf,p.cancelado,');
           Q460.SQL.Add('p.cliente,p.id,p.desconto,p.acrescimo from pedido p');
           Q460.SQL.Add('where p.coo = :pCupom');
//           Q460.SQL.Add('and p.cancelado = '+QuotedStr('N'));
           Q460.SQL.Add('and p.ccf > 0');
           // SQL Registro C470
           Q470.Close;
           Q470.SQL.Clear;
           Q470.SQL.Add('select i.idproduto,i.quantidade,p.unidade,i.valor,');
           Q470.SQL.Add('i.valor_total,i.desconto,i.aliq_icms,i.aliq_icms_st,');
           Q470.SQL.Add('i.valor_pis,i.valor_cofins,i.cfop,');
           Q470.SQL.Add('i.cst from pedido_itens i');
           Q470.SQL.Add('inner join produtos p on p.id = i.idproduto');
           Q470.SQL.Add('where i.idpedido = :pCodigo');
           Q470.SQL.Add('and i.cancelado = '+QuotedStr('N'));
           // SQL Registro C490
           Q490.close;
           Q490.SQL.Clear;
           Q490.SQL.Add('select registro60a.aliquota_trib,registro60a.totalizador from registro60a');
           Q490.SQL.Add('where registro60a.id_reg60m = :pCodigo');
           Q490.SQL.Add('group by registro60a.aliquota_trib,registro60a.totalizador');
           // repassa dados para o compoente
           Q400.Params.ParamByName('pDatai').AsDate      := Datai;
           Q400.Params.ParamByName('pDataf').AsDate      := Dataf;
           Q400.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
           Q400.Open;
           while not Q400.Eof do
           begin
             with RegistroC400New do
             begin
               COD_MOD := '2D';
               ECF_MOD := 'ECF';
               ECF_FAB := Q400.FieldByName('seriaecf').AsString;
               ECF_CX  := Q400.FieldByName('caixa').AsString;
               // registro C405
               Q405.Close;
               Q405.Params.ParamByName('pSerial').AsString   := Q400.FieldByname('seriaecf').AsString;
               Q405.Params.ParamByName('pDatai').AsDate      := Datai;
               Q405.Params.ParamByName('pDataf').AsDate      := Dataf;
               Q405.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Q405.Open;
               aNumReg := RetornaQtdRegDBX(Q405);
               sLbMensagem.Caption := 'Registros do ECF';
               sProgressBar1.Max := aNumReg;
               Application.ProcessMessages;
               aRegAtual := 0;
               while not Q405.Eof do
               begin
                 if Q405.FieldByName('venda_bruta').AsFloat > 0 then
                 begin
                   CdsRegistroC490.EmptyDataSet;
                   with RegistroC405New do
                   begin
                     DT_DOC      := Q405.FieldByName('data_movimento').AsDateTime;
                     CRO         := Q405.FieldByName('contador_reinicio').AsInteger;
                     CRZ         := Q405.FieldByName('contador_reducao').AsInteger;
                     NUM_COO_FIN := Q405.FieldByName('coo_final').AsInteger;
                     GT_FIN      := Q405.FieldByName('grande_total').AsFloat;
                     VL_BRT      := Q405.FieldByName('venda_bruta').AsFloat;
                     // registro C420
                     Q420.Close;
                     Q420.Params.ParamByName('pCodigo').AsInteger := Q405.FieldByName('id').AsInteger;
                     Q420.Open;
                     aContador := 1;
                     AuxInt := 1;
                     while not Q420.Eof do
                     begin
                       aControle := false;
                       if Q420.FieldByName('totalizador').AsFloat > 0 then
                       begin
                         AuxStr := '';
                         aCST   := '';
                         aICMS  := 0;
                         if (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'F') or
                            (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'FF') then
                         begin
                           AuxStr := AuxStr + 'F' + IntToStr(aContador);
                           aCST   := '060';
                           Inc(aContador);
                         end
                         else if (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'I') or
                                 (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'II') then
                         begin
                           AuxStr := AuxStr + 'I' + IntToStr(aContador);
                           aCST   := '040';
                           Inc(aContador);
                         end
                         else if (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'N') or
                                 (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'NN') then
                         begin
                           AuxStr := AuxStr + 'N' + IntToStr(aContador);
                           aCST   := '041';
                           Inc(aContador);
                         end
                         else if (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'FS') then
                         begin
                           AuxStr := AuxStr + 'FS' + IntToStr(aContador);
                           aCST   := '060';
                           Inc(aContador);
                         end
                         else if (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'NS') then
                         begin
                           AuxStr := AuxStr + 'NS' + IntToStr(aContador);
                           aCST   := '041';
                           Inc(aContador);
                         end
                         else if (UpperCase(Trim(Q420.FieldByName('aliquota_trib').AsString)) = 'IS') then
                         begin
                           AuxStr := AuxStr + 'IS' + IntToStr(aContador);
                           aCST   := '040';
                           Inc(aContador);
                         end
                         else if (UpperCase(Q420.FieldByName('aliquota_trib').AsString) = 'DESC') then
                            AuxStr := AuxStr + 'DT'
                         else if (UpperCase(Q420.FieldByName('aliquota_trib').AsString) = 'ACRE') then
                            AuxStr := AuxStr + 'AT'
                         else if (UpperCase(Q420.FieldByName('aliquota_trib').AsString) = 'AT') then
                            AuxStr := AuxStr + 'AT'
                         else if (UpperCase(Q420.FieldByName('aliquota_trib').AsString) = 'CANC') then
                            AuxStr := AuxStr + 'Can-T'
                         else if (UpperCase(Q420.FieldByName('aliquota_trib').AsString) = 'OPNF') then
                            AuxStr := AuxStr + 'OPNF'
                         else
                         begin
                           AuxStr := AuxStr + AlinhaTXT(ZeroEsquerda(IntToStr(AuxInt),2)+'T'+FiltraNumero(Q420.FieldByName('aliquota_trib').AsString),1,7);
                           aControle := true;
                           aCST   := '000';
                           aICMS  := StrToFloat(FiltraNumero(Q420.FieldByName('aliquota_trib').AsString))/100;
                           Inc(AuxInt);
                         end;
                         //
                         with RegistroC420New do
                         begin
                           COD_TOT_PAR  := AuxStr;
                           VLR_ACUM_TOT := Q420.FieldByName('totalizador').AsFloat;
                           //
                           if aControle then
                              NR_TOT := AuxInt-1
                           else
                              NR_TOT := 0;
                           DESCR_NR_TOT := '';
                           // registro C425
                           if pPerfil = 1 then
                           begin
                             Q425.Close;
                             Q425.Params.ParamByName('pDatai').AsDate      := Q405.FieldByName('data_movimento').AsDateTime;
                             Q425.Params.ParamByName('pDataf').AsDate      := Q405.FieldByName('data_movimento').AsDateTime;
                             Q425.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
                             Q425.Params.ParamByName('pCST').AsString      := aCST;
                             Q425.Params.ParamByName('pAliq').AsFloat      := aICMS;
                             Q425.Open;
                             while not Q425.Eof do
                             begin
                               with RegistroC425New do
                               begin
                                 COD_ITEM  := IntToStr(Q425.FieldByName('idproduto').AsInteger);
                                 QTD       := Q425.FieldByName('quantidade').AsFloat;
                                 UNID      := Q425.FieldByName('unidade').AsString;
                                 VL_ITEM   := Q425.FieldByName('valor_total').AsFloat;
                                 VL_PIS    := Q425.FieldByName('valor_pis').AsFloat;
                                 VL_COFINS := Q425.FieldByName('valor_cofins').AsFloat;
                               end;
                               Q425.Next;
                             end;
                           end;
                         end;
                       end;
                       Q420.Next;
                     end;
                     // registro C460
                     if pPerfil = 0 then
                     begin
                       aDescCupom  := 0;
                       aAcresCupom := 0;
                       for i:=Q405.FieldByName('coo_inicial').AsInteger to Q405.FieldByName('coo_final').AsInteger do
                       begin
                         Q460.Close;
                         Q460.Params.ParamByName('pCupom').AsString := IntToStrZero(i,6);
                         Q460.Open;
                         while not Q460.Eof do
                         begin
                           if VerificaItemCupom(Q460.FieldByName('id').AsInteger) then
                           begin
                             with RegistroC460New do
                             begin
                               if Q460.FieldByName('cancelado').AsString <> 'S'  then
                               begin
                                 aDescCupom  := Q460.FieldByName('desconto').AsFloat;
                                 aAcresCupom := Q460.FieldByName('acrescimo').AsFloat;
                                 //
                                 COD_MOD   := '2D';
                                 COD_SIT   := sdRegular;
                                 NUM_DOC   := IntToStrZero(Q460.FieldByName('coo').AsInteger,6);
                                 DT_DOC    := Q460.FieldByName('data_entrega').AsDateTime;
                                 VL_DOC    := Q460.FieldByName('valor_total').AsFloat;
                                 VL_PIS    := Q460.FieldByName('valor_pis').AsFloat;
                                 VL_COFINS := Q460.FieldByName('valor_cofins').AsFloat;
                                 if (Trim(Q460.FieldByName('cnpjcpf').AsString) <> '') and
                                    (Trim(Q460.FieldByName('cnpjcpf').AsString) <> '11111111111') then
                                 begin
                                   CPF_CNPJ  := Q460.FieldByName('cnpjcpf').AsString;
                                   NOM_ADQ   := Q460.FieldByName('cliente').AsString;
                                 end
                                 else
                                 begin
                                   CPF_CNPJ  := '';
                                   NOM_ADQ   := '';
                                 end;
                                 // registro C470
                                 Q470.Close;
                                 Q470.Params.ParamByName('pCodigo').AsInteger := Q460.FieldByName('id').AsInteger;
                                 Q470.Open;
                                 while not Q470.Eof do
                                 begin
                                   if (Q470.FieldByName('aliq_icms').AsFloat > 0) then
                                   begin
                                     aTotalItem := (Q470.FieldByName('valor_total').AsFloat - aDescCupom) + aAcresCupom;
                                     with RegistroC470New do
                                     begin
                                       COD_ITEM  := IntToStr(Q470.FieldByName('idproduto').AsInteger);
                                       QTD       := Q470.FieldByName('quantidade').AsFloat;
                                       QTD_CANC  := 0;
                                       UNID      := Q470.FieldByName('unidade').AsString;
                                       VL_ITEM   := aTotalItem;
                                       // verifica tributação
                                       CST_ICMS  := Q470.FieldByName('cst').AsString;
                                       CFOP      := FiltraNumero(Q470.FieldByName('cfop').AsString);
                                       ALIQ_ICMS := Q470.FieldByName('aliq_icms').AsFloat;
                                       VL_PIS    := Q470.FieldByName('valor_pis').AsFloat;
                                       VL_COFINS := Q470.FieldByName('valor_cofins').AsFloat;
                                     end;
                                     // insere registro C490
                                     if not CdsRegistroC490.Locate('CST;CFOP;ALIQ',VarArrayOf([Q470.FieldByName('cst').AsString,
                                                                                               FiltraNumero(Q470.FieldByName('cfop').AsString),
                                                                                               Q470.FieldByName('aliq_icms').AsFloat]),[]) then
                                     begin
                                       CdsRegistroC490.Append;
                                       CdsRegistroC490.FieldByName('CST').AsString  := Q470.FieldByName('cst').AsString;
                                       CdsRegistroC490.FieldByName('CFOP').AsString := FiltraNumero(Q470.FieldByName('cfop').AsString);
                                       CdsRegistroC490.FieldByName('Aliq').AsFloat  := Q470.FieldByName('aliq_icms').AsFloat;
                                     end
                                     else CdsRegistroC490.Edit;
                                     aValICMS := ((aTotalItem * Q470.FieldByName('aliq_icms').AsFloat) / 100);
                                     CdsRegistroC490.FieldByName('VAL_OPER').AsFloat := CdsRegistroC490.FieldByName('VAL_OPER').AsFloat + aTotalItem;
                                     CdsRegistroC490.FieldByName('Val_Base').AsFloat := CdsRegistroC490.FieldByName('Val_Base').AsFloat + aTotalItem;
                                     CdsRegistroC490.FieldByName('Val_ICMS').AsFloat := CdsRegistroC490.FieldByName('Val_ICMS').AsFloat + aValICMS;
                                     CdsRegistroC490.Post;
                                     //
                                     if (copy(Q470.FieldByName('cst').AsString,2,2) = '00') or
                                        (copy(Q470.FieldByName('cst').AsString,2,2) = '10') or
                                        (copy(Q470.FieldByName('cst').AsString,2,2) = '20') or
                                        (copy(Q470.FieldByName('cst').AsString,2,2) = '70') then
                                     begin
                                       sDebitos := sDebitos + aValICMS;
                                     end;
                                   end;
                                   Q470.Next;
                                 end;
                               end
                               else
                               begin
                                 COD_MOD   := '2D';
                                 COD_SIT   := sdRegular;
                                 NUM_DOC   := IntToStrZero(Q460.FieldByName('coo').AsInteger,6);
                                 DT_DOC    := 0;
                                 VL_DOC    := 0;
                                 VL_PIS    := 0;
                                 VL_COFINS := 0;
                                 CPF_CNPJ  := '';
                                 NOM_ADQ   := '';
                                 CPF_CNPJ  := '';
                                 NOM_ADQ   := '';
                               end;
                             end;
                           end;
                           Q460.Next;
                         end;
                       end;
                     end;
                     // registro 490
                     CdsRegistroC490.First;
                     while not CdsRegistroC490.Eof do
                     begin
                       if CdsRegistroC490.FieldByName('VAL_OPER').AsFloat > 0 then
                       begin
                         with RegistroC490New do
                         begin
                           CST_ICMS   := CdsRegistroC490.FieldByName('CST').AsString;
                           CFOP       := CdsRegistroC490.FieldByName('CFOP').AsString;
                           ALIQ_ICMS  := CdsRegistroC490.FieldByName('ALIQ').AsFloat;
                           VL_OPR     := CdsRegistroC490.FieldByName('VAL_OPER').AsFloat;
                           VL_BC_ICMS := CdsRegistroC490.FieldByName('VAL_BASE').AsFloat;
                           VL_ICMS    := CdsRegistroC490.FieldByName('VAL_ICMS').AsFloat;
                           COD_OBS    := '';
                         end;
                       end;
                       CdsRegistroC490.Next;
                     end;
                     {
                     Q490.Close;
                     Q490.Params.ParamByName('pCodigo').AsInteger := Q405.FieldByName('ID').AsInteger;
                     Q490.Open;
                     while not Q490.Eof do
                     begin
                       if (Q490.FieldByName('TOTALIZADOR').AsFloat > 0) and
                          (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) <> 'CANC') and
                          (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) <> 'DESC') and
                          (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) <> 'ACRES') then
                       begin
                         with RegistroC490New do
                         begin
                           ALIQ_ICMS  := 0;
                           VL_BC_ICMS := 0;
                           VL_ICMS    := 0;
                           if (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'F') or
                              (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'FS') or
                              (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'FF') then
                           begin
                             CST_ICMS   := '060';
                             CFOP       := '5403';
                           end
                           else if (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'I') or
                                   (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'N') or
                                   (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'II') or
                                   (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'NN') or
                                   (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'NS') or
                                   (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) = 'IS') then
                           begin
                             CST_ICMS   := '040';
                             CFOP       := '5403';
                           end
                           else
                           begin
                             if (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) <> 'CANC') and
                                (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) <> 'DESC') and
                                (UpperCase(Trim(Q490.FieldByName('aliquota_trib').AsString)) <> 'ACRES') then
                             begin
                               AuxAliq := (StrToFloat(Q490.FieldByName('aliquota_trib').AsString) / 100);
                               CST_ICMS   := '000';
                               CFOP       := '5102';
                               ALIQ_ICMS  := AuxAliq;
                               VL_BC_ICMS := Q490.FieldByName('TOTALIZADOR').AsFloat;
                               VL_ICMS    := (Q490.FieldByName('TOTALIZADOR').AsFloat*AuxAliq)/100;
                               // soma ao total de debitos
                               sDebitos := sDebitos + ((Q490.FieldByName('totalizador').AsFloat*AuxAliq)/100) ;
                             end;
                           end;
                           VL_OPR     := Q490.FieldByName('TOTALIZADOR').AsFloat;
                           COD_OBS    := '';
                         end;
                       end;
                       Q490.Next;
                     end;
                     }
                   end;
                   Inc(aRegAtual);
                   sProgressBar1.Position := aRegAtual;
                   Application.ProcessMessages;
                 end;
                 Q405.Next;
               end;
             end;
             Q400.Next;
           end;
        end;
      end;
    except
      on E:Exception do ShowMessage(E.Message);
    end;
  finally
    FreeAndNil(QNota);
    FreeAndNil(QItem);
    FreeAndNil(QTrib);
    FreeAndNil(Q300);
    FreeAndNil(Q310);
    FreeAndNil(Q320);
    FreeAndNil(Q321);
    FreeAndNil(Q350);
    FreeAndNil(Q370);
    FreeAndNil(Q390);
    FreeAndNil(Q400);
    FreeAndNil(Q405);
    FreeAndNil(Q420);
    FreeAndNil(Q425);
    FreeAndNil(Q460);
    FreeAndNil(Q470);
    FreeAndNil(Q490);
  end;

end;

procedure TSPED_EFD.DadosBloco_D;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco D.
   with DmAcBr.ACBrSpedFiscal1.Bloco_D do
   begin
      with RegistroD001New do
      begin
        IND_MOV := imSemDados;
      end;
   end;

end;

procedure TSPED_EFD.DadosBloco_E(CdsUFST:TClientDataSet;Datai,Dataf:TDateTime;
  CodRec,CodEmp:String;pTruncado:Boolean;pINDICADOR:Integer);
var Query : TSQLQuery;
    aCredIPI, aDebIPI, aOutrosDebDIPI, aOutrosCredIPI , aSaldoIPI, aSaldo : Double;
    aMesAno : String;
    aRegAtual, aNumReg : Integer;
    Dia, Mes, Ano : Word;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco E.
   with DmAcBr.ACBrSpedFiscal1.Bloco_E do
   begin
      // Abertura do Bloco E
      with RegistroE001New do
      begin
         IND_MOV := imComDados;
         // registro E100
         with RegistroE100New do
         begin
           DT_INI := Datai;
           DT_FIN := Dataf;
         end;
         DecodeDate(Datai,Ano,Mes,Dia);
         aMesAno := IntToStrZero(Mes,2)+IntToStrZero(Ano,4);
         //
         with RegistroE110New do
         begin
            VL_TOT_DEBITOS := sDebitos;
            VL_AJ_DEBITOS := 0;
            VL_TOT_AJ_DEBITOS := 0;
            VL_ESTORNOS_CRED := 0;
            VL_TOT_CREDITOS := sCreditos;
            VL_AJ_CREDITOS := 0;
            VL_TOT_AJ_CREDITOS := 0;
            VL_ESTORNOS_DEB := 0;
            VL_SLD_CREDOR_ANT := 0;
            // apura o ICMS
            aSaldo := sDebitos - sCreditos;
            if pTruncado then
               aSaldo := TruncaValor(aSaldo,2);
            if (aSaldo > 0) then // devedor
            begin
              VL_SLD_APURADO := aSaldo;
              VL_TOT_DED := 0;
              VL_ICMS_RECOLHER := aSaldo;
              VL_SLD_CREDOR_TRANSPORTAR := 0;
            end
            else // credor
            begin
              VL_SLD_APURADO := 0;
              VL_TOT_DED := 0;
              VL_ICMS_RECOLHER := 0;
              VL_SLD_CREDOR_TRANSPORTAR := aSaldo*-1;
            end;
            DEB_ESP := 0;
         end;
         // registro E116
         if aSaldo > 0 then
         begin
           with RegistroE116New do
           begin
             COD_OR    := '000';
             VL_OR     := aSaldo;
             DT_VCTO   := Dataf;
             COD_REC   := CodRec;
             NUM_PROC  := '';
             IND_PROC  := opNenhum;
             PROC      := '';
             MES_REF   := aMesAno;
             TXT_COMPL := '';
           end;
         end;
         //
         if CdsUFST.RecordCount > 0 then
         begin
           // registro E200
           CdsUFST.First;
           while not CdsUFST.Eof do
           begin
             with RegistroE200New do
             begin
               UF := CdsUFST.FieldByName('UF').AsString;
               DT_INI := Datai;
               DT_FIN := Dataf;
               aSaldo := CdsUFST.FieldByName('CREDITO').AsFloat - CdsUFST.FieldByName('DEBITO').AsFloat;

               // E210
               with RegistroE210New do
               begin
                 IND_MOV_ST         := mstComOperacaoST;
                 VL_SLD_CRED_ANT_ST := 0;
                 VL_DEVOL_ST        := 0;
                 VL_RESSARC_ST      := 0;
                 VL_OUT_CRED_ST     := CdsUFST.FieldByName('CREDITO').AsFloat;
                 VL_AJ_CREDITOS_ST  := 0;
                 VL_RETENCAO_ST     := 0;
                 VL_OUT_DEB_ST      := CdsUFST.FieldByName('DEBITO').AsFloat;
                 VL_AJ_DEBITOS_ST   := 0;
                 VL_SLD_DEV_ANT_ST  := 0;
                 VL_DEDUCOES_ST     := 0;
                 if aSaldo < 0 then
                 begin
                   VL_ICMS_RECOL_ST   := (aSaldo*-1);
                   VL_SLD_CRED_ST_TRANSPORTAR := 0;
                   DEB_ESP_ST         := 0;
                 end
                 else
                 begin
                   VL_ICMS_RECOL_ST   := 0;
                   VL_SLD_CRED_ST_TRANSPORTAR := aSaldo;
                   DEB_ESP_ST         := 0;
                 end;
               end
             end;
             CdsUFST.Next;
           end;
         end;
         // registro E500 para apuração do IPI
         if pINDICADOR = 0 then
         begin
           with RegistroE500New do
           begin
             IND_APUR := iaMensal;
             DT_INI   := Datai;
             DT_FIN   := Dataf;
             // seleciona os dados
             aCredIPI       := 0;
             aDebIPI        := 0;
             aOutrosCredIPI := 0;
             aOutrosDebDIPI := 0;
             aSaldoIPI      := 0;
             Query := TSQLQuery.Create(nil);
             try
               Query.SQLConnection := ConexaoDados;
               // entradas
               Query.Close;
               Query.SQL.Clear;
               Query.SQL.Add('select i.cst_ipi,i.cfop,');
               Query.SQL.Add('sum(i.quantidade * i.valor) as total_produto,');
               Query.SQL.Add('sum(i.base_ipi) as val_base_ipi,');
               Query.SQL.Add('sum(i.valor_ipi) as val_ipi');
               Query.SQL.Add('from compras c');
               Query.SQL.Add('left outer join classificacao cf on c.id_classificacao = cf.id');
               Query.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
               Query.SQL.Add('where c.data_compra between :pDatai and :pDataf');
               Query.SQL.Add('and c.cancelado = '+QuotedStr('N'));
               Query.SQL.Add('and c.nota is not null');
               Query.SQL.Add('and c.idempresa = :pEmpresa');
               Query.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
               Query.SQL.Add('group by i.cst_ipi,i.cfop');
               Query.Params.ParamByName('pDatai').AsDate      := Datai;
               Query.Params.ParamByName('pDataf').AsDate      := Dataf;
               Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Query.Open;
               aNumReg := RetornaQtdRegDBX(Query);
               sLbMensagem.Caption := 'Registros de E500 de apuração do IPI de entrada';
               sProgressBar1.Max := aNumReg;
               Application.ProcessMessages;
               aRegAtual := 0;
               while not Query.Eof do
               begin
                 with RegistroE510New do
                 begin
                   CFOP        := FiltraNumero(Query.FieldByName('cfop').AsString);
                   CST_IPI     := Query.FieldByName('cst_ipi').AsString;
                   VL_CONT_IPI := Query.FieldByName('total_produto').AsFloat;
                   VL_BC_IPI   := Query.FieldByName('val_base_ipi').AsFloat;
                   VL_IPI      := Query.FieldByName('val_ipi').AsFloat;
                   // soma os creditos
                   aCredIPI    := aCredIPI + Query.FieldByName('val_ipi').AsFloat;
                 end;
                 Inc(aRegAtual);
                 sProgressBar1.Position := aRegAtual;
                 Application.ProcessMessages;
                 Query.Next;
               end;
               // saidas
               Query.Close;
               Query.SQL.Clear;
               Query.SQL.Add('select i.cst_ipi,i.cfop,');
               Query.SQL.Add('sum(i.quantidade * i.valor) as total_produto,');
               Query.SQL.Add('sum(i.base_ipi) as val_base_ipi,');
               Query.SQL.Add('sum(i.valor_ipi) as val_ipi');
               Query.SQL.Add('from pedido p');
               Query.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
               Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
               Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
               Query.SQL.Add('and p.cancelado = '+QuotedStr('N'));
               Query.SQL.Add('and p.numero_doc is not null');
               Query.SQL.Add('and p.idempresa = :pEmpresa');
               Query.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
               Query.SQL.Add('group by i.cst_ipi,i.cfop');
               Query.Params.ParamByName('pDatai').AsDate      := Datai;
               Query.Params.ParamByName('pDataf').AsDate      := Dataf;
               Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Query.Open;
               aNumReg := RetornaQtdRegDBX(Query);
               sLbMensagem.Caption := 'Registros de E500 de apuração do IPI de saida';
               sProgressBar1.Max := aNumReg;
               Application.ProcessMessages;
               aRegAtual := 0;
               while not Query.Eof do
               begin
                 with RegistroE510New do
                 begin
                   CFOP        := FiltraNumero(Query.FieldByName('cfop').AsString);
                   CST_IPI     := Query.FieldByName('cst_ipi').AsString;
                   VL_CONT_IPI := Query.FieldByName('total_produto').AsFloat;
                   VL_BC_IPI   := Query.FieldByName('val_base_ipi').AsFloat;
                   VL_IPI      := Query.FieldByName('val_ipi').AsFloat;
                   // soma os creditos
                   aDebIPI     := aDebIPI + Query.FieldByName('val_ipi').AsFloat;
                 end;
                 Inc(aRegAtual);
                 sProgressBar1.Position := aRegAtual;
                 Application.ProcessMessages;
                 Query.Next;
               end;
               Query.Close;
             finally
               FreeAndNil(Query);
             end;
             with RegistroE520New do
             begin
               aSaldoIPI     := ((aDebIPI + aOutrosDebDIPI) - (aCredIPI + aOutrosCredIPI));
               VL_SD_ANT_IPI := 0;
               VL_DEB_IPI    := aDebIPI;
               VL_CRED_IPI   := aCredIPI;
               VL_OD_IPI     := aOutrosDebDIPI;
               VL_OC_IPI     := aOutrosCredIPI;
               if aSaldoIPI < 0 then
               begin
                 VL_SC_IPI   := aSaldoIPI*-1;
                 VL_SD_IPI   := 0;
               end
               else
               begin
                 VL_SC_IPI   := 0;
                 VL_SD_IPI   := aSaldoIPI;
               end;
             end;
           end;
         end;  
      end;
   end;

end;

procedure TSPED_EFD.DadosBloco_G(Datai,Dataf:TDateTime;CodEmp:String);
var Qry110, Qry125, Qry130, Qry140 : TSQLQuery;
    aItem : Integer;
begin
   Qry110 := TSQLQuery.Create(nil);
   Qry125 := TSQLQuery.Create(nil);
   Qry130 := TSQLQuery.Create(nil);
   Qry140 := TSQLQuery.Create(nil);
   try
     Qry110.SQLConnection := ConexaoDados;
     Qry125.SQLConnection := ConexaoDados;
     Qry130.SQLConnection := ConexaoDados;
     Qry140.SQLConnection := ConexaoDados;
     // Alimenta o componente com informações para gerar todos os registros do Bloco G.
     with DmAcBr.ACBrSpedFiscal1.Bloco_G do
     begin
        with RegistroG001New do
        begin
          if not sControleBlocoG then
          begin
             IND_MOV := imSemDados;
          end
          else
          begin
             IND_MOV := imComDados;
             // registro G110
             Qry110.Close;
             Qry110.SQL.Clear;
             Qry110.SQL.Add('select sum(c.valor_icms) as total from compras c');
             Qry110.SQL.Add('left outer join classificacao cf on cf.id = c.id_classificacao');
             Qry110.SQL.Add('where c.data_compra between :pDatai and :pDataf');
             Qry110.SQL.Add('and c.cancelado = '+QuotedStr('N'));
             Qry110.SQL.Add('and c.nota is not null');
             Qry110.SQL.Add('and c.idempresa = :pEmpresa');
             Qry110.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('S'));
             Qry110.Params.ParamByName('pDatai').AsDate := Datai;
             Qry110.Params.ParamByName('pDataf').AsDate := Dataf;
             Qry110.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
             Qry110.Open;
             if not Qry110.IsEmpty then
             begin
               with RegistroG110New do
               begin
                 DT_INI        := Datai;
                 DT_FIN        := Dataf;
                 MODO_CIAP     := '';
                 SALDO_IN_ICMS := 0;
                 SALDO_FN_ICMS := 0;
                 SOM_PARC      := Qry110.FieldByName('total').AsFloat;
                 VL_TRIB_EXP   := 0;
                 VL_TOTAL      := 0;
                 IND_PER_SAI   := 0;
                 ICMS_APROP    := 0;
                 SOM_ICMS_OC   := 0;
                 // registro G125
                 Qry125.Close;
                 Qry125.SQL.Clear;
                 Qry125.SQL.Add('select i.idproduto,c.data_compra,');
                 Qry125.SQL.Add('i.valor_icms,i.valor_icms_st from compras c');
                 Qry125.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
                 Qry125.SQL.Add('left outer join produtos p on p.id = i.idproduto');
                 Qry125.SQL.Add('left outer join classificacao cf on cf.id = c.id_classificacao');
                 Qry125.SQL.Add('where c.data_compra between :pDatai and :pDataf');
                 Qry125.SQL.Add('and c.cancelado = '+QuotedStr('N'));
                 Qry125.SQL.Add('and c.nota is not null');
                 Qry125.SQL.Add('and c.idempresa = :pEmpresa');
                 Qry125.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('S'));
                 Qry125.Params.ParamByName('pDatai').AsDate := Datai;
                 Qry125.Params.ParamByName('pDataf').AsDate := Dataf;
                 Qry125.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
                 Qry125.Open;
                 while not Qry125.Eof do
                 begin
                   with RegistroG125New do
                   begin
                     COD_IND_BEM       := IntToStr(Qry125.FieldByName('idproduto').AsInteger);
                     DT_MOV            := Qry125.FieldByName('data_compra').AsDateTime;
                     TIPO_MOV          := mbcIM;
                     VL_IMOB_ICMS_OP   := Qry125.FieldByName('valor_icms').AsFloat;
                     VL_IMOB_ICMS_ST   := Qry125.FieldByName('valor_icms_st').AsFloat;
                     VL_IMOB_ICMS_FRT  := 0;
                     VL_IMOB_ICMS_DIF  := 0;
                     NUM_PARC          := 0;
                     VL_PARC_PASS      := 0;
                     VL_PARC_APROP     := Qry125.FieldByName('valor_icms').AsFloat;
                     // registro G130
                     Qry130.Close;
                     Qry130.SQL.Clear;
                     Qry130.SQL.Add('select c.id,c.idfornecedor,c.chave_nfe,');
                     Qry130.SQL.Add('c.data_compra,c.nota from compras c');
                     Qry130.SQL.Add('left outer join compras_itens i on i.idcompra = c.id');
                     Qry130.SQL.Add('left outer join produtos p on p.id = i.idproduto');
                     Qry130.SQL.Add('left outer join classificacao cf on cf.id = c.id_classificacao');
                     Qry130.SQL.Add('where c.data_compra between :pDatai and :pDataf');
                     Qry130.SQL.Add('and c.cancelado = '+QuotedStr('N'));
                     Qry130.SQL.Add('and c.nota is not null');
                     Qry130.SQL.Add('and c.idempresa = :pEmpresa');
                     Qry130.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('S'));
                     Qry130.Params.ParamByName('pDatai').AsDate := Datai;
                     Qry130.Params.ParamByName('pDataf').AsDate := Dataf;
                     Qry130.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
                     Qry130.Params.ParamByName('pProduto').AsInteger := Qry125.FieldByname('cd_produto').AsInteger;
                     Qry130.Open;
                     while not Qry130.Eof do
                     begin
                       with RegistroG130New do
                       begin
                         IND_EMIT    := edTerceiros;
                         COD_PART    := 'F'+IntToStrZero(Qry130.FieldByName('idfornecedor').AsInteger,5);
                         if Qry130.FieldByName('CHAVE_NFE').AsString <> '' then
                            COD_MOD  := '55'
                         else
                            COD_MOD  := '01';
                         SERIE       := '1';
                         NUM_DOC     := Qry130.FieldByName('NOTA').AsString;
                         CHV_NFE_CTE := Qry130.FieldByName('CHAVE_NFE').AsString;
                         DT_DOC      := Qry130.FieldByName('DATA_COMPRA').AsDateTime;
                         // registro G140
                         Qry140.Close;
                         Qry140.SQL.Clear;
                         Qry140.SQL.Add('select i.idproduto from compras_itens i');
                         Qry140.SQL.Add('where i.idcompra = :pCodigo');
                         Qry140.Params.ParamByName('pCodigo').AsInteger := Qry130.FieldByName('id').AsInteger;
                         Qry140.Open;
                         aItem := 0;
                         while not Qry140.Eof do
                         begin
                           Inc(aItem);
                           with RegistroG140New do
                           begin
                             NUM_ITEM := IntToStrZero(aItem,2);
                             COD_ITEM := IntToStr(Qry140.FieldByName('idproduto').AsInteger);
                           end;
                           Qry140.Next
                         end;
                       end;
                       Qry130.Next;
                     end;
                   end;
                   Qry125.Next;
                 end;
               end;
             end;
          end;
        end;
     end;
   finally
     FreeAndNil(Qry110);
     FreeAndNil(Qry125);
     FreeAndNil(Qry130);
     FreeAndNil(Qry140);
   end;
end;

procedure TSPED_EFD.DadosBloco_H(var CdsInventario:TClientDataSet; Processar:Boolean;
  Datai,Dataf:TDateTime);
var aTotalInvent : Double;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco H.
   with DmAcBr.ACBrSPEDFiscal1.Bloco_H do
   begin
     with RegistroH001New do
     begin
       if Processar then
       begin
         IND_MOV := imComDados;
         with RegistroH005New do
         begin
            aTotalInvent := RetornaTotalInventario(CdsInventario);
            DT_INV  := Dataf;
            VL_INV  := aTotalInvent;
            MOT_INV := miFinalPeriodo;
            // registro H010
            if aTotalInvent > 0 then
            begin
              CdsInventario.First;
              while not CdsInventario.Eof do
              begin
                 with RegistroH010New do
                 begin
                    COD_ITEM  := IntToStr(CdsInventario.FieldByName('cd_produto').AsInteger);
                    UNID      := CdsInventario.FieldByName('unidade').AsString;
                    QTD       := CdsInventario.FieldByName('quantidade').AsFloat;
                    VL_UNIT   := CdsInventario.FieldByName('valor').AsFloat;
                    VL_ITEM   := CdsInventario.FieldByName('total').AsFloat;
                    IND_PROP  := piInformante;
                    COD_PART  := '';
                    TXT_COMPL := '';
                    COD_CTA   := '00000';
                 end;
                 CdsInventario.Next;
              end;
            end;
         end;
       end
       else
       begin
         IND_MOV := imSemDados;
{         with RegistroH005New do
         begin
           DT_INV       := Dataf;
           VL_INV       := 0;
           MOT_INV      := miFinalPeriodo;
         end; }
       end;
     end;
   end;

end;

procedure TSPED_EFD.InsereItemInventario(var CdsInventario:TClientDataSet; pCod: Integer;
  pUnid: String; pQuant, pValor: Double);
begin
  try
    if pQuant < 0 then
       pQuant := 0;
    CdsInventario.Append;
    CdsInventario.FieldByName('cd_produto').AsInteger := pCod;
    CdsInventario.FieldByName('unidade').AsString     := pUnid;
    CdsInventario.FieldByName('quantidade').AsFloat   := pQuant;
    CdsInventario.FieldByName('valor').AsFloat        := pValor;
    CdsInventario.FieldByName('total').AsFloat        := pQuant*pValor;
    CdsInventario.Post;
  except
    MessageDlg('Erro ao gravar inventário. Verifique!', mtError, [mbOK], 0);
  end;
end;

function TSPED_EFD.VerificaIPIProdutosNota(pID, pES: Integer): Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    if pES = 0 then // erntrada
    begin
      Q.SQL.Add('select i.idcompra from compras_itens i');
      Q.SQL.Add('where i.idcompra = :pID');
      Q.SQL.Add('and i.valor_ipi > 0');
    end
    else if pES = 1 then // saida
    begin
      Q.SQL.Add('select i.idpedido from pedido_itens i');
      Q.SQL.Add('where i.idpedido = :pID');
      Q.SQL.Add('and i.valor_ipi > 0');
    end;
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Open;
    Result := false;
    if not Q.IsEmpty then
       Result := true;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

procedure TSPED_EFD.InsereRegistroUFST(var CdsUFST:TClientDataSet; pUF: String; pCredito,pDebito:Double);
begin
  if not CdsUFST.Locate('UF',pUF,[]) then
  begin
     CdsUFST.Append;
     CdsUFST.FieldByname('UF').AsString := pUF;
  end
  else
     CdsUFST.Edit;
  // soma valos
  CdsUFST.FieldByname('CREDITO').AsFloat := CdsUFST.FieldByname('CREDITO').AsFloat + pCredito;
  CdsUFST.FieldByname('DEBITO').AsFloat  := CdsUFST.FieldByname('DEBITO').AsFloat  + pDebito;
  CdsUFST.Post;

end;

function TSPED_EFD.VerificaNotaDevolucao(fCodigo: Integer): Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);                            
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select fornec.registro_1 from fornec');
    Q.SQL.Add('where fornec.cd_fornec = :Codigo');
    Q.Params.ParamByName('Codigo').AsInteger := fCodigo;
    Q.Open;
    //
    Result := false;
    if Trim(FiltraNumero(Q.FieldByname('registro_1').AsString)) =
       Trim(FiltraNumero(sCNPJEmpresa)) then
       Result := true;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

function TSPED_EFD.VerificaSTProdutosNota(pID, pES: Integer): Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    if pES = 0 then // erntrada
    begin
      Q.SQL.Add('select i.idcompra from compras_itens i');
      Q.SQL.Add('where i.idcompra = :pID');
      Q.SQL.Add('and i.base_icms_st > 0');
      Q.SQL.Add('and (i.cst = '+QuotedStr('010')+' or i.cst = '+QuotedStr('060')+' or i.cst = '+QuotedStr('070')+')');
    end
    else if pES = 1 then // saida
    begin
      Q.SQL.Add('select i.idpedido from pedido_itens i');
      Q.SQL.Add('where i.idpedido = :pID');
      Q.SQL.Add('and i.base_icms_st > 0');
      Q.SQL.Add('and (i.cst = '+QuotedStr('010')+' or i.cst = '+QuotedStr('060')+' or i.cst = '+QuotedStr('070')+')');
    end;
    Q.Params.ParamByName('pID').AsInteger := pID;
    Q.Open;
    Result := false;
    if not Q.IsEmpty then
       Result := true;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

function TSPED_EFD.RetornaTotalInventario(CdsInventario:TClientDataSet): Double;
begin
  Result := 0;
  CdsInventario.First;
  while not CdsInventario.Eof do
  begin
    Result := Result + CdsInventario.FieldByname('total').AsFloat;
    CdsInventario.Next;
  end;

end;

function TSPED_EFD.RetornaUFCliFor(pCodigo, pTipo: Integer): String;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select c.uf_end from contato c');
    Q.SQL.Add('where c.id = :pCodigo');
    Q.Params.ParamByName('pCodigo').AsInteger := pCodigo;
    Q.Open;
    Result := Q.FieldByName('uf_end').AsString;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;


constructor TSPED_EFD.CrieInstancia;
begin

end;

destructor TSPED_EFD.DestruaInstancia;
begin

end;

function TSPED_EFD.RetornaSaldoInventario(pCDProduto, pEmpresa: Integer;
  pDataBase:TDateTime;pQuantAtual:Double): Double;
var Query : TSQLQuery;
    aTotalEnt, aTotalSai : Double;
begin
  Query := TSQLQuery.Create(nil);
  try
    with Query do
    begin
      SQLConnection := ConexaoDados;
      Close;
      SQL.Clear;
      // captura a quantidade de entrada
      SQL.Add('select sum(i.quantidade)');
      SQL.Add('from compras c, compras_itens i');
      SQL.Add('where i.idcompra = c.id');
      SQL.Add('and c.data_compra > :data_base');
      SQL.Add('and c.cancelado = '+QuotedStr('N'));
      SQL.Add('and c.idempresa = :cd_empresa');
      SQL.Add('and i.cancelado = '+QuotedStr('N'));
      SQL.Add('and i.idproduto = :cd_produto');
      Params.ParamByName('data_base').AsDate     := pDataBase;
      Params.ParamByName('cd_produto').AsInteger := pCDProduto;
      Params.ParamByName('cd_empresa').AsInteger := pEmpresa;
      Open;
      aTotalEnt := FieldByName('sum').AsFloat;
      // captura a quantidade de saida
      Close;
      SQL.Clear;
      SQL.Add('select sum(i.quantidade)');
      SQL.Add('from pedido p, pedido_itens i');
      SQL.Add('where i.idpedido = p.id');
      SQL.Add('and p.data_pedido > :data_base');
      SQL.Add('and p.cancelado = '+QuotedStr('N'));
      SQL.Add('and p.idempresa = :cd_empresa');
      SQL.Add('and i.cancelado = '+QuotedStr('N'));
      SQL.Add('and i.idproduto = :cd_produto');
      Params.ParamByName('data_base').AsDate     := pDataBase;
      Params.ParamByName('cd_produto').AsInteger := pCDProduto;
      Params.ParamByName('cd_empresa').AsInteger := pEmpresa;
      Open;
      aTotalSai := FieldByName('sum').AsFloat;
      Close;
      // calcula o saldo atual
      Result := ((pQuantAtual + aTotalSai) -aTotalEnt);
    end
  finally
    FreeAndNil(Query);
  end;
end;

function TSPED_EFD.VerificaItemCupom(ID: Integer): Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select i.id from pedido_itens i');
    Q.SQL.Add('where i.idpedido = :pID');
//    Q.SQL.Add('and i.aliq_icms > 0');
    Q.Params.ParamByName('pID').AsInteger := ID;
    Q.Open;
    Result := not Q.IsEmpty;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

function TSPED_EFD.RetornaNumeroTanque(pIDProduto: Integer): String;
var Q : TSQLQuery;
begin
  Result := '';
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    Q.SQL.Add('select t.tanque_numero');
    Q.SQL.Add('from tanques_abastec t');
    Q.SQL.Add('where t.id_produto = '+IntToStr(pIDProduto));
    Q.Open;
    Result := Q.FieldByName('tanque_numero').AsString;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

end.
