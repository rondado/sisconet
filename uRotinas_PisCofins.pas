unit uRotinas_PisCofins;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ActnList, Buttons, StdCtrls, CheckLst,
  ACBrSpedFiscal, ACBrEPCBlocos, ACBrUtil, ACBrTXTClass, SqlExpr, DB,
  DBClient, ACBrSpedPisCofins, uDmAcBr, uLibrary;

type
  TSPED_PC = class(TObject)
  protected
    { Protected declarations }
  private
    { Private declarations }
    CdsConsolidacao : TClientDataSet;
    function VerificaMovimentoPisCofins(pIDEMpresa:Integer;pDatai,pDataf:TDateTime):Boolean;
    function VerificaECFMovimentoPisCofins(pIDEMpresa:Integer;pDatai,pDataf:TDateTime):Boolean;
    function VerificaNotaDevolucao(fCodigo: Integer;pCNPJEmpresa:String): Boolean;
    function VerificaSTProdutosNota(pID, pES: Integer): Boolean;
    function VerificaIPIProdutosNota(pID, pES: Integer): Boolean;
    function VerificaMovimentoBlocoA(pDatai,pDataf:TDateTime;pEmpresa:Integer=0):Boolean;
    procedure CriaPreparaTabelaConsolidacao;

  public
    { Public declarations }
    sNotasEntrada : Boolean;
    sLbMensagem,sLBBlocos : TLabel;
    sProgressBar1,sProgressBar2 : TProgressBar;
    procedure DadosBlocoPC_0(CdsEmpresa,CdsContabil:TClientDataSet;
                             Datai,Dataf:TDateTime;
                             pCOD_VERPC,pSitEspecial,pIndicadorPC,pCOD_FIN:Integer;
                             pNumeroRecAnterior,CodEmp:String;
                             pIncidencia,pAproCred,pContrApur,pEscrApur : Integer);
    procedure DadosBlocoPC_A(CdsEmpresa:TClientDataSet;
                             pDatai,pDataf:TDateTime;
                             CodEmp:Integer);
    procedure DadosBlocoPC_C(CdsEmpresa:TClientDataSet;
                             pDatai,pDataf:TDateTime;
                             CodEmp,pEscrApur:Integer;
                             VerificaSTIPI:Boolean);
    procedure DadosBlocoPC_D;
    procedure DadosBlocoPC_F(CdsEmpresa:TClientDataSet;
                             pDatai,pDataf:TDateTime;
                             CodEmp,pEscrApur:Integer);
    procedure DadosBlocoPC_M;
    procedure DadosBlocoPC_1(pDatai,pDataf:TDateTime;
                             pEscrApur:Integer);
    procedure DadosBlocoPC_9;
    constructor CrieInstancia;
    destructor DestruaInstancia;
  end;


implementation

uses ACBrEPCBloco_0, ACBrEPCBloco_C, ACBrEPCBloco_C_Class,
  ACBrEPCBloco_A_Class, ACBrEPCBloco_A, ACBrEPCBloco_F,
  ACBrEPCBloco_F_Class, ACBrEPCBloco_1_Class, ACBrEPCBloco_1;

constructor TSPED_PC.CrieInstancia;
begin

end;

procedure TSPED_PC.DadosBlocoPC_0(CdsEmpresa,CdsContabil:TClientDataSet;Datai,
  Dataf:TDateTime;pCOD_VERPC,pSitEspecial,pIndicadorPC,pCOD_FIN:Integer;
  pNumeroRecAnterior,CodEmp:String;pIncidencia,pAproCred,pContrApur,pEscrApur : Integer);
var aCodVersao : TACBrVersaoLeiaute;
    aSitEspecial : TACBrIndicadorSituacaoEspecial;
    aCodFin : TACBrTipoEscrituracao;
    aControle : Boolean;
    Query : TSQLQuery;
begin
   Query := TSqlQuery.Create(nil);
   Query.SQLConnection := ConexaoDados;
   // captura versão
   case pCOD_VERPC of
     0 : aCodVersao := vlVersao100;
     1 : aCodVersao := vlVersao101;
     2 : aCodVersao := vlVersao200;
     3 : aCodVersao := vlVersao201;
   end;
   // captura Situação Especial
   case pSitEspecial of
     0 : aSitEspecial := indSitAbertura;      // 0 - Abertura
     1 : aSitEspecial := indSitCisao;         // 1 - Cisão
     2 : aSitEspecial := indSitFusao;         // 2 - Fusão
     3 : aSitEspecial := indSitIncorporacao;  // 3 - Incorporação
     4 : aSitEspecial := indSitEncerramento;  // 4 - Encerramento
     5 : aSitEspecial := indNenhum;           // 5 - Vazio
   end;
   // captura codigo da finalidade
   case pCOD_FIN of
     0 : aCodFin := tpEscrOriginal;
     1 : aCodFin := tpEscrRetificadora;
   end;
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 0.
   with DmAcBr.ACBrSPEDPisCofins1.Bloco_0 do
   begin
      // Dados da Empresa
      with Registro0000New do
      begin
         COD_VER          := aCodVersao;
         TIPO_ESCRIT      := tpEscrOriginal;
         IND_SIT_ESP      := aSitEspecial;
         NUM_REC_ANTERIOR := pNumeroRecAnterior;
         DT_INI           := Datai;
         DT_FIN           := Dataf;
         NOME             := Trim(CdsEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
         CNPJ             := FiltraNumero(CdsEmpresa.FieldByName('CNPJ_CPF').AsString);
         UF               := CdsEmpresa.FieldByName('UF').AsString;
         if CdsEmpresa.FieldByName('COD_MUNICIPIO').AsString <> '' then
            COD_MUN    := StrToInt(CdsEmpresa.FieldByName('COD_MUNICIPIO').AsString)
         else
            COD_MUN    := 0;
         SUFRAMA          := CdsEmpresa.FieldByName('COD_SUFRAMA').AsString;
         IND_NAT_PJ       := indNatPJSocEmpresariaGeral;
         IND_ATIV         := indAtivIndustrial;
      end;
      with Registro0001New do
      begin
         IND_MOV := imComDados;
         // FILHO - Dados do contador.
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
         // FILHO - Regime de Apuração
         with Registro0110New do
         begin
           case pIncidencia of
             0: COD_INC_TRIB := codEscrOpIncNaoCumulativo;
             1: COD_INC_TRIB := codEscrOpIncCumulativo;
             2: COD_INC_TRIB := codEscrOpIncAmbos;
           end;
           case pAproCred of
             0: IND_APRO_CRED := indMetodoApropriacaoDireta;
             1: IND_APRO_CRED := indMetodoDeRateioProporcional;
           end;
           case pContrApur of
             0: COD_TIPO_CONT := codIndTipoConExclAliqBasica;
             1: COD_TIPO_CONT := codIndTipoAliqEspecificas;
           end;
           case pEscrApur of
             0: IND_REG_CUM := codRegimeCaixa;
             1: IND_REG_CUM := codRegimeCompetEscritConsolidada;
             2: IND_REG_CUM := codRegimeCompetEscritDetalhada;
           end;
         end;
         //
         CdsEmpresa.First;
         while not CdsEmpresa.Eof do
         begin
//           if VerificaMovimentoPisCofins(CdsEmpresa.FieldByName('id').AsInteger,Datai,Dataf) then
           begin
             with Registro0140New do
             begin
               COD_EST := IntToStrZero(CdsEmpresa.FieldByName('ID').AsInteger,6);
               NOME    := Trim(CdsEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
               CNPJ    := FiltraNumero(CdsEmpresa.FieldByName('CNPJ_CPF').AsString);
               UF      := CdsEmpresa.FieldByName('UF').AsString;
               IE      := Trim(CdsEmpresa.FieldByName('INSCRICAO_RG').AsString);
               if CdsEmpresa.FieldByName('COD_MUNICIPIO').AsString <> '' then
                  COD_MUN    := StrToInt(CdsEmpresa.FieldByName('COD_MUNICIPIO').AsString)
               else
                  COD_MUN    := 0;
               IM         := CdsEmpresa.FieldByName('INSC_MUNIC').AsString;
               SUFRAMA    := CdsEmpresa.FieldByName('COD_SUFRAMA').AsString;
               // registro 0150 clientes
               Query.Close;
               Query.SQL.Clear;
               Query.SQL.Add('select contato.id ,contato.nome,contato.cnpj_cpf,contato.insc_rg,');
               Query.SQL.Add('contato.codcidade,contato.endereco,contato.num_end,');
               Query.SQL.Add('contato.bairro_end,contato.uf_end,pedido.status_nfe from pedido');
               Query.SQL.Add('left outer join contato on contato.id = pedido.idcliente');
               Query.SQL.Add('where pedido.data_entrega between :pDatai and :pDataf');
               Query.SQL.Add('and pedido.status_nfe = '+QuotedStr('100'));
               Query.SQL.Add('and pedido.cancelado = '+QuotedStr('N'));
               Query.SQL.Add('and pedido.idempresa = :pEmpresa');
               Query.SQL.Add('and pedido.numero_doc is not null');
               Query.SQL.Add('group by contato.id ,contato.nome,contato.cnpj_cpf,contato.insc_rg,');
               Query.SQL.Add('contato.codcidade,contato.endereco,contato.num_end,');
               Query.SQL.Add('contato.bairro_end,contato.uf_end,pedido.status_nfe');
               Query.Params.ParamByName('pDatai').AsDate      := Datai;
               Query.Params.ParamByName('pDataf').AsDate      := Dataf;
               Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Query.Open;
               while not Query.Eof do
               begin
                 // Clientes
                 if not Registro0150.LocalizaRegistro('C'+IntToStrZero(Query.FieldByName('IDCLIENTE').AsInteger,5)) then
                 begin
                   with Registro0150New do
                   begin
                     COD_PART := 'C'+IntToStrZero(Query.FieldByName('IDCLIENTE').AsInteger,5);
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
                     ENDERECO := Copy(Trim(Query.FieldByName('ENDERECO').AsString),1,59);
                     NUM      := Trim(Query.FieldByName('num_end').AsString);
                     COMPL    := '';
                     BAIRRO   := Trim(Query.FieldByName('bairro_end').AsString);
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
                   if not Registro0150.LocalizaRegistro('F'+IntToStrZero(Query.FieldByName('idfornecedor').AsInteger,5)) then
                   begin
                     with Registro0150New do
                     begin
                        COD_PART := 'F'+IntToStrZero(Query.FieldByName('idfornecedor').AsInteger,5);
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
                        ENDERECO := Copy(Trim(Query.FieldByName('ENDERECO').AsString),1,59);
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
//                 Query.SQL.Add('and (c.status_nfe = '+QuotedStr('100')+' or c.status_nfe is null)');
                 Query.SQL.Add('and c.cancelado = '+QuotedStr('N'));
                 Query.SQL.Add('and c.nota is not null');
                 Query.SQL.Add('and c.idempresa = :pEmpresa');
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
               Query.Params.ParamByName('pDatai').AsDate      := Datai;
               Query.Params.ParamByName('pDataf').AsDate      := Dataf;
               Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Query.Open;
               while not Query.Eof do
               begin
                 if (Query.FieldByName('STATUS_NFE').AsString = '100') or
                    (Query.FieldByName('STATUS_NFE').AsString = '') then
                 begin
//                   if Query.FieldByName('chave_nfe').AsString = '' then
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
                 Query.Next;
               end;
               // Unidades de Medida saida ECF
               Query.Close;
               Query.SQL.Clear;
               Query.SQL.Add('select distinct pr.unidade,p.status_nfe,p.chave_nfe from pedido p');
               Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
               Query.SQL.Add('left outer join produtos pr on i.idproduto = pr.id');
               Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
               Query.SQL.Add('and p.cancelado = '+QuotedStr('S'));
               Query.SQL.Add('and p.coo > 0');
               Query.SQL.Add('and p.idempresa = :pEmpresa');
               Query.SQL.Add('and pr.unidade is not null');
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
                       if not registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
                       begin
                          with Registro0200New do
                          begin
                             COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                             DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                             COD_BARRA    := Query.FieldByName('ean13').AsString;
                             COD_ANT_ITEM := '';
                             UNID_INV     := Trim(Query.FieldByName('unidade').AsString);
                             TIPO_ITEM    := tiMercadoriaRevenda;
                             COD_NCM      := Trim(Query.FieldByName('ncm').AsString);
                             EX_IPI       := '';
                             COD_GEN      := '';
                             COD_LST      := '';
                             ALIQ_ICMS    := Query.FieldByName('aliq_icms').AsFloat;
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
               Query.Params.ParamByName('pDatai').AsDate      := Datai;
               Query.Params.ParamByName('pDataf').AsDate      := Dataf;
               Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Query.Open;
               while not Query.Eof do
               begin
                 if (Query.FieldByName('STATUS_NFE').AsString = '100') or
                    (Query.FieldByName('STATUS_NFE').AsString = '') then
                 begin
//                   if Query.FieldByName('chave_nfe').AsString = '' then
                   begin
                     if not registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
                     begin
                        with Registro0200New do
                        begin
                           COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                           DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                           COD_BARRA    := '';
                           COD_ANT_ITEM := '';
                           UNID_INV     := Trim(Query.FieldByName('unidade').AsString);
                           TIPO_ITEM    := tiMercadoriaRevenda;
                           COD_NCM      := Trim(Query.FieldByName('ncm').AsString);
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
               // serviços prestados
               Query.Close;
               Query.SQL.Clear;
               Query.SQL.Add('select i.idproduto,i.descricao,');
               Query.SQL.Add('i.aliq_iss,i.quantidade,i.valor,');
               Query.SQL.Add('p.status_nfe,p.chave_nfe from pedido p');
               Query.SQL.Add('left outer join classificacao c on c.id = p.id_classificacao');
               Query.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
               Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
               Query.SQL.Add('and p.cancelado = '+QuotedStr('N'));
               Query.SQL.Add('and p.numdav is not null');
               Query.SQL.Add('and p.idempresa = :pEmpresa');
               Query.SQL.Add('and c.tipo = 4');
               Query.Params.ParamByName('pDatai').AsDate      := Datai;
               Query.Params.ParamByName('pDataf').AsDate      := Dataf;
               Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Query.Open;
               while not Query.Eof do
               begin
                 if (Query.FieldByName('STATUS_NFE').AsString = '100') or
                    (Query.FieldByName('STATUS_NFE').AsString = '') then
                 begin
//                   if Query.FieldByName('chave_nfe').AsString = '' then
                   begin
                     if not registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
                     begin
                        with Registro0200New do
                        begin
                           COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                           DESCR_ITEM   := Trim(Query.FieldByName('descricao').AsString);
                           COD_BARRA    := '';
                           COD_ANT_ITEM := '';
                           UNID_INV     := '';
                           TIPO_ITEM    := tiServicos;
                           COD_NCM      := '';
                           EX_IPI       := '';
                           COD_GEN      := '';
                           COD_LST      := '';
                           ALIQ_ICMS    := Query.FieldByName('aliq_iss').AsCurrency;
                        end;
                     end;
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
               Query.Params.ParamByName('pDatai').AsDate      := Datai;
               Query.Params.ParamByName('pDataf').AsDate      := Dataf;
               Query.Params.ParamByName('pEmpresa').AsInteger := StrToInt(CodEmp);
               Query.Open;
               while not Query.Eof do
               begin
                  if not registro0200.LocalizaRegistro(IntToStr(Query.FieldByName('idproduto').AsInteger)) then
                  begin
                     with Registro0200New do
                     begin
                        COD_ITEM     := IntToStr(Query.FieldByName('idproduto').AsInteger);
                        DESCR_ITEM   := Query.FieldByName('descricao').AsString;
                        COD_BARRA    := '';
                        COD_ANT_ITEM := '';
                        UNID_INV     := Trim(Query.FieldByName('unidade').AsString);
                        TIPO_ITEM    := tiMercadoriaRevenda;
                        COD_NCM      := Trim(Query.FieldByName('ncm').AsString);
                        EX_IPI       := '';
                        COD_GEN      := '';
                        COD_LST      := '';
                        ALIQ_ICMS    := Query.FieldByName('aliq_icms').AsCurrency;
                     end;
                  end;
                  Query.Next;
               end;
             end;
           end;
           CdsEmpresa.Next;
         end;
      end;
   end;

end;

procedure TSPED_PC.DadosBlocoPC_1(pDatai, pDataf:TDateTime;pEscrApur:Integer);
var Query : TSQLQuery;
    aCST : Integer;
begin
   // Bloco 1
   Query := TSQLQuery.Create(nil);
   Query.SQLConnection := ConexaoDados;
   with DmAcBr.ACBrSPEDPisCofins1.Bloco_1 do
   begin
      with Registro1001New do
      begin
        if pEscrApur = 2 then
        begin
          IND_MOV := imSemDados;
        end
        else
        begin
          IND_MOV := imComDados;
          with Query do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select e.cnpj_cpf,p.status_nfe,');
            SQL.Add('i.cst_pis,i.cst_cofins,i.cfop,');
            SQL.Add('sum(i.valor_total) as total_produto,');
            SQL.Add('count(i.id) as quant_docs');
            SQL.Add('from empresa e');
            SQL.Add('left outer join pedido p on p.idempresa = e.id');
            SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
            SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
            SQL.Add('where p.data_entrega between :pDatai and :pDataf');
            SQL.Add('and p.cancelado = '+QuotedStr('N'));
            SQL.Add('and p.numero_doc is not null');
            SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
            SQL.Add('and p.valor_total > 0');
            SQL.Add('group by e.cnpj_cpf,p.status_nfe,');
            SQL.Add('i.cst_pis,i.cst_cofins,i.cfop');
            Params.ParamByName('pDatai').AsDate      := pDatai;
            Params.ParamByName('pDataf').AsDate      := pDataf;
            Open;
            while not Eof do
            begin
              with Registro1900New do
              begin
                CNPJ       := Trim(FieldByName('cnpj_cpf').AsString);
                if FieldByName('status_nfe').AsString = '' then
                   COD_MOD := '01'
                else
                   COD_MOD := '55';
                SER        := '';
                SUB_SER    := '';
                COD_SIT    := csffRegular;
                VL_TOT_REC := FieldByName('total_produto').AsFloat;
                QUANT_DOC  := FieldByName('quant_docs').AsInteger;
                aCST := FieldByname('cst_pis').AsInteger;
                if aCST = 0 then
                   aCST := 50;
                case aCST of
                  01 : CST_PIS := stpisValorAliquotaNormal;
                  02 : CST_PIS := stpisValorAliquotaDiferenciada;
                  03 : CST_PIS := stpisQtdeAliquotaUnidade;
                  04 : CST_PIS := stpisMonofaticaAliquotaZero;
                  05 : CST_PIS := stpisValorAliquotaPorST;
                  06 : CST_PIS := stpisAliquotaZero;
                  07 : CST_PIS := stpisIsentaContribuicao;
                  08 : CST_PIS := stpisSemIncidenciaContribuicao;
                  09 : CST_PIS := stpisSuspensaoContribuicao;
                  49 : CST_PIS := stpisOutrasOperacoesSaida;
                  50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                  51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                  52 : CST_PIS := stpisOperCredExcRecExportacao;
                  53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                  54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                  55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                  56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                  60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                  61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                  62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                  63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                  64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                  65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                  66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                  70 : CST_PIS := stpisOperAquiSemDirCredito;
                  71 : CST_PIS := stpisOperAquiComIsensao;
                  72 : CST_PIS := stpisOperAquiComSuspensao;
                  73 : CST_PIS := stpisOperAquiAliquotaZero;
                  74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                  75 : CST_PIS := stpisOperAquiPorST;
                  98 : CST_PIS := stpisOutrasOperacoesEntrada;
                  99 : CST_PIS := stpisOutrasOperacoes;
                end;
                aCST := FieldByName('cst_cofins').AsInteger;
                if aCST = 0 then
                   aCST := 50;
                case aCST of
                  01 : CST_COFINS := stcofinsValorAliquotaNormal;
                  02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                  03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                  04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                  05 : CST_COFINS := stcofinsValorAliquotaPorST;
                  06 : CST_COFINS := stcofinsAliquotaZero;
                  07 : CST_COFINS := stcofinsIsentaContribuicao;
                  08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                  09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                  49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                  50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                  51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                  52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                  53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                  54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                  55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                  56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                  60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                  61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                  62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                  63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                  64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                  65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                  66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                  70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                  71 : CST_COFINS := stcofinsOperAquiComIsensao;
                  72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                  73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                  74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                  75 : CST_COFINS := stcofinsOperAquiPorST;
                  98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                  99 : CST_COFINS := stcofinsOutrasOperacoes;
                end;
                CFOP       := FieldByName('cfop').AsInteger;
                INF_COMPL  := '';
                COD_CTA    := '';
              end;
              Next;
            end;
          end;
        end;
      end;
   end;
   FreeAndNil(Query);
end;

procedure TSPED_PC.DadosBlocoPC_9;
begin
  DmAcBr.ACBrSPEDPisCofins1.WriteBloco_9;
  CdsConsolidacao.Close;
  CdsConsolidacao.Destroy;

end;

procedure TSPED_PC.DadosBlocoPC_A(CdsEmpresa:TClientDataSet;pDatai,pDataf:TDateTime;CodEmp:Integer);
var AuxStr, aUF, aSitTribIPI : String;
    AuxAliq, AuxValor, AuxFrete, aValBaseICMS, aValICMS, aIndiceDespAcess : Double;
    aContador, AuxInt, IItens, NNotas, BNotas, i: Integer;
    QNota,QItem : TSQLQuery;
    aControle : Boolean;
    aNumReg, aRegAtual, aCodProAtual, aCST_PIS, aCST_COFINS : Integer;
begin
   QNota := TSqlQuery.Create(nil);
   QItem := TSqlQuery.Create(nil);
   QNota.SQLConnection := ConexaoDados;
   QItem.SQLConnection := ConexaoDados;
   //
   sProgressBar1.Max      := 0;
   sProgressBar1.Position := 0;
   with DmAcBr.ACBrSPEDPisCofins1.Bloco_A do
   begin
      with RegistroA001New do
      begin
         if not VerificaMovimentoBlocoA(pDatai,pDataf) then
         begin
            IND_MOV := imSemDados;
         end
         else
         begin
           //
           IND_MOV := imComDados;
           CdsEmpresa.First;
           while not CdsEmpresa.Eof do
           begin
             if VerificaMovimentoBlocoA(pDatai,pDataf,CdsEmpresa.FieldByName('id').AsInteger) then
             begin                                                              
               with RegistroA010New do
               begin
                 CNPJ := FiltraNumero(CdsEmpresa.FieldByName('CNPJ_CPF').AsString);
                 // notas de serviços
                 QNota.Close;
                 QNota.SQL.Clear;
                 QNota.SQL.Add('select distinct p.id,p.idcliente,p.status_nfe,');
                 QNota.SQL.Add('p.coo,p.data_entrega,p.tipo_frete,p.valor_outros,');
                 QNota.SQL.Add('p.valor_total,p.desconto,p.base_iss,P.valor_iss,');
                 QNota.SQL.Add('P.valor_ipi,C.cnpj_cpf,P.valor_pis,P.base_pis,');
                 QNota.SQL.Add('P.base_cofins,P.valor_cofins,P.chave_nfe,P.valor_frete from pedido p');
                 QNota.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                 QNota.SQL.Add('left outer join contato c on c.id = p.idcliente');
                 QNota.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                 QNota.SQL.Add('and p.cancelado = '+QuotedStr('N'));
                 QNota.SQL.Add('and p.numdav is not null');
                 QNota.SQL.Add('and p.idempresa = :pEmpresa');
                 QNota.SQL.Add('and cf.apropriar_icms_ap = 0');
                 QNota.SQL.Add('and cf.tipo = 4');
                 // SQL Itens
                 QItem.Close;
                 QItem.SQL.Clear;
                 QItem.SQL.Add('select i.idproduto,pr.unidade,i.aliq_iss,');
                 QItem.SQL.Add('i.aliq_pis,i.aliq_cofins,i.cfop,i.cst_pis,i.cst_cofins,');
                 QItem.SQL.Add('sum(i.quantidade) as qtd_produto,');
                 QItem.SQL.Add('sum(i.valor) as val_venda,');
                 QItem.SQL.Add('sum(i.valor_total) as total_produto,');
                 QItem.SQL.Add('sum(i.desconto) as val_desc,');
                 QItem.SQL.Add('sum(i.base_iss) as val_base_iss,');
                 QItem.SQL.Add('sum(i.valor_iss) as val_iss,');
                 QItem.SQL.Add('sum(i.base_pis) as val_base_pis,');
                 QItem.SQL.Add('sum(i.valor_pis) as val_pis,');
                 QItem.SQL.Add('sum(i.base_cofins) as val_base_cofins,');
                 QItem.SQL.Add('sum(i.valor_cofins) as val_cofins from pedido p');
                 QItem.SQL.Add('inner join pedido_itens i on i.idpedido = p.id');
                 QItem.SQL.Add('inner join produtos pr on pr.id = i.idproduto');
                 QItem.SQL.Add('where i.idpedido = :pCD_Saida');
                 QItem.SQL.Add('group by i.idproduto,pr.unidade,i.aliq_iss,i.desconto,');
                 QItem.SQL.Add('i.aliq_pis,i.aliq_cofins,i.cfop,i.cst_pis,i.cst_cofins');
                 // seleciona Dados
                 QNota.Params.ParamByName('pDatai').AsDate      := pDatai;
                 QNota.Params.ParamByName('pDataf').AsDate      := pDataf;
                 QNota.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                 QNota.Open;
                 //
                 aNumReg := RetornaQtdRegDBX(QNota);
                 sLbMensagem.Caption := 'Registros de Saidas';
                 sProgressBar1.Max := aNumReg;
                 Application.ProcessMessages;
                 aRegAtual := 0;
                 while not QNota.Eof do
                 begin
                   AuxFrete := 0;
                   if (QNota.FieldByName('STATUS_NFE').AsString = '100') or
                      (QNota.FieldByName('STATUS_NFE').AsString = '') then
                   begin
                     AuxFrete := QNota.FieldByName('Frete').AsFloat;
                     with RegistroA100New do
                     begin
                       COD_PART      := 'C'+IntToStrZero(QNota.FieldByName('idcliente').AsInteger,5);
                       IND_EMIT      := iedfProprio;
                       IND_OPER      := itoPrestado;
                       COD_SIT       := sdfRegular;
                       SER           := '';
                       NUM_DOC       := IntToStr(QNota.FieldByName('coo').AsInteger);
                       CHV_NFSE      := QNota.FieldByName('CHAVE_NFE').AsString;
                       DT_DOC        := QNota.FieldByName('data_entrega').AsDateTime;
                       DT_EXE_SERV   := QNota.FieldByName('data_entrega').AsDateTime;
                       IND_PGTO      := tpPrazo;
                       VL_DESC       := QNota.FieldByName('desconto').AsFloat;
                       VL_DOC        := QNota.FieldByName('valor_total').AsFloat;
                       aIndiceDespAcess := 1;
                       if QNota.FieldByName('valor_outros').AsFloat > 0 then
                          aIndiceDespAcess := (((QNota.FieldByName('BASE_ISS').AsFloat * 100)/ QNota.FieldByName('valor_total').AsFloat)/100);
                       VL_ISS       := QNota.FieldByName('VALOR_ISS').AsFloat;
                       //
                       VL_BC_PIS     := QNota.FieldByName('base_pis').AsFloat;
                       VL_PIS        := QNota.FieldByName('valor_pis').AsFloat;
                       VL_BC_COFINS  := QNota.FieldByName('base_cofins').AsFloat;
                       VL_COFINS     := QNota.FieldByName('valor_Cofins').AsFloat;
                       VL_PIS_RET    := 0;
                       VL_COFINS_RET := 0;
                       // Registro C170
    //                   if QNota.FieldByName('CHAVE_NFE').AsString = '' then
                       begin
                         QItem.Close;
                         QItem.Params.ParamByName('pCD_Saida').AsInteger := QNota.FieldByName('ID').AsInteger;
                         QItem.Open;
                         IItens := 0;
                         while not QItem.Eof do
                         begin
                           Inc(IItens);
                           with RegistroA170New do   //Inicio Adicionar os Itens:
                           begin
                              NUM_ITEM    := IItens;
                              COD_ITEM    := IntToStr(QItem.FieldByName('idproduto').AsInteger);
                              DESCR_COMPL := '';
                              if QItem.FieldByName('val_desc').AsFloat > 0 then
                                 AuxValor  := (QItem.FieldByName('val_venda').AsFloat - QItem.FieldByName('val_desc').AsFloat)
                              else
                                 AuxValor  := QItem.FieldByName('val_venda').AsFloat;
                              VL_ITEM          := (AuxValor*QItem.FieldByName('qtd_produto').AsFloat);
                              VL_DESC          := QItem.FieldByName('val_desc').AsFloat;
                              VL_ISS           := QItem.FieldByName('val_iss').AsFloat*aIndiceDespAcess;
                              aCST_PIS := QItem.FieldByname('cst_pis').AsInteger;
                              if aCST_PIS = 0 then
                                 aCST_PIS := 50;
                              case aCST_PIS of
                                01 : CST_PIS := stpisValorAliquotaNormal;
                                02 : CST_PIS := stpisValorAliquotaDiferenciada;
                                03 : CST_PIS := stpisQtdeAliquotaUnidade;
                                04 : CST_PIS := stpisMonofaticaAliquotaZero;
                                05 : CST_PIS := stpisValorAliquotaPorST;
                                06 : CST_PIS := stpisAliquotaZero;
                                07 : CST_PIS := stpisIsentaContribuicao;
                                08 : CST_PIS := stpisSemIncidenciaContribuicao;
                                09 : CST_PIS := stpisSuspensaoContribuicao;
                                49 : CST_PIS := stpisOutrasOperacoesSaida;
                                50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                                51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                                52 : CST_PIS := stpisOperCredExcRecExportacao;
                                53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                                54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                                55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                                56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                                60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                                61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                                62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                                63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                                64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                                65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                                66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                                70 : CST_PIS := stpisOperAquiSemDirCredito;
                                71 : CST_PIS := stpisOperAquiComIsensao;
                                72 : CST_PIS := stpisOperAquiComSuspensao;
                                73 : CST_PIS := stpisOperAquiAliquotaZero;
                                74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                                75 : CST_PIS := stpisOperAquiPorST;
                                98 : CST_PIS := stpisOutrasOperacoesEntrada;
                                99 : CST_PIS := stpisOutrasOperacoes;
                              end;
                              VL_BC_PIS := QItem.FieldByName('val_base_pis').AsFloat;
                              VL_PIS    := QItem.FieldByName('val_pis').AsFloat;
                              ALIQ_PIS  := QItem.FieldByName('aliq_pis').AsFloat;
                              //
                              aCST_COFINS := QItem.FieldByName('cst_cofins').AsInteger;
                              if aCST_COFINS = 0 then
                                 aCST_COFINS := 50;
                              case aCST_PIS of
                                01 : CST_COFINS := stcofinsValorAliquotaNormal;
                                02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                                03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                                04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                                05 : CST_COFINS := stcofinsValorAliquotaPorST;
                                06 : CST_COFINS := stcofinsAliquotaZero;
                                07 : CST_COFINS := stcofinsIsentaContribuicao;
                                08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                                09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                                49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                                50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                                51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                                52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                                53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                                54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                                55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                                56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                                60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                                61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                                62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                                63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                                64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                                65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                                66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                                70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                                71 : CST_COFINS := stcofinsOperAquiComIsensao;
                                72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                                73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                                74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                                75 : CST_COFINS := stcofinsOperAquiPorST;
                                98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                                99 : CST_COFINS := stcofinsOutrasOperacoes;
                              end;
                              VL_BC_COFINS     := QItem.FieldByName('val_base_cofins').AsFloat;
                              VL_COFINS        := QItem.FieldByName('val_cofins').AsFloat;
                              ALIQ_COFINS      := QItem.FieldByName('aliq_cofins').AsFloat;
                              COD_CTA          := '';
                            end; //Fim dos Itens;
                            QItem.Next;
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
             end;
             CdsEmpresa.Next;
          end;
        end;
      end;
   end;


end;

procedure TSPED_PC.DadosBlocoPC_C(CdsEmpresa:TClientDataSet;pDatai,
  pDataf:TDateTime;CodEmp,pEscrApur:Integer; VerificaSTIPI:Boolean);
var AuxStr, aUF, aSitTribIPI : String;
    AuxAliq, AuxValor, AuxFrete, aValBaseICMS, aValICMS, aIndiceDespAcess : Double;
    aContador, AuxInt, IItens, NNotas, BNotas, i, aCST_PIS, aCST_COFINS: Integer;
    QNota,QItem : TSQLQuery;
    Q400,Q405,Q481,Q485,Q490 : TSQLQuery;
    aControle, GerarRegistro100 : Boolean;
    aDataMov : TDateTime;
    aNumReg, aRegAtual : Integer;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco C.
   QNota := TSqlQuery.Create(nil);
   QItem := TSqlQuery.Create(nil);
   Q400 := TSqlQuery.Create(nil);
   Q405 := TSqlQuery.Create(nil);
   Q481 := TSqlQuery.Create(nil);
   Q485 := TSqlQuery.Create(nil);
   Q490 := TSqlQuery.Create(nil);
   QNota.SQLConnection := ConexaoDados;
   QItem.SQLConnection := ConexaoDados;
   Q400.SQLConnection := ConexaoDados;
   Q405.SQLConnection := ConexaoDados;
   Q481.SQLConnection := ConexaoDados;
   Q485.SQLConnection := ConexaoDados;
   Q490.SQLConnection := ConexaoDados;
   CriaPreparaTabelaConsolidacao;
   //
   sProgressBar1.Max     := 0;
   sProgressBar1.Position:= 0 ;
   with DmAcBr.ACBrSPEDPisCofins1.Bloco_C do
   begin
      with RegistroC001New do
      begin
         if pEscrApur <> 2 then
         begin
           IND_MOV := imSemDados;
         end
         else
         begin
           IND_MOV := imComDados;
           //
           CdsEmpresa.First;
           while not CdsEmpresa.Eof do
           begin
  //           if VerificaMovimentoPisCofins(CdsEmpresa.FieldByName('id').AsInteger,pDatai,pDataf) then
             begin
               with RegistroC010New do
               begin
                 CNPJ      := FiltraNumero(CdsEmpresa.FieldByName('CNPJ_CPF').AsString);
                 IND_ESCRI := IndEscriConsolidado;
                 // notas de entrada
                 if sNotasEntrada then
                 begin
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
                   QItem.SQL.Add('i.aliq_cofins,I.cst,i.cfop,i.cst_ipi,');
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
                   QItem.SQL.Add('i.aliq_cofins,I.cst,i.cfop,i.cst_ipi');
                   // seleciona Dados
                   QNota.Params.ParamByName('pDatai').AsDate      := pDatai;
                   QNota.Params.ParamByName('pDataf').AsDate      := pDataf;
                   QNota.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                   QNota.Open;
                   aNumReg := RetornaQtdRegDBX(QNota);
                   sLbMensagem.Caption := 'Registros de Entrada';
                   sProgressBar1.Max := aNumReg;
                   Application.ProcessMessages;
                   aRegAtual := 0;
                   while not QNota.Eof do
                   begin
                     AuxFrete := 0;
                     if (QNota.FieldByName('STATUS_NFE').AsString = '100') or
                        (QNota.FieldByName('STATUS_NFE').AsString = '') then
                     begin
                       GerarRegistro100 := true;
                       // verifica em caso de falta de chave se tem registro de lançamento na tabela nfemsg
//                       if QNota.FieldByName('STATUS_NFE').AsString = '' then
//                       begin
//                         if not(VerificaLancamentoNFEMSG(QNota.FieldByName('ID').AsInteger,0)) then
//                            GerarRegistro100 := false;
//                       end;
                       // adicionar o regisotro
                       if GerarRegistro100 then
                       begin
                         AuxFrete := QNota.FieldByName('valor_Frete').AsFloat;
                         with RegistroC100New do
                         begin
                           COD_PART      := 'F'+IntToStrZero(QNota.FieldByName('idfornecedor').AsInteger,5);
                           if QNota.FieldByName('deolucao').AsString = 'N' then
                              IND_EMIT      := edEmissaoPropria
                           else
                              IND_EMIT      := edTerceiros;
                           NUM_DOC       := IntToStr(QNota.FieldByName('nota').AsInteger);
                           IND_OPER      := tpEntradaAquisicao;
                           if QNota.FieldByName('CHAVE_NFE').AsString <> '' then
                              COD_MOD       := '55'
                           else
                              COD_MOD       := '01';
                           COD_SIT       := sdRegular;
                           SER           := '';
                           CHV_NFE       := QNota.FieldByName('CHAVE_NFE').AsString;
                           DT_DOC        := QNota.FieldByName('Data_compra').AsDateTime;
                           DT_E_S        := QNota.FieldByName('Data_compra').AsDateTime;
                           if (VerificaSTIPI) and
                              (not VerificaSTProdutosNota(QNota.FieldByName('ID').AsInteger,0)) then
                           begin
                             AuxValor := ((QNota.FieldByName('valor_total').AsFloat - QNota.FieldByName('valor_icms_st').AsFloat) - QNota.FieldByName('valor_ipi').AsFloat);
                             AuxValor := AuxValor;
                             VL_DOC        := AuxValor;
                             VL_BC_ICMS_ST := 0;
                             VL_ICMS_ST    := 0;
                           end
                           else
                           begin
                             AuxValor := (QNota.FieldByName('valor_total').AsFloat - QNota.FieldByName('valor_ipi').AsFloat);
                             AuxValor := AuxValor;
                             VL_DOC        := AuxValor;
                             VL_BC_ICMS_ST := QNota.FieldByName('val_base_icms_sub').AsFloat;
                             VL_ICMS_ST    := QNota.FieldByName('val_icms_sub').AsFloat;
                           end;
                           IND_PGTO      := tpPrazo;
                           VL_DESC       := QNota.FieldByName('desconto').AsFloat;
                           VL_ABAT_NT    := 0;
                           VL_MERC       := QNota.FieldByName('valor_total').AsFloat;
                           IND_FRT       := tfSemCobrancaFrete;
                           VL_SEG        := QNota.FieldByName('valor_seguro').AsFloat;
                           VL_OUT_DA     := QNota.FieldByName('valor_outros').AsFloat;
                           aIndiceDespAcess := 1;
                           if QNota.FieldByName('valor_outros').AsFloat > 0 then
                              aIndiceDespAcess := (((QNota.FieldByName('BASE_ICMS').AsFloat * 100)/ QNota.FieldByName('valor_total').AsFloat)/100);
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
            //               if QNota.FieldByName('CHAVE_NFE').AsString = '' then
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
                                  NUM_ITEM    := FormatFloat('000', IItens);
                                  COD_ITEM    := IntToStr(QItem.FieldByName('idproduto').AsInteger);
                                  DESCR_COMPL := '';
                                  QTD         := QItem.FieldByName('qtd_produto').AsFloat;
                                  UNID        := QItem.FieldByName('unidade').AsString;
                                  AuxValor    := (QItem.FieldByName('val_custo').AsFloat - QItem.FieldByName('val_desc').AsFloat);
                                  VL_ITEM          := (AuxValor*QItem.FieldByName('qtd_produto').AsFloat);
                                  VL_DESC          := QItem.FieldByName('val_desc').AsFloat;
                                  IND_MOV          := mfNao;
                                  //
                                  case StrToInt(QItem.FieldByName('cst').AsString) of
                                     0: CST_ICMS   := sticmsTributadaIntegralmente;
                                    10: CST_ICMS   := sticmsTributadaComCobracaPorST;
                                    20: CST_ICMS   := sticmsComReducao;
                                    40: CST_ICMS   := sticmsIsenta;
                                    41: CST_ICMS   := sticmsNaoTributada;
                                    60: CST_ICMS   := sticmsCobradoAnteriormentePorST;
                                    70: CST_ICMS   := sticmsComReducaoPorST;
                                  end;
                                  CFOP             := FiltraNumero(QItem.FieldByName('cfop').AsString);
                                  COD_NAT          := '';
                                  VL_BC_ICMS       := QItem.FieldByName('val_base_icms').AsFloat*aIndiceDespAcess;
                                  ALIQ_ICMS        := QItem.FieldByName('aliq_icms').AsFloat;
                                  VL_ICMS          := QItem.FieldByName('val_icms').AsFloat*aIndiceDespAcess;
                                  VL_BC_ICMS_ST    := QItem.FieldByName('val_base_icms_sub').AsFloat;
                                  ALIQ_ST          := QItem.FieldByName('aliq_icms_st').AsFloat;
                                  VL_ICMS_ST       := QItem.FieldByName('val_icms_sub').AsFloat;
                                  IND_APUR         := iaMensal;
                                  aSitTribIPI      := QItem.FieldByName('CST_IPI').AsString;
                                  if aSitTribIPI = '' then
                                     aSitTribIPI := '49';
                                  case StrToInt(aSitTribIPI) of
                                     0 : CST_IPI := stipiEntradaRecuperacaoCredito;
                                     1 : CST_IPI := stipiEntradaTributradaZero;
                                     2 : CST_IPI := stipiEntradaIsenta;
                                     3 : CST_IPI := stipiEntradaNaoTributada;
                                     4 : CST_IPI := stipiEntradaImune;
                                     5 : CST_IPI := stipiEntradaComSuspensao;
                                    49 : CST_IPI := stipiOutrasEntradas;
                                    50 : CST_IPI := stipiSaidaTributada;
                                    51 : CST_IPI := stipiSaidaTributadaZero;
                                    52 : CST_IPI := stipiSaidaIsenta;
                                    53 : CST_IPI := stipiSaidaNaoTributada;
                                    54 : CST_IPI := stipiSaidaImune;
                                    55 : CST_IPI := stipiSaidaComSuspensao;
                                    99 : CST_IPI := stipiOutrasSaidas;
                                  end;
                                  COD_ENQ          := '';
                                  VL_BC_IPI        := QItem.FieldByName('val_base_ipi').AsFloat;
                                  ALIQ_IPI         := QItem.FieldByName('aliq_ipi').AsFloat;
                                  VL_IPI           := QItem.FieldByName('val_ipi').AsFloat;
                                  aCST_PIS := QItem.FieldByname('cst_pis').AsInteger;
                                  if aCST_PIS = 0 then
                                     aCST_PIS := 99;
                                  case aCST_PIS of
                                    01 : CST_PIS := stpisValorAliquotaNormal;
                                    02 : CST_PIS := stpisValorAliquotaDiferenciada;
                                    03 : CST_PIS := stpisQtdeAliquotaUnidade;
                                    04 : CST_PIS := stpisMonofaticaAliquotaZero;
                                    05 : CST_PIS := stpisValorAliquotaPorST;
                                    06 : CST_PIS := stpisAliquotaZero;
                                    07 : CST_PIS := stpisIsentaContribuicao;
                                    08 : CST_PIS := stpisSemIncidenciaContribuicao;
                                    09 : CST_PIS := stpisSuspensaoContribuicao;
                                    49 : CST_PIS := stpisOutrasOperacoesSaida;
                                    50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                                    51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                                    52 : CST_PIS := stpisOperCredExcRecExportacao;
                                    53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                                    54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                                    55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                                    56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                                    60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                                    61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                                    62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                                    63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                                    64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                                    65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                                    66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                                    70 : CST_PIS := stpisOperAquiSemDirCredito;
                                    71 : CST_PIS := stpisOperAquiComIsensao;
                                    72 : CST_PIS := stpisOperAquiComSuspensao;
                                    73 : CST_PIS := stpisOperAquiAliquotaZero;
                                    74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                                    75 : CST_PIS := stpisOperAquiPorST;
                                    98 : CST_PIS := stpisOutrasOperacoesEntrada;
                                    99 : CST_PIS := stpisOutrasOperacoes;
                                  end;
                                  VL_BC_PIS        := QItem.FieldByName('val_base_pis').AsFloat;
                                  ALIQ_PIS_PERC    := QItem.FieldByName('aliq_pis').AsFloat;
                                  QUANT_BC_PIS     := 0;
                                  ALIQ_PIS_R       := 0;
                                  VL_PIS           := QItem.FieldByName('val_pis').AsFloat;
                                  aCST_COFINS := QItem.FieldByName('cst_cofins').AsInteger;
                                  if aCST_COFINS = 0 then
                                     aCST_COFINS := 99;
                                  case aCST_PIS of
                                    01 : CST_COFINS := stcofinsValorAliquotaNormal;
                                    02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                                    03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                                    04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                                    05 : CST_COFINS := stcofinsValorAliquotaPorST;
                                    06 : CST_COFINS := stcofinsAliquotaZero;
                                    07 : CST_COFINS := stcofinsIsentaContribuicao;
                                    08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                                    09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                                    49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                                    50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                                    51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                                    52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                                    53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                                    54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                                    55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                                    56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                                    60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                                    61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                                    62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                                    63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                                    64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                                    65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                                    66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                                    70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                                    71 : CST_COFINS := stcofinsOperAquiComIsensao;
                                    72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                                    73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                                    74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                                    75 : CST_COFINS := stcofinsOperAquiPorST;
                                    98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                                    99 : CST_COFINS := stcofinsOutrasOperacoes;
                                  end;
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
                 // seleciona Dados
                 QNota.Params.ParamByName('pDatai').AsDate      := pDatai;
                 QNota.Params.ParamByName('pDataf').AsDate      := pDataf;
                 QNota.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('ID').AsInteger;
                 QNota.Open;
                 //
                 aNumReg := RetornaQtdRegDBX(QNota);
                 sLbMensagem.Caption := 'Registros de Saidas';
                 sProgressBar1.Max := aNumReg;
                 Application.ProcessMessages;
                 aRegAtual := 0;
                 while not QNota.Eof do
                 begin
                   AuxFrete := 0;
                   if (QNota.FieldByName('STATUS_NFE').AsString = '100') or
                      (QNota.FieldByName('STATUS_NFE').AsString = '') then
                   begin
                     GerarRegistro100 := true;
                     // verifica em caso de falta de chave se tem registro de lançamento na tabela nfemsg
                     if QNota.FieldByName('STATUS_NFE').AsString = '' then
                        GerarRegistro100 := false;
                     // adicionar o regisotro
                     if GerarRegistro100 then
                     begin
                       AuxFrete := QNota.FieldByName('valor_Frete').AsFloat;
                       with RegistroC100New do
                       begin
                         COD_PART      := 'C'+IntToStrZero(QNota.FieldByName('idcliente').AsInteger,5);
                         IND_EMIT      := edEmissaoPropria;
                         IND_OPER      := tpSaidaPrestacao;
                         if QNota.FieldByName('CHAVE_NFE').AsString <> '' then
                            COD_MOD       := '55'
                         else
                            COD_MOD       := '01';
                         COD_SIT       := sdRegular;
                         SER           := '';
                         NUM_DOC       := IntToStr(QNota.FieldByName('numero_doc').AsInteger);
                         CHV_NFE       := QNota.FieldByName('CHAVE_NFE').AsString;
                         DT_DOC        := QNota.FieldByName('Data_entrega').AsDateTime;
                         DT_E_S        := QNota.FieldByName('Data_entrega').AsDateTime;
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
                           AuxValor := (QNota.FieldByName('valor_total').AsFloat - QNota.FieldByName('valor_ipi').AsFloat);
                           AuxValor := AuxValor;
                           VL_DOC        := AuxValor;
                           VL_BC_ICMS_ST := QNota.FieldByName('base_icms_st').AsFloat;
                           VL_ICMS_ST    := QNota.FieldByName('valor_icms_st').AsFloat;
                         end;
                         IND_PGTO      := tpPrazo;
                         VL_DESC       := QNota.FieldByName('desconto').AsFloat;
                         VL_ABAT_NT    := 0;
                         VL_MERC       := QNota.FieldByName('valor_total').AsFloat;
                         IND_FRT       := tfSemCobrancaFrete;
                         VL_SEG        := QNota.FieldByName('valor_seguro').AsFloat;
                         VL_OUT_DA     := QNota.FieldByName('valor_outros').AsFloat;
                         aIndiceDespAcess := 1;
                         if QNota.FieldByName('valor_outros').AsFloat > 0 then
                            aIndiceDespAcess := (((QNota.FieldByName('BASE_ICMS').AsFloat * 100)/ QNota.FieldByName('valor_total').AsFloat)/100);
                         VL_BC_ICMS    := QNota.FieldByName('BASE_ICMS').AsFloat;
                         VL_ICMS       := QNota.FieldByName('VALOR_ICMS').AsFloat;

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
    //                     if QNota.FieldByName('CHAVE_NFE').AsString = '' then
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
                                COD_ITEM    := IntToStr(QItem.FieldByName('idproduto').AsInteger);
                                DESCR_COMPL := '';
                                QTD         := QItem.FieldByName('qtd_produto').AsFloat;
                                UNID        := QItem.FieldByName('unidade').AsString;
                                AuxValor    := (QItem.FieldByName('val_venda').AsFloat - QItem.FieldByName('val_desc').AsFloat);
                                VL_ITEM          := (AuxValor*QItem.FieldByName('qtd_produto').AsFloat);
                                VL_DESC          := QItem.FieldByName('val_desc').AsFloat;
                                IND_MOV          := mfNao;
                                case StrToInt(QItem.FieldByName('cst').AsString) of
                                   0: CST_ICMS   := sticmsTributadaIntegralmente;
                                  10: CST_ICMS   := sticmsTributadaComCobracaPorST;
                                  20: CST_ICMS   := sticmsComReducao;
                                  40: CST_ICMS   := sticmsIsenta;
                                  41: CST_ICMS   := sticmsNaoTributada;
                                  60: CST_ICMS   := sticmsCobradoAnteriormentePorST;
                                  70: CST_ICMS   := sticmsComReducaoPorST;
                                end;
                                CFOP             := FiltraNumero(QItem.FieldByName('cfop').AsString);
                                COD_NAT          := '';
                                VL_BC_ICMS       := QItem.FieldByName('val_base_icms').AsFloat*aIndiceDespAcess;
                                ALIQ_ICMS        := QItem.FieldByName('aliq_icms').AsFloat;
                                VL_ICMS          := QItem.FieldByName('val_icms').AsFloat*aIndiceDespAcess;
                                VL_BC_ICMS_ST    := QItem.FieldByName('val_base_icms_sub').AsFloat;
                                ALIQ_ST          := QItem.FieldByName('aliq_icms_st').AsFloat;
                                VL_ICMS_ST       := QItem.FieldByName('val_icms_sub').AsFloat;
                                IND_APUR         := iaMensal;
                                aSitTribIPI      := QItem.FieldByName('cst_ipi').AsString;
                                if aSitTribIPI = '' then
                                   aSitTribIPI := '99';
                                case StrToInt(aSitTribIPI) of
                                   0 : CST_IPI := stipiEntradaRecuperacaoCredito;
                                   1 : CST_IPI := stipiEntradaTributradaZero;
                                   2 : CST_IPI := stipiEntradaIsenta;
                                   3 : CST_IPI := stipiEntradaNaoTributada;
                                   4 : CST_IPI := stipiEntradaImune;
                                   5 : CST_IPI := stipiEntradaComSuspensao;
                                  49 : CST_IPI := stipiOutrasEntradas;
                                  50 : CST_IPI := stipiSaidaTributada;
                                  51 : CST_IPI := stipiSaidaTributadaZero;
                                  52 : CST_IPI := stipiSaidaIsenta;
                                  53 : CST_IPI := stipiSaidaNaoTributada;
                                  54 : CST_IPI := stipiSaidaImune;
                                  55 : CST_IPI := stipiSaidaComSuspensao;
                                  99 : CST_IPI := stipiOutrasSaidas;
                               end;
                                COD_ENQ          := '';
                                VL_BC_IPI        := QItem.FieldByName('val_base_ipi').AsFloat;
                                ALIQ_IPI         := QItem.FieldByName('aliq_ipi').AsFloat;
                                VL_IPI           := QItem.FieldByName('val_ipi').AsFloat;
                                aCST_PIS := QItem.FieldByname('cst_pis').AsInteger;
                                if aCST_PIS = 0 then
                                   aCST_PIS := 49;
                                case aCST_PIS of
                                  01 : CST_PIS := stpisValorAliquotaNormal;
                                  02 : CST_PIS := stpisValorAliquotaDiferenciada;
                                  03 : CST_PIS := stpisQtdeAliquotaUnidade;
                                  04 : CST_PIS := stpisMonofaticaAliquotaZero;
                                  05 : CST_PIS := stpisValorAliquotaPorST;
                                  06 : CST_PIS := stpisAliquotaZero;
                                  07 : CST_PIS := stpisIsentaContribuicao;
                                  08 : CST_PIS := stpisSemIncidenciaContribuicao;
                                  09 : CST_PIS := stpisSuspensaoContribuicao;
                                  49 : CST_PIS := stpisOutrasOperacoesSaida;
                                  50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                                  51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                                  52 : CST_PIS := stpisOperCredExcRecExportacao;
                                  53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                                  54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                                  55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                                  56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                                  60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                                  61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                                  62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                                  63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                                  64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                                  65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                                  66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                                  70 : CST_PIS := stpisOperAquiSemDirCredito;
                                  71 : CST_PIS := stpisOperAquiComIsensao;
                                  72 : CST_PIS := stpisOperAquiComSuspensao;
                                  73 : CST_PIS := stpisOperAquiAliquotaZero;
                                  74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                                  75 : CST_PIS := stpisOperAquiPorST;
                                  98 : CST_PIS := stpisOutrasOperacoesEntrada;
                                  99 : CST_PIS := stpisOutrasOperacoes;
                                end;
                                VL_BC_PIS        := QItem.FieldByName('val_base_pis').AsFloat;
                                ALIQ_PIS_PERC    := QItem.FieldByName('aliq_pis').AsFloat;
                                QUANT_BC_PIS     := 0;
                                ALIQ_PIS_R       := 0;
                                VL_PIS           := QItem.FieldByName('val_pis').AsFloat;
                                aCST_COFINS := QItem.FieldByName('cst_cofins').AsInteger;
                                if aCST_COFINS = 0 then
                                   aCST_COFINS := 49;
                                case aCST_PIS of
                                  01 : CST_COFINS := stcofinsValorAliquotaNormal;
                                  02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                                  03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                                  04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                                  05 : CST_COFINS := stcofinsValorAliquotaPorST;
                                  06 : CST_COFINS := stcofinsAliquotaZero;
                                  07 : CST_COFINS := stcofinsIsentaContribuicao;
                                  08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                                  09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                                  49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                                  50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                                  51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                                  52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                                  53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                                  54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                                  55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                                  56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                                  60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                                  61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                                  62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                                  63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                                  64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                                  65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                                  66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                                  70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                                  71 : CST_COFINS := stcofinsOperAquiComIsensao;
                                  72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                                  73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                                  74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                                  75 : CST_COFINS := stcofinsOperAquiPorST;
                                  98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                                  99 : CST_COFINS := stcofinsOutrasOperacoes;
                                end;
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
                       end;
                     end;
                   end;
                   Inc(aRegAtual);
                   sProgressBar1.Position := aRegAtual;
                   Application.ProcessMessages;
                   //
                   QNota.Next;
                 end;
                 // Registro C180 referente a vendas
                 QNota.Close;
                 QNota.SQL.Clear;
                 QNota.SQL.Add('select i.idproduto,pr.codigo_ncm,');
                 QNota.SQL.Add('sum(i.valor - i.desconto) as val_prod');
                 QNota.SQL.Add('from pedido p');
                 QNota.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                 QNota.SQL.Add('inner join pedido_itens i on i.idpedido = p.id');
                 QNota.SQL.Add('inner join produtos pr on pr.id = i.idproduto');
                 QNota.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                 QNota.SQL.Add('and p.cancelado = '+QuotedStr('N'));
                 QNota.SQL.Add('and p.numero_doc is not null');
                 QNota.SQL.Add('and p.idempresa = :pEmpresa');
                 QNota.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                 QNota.SQL.Add('group by i.idproduto,pr.codigo_ncm');
                 // seleciona Dados
                 QNota.Params.ParamByName('pDatai').AsDate      := pDatai;
                 QNota.Params.ParamByName('pDataf').AsDate      := pDataf;
                 QNota.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                 QNota.Open;
                 aNumReg := RetornaQtdRegDBX(QNota);
                 sLbMensagem.Caption := 'Consolidação de saídas';
                 sProgressBar1.Max := aNumReg;
                 Application.ProcessMessages;
                 aRegAtual := 0;
                 while not QNota.Eof do
                 begin
                   with RegistroC180New do
                   begin
                     COD_MOD     := '55';
                     DT_DOC_INI  := pDatai;
                     DT_DOC_FIN  := pDataf;
                     COD_ITEM    := IntToStr(QNota.FieldByname('IDPRODUTO').AsInteger);
                     COD_NCM     := Trim(QNota.FieldByname('CODIGO_NCM').AsString);
                     EX_IPI      := '';
                     VL_TOT_ITEM := QNota.FieldByname('val_prod').AsFloat;
                     // registro C181
                     QItem.Close;
                     QItem.SQL.Clear;
                     QItem.SQL.Add('select i.cst_pis,i.cfop,i.aliq_pis,');
                     QItem.SQL.Add('sum((i.valor - i.desconto) * i.quantidade) as val_prod,');
                     QItem.SQL.Add('sum(i.desconto) as val_desc,');
                     QItem.SQL.Add('sum(i.valor_pis) as val_pis from pedido p');
                     QItem.SQL.Add('inner join pedido_itens i on i.idpedido = p.id');
                     QItem.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                     QItem.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                     QItem.SQL.Add('and p.cancelado = '+QuotedStr('N'));
                     QItem.SQL.Add('and p.numero_doc is not null');
                     QItem.SQL.Add('and p.idempresa = :pEmpresa');
                     QItem.SQL.Add('and cf.apropriar_icms_ap = 0');
                     QItem.SQL.Add('and i.idproduto = :pCd_Prod');
                     QItem.SQL.Add('group by i.cst_pis,i.cfop,i.aliq_pis');
                     QItem.Params.ParamByName('pDatai').AsDate      := pDatai;
                     QItem.Params.ParamByName('pDataf').AsDate      := pDataf;
                     QItem.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                     QItem.Params.ParamByName('pCd_Prod').AsInteger := QNota.FieldByname('idproduto').AsInteger;
                     QItem.Open;
                     CdsConsolidacao.EmptyDataSet;
                     while not QItem.Eof do
                     begin
                       if not CdsConsolidacao.Locate('CST;CFOP',VarArrayOf([QItem.FieldByName('cst_pis').AsString,
                                                                            QItem.FieldByName('cfop').AsString]),[]) then
                       begin
                         CdsConsolidacao.Append;
                         CdsConsolidacao.FieldByName('CST').AsString  := QItem.FieldByName('cst_pis').AsString;
                         CdsConsolidacao.FieldByName('CFOP').AsString := FiltraNumero(QItem.FieldByName('cfop').AsString);
                         CdsConsolidacao.FieldByName('ALIQ').AsFloat  := QItem.FieldByName('aliq_pis').AsFloat;
                       end
                       else
                       begin
                         CdsConsolidacao.Edit;
                       end;
                       // captura o valor
                       CdsConsolidacao.FieldByName('VL_ITEM').AsFloat := CdsConsolidacao.FieldByName('VL_ITEM').AsFloat + QItem.FieldByName('Val_Prod').AsFloat;
                       CdsConsolidacao.FieldByName('VL_DESC').AsFloat := CdsConsolidacao.FieldByName('VL_DESC').AsFloat + QItem.FieldByName('Val_Desc').AsFloat;
                       CdsConsolidacao.FieldByName('VL_BC').AsFloat   := CdsConsolidacao.FieldByName('VL_BC').AsFloat   + QItem.FieldByName('Val_Prod').AsFloat;
                       CdsConsolidacao.FieldByName('VL').AsFloat      := CdsConsolidacao.FieldByName('VL').AsFloat      + QItem.FieldByName('Val_Pis').AsFloat;
                       CdsConsolidacao.Post;
                       //
                       QItem.Next;
                     end;
                     //
                     CdsConsolidacao.First;
                     while not CdsConsolidacao.Eof do
                     begin
                       with RegistroC181New do
                       begin
                         aCST_PIS := CdsConsolidacao.FieldByName('cst_pis').AsInteger;
                         if aCST_PIS = 0 then
                            aCST_PIS := 50;
                         case aCST_PIS of
                           01 : CST_PIS := stpisValorAliquotaNormal;
                           02 : CST_PIS := stpisValorAliquotaDiferenciada;
                           03 : CST_PIS := stpisQtdeAliquotaUnidade;
                           04 : CST_PIS := stpisMonofaticaAliquotaZero;
                           05 : CST_PIS := stpisValorAliquotaPorST;
                           06 : CST_PIS := stpisAliquotaZero;
                           07 : CST_PIS := stpisIsentaContribuicao;
                           08 : CST_PIS := stpisSemIncidenciaContribuicao;
                           09 : CST_PIS := stpisSuspensaoContribuicao;
                           49 : CST_PIS := stpisOutrasOperacoesSaida;
                           50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                           51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                           52 : CST_PIS := stpisOperCredExcRecExportacao;
                           53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                           54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                           55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                           56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                           60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                           61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                           62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                           63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                           64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                           65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                           66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                           70 : CST_PIS := stpisOperAquiSemDirCredito;
                           71 : CST_PIS := stpisOperAquiComIsensao;
                           72 : CST_PIS := stpisOperAquiComSuspensao;
                           73 : CST_PIS := stpisOperAquiAliquotaZero;
                           74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                           75 : CST_PIS := stpisOperAquiPorST;
                           98 : CST_PIS := stpisOutrasOperacoesEntrada;
                           99 : CST_PIS := stpisOutrasOperacoes;
                         end;
                         CFOP           := FiltraNumero(CdsConsolidacao.FieldByName('cfop').AsString);
                         VL_ITEM        := CdsConsolidacao.FieldByName('vl_item').AsFloat;
                         VL_DESC        := CdsConsolidacao.FieldByName('vl_desc').AsFloat;
                         VL_BC_PIS      := CdsConsolidacao.FieldByName('vl_bc').AsFloat;
                         ALIQ_PIS       := CdsConsolidacao.FieldByName('aliq').AsFloat;
                         QUANT_BC_PIS   := 0;
                         ALIQ_PIS_QUANT := 0;
                         VL_PIS         := CdsConsolidacao.FieldByName('vl').AsFloat;
                         COD_CTA        := '';
                       end;
                       CdsConsolidacao.Next;
                     end;
                     // registro C185
                     QItem.Close;
                     QItem.SQL.Clear;
                     QItem.SQL.Add('select i.cst_cofins,i.cfop,i.aliq_cofins,');
                     QItem.SQL.Add('sum((i.valor - i.desconto) * i.quantidade) as val_prod,');
                     QItem.SQL.Add('sum(i.desconto) as val_desc,');
                     QItem.SQL.Add('sum(i.valor_cofins) as val_cofins from pedido p');
                     QItem.SQL.Add('inner join pedido_itens i on i.idpedido = p.id');
                     QItem.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                     QItem.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                     QItem.SQL.Add('and p.cancelado = '+QuotedStr('N'));
                     QItem.SQL.Add('and p.numero_doc is not null');
                     QItem.SQL.Add('and p.idempresa = :pEmpresa');
                     QItem.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                     QItem.SQL.Add('and i.idproduto = :pCd_Prod');
                     QItem.SQL.Add('group by i.cst_cofins,i.cfop,i.aliq_cofins');
                     QItem.Params.ParamByName('pDatai').AsDate      := pDatai;
                     QItem.Params.ParamByName('pDataf').AsDate      := pDataf;
                     QItem.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                     QItem.Params.ParamByName('pCd_Prod').AsInteger := QNota.FieldByname('IDPRODUTO').AsInteger;
                     QItem.Open;
                     CdsConsolidacao.EmptyDataSet;
                     while not QItem.Eof do
                     begin
                       if not CdsConsolidacao.Locate('CST;CFOP',VarArrayOf([QItem.FieldByName('cst_cofins').AsString,
                                                                            QItem.FieldByName('cfop').AsString]),[]) then
                       begin
                         CdsConsolidacao.Append;
                         CdsConsolidacao.FieldByName('CST').AsString  := QItem.FieldByName('cst_cofins').AsString;
                         CdsConsolidacao.FieldByName('CFOP').AsString := FiltraNumero(QItem.FieldByName('cfop').AsString);
                         CdsConsolidacao.FieldByName('ALIQ').AsFloat  := QItem.FieldByName('aliq_cofins').AsFloat;
                       end
                       else
                       begin
                         CdsConsolidacao.Edit;
                       end;
                       //
                       CdsConsolidacao.FieldByName('VL_ITEM').AsFloat := CdsConsolidacao.FieldByName('VL_ITEM').AsFloat + QItem.FieldByName('Val_Prod').AsFloat;
                       CdsConsolidacao.FieldByName('VL_DESC').AsFloat := CdsConsolidacao.FieldByName('VL_DESC').AsFloat + QItem.FieldByName('Val_Desc').AsFloat;
                       CdsConsolidacao.FieldByName('VL_BC').AsFloat   := CdsConsolidacao.FieldByName('VL_BC').AsFloat   + QItem.FieldByName('Val_Prod').AsFloat;
                       CdsConsolidacao.FieldByName('VL').AsFloat      := CdsConsolidacao.FieldByName('VL').AsFloat      + QItem.FieldByName('Val_cofins').AsFloat;
                       CdsConsolidacao.Post;
                       //
                       QItem.Next;
                     end;
                     //
                     CdsConsolidacao.First;
                     while not CdsConsolidacao.Eof do
                     begin
                       with RegistroC185New do
                       begin
                         aCST_PIS := CdsConsolidacao.FieldByName('cst').AsInteger;
                         if aCST_PIS = 0 then
                            aCST_PIS := 50;
                         case aCST_PIS of
                           01 : CST_COFINS := stcofinsValorAliquotaNormal;
                           02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                           03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                           04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                           05 : CST_COFINS := stcofinsValorAliquotaPorST;
                           06 : CST_COFINS := stcofinsAliquotaZero;
                           07 : CST_COFINS := stcofinsIsentaContribuicao;
                           08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                           09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                           49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                           50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                           51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                           52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                           53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                           54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                           55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                           56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                           60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                           61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                           62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                           63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                           64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                           65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                           66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                           70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                           71 : CST_COFINS := stcofinsOperAquiComIsensao;
                           72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                           73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                           74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                           75 : CST_COFINS := stcofinsOperAquiPorST;
                           98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                           99 : CST_COFINS := stcofinsOutrasOperacoes;
                         end;
                         CFOP              := FiltraNumero(CdsConsolidacao.FieldByName('cfop').AsString);
                         VL_ITEM           := CdsConsolidacao.FieldByName('vl_item').AsFloat;
                         VL_DESC           := CdsConsolidacao.FieldByName('Vl_Desc').AsFloat;
                         VL_BC_COFINS      := CdsConsolidacao.FieldByName('vl_item').AsFloat;
                         ALIQ_COFINS       := CdsConsolidacao.FieldByName('aliq').AsFloat;
                         QUANT_BC_COFINS   := 0;
                         ALIQ_COFINS_QUANT := 0;
                         VL_COFINS         := CdsConsolidacao.FieldByName('vl').AsFloat;
                         COD_CTA           := '';
                       end;
                       CdsConsolidacao.Next;
                     end;
                   end;
                   Inc(aRegAtual);
                   sProgressBar1.Position := aRegAtual;
                   Application.ProcessMessages;
                   //
                   QNota.Next;
                 end;
                 // Registro C190 referente a compras
                 if sNotasEntrada then
                 begin
                   QNota.Close;
                   QNota.SQL.Clear;
                   QNota.SQL.Add('select i.idproduto,pr.codigo_ncm,');
                   QNota.SQL.Add('sum((i.valor - i.desconto) * i.quantidade) as val_prod');
                   QNota.SQL.Add('from compras c');
                   QNota.SQL.Add('left outer join classificacao cf on c.id_classificacao = cf.id');
                   QNota.SQL.Add('inner join compras_itens i on i.idcompra = c.id');
                   QNota.SQL.Add('inner join produtos pr on i.idproduto = pr.id');
                   QNota.SQL.Add('where c.data_compra between :pDatai and :pDataf');
                   QNota.SQL.Add('and c.cancelado = '+QuotedStr('N'));
                   QNota.SQL.Add('and c.nota is not null');
                   QNota.SQL.Add('and c.idempresa = :pEmpresa');
                   QNota.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                   QNota.SQL.Add('group by i.idproduto,pr.codigo_ncm');
                   // seleciona Dados
                   QNota.Params.ParamByName('pDatai').AsDate      := pDatai;
                   QNota.Params.ParamByName('pDataf').AsDate      := pDataf;
                   QNota.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                   QNota.Open;
                   aNumReg := RetornaQtdRegDBX(QNota);
                   sLbMensagem.Caption := 'Consolidação de entradas';
                   sProgressBar1.Max := aNumReg;
                   Application.ProcessMessages;
                   aRegAtual := 0;
                   while not QNota.Eof do
                   begin
                     with RegistroC190New do
                     begin
                       COD_MOD     := '55';
                       DT_REF_INI  := pDatai;
                       DT_REF_FIN  := pDataf;
                       COD_ITEM    := IntToStr(QNota.FieldByname('IDPRODUTO').AsInteger);
                       COD_NCM     := Trim(QNota.FieldByname('CODIGO_NCM').AsString);
                       EX_IPI      := '';
                       VL_TOT_ITEM := QNota.FieldByname('val_prod').AsFloat;
                       // registro C191
                       QItem.Close;
                       QItem.SQL.Clear;
                       QItem.SQL.Add('select f.cnpj_cpf,i.cst_pis,i.cfop,i.aliq_pis,');
                       QItem.SQL.Add('sum((i.valor - i.desconto) * i.quantidade) as val_prod,');
                       QItem.SQL.Add('sum(i.desconto) as val_desc,');
                       QItem.SQL.Add('sum(i.valor_pis) as val_pis from compras c');
                       QItem.SQL.Add('inner join compras_itens i on i.idcompra = c.id');
                       QItem.SQL.Add('left outer join contato f on c.idfornecedor = f.id');
                       QItem.SQL.Add('left outer join classificacao cf on c.id_classificacao = cf.id');
                       QItem.SQL.Add('where c.data_compra between :pDatai and :pDataf');
                       QItem.SQL.Add('and c.cancelado = '+QuotedStr('N'));
                       QItem.SQL.Add('and c.nota is not null');
                       QItem.SQL.Add('and c.idempresa = :pEmpresa');
                       QItem.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                       QItem.SQL.Add('and i.idproduto = :pCd_Prod');
                       QItem.SQL.Add('group by f.cnpj_cpf,i.cst_pis,i.cfop,i.aliq_pis');
                       QItem.Params.ParamByName('pDatai').AsDate      := pDatai;
                       QItem.Params.ParamByName('pDataf').AsDate      := pDataf;
                       QItem.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                       QItem.Params.ParamByName('pCd_Prod').AsInteger := QNota.FieldByname('IDPRODUTO').AsInteger;
                       QItem.Open;
                       while not QItem.Eof do
                       begin
                         with RegistroC191New do
                         begin
                           CNPJ_CPF_PART := FiltraNumero(QItem.FieldByName('cnpj_cpf').AsString);
                           aCST_PIS      := QItem.FieldByName('cst_pis').AsInteger;
                           if aCST_PIS = 0 then
                              aCST_PIS := 50;
                           case aCST_PIS of
                             01 : CST_PIS := stpisValorAliquotaNormal;
                             02 : CST_PIS := stpisValorAliquotaDiferenciada;
                             03 : CST_PIS := stpisQtdeAliquotaUnidade;
                             04 : CST_PIS := stpisMonofaticaAliquotaZero;
                             05 : CST_PIS := stpisValorAliquotaPorST;
                             06 : CST_PIS := stpisAliquotaZero;
                             07 : CST_PIS := stpisIsentaContribuicao;
                             08 : CST_PIS := stpisSemIncidenciaContribuicao;
                             09 : CST_PIS := stpisSuspensaoContribuicao;
                             49 : CST_PIS := stpisOutrasOperacoesSaida;
                             50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                             51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                             52 : CST_PIS := stpisOperCredExcRecExportacao;
                             53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                             54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                             55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                             56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                             60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                             61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                             62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                             63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                             64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                             65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                             66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                             70 : CST_PIS := stpisOperAquiSemDirCredito;
                             71 : CST_PIS := stpisOperAquiComIsensao;
                             72 : CST_PIS := stpisOperAquiComSuspensao;
                             73 : CST_PIS := stpisOperAquiAliquotaZero;
                             74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                             75 : CST_PIS := stpisOperAquiPorST;
                             98 : CST_PIS := stpisOutrasOperacoesEntrada;
                             99 : CST_PIS := stpisOutrasOperacoes;
                           end;
                           CFOP           := QItem.FieldByName('cfop').AsInteger;
                           VL_ITEM        := QItem.FieldByName('Val_Prod').AsFloat;
                           VL_DESC        := QItem.FieldByName('Val_Desc').AsFloat;
                           VL_BC_PIS      := QItem.FieldByName('Val_Prod').AsFloat;
                           ALIQ_PIS       := QItem.FieldByName('aliq_pis').AsFloat;
                           QUANT_BC_PIS   := 0;
                           ALIQ_PIS_QUANT := 0;
                           VL_PIS         := QItem.FieldByName('val_pis').AsFloat;
                           COD_CTA        := '';
                         end;
                         QItem.Next;
                       end;
                       // registro C195
                       QItem.Close;
                       QItem.SQL.Clear;
                       QItem.SQL.Add('select f.cnpj_cpf,i.cst_cofins,i.cfop,i.aliq_cofins,');
                       QItem.SQL.Add('sum((i.valor - i.desconto) * i.quantidade) as val_prod,');
                       QItem.SQL.Add('sum(i.desconto) as val_desc,');
                       QItem.SQL.Add('sum(i.valor_cofins) as val_cofins from compras c');
                       QItem.SQL.Add('inner join compras_itens i on i.idcompra = c.id');
                       QItem.SQL.Add('left outer join contato f on c.idfornecedor = f.id');
                       QItem.SQL.Add('left outer join classificacao cf on c.id_classificacao = cf.id');
                       QItem.SQL.Add('where c.data_compra between :pDatai and :pDataf');
                       QItem.SQL.Add('and c.cancelado = '+QuotedStr('N'));
                       QItem.SQL.Add('and c.nota is not null');
                       QItem.SQL.Add('and c.idempresa = :pEmpresa');
                       QItem.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                       QItem.SQL.Add('and i.idproduto = :pCd_Prod');
                       QItem.SQL.Add('group by f.cnpj_cpf,i.cst_cofins,i.cfop,i.aliq_cofins');
                       QItem.Params.ParamByName('pDatai').AsDate      := pDatai;
                       QItem.Params.ParamByName('pDataf').AsDate      := pDataf;
                       QItem.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                       QItem.Params.ParamByName('pCd_Prod').AsInteger := QNota.FieldByname('CD_PRODUTO').AsInteger;
                       QItem.Open;
                       while not QItem.Eof do
                       begin
                         with RegistroC195New do
                         begin
                           CNPJ_CPF_PART := FiltraNumero(QItem.FieldByName('cnpj_cpf').AsString);
                           aCST_COFINS      := QItem.FieldByName('cst_cofins').AsInteger;
                           if aCST_COFINS = 0 then
                              aCST_COFINS := 50;
                           case aCST_COFINS of
                             01 : CST_COFINS := stcofinsValorAliquotaNormal;
                             02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                             03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                             04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                             05 : CST_COFINS := stcofinsValorAliquotaPorST;
                             06 : CST_COFINS := stcofinsAliquotaZero;
                             07 : CST_COFINS := stcofinsIsentaContribuicao;
                             08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                             09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                             49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                             50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                             51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                             52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                             53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                             54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                             55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                             56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                             60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                             61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                             62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                             63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                             64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                             65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                             66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                             70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                             71 : CST_COFINS := stcofinsOperAquiComIsensao;
                             72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                             73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                             74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                             75 : CST_COFINS := stcofinsOperAquiPorST;
                             98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                             99 : CST_COFINS := stcofinsOutrasOperacoes;
                           end;
                           CFOP              := QItem.FieldByName('cfop').AsInteger;
                           VL_ITEM           := QItem.FieldByName('Val_Prod').AsFloat;
                           VL_DESC           := QItem.FieldByName('Val_Desc').AsFloat;
                           VL_BC_COFINS      := QItem.FieldByName('Val_Prod').AsFloat;
                           ALIQ_COFINS       := QItem.FieldByName('aliq_cofins').AsFloat;
                           QUANT_BC_COFINS   := 0;
                           ALIQ_COFINS_QUANT := 0;
                           VL_COFINS         := QItem.FieldByName('val_cofins').AsFloat;
                           COD_CTA           := '';
                         end;
                         QItem.Next;
                       end;
                     end;
                     Inc(aRegAtual);
                     sProgressBar1.Position := aRegAtual;
                     Application.ProcessMessages;
                     //
                     QNota.Next;
                   end;
                 end;
                 //  processa os dados dos cupons fiscais
                 QNota.Close;
                 QNota.SQL.Clear;
                 QNota.SQL.Add('select i.idproduto from pedido p');
                 QNota.SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
                 QNota.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                 QNota.SQL.Add('and p.cancelado = '+QuotedStr('N'));
                 QNota.SQL.Add('and p.coo > 0');
                 QNota.SQL.Add('and p.idempresa = :pEmpresa');
                 QNota.Params.ParamByName('pDatai').AsDate      := pDatai;
                 QNota.Params.ParamByName('pDataf').AsDate      := pDataf;
                 QNota.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                 QNota.Open;
                 if not QNota.IsEmpty then
                 begin
                   with RegistroC490New do
                   begin
                     DT_DOC_INI := pDatai;
                     DT_DOC_FIN := pDataf;
                     COD_MOD    := '2D';
                     Application.ProcessMessages;
                     sProgressBar2.Position := 25;
                     // grava registro C491 - Consolidação Pis
                     QItem.Close;
                     QItem.SQL.Clear;
                     QItem.SQL.Add('select i.idproduto,i.cst_pis,i.cfop,i.aliq_pis,');
                     QItem.SQL.Add('sum((i.valor-i.desconto)*i.quantidade) as val_prod,');
                     QItem.SQL.Add('sum(i.desconto) as val_desc,');
                     QItem.SQL.Add('sum(i.valor_pis) as val_pis from pedido p');
                     QItem.SQL.Add('inner join pedido_itens i on i.idpedido = p.id');
                     QItem.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                     QItem.SQL.Add('where p.data_pedido between :pDatai and :pDataf');
                     QItem.SQL.Add('and p.cancelado = '+QuotedStr('N'));
                     QItem.SQL.Add('and p.coo > 0');
                     QItem.SQL.Add('and p.idempresa = :pEmpresa');
                     QItem.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                     QItem.SQL.Add('group by i.idproduto,i.cst_pis,i.cfop,i.aliq_pis');
                     QItem.Params.ParamByName('pDatai').AsDate      := pDatai;
                     QItem.Params.ParamByName('pDataf').AsDate      := pDataf;
                     QItem.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                     QItem.Open;
                     while not QItem.Eof do
                     begin
                       with RegistroC491New do
                       begin
                         COD_ITEM := QItem.FieldByName('idproduto').AsString;
                         aCST_PIS := StrToInt(QItem.FieldByName('cst_pis').AsString);
                         if aCST_PIS = 0 then
                            aCST_PIS := 99;
                         case aCST_PIS of
                           01 : CST_PIS := stpisValorAliquotaNormal;
                           02 : CST_PIS := stpisValorAliquotaDiferenciada;
                           03 : CST_PIS := stpisQtdeAliquotaUnidade;
                           04 : CST_PIS := stpisMonofaticaAliquotaZero;
                           05 : CST_PIS := stpisValorAliquotaPorST;
                           06 : CST_PIS := stpisAliquotaZero;
                           07 : CST_PIS := stpisIsentaContribuicao;
                           08 : CST_PIS := stpisSemIncidenciaContribuicao;
                           09 : CST_PIS := stpisSuspensaoContribuicao;
                           49 : CST_PIS := stpisOutrasOperacoesSaida;
                           50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                           51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                           52 : CST_PIS := stpisOperCredExcRecExportacao;
                           53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                           54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                           55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                           56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                           60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                           61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                           62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                           63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                           64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                           65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                           66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                           70 : CST_PIS := stpisOperAquiSemDirCredito;
                           71 : CST_PIS := stpisOperAquiComIsensao;
                           72 : CST_PIS := stpisOperAquiComSuspensao;
                           73 : CST_PIS := stpisOperAquiAliquotaZero;
                           74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                           75 : CST_PIS := stpisOperAquiPorST;
                           98 : CST_PIS := stpisOutrasOperacoesEntrada;
                           99 : CST_PIS := stpisOutrasOperacoes;
                         end;
                         CFOP           := QItem.FieldByName('cfop').AsInteger;
                         VL_ITEM        := QItem.FieldByName('val_prod').AsFloat;
                         VL_BC_PIS      := QItem.FieldByName('val_prod').AsFloat;
                         ALIQ_PIS       := QItem.FieldByName('aliq_pis').AsFloat;
                         QUANT_BC_PIS   := 0;
                         ALIQ_PIS_QUANT := 0;
                         VL_PIS         := QItem.FieldByName('val_pis').AsFloat;
                         COD_CTA        := '';
                       end;
                       Application.ProcessMessages;
                       sProgressBar2.Position := 29;
                       QItem.Next;
                     end;
                     // grava registro C495 - Consolidação Cofins
                     QItem.Close;
                     QItem.SQL.Clear;
                     QItem.SQL.Add('select i.idproduto,i.cst_cofins,i.cfop,i.aliq_cofins,');
                     QItem.SQL.Add('sum((i.valor-i.desconto)*i.quantidade) as val_prod,');
                     QItem.SQL.Add('sum(i.desconto) as val_desc,');
                     QItem.SQL.Add('sum(i.valor_cofins) as val_cofins from pedido p');
                     QItem.SQL.Add('inner join pedido_itens i on i.idpedido = p.id');
                     QItem.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                     QItem.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                     QItem.SQL.Add('and p.cancelado = '+QuotedStr('N'));
                     QItem.SQL.Add('and p.coo > 0');
                     QItem.SQL.Add('and p.idempresa = :pEmpresa');
                     QItem.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                     QItem.SQL.Add('group by i.idproduto,i.cst_cofins,i.cfop,i.aliq_cofins');
                     QItem.Params.ParamByName('pDatai').AsDate      := pDatai;
                     QItem.Params.ParamByName('pDataf').AsDate      := pDataf;
                     QItem.Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByName('id').AsInteger;
                     QItem.Open;
                     while not QItem.Eof do
                     begin
                       with RegistroC495New do
                       begin
                         COD_ITEM    := QItem.FieldByName('idproduto').AsString;
                         aCST_COFINS := StrToInt(QItem.FieldByName('cst_cofins').AsString);
                         if aCST_COFINS = 0 then
                            aCST_COFINS := 50;
                         case aCST_COFINS of
                           01 : CST_COFINS := stcofinsValorAliquotaNormal;
                           02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                           03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                           04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                           05 : CST_COFINS := stcofinsValorAliquotaPorST;
                           06 : CST_COFINS := stcofinsAliquotaZero;
                           07 : CST_COFINS := stcofinsIsentaContribuicao;
                           08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                           09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                           49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                           50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                           51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                           52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                           53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                           54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                           55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                           56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                           60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                           61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                           62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                           63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                           64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                           65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                           66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                           70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                           71 : CST_COFINS := stcofinsOperAquiComIsensao;
                           72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                           73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                           74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                           75 : CST_COFINS := stcofinsOperAquiPorST;
                           98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                           99 : CST_COFINS := stcofinsOutrasOperacoes;
                         end;
                         CFOP              := QItem.FieldByName('cfop').AsInteger;
                         VL_ITEM           := QItem.FieldByName('val_prod').AsFloat;
                         VL_BC_COFINS      := QItem.FieldByName('val_prod').AsFloat;
                         ALIQ_COFINS       := QItem.FieldByName('aliq_cofins').AsFloat;
                         QUANT_BC_COFINS   := 0;
                         ALIQ_COFINS_QUANT := 0;
                         VL_COFINS         := QItem.FieldByName('val_cofins').AsFloat;
                         COD_CTA           := '';
                       end;
                       Application.ProcessMessages;
                       sProgressBar2.Position := 30;
                       //
                       QItem.Next;
                     end;
                   end;
                 end;
               end;
             end;
             CdsEmpresa.Next;
           end;
         end;
      end;
   end;

end;

procedure TSPED_PC.DadosBlocoPC_D;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco D.
   with DmAcBr.ACBrSPEDPisCofins1.Bloco_D do
   begin
      with RegistroD001New do
      begin
        IND_MOV := imSemDados;
      end;
   end;

end;

procedure TSPED_PC.DadosBlocoPC_F(CdsEmpresa:TClientDataSet;pDatai,
  pDataf:TDateTime;CodEmp,pEscrApur:Integer);
var Query : TSQLQuery;
    aCST : Integer; 
begin
   // Bloco F.
   Query := TSQLQuery.Create(nil);
   Query.SQLConnection := ConexaoDados;
   //
   with DmAcBr.ACBrSPEDPisCofins1.Bloco_F do
   begin
      with RegistroF001New do
      begin
        if pEscrApur = 2 then
        begin
          IND_MOV := imSemDados;
        end
        else
        begin
          IND_MOV := imComDados;
          //
          CdsEmpresa.First;
          while not CdsEmpresa.Eof do
          begin
//            if VerificaMovimentoPisCofins(CdsEmpresa.FieldByName('id').AsInteger,pDatai,pDataf) then
            begin
              with RegistroF010New do
              begin
                CNPJ := FiltraNumero(CdsEmpresa.FieldByName('cnpj_cpf').AsString);
                if pEscrApur = 0 then
                begin
                  with Query do
                  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('select i.cst_pis,i.aliq_pis,i.cst_cofins,i.aliq_cofins,');
                    SQL.Add('i.cfop,p.idplanocontas,');
                    SQL.Add('sum(i.valor_total) as total_produto,');
                    SQL.Add('sum(i.desconto) as val_desc,');
                    SQL.Add('sum(i.base_pis) as val_base_pis,');
                    SQL.Add('sum(i.valor_pis) as val_pis,');
                    SQL.Add('sum(i.base_cofins) as val_base_cofins,');
                    SQL.Add('sum(i.valor_cofins) as val_cofins');
                    SQL.Add('from pedido p');
                    SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                    SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
                    SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                    SQL.Add('and p.cancelado = '+QuotedStr('N'));
                    SQL.Add('and p.numero_doc is not null');
                    SQL.Add('and p.idempresa = :pEmpresa');
                    SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                    SQL.Add('group by i.cst_pis,i.aliq_pis,i.cst_cofins,i.aliq_cofins,');
                    SQL.Add('i.cfop,p.idplanocontas');
                    Params.ParamByName('pDatai').AsDate      := pDatai;
                    Params.ParamByName('pDataf').AsDate      := pDataf;
                    Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByname('id').AsInteger;
                    Open;
                    while not Eof do
                    begin
                      with RegistroF500New do
                      begin
                        VL_REC_CAIXA   := FieldByname('total_produto').AsFloat;
                        aCST := FieldByname('cst_pis').AsInteger;
                        if aCST = 0 then
                           aCST := 50;
                        case aCST of
                          01 : CST_PIS := stpisValorAliquotaNormal;
                          02 : CST_PIS := stpisValorAliquotaDiferenciada;
                          03 : CST_PIS := stpisQtdeAliquotaUnidade;
                          04 : CST_PIS := stpisMonofaticaAliquotaZero;
                          05 : CST_PIS := stpisValorAliquotaPorST;
                          06 : CST_PIS := stpisAliquotaZero;
                          07 : CST_PIS := stpisIsentaContribuicao;
                          08 : CST_PIS := stpisSemIncidenciaContribuicao;
                          09 : CST_PIS := stpisSuspensaoContribuicao;
                          49 : CST_PIS := stpisOutrasOperacoesSaida;
                          50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                          51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                          52 : CST_PIS := stpisOperCredExcRecExportacao;
                          53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                          54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                          55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                          56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                          60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                          61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                          62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                          63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                          64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                          65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                          66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                          70 : CST_PIS := stpisOperAquiSemDirCredito;
                          71 : CST_PIS := stpisOperAquiComIsensao;
                          72 : CST_PIS := stpisOperAquiComSuspensao;
                          73 : CST_PIS := stpisOperAquiAliquotaZero;
                          74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                          75 : CST_PIS := stpisOperAquiPorST;
                          98 : CST_PIS := stpisOutrasOperacoesEntrada;
                          99 : CST_PIS := stpisOutrasOperacoes;
                        end;
                        VL_DESC_PIS    := FieldByname('val_desc').AsFloat;
                        VL_BC_PIS      := FieldByname('val_base_pis').AsFloat;
                        ALIQ_PIS       := FieldByname('aliq_pis').AsFloat;
                        VL_PIS         := FieldByname('val_pis').AsFloat;
                        aCST := FieldByName('cst_cofins').AsInteger;
                        if aCST = 0 then
                           aCST := 50;
                        case aCST of
                          01 : CST_COFINS := stcofinsValorAliquotaNormal;
                          02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                          03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                          04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                          05 : CST_COFINS := stcofinsValorAliquotaPorST;
                          06 : CST_COFINS := stcofinsAliquotaZero;
                          07 : CST_COFINS := stcofinsIsentaContribuicao;
                          08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                          09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                          49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                          50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                          51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                          52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                          53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                          54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                          55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                          56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                          60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                          61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                          62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                          63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                          64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                          65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                          66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                          70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                          71 : CST_COFINS := stcofinsOperAquiComIsensao;
                          72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                          73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                          74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                          75 : CST_COFINS := stcofinsOperAquiPorST;
                          98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                          99 : CST_COFINS := stcofinsOutrasOperacoes;
                        end;
                        VL_DESC_COFINS := FieldByname('val_desc').AsFloat;
                        VL_BC_COFINS   := FieldByname('val_base_cofins').AsFloat;
                        ALIQ_COFINS    := FieldByname('aliq_cofins').AsFloat;
                        VL_COFINS      := FieldByname('val_cofins').AsFloat;
                        COD_MOD        := FieldByname('idplanocontas').AsString;
                        CFOP           := FieldByname('cfop').AsInteger;
                        COD_CTA        := '';
                        INFO_COMPL     := '';
                      end;
                      Next;
                    end;
                  end;  
                  //
                  with Query do
                  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('select c.cnpj_cpf,i.idproduto,i.cst_pis,i.cst_cofins,');
                    SQL.Add('p.idplanocontas,p.numero_doc,');
                    SQL.Add('sum(i.valor_total) as total_produto');
                    SQL.Add('from pedido p');
                    SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                    SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
                    SQL.Add('left outer join contato c on c.id = p.idcliente');
                    SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                    SQL.Add('and p.cancelado = '+QuotedStr('N'));
                    SQL.Add('and p.numero_doc is not null');
                    SQL.Add('and p.idempresa = :pEmpresa');
                    SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                    SQL.Add('and p.valor_total > 0');
                    SQL.Add('group by c.cnpj_cpf,i.idproduto,i.cst_pis,i.cst_cofins,');
                    SQL.Add('p.idplanocontas,p.numero_doc');
                    Params.ParamByName('pDatai').AsDate      := pDatai;
                    Params.ParamByName('pDataf').AsDate      := pDataf;
                    Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByname('id').AsInteger;
                    Open;
                    while not Eof do
                    begin
                      with RegistroF525New do
                      begin
                        VL_REC       := FieldByName('total_produto').AsFloat;
                        IND_REC      := crItemVendido;
                        CNPJ_CPF     := Trim(FieldByName('cnpj_cpf').AsString);
                        NUM_DOC      := FieldByName('numero_doc').AsString;
                        COD_ITEM     := FieldByName('idproduto').AsString;
                        VL_REC_DET   := FieldByName('total_produto').AsFloat;
                        aCST := FieldByname('cst_pis').AsInteger;
                        if aCST = 0 then
                           aCST := 50;
                        case aCST of
                          01 : CST_PIS := stpisValorAliquotaNormal;
                          02 : CST_PIS := stpisValorAliquotaDiferenciada;
                          03 : CST_PIS := stpisQtdeAliquotaUnidade;
                          04 : CST_PIS := stpisMonofaticaAliquotaZero;
                          05 : CST_PIS := stpisValorAliquotaPorST;
                          06 : CST_PIS := stpisAliquotaZero;
                          07 : CST_PIS := stpisIsentaContribuicao;
                          08 : CST_PIS := stpisSemIncidenciaContribuicao;
                          09 : CST_PIS := stpisSuspensaoContribuicao;
                          49 : CST_PIS := stpisOutrasOperacoesSaida;
                          50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                          51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                          52 : CST_PIS := stpisOperCredExcRecExportacao;
                          53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                          54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                          55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                          56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                          60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                          61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                          62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                          63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                          64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                          65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                          66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                          70 : CST_PIS := stpisOperAquiSemDirCredito;
                          71 : CST_PIS := stpisOperAquiComIsensao;
                          72 : CST_PIS := stpisOperAquiComSuspensao;
                          73 : CST_PIS := stpisOperAquiAliquotaZero;
                          74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                          75 : CST_PIS := stpisOperAquiPorST;
                          98 : CST_PIS := stpisOutrasOperacoesEntrada;
                          99 : CST_PIS := stpisOutrasOperacoes;
                        end;
                        aCST := FieldByName('cst_cofins').AsInteger;
                        if aCST = 0 then
                           aCST := 50;
                        case aCST of
                          01 : CST_COFINS := stcofinsValorAliquotaNormal;
                          02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                          03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                          04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                          05 : CST_COFINS := stcofinsValorAliquotaPorST;
                          06 : CST_COFINS := stcofinsAliquotaZero;
                          07 : CST_COFINS := stcofinsIsentaContribuicao;
                          08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                          09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                          49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                          50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                          51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                          52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                          53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                          54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                          55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                          56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                          60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                          61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                          62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                          63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                          64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                          65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                          66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                          70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                          71 : CST_COFINS := stcofinsOperAquiComIsensao;
                          72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                          73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                          74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                          75 : CST_COFINS := stcofinsOperAquiPorST;
                          98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                          99 : CST_COFINS := stcofinsOutrasOperacoes;
                        end;
                        INFO_COMPL   := '';
                        COD_CTA      := '';
                      end;
                      Next;
                    end;
                  end;
                end;
                //
                if pEscrApur = 1 then
                begin
                  with Query do
                  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('select i.cst_pis,i.aliq_pis,i.cst_cofins,i.aliq_cofins,');
                    SQL.Add('i.cfop,p.idplanocontas,');
                    SQL.Add('sum(i.valor_total) as total_produto,');
                    SQL.Add('sum(i.desconto) as val_desc,');
                    SQL.Add('sum(i.base_pis) as val_base_pis,');
                    SQL.Add('sum(i.valor_pis) as val_pis,');
                    SQL.Add('sum(i.base_cofins) as val_base_cofins,');
                    SQL.Add('sum(i.valor_cofins) as val_cofins');
                    SQL.Add('from pedido p');
                    SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
                    SQL.Add('left outer join pedido_itens i on i.idpedido = p.id');
                    SQL.Add('where p.data_entrega between :pDatai and :pDataf');
                    SQL.Add('and p.cancelado = '+QuotedStr('N'));
                    SQL.Add('and p.numero_doc is not null');
                    SQL.Add('and p.idempresa = :pEmpresa');
                    SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('N'));
                    SQL.Add('group by i.cst_pis,i.aliq_pis,i.cst_cofins,i.aliq_cofins,');
                    SQL.Add('i.cfop,p.idplanocontas');
                    Params.ParamByName('pDatai').AsDate      := pDatai;
                    Params.ParamByName('pDataf').AsDate      := pDataf;
                    Params.ParamByName('pEmpresa').AsInteger := CdsEmpresa.FieldByname('id').AsInteger;
                    Open;
                    while not Eof do
                    begin
                      with RegistroF550New do
                      begin
                        VL_REC_COMP    := FieldByname('total_produto').AsFloat;
                        aCST := FieldByname('cst_pis').AsInteger;
                        if aCST = 0 then
                           aCST := 50;
                        case aCST of
                          01 : CST_PIS := stpisValorAliquotaNormal;
                          02 : CST_PIS := stpisValorAliquotaDiferenciada;
                          03 : CST_PIS := stpisQtdeAliquotaUnidade;
                          04 : CST_PIS := stpisMonofaticaAliquotaZero;
                          05 : CST_PIS := stpisValorAliquotaPorST;
                          06 : CST_PIS := stpisAliquotaZero;
                          07 : CST_PIS := stpisIsentaContribuicao;
                          08 : CST_PIS := stpisSemIncidenciaContribuicao;
                          09 : CST_PIS := stpisSuspensaoContribuicao;
                          49 : CST_PIS := stpisOutrasOperacoesSaida;
                          50 : CST_PIS := stpisOperCredExcRecTribMercInt;
                          51 : CST_PIS := stpisOperCredExcRecNaoTribMercInt;
                          52 : CST_PIS := stpisOperCredExcRecExportacao;
                          53 : CST_PIS := stpisOperCredRecTribNaoTribMercInt;
                          54 : CST_PIS := stpisOperCredRecTribMercIntEExportacao;
                          55 : CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;
                          56 : CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;
                          60 : CST_PIS := stpisCredPresAquiExcRecTribMercInt;
                          61 : CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;
                          62 : CST_PIS := stpisCredPresAquiExcExcRecExportacao;
                          63 : CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;
                          64 : CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;
                          65 : CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;
                          66 : CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao;
                          70 : CST_PIS := stpisOperAquiSemDirCredito;
                          71 : CST_PIS := stpisOperAquiComIsensao;
                          72 : CST_PIS := stpisOperAquiComSuspensao;
                          73 : CST_PIS := stpisOperAquiAliquotaZero;
                          74 : CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;
                          75 : CST_PIS := stpisOperAquiPorST;
                          98 : CST_PIS := stpisOutrasOperacoesEntrada;
                          99 : CST_PIS := stpisOutrasOperacoes;
                        end;
                        VL_DESC_PIS    := FieldByname('val_desc').AsFloat;
                        VL_BC_PIS      := FieldByname('val_base_pis').AsFloat;
                        ALIQ_PIS       := FieldByname('aliq_pis').AsFloat;
                        VL_PIS         := FieldByname('val_pis').AsFloat;
                        CST_COFINS     := stcofinsValorAliquotaNormal;
                        aCST := FieldByName('cst_cofins').AsInteger;
                        if aCST = 0 then
                           aCST := 50;
                        case aCST of
                          01 : CST_COFINS := stcofinsValorAliquotaNormal;
                          02 : CST_COFINS := stcofinsValorAliquotaDiferenciada;
                          03 : CST_COFINS := stcofinsQtdeAliquotaUnidade;
                          04 : CST_COFINS := stcofinsMonofaticaAliquotaZero;
                          05 : CST_COFINS := stcofinsValorAliquotaPorST;
                          06 : CST_COFINS := stcofinsAliquotaZero;
                          07 : CST_COFINS := stcofinsIsentaContribuicao;
                          08 : CST_COFINS := stcofinsSemIncidenciaContribuicao;
                          09 : CST_COFINS := stcofinsSuspensaoContribuicao;
                          49 : CST_COFINS := stcofinsOutrasOperacoesSaida;
                          50 : CST_COFINS := stcofinsOperCredExcRecTribMercInt;
                          51 : CST_COFINS := stcofinsOperCredExcRecNaoTribMercInt;
                          52 : CST_COFINS := stcofinsOperCredExcRecExportacao;
                          53 : CST_COFINS := stcofinsOperCredRecTribNaoTribMercInt;
                          54 : CST_COFINS := stcofinsOperCredRecTribMercIntEExportacao;
                          55 : CST_COFINS := stcofinsOperCredRecNaoTribMercIntEExportacao;
                          56 : CST_COFINS := stcofinsOperCredRecTribENaoTribMercIntEExportacao;
                          60 : CST_COFINS := stcofinsCredPresAquiExcRecTribMercInt;
                          61 : CST_COFINS := stcofinsCredPresAquiExcRecNaoTribMercInt;
                          62 : CST_COFINS := stcofinsCredPresAquiExcExcRecExportacao;
                          63 : CST_COFINS := stcofinsCredPresAquiRecTribNaoTribMercInt;
                          64 : CST_COFINS := stcofinsCredPresAquiRecTribMercIntEExportacao;
                          65 : CST_COFINS := stcofinsCredPresAquiRecNaoTribMercIntEExportacao;
                          66 : CST_COFINS := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao;
                          70 : CST_COFINS := stcofinsOperAquiSemDirCredito;
                          71 : CST_COFINS := stcofinsOperAquiComIsensao;
                          72 : CST_COFINS := stcofinsOperAquiComSuspensao;
                          73 : CST_COFINS := stcofinsOperAquiAliquotaZero;
                          74 : CST_COFINS := stcofinsOperAqui_SemIncidenciaContribuicao;
                          75 : CST_COFINS := stcofinsOperAquiPorST;
                          98 : CST_COFINS := stcofinsOutrasOperacoesEntrada;
                          99 : CST_COFINS := stcofinsOutrasOperacoes;
                        end;
                        VL_DESC_COFINS := FieldByname('val_desc').AsFloat;
                        VL_BC_COFINS   := FieldByname('val_base_cofins').AsFloat;
                        ALIQ_COFINS    := FieldByname('aliq_cofins').AsFloat;
                        VL_COFINS      := FieldByname('val_cofins').AsFloat;
                        COD_MOD        := FieldByname('cd_conta').AsString;
                        CFOP           := FieldByname('codigo_fiscal').AsInteger;
                        COD_CTA        := '';
                        INFO_COMPL     := '';
                      end;
                      Next;
                    end;
                  end;
                end;
              end;
            end;
            CdsEmpresa.Next;
          end;
        end;
      end;
   end;
   FreeAndNil(Query);
end;

procedure TSPED_PC.DadosBlocoPC_M;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco M.
   with DmAcBr.ACBrSPEDPisCofins1.Bloco_M do
   begin
      with RegistroM001New do
      begin
        IND_MOV := imSemDados;
{         with RegistroM100New do
         begin
            COD_CRED       := '';
            IND_CRED_ORI   := TACBrIndCredOri(0);
            VL_BC_PIS      := 0;
            ALIQ_PIS       := 0;
            QUANT_BC_PIS   := 0;
            ALIQ_PIS_QUANT := 0;
            VL_CRED        := 0;
            VL_AJUS_ACRES  := 0;
            VL_AJUS_REDUC  := 0;
            VL_CRED_DIF    := 0;
            VL_CRED_DISP   := 0;
            IND_DESC_CRED  := TACBrIndDescCred(0);
            VL_CRED_DESC   := 0;
            SLD_CRED       := 0;
         end;  }
      end;
   end;

end;


destructor TSPED_PC.DestruaInstancia;
begin

end;

function TSPED_PC.VerificaMovimentoPisCofins(pIDEMpresa: Integer;pDatai,
  pDataf:TDateTime): Boolean;
var SQL : TSQLQuery;
begin
  Result := false;
  SQL := TSQLQuery.Create(nil);
  try
    SQL.SQLConnection := ConexaoDados;
    // verifica movimento de Pis/Cofins na entrada
    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('select sum(notaent.val_pis) as val_pis,');
    SQL.SQL.Add('sum(notaent.val_cofins) as val_cofins from notaent');
    SQL.SQL.Add('where notaent.dt_entrada between :pDatai and :pDataf');
    SQL.SQL.Add('and notaent.cd_empresa = :pEmpresa');
    SQL.Params.ParamByName('pDatai').AsDate      := pDatai;
    SQL.Params.ParamByName('pDataf').AsDate      := pDataf;
    SQL.Params.ParamByName('pEmpresa').AsInteger := pIDEMpresa;
    SQL.Open;
    if (SQL.FieldByName('val_pis').AsFloat > 0) or
       (SQL.FieldByName('val_cofins').AsFloat > 0) then
    begin
      Result := true;
    end;
    SQL.Close;
    // verifica movimento de Pis/Cogins da Saida
    if not Result then
    begin
      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('select sum(notasai.val_pis) as val_pis,');
      SQL.SQL.Add('sum(notasai.val_cofins) as val_cofins from notasai');
      SQL.SQL.Add('where notasai.dt_entrega between :pDatai and :pDataf');
      SQL.SQL.Add('and notasai.cd_empresa = :pEmpresa');
      SQL.Params.ParamByName('pDatai').AsDate      := pDatai;
      SQL.Params.ParamByName('pDataf').AsDate      := pDataf;
      SQL.Params.ParamByName('pEmpresa').AsInteger := pIDEMpresa;
      SQL.Open;
      if (SQL.FieldByName('val_pis').AsFloat > 0) or
         (SQL.FieldByName('val_cofins').AsFloat > 0) then
      begin
        Result := true;
      end;
      SQL.Close;
    end;
  finally
    FreeAndNil(SQL);
  end;

end;

function TSPED_PC.VerificaNotaDevolucao(fCodigo: Integer;pCNPJEmpresa:String): Boolean;
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
       Trim(FiltraNumero(pCNPJEmpresa)) then
       Result := true;
    Q.Close;
  finally
    FreeAndNil(Q);
  end;

end;

function TSPED_PC.VerificaSTProdutosNota(pID, pES: Integer): Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    if pES = 0 then // erntrada
    begin
      Q.SQL.Add('select entprod.cd_entrada from entprod');
      Q.SQL.Add('where entprod.cd_entrada = :pID');
      Q.SQL.Add('and entprod.val_base_icms_sub > 0');
      Q.SQL.Add('and (entprod.situacao_tributaria_icms = '+QuotedStr('10')+' or');
      Q.SQL.Add('     entprod.situacao_tributaria_icms = '+QuotedStr('60')+' or');
      Q.SQL.Add('     entprod.situacao_tributaria_icms = '+QuotedStr('70')+')');
    end
    else if pES = 1 then // saida
    begin
      Q.SQL.Add('select saiprod.cd_saida from saiprod');
      Q.SQL.Add('where saiprod.cd_saida = :pID');
      Q.SQL.Add('and saiprod.val_base_icms_sub > 0');
      Q.SQL.Add('and (saiprod.situacao_tributaria_icms = '+QuotedStr('10')+' or');
      Q.SQL.Add('     saiprod.situacao_tributaria_icms = '+QuotedStr('60')+' or');
      Q.SQL.Add('     saiprod.situacao_tributaria_icms = '+QuotedStr('70')+')');
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

function TSPED_PC.VerificaIPIProdutosNota(pID, pES: Integer): Boolean;
var Q : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    Q.Close;
    Q.SQL.Clear;
    if pES = 0 then // erntrada
    begin
      Q.SQL.Add('select entprod.cd_entrada from entprod');
      Q.SQL.Add('where entprod.cd_entrada = :pID');
      Q.SQL.Add('and entprod.val_IPI > 0');
    end
    else if pES = 1 then // saida
    begin
      Q.SQL.Add('select saiprod.cd_saida from saiprod');
      Q.SQL.Add('where saiprod.cd_saida = :pID');
      Q.SQL.Add('and saiprod.val_IPI > 0');
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


function TSPED_PC.VerificaECFMovimentoPisCofins(pIDEMpresa: Integer;
  pDatai, pDataf: TDateTime): Boolean;
var SQL : TSQLQuery;
begin
  Result := false;
  SQL := TSQLQuery.Create(nil);
  try
    SQL.SQLConnection := ConexaoDados;
    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('select sum(notasai.val_pis) as val_pis,');
    SQL.SQL.Add('sum(notasai.val_cofins) as val_cofins from notasai');
    SQL.SQL.Add('where notasai.dt_entrega between :pDatai and :pDataf');
    SQL.SQL.Add('and notasai.cd_empresa = :pEmpresa');
    SQL.SQL.Add('and notasai.num_ref = '+QuotedStr('CF'));
    SQL.Params.ParamByName('pDatai').AsDate      := pDatai;
    SQL.Params.ParamByName('pDataf').AsDate      := pDataf;
    SQL.Params.ParamByName('pEmpresa').AsInteger := pIDEMpresa;
    SQL.Open;
    if (SQL.FieldByName('val_pis').AsFloat > 0) or
       (SQL.FieldByName('val_cofins').AsFloat > 0) then
    begin
      Result := true;
    end;
    SQL.Close;
  finally
    FreeAndNil(SQL);
  end;

end;

function TSPED_PC.VerificaMovimentoBlocoA(pDatai, pDataf: TDateTime;
  pEmpresa: Integer): Boolean;
var Query : TSQLQuery;
begin
  Query := TSQLQuery.Create(nil);
  try
    Query.SQLConnection := ConexaoDados;
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('select distinct p.id from pedido p');
    Query.SQL.Add('left outer join classificacao cf on p.id_classificacao = cf.id');
    Query.SQL.Add('left outer join contato c on c.id = p.idcliente');
    Query.SQL.Add('where p.data_entrega between :pDatai and :pDataf');
    Query.SQL.Add('and p.cancelado = '+QuotedStr('N'));
    Query.SQL.Add('and p.numdav is not null');
    if pEmpresa > 0 then
       Query.SQL.Add('and p.idempresa = :pEmpresa');
    Query.SQL.Add('and cf.apropriar_icms_ap = '+QuotedStr('S'));
    Query.SQL.Add('and cf.tipo = 4');
    Query.Params.ParamByName('pDatai').AsDate      := pDatai;
    Query.Params.ParamByName('pDataf').AsDate      := pDataf;
    if pEmpresa > 0 then
       Query.Params.ParamByName('pEmpresa').AsInteger := pEmpresa;
    Query.Open;
    Result := not Query.IsEmpty;
    Query.Close;
  finally
    FreeAndNil(Query);
  end;

end;

procedure TSPED_PC.CriaPreparaTabelaConsolidacao;
begin
  CdsConsolidacao := TClientDataSet.Create(nil);
  try
    CdsConsolidacao.FieldDefs.Add('CST',ftString,3,false);
    CdsConsolidacao.FieldDefs.Add('CFOP',ftString,4,false);
    CdsConsolidacao.FieldDefs.Add('VL_ITEM',ftFloat,0,false);
    CdsConsolidacao.FieldDefs.Add('VL_DESC',ftFloat,0,false);
    CdsConsolidacao.FieldDefs.Add('VL_BC',ftFloat,0,false);
    CdsConsolidacao.FieldDefs.Add('ALIQ',ftFloat,0,false);
    CdsConsolidacao.FieldDefs.Add('VL',ftFloat,0,false);
    if not CdsConsolidacao.Active then
       CdsConsolidacao.CreateDataSet;
    CdsConsolidacao.AddIndex('IDXCST','CST;CFOP',[IxUnique]);
    CdsConsolidacao.IndexName := 'IDXCST';
  finally
    CdsConsolidacao.EmptyDataSet;
    CdsConsolidacao.Open;
  end;

end;

end.
