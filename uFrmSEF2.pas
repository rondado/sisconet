unit uFrmSEF2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, inifiles, ACBrSEF2_eDoc_BlocoC,
  ACBrSEF2_BlocoE, Buttons, ACBrSEF2, ACBrSEF2Conversao, SqlExpr, ACBrBase;

type
  TFrmSEF2 = class(TForm)
    stat1: TStatusBar;
    PgcSEF2: TPageControl;
    TbsGerar: TTabSheet;
    TbsPerfil: TTabSheet;
    btnSalva_SEF2: TButton;
    rgConteudoArquivo: TRadioGroup;
    dlgSave1: TSaveDialog;
    lbl20: TLabel;
    cbbIND_ED: TComboBox;
    lbl21: TLabel;
    cbbIND_ARQ: TComboBox;
    lbl22: TLabel;
    cbbPRF_ISS: TComboBox;
    lbl23: TLabel;
    cbbPRF_ICMS: TComboBox;
    lbl24: TLabel;
    cbbPRF_RIDF: TComboBox;
    lbl25: TLabel;
    cbbPRF_RUDF: TComboBox;
    lbl26: TLabel;
    cbbPRF_LMC: TComboBox;
    lbl27: TLabel;
    cbbPRF_RV: TComboBox;
    lbl28: TLabel;
    cbbPRF_RI: TComboBox;
    lbl29: TLabel;
    cbbIND_EC: TComboBox;
    lbl30: TLabel;
    cbbIND_ISS: TComboBox;
    lbl31: TLabel;
    cbbIND_RT: TComboBox;
    lbl32: TLabel;
    cbbIND_ST: TComboBox;
    lbl33: TLabel;
    cbbIND_AT: TComboBox;
    lbl34: TLabel;
    cbbIND_IPI: TComboBox;
    lbl35: TLabel;
    cbbIND_RI: TComboBox;
    lbl36: TLabel;
    cbbIND_ICMS: TComboBox;
    GrpPeriodo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtDatai: TDateTimePicker;
    EdtDataf: TDateTimePicker;
    BitBtn1: TBitBtn;
    ACBrSEF21: TACBrSEF2;
    RdFinalidade: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalva_SEF2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GravaINI;
    procedure LeINI;
    //
    procedure Bloco_0;
    procedure Bloco_C;
    procedure Bloco_E;
    procedure Bloco_F;
    procedure Bloco_G;
    procedure Bloco_H;

  public
    { Public declarations }
  end;

var
  FrmSEF2: TFrmSEF2;
  SEF2 : TACBrSEF2;

implementation

uses ACBrSEF2_eDoc_BlocoC_Class,  ACBrSEF2_Bloco0_1,  ACBrSEF2_Bloco0,
   ACBrSEF2_BlocoE_1, uLibrary, uDmWorkCom, uDMClientes, DB;


{$R *.dfm}

procedure TFrmSEF2.GravaINI;
var cINI : TIniFile;
I : Integer;
begin
  cINI := TIniFile.Create(ExtractFilePath(Application.ExeName)+'REG_030.ini');
  cINI.WriteString('eDOC','Indicador de entrada de dados',cbbIND_ED.Text);
  cINI.WriteString('eDOC','Indicador do documento contido no arquivo:',cbbIND_ARQ.Text);
  cINI.WriteString('eDOC','Indicador de exigibilidade da escrituração do ISS:',cbbPRF_ISS.Text);
  cINI.WriteString('eDOC','Indicador de exigibilidade da escrituração do ICMS:',cbbPRF_ICMS.Text);
  cINI.WriteString('eDOC','Indicador de exigibilidade do Registro de Impressão de Documentos Fiscais:',cbbPRF_RIDF.Text);
  cINI.WriteString('eDOC','Indicador de exigibilidade do Registro de Utilização de Documentos Fiscais:',cbbPRF_RUDF.Text);
  cINI.WriteString('eDOC','Indicador de exigibilidade do Livro de Movimentação de Combustíveis:',cbbPRF_LMC.Text);
  cINI.WriteString('eDOC','Indicador de exigibilidade do Registro de Veículos:',cbbPRF_RV.Text);
  cINI.WriteString('eDOC','Indicador de exigibilidade anual do Registro de Inventário:',cbbPRF_RI.Text);
  cINI.WriteString('eDOC','Indicador de apresentação da escrituração contábil:',cbbIND_EC.Text);
  cINI.WriteString('eDOC','Indicador de operações sujeitas ao ISS:',cbbIND_ISS.Text);
  cINI.WriteString('eDOC','Indicador de operações sujeitas à retenção tributária do ISS, na condição de contribuinte-substituído:',cbbIND_RT.Text);
  cINI.WriteString('eDOC','Indicador de operações sujeitas ao ICMS:',cbbIND_ICMS.Text);
  cINI.WriteString('eDOC','Indicador de operações sujeitas à substituição tributária do ICMS, na condição de contribuinte-substituto:',cbbIND_ST.Text);
  cINI.WriteString('eDOC','Indicador de operações sujeitas à antecipação tributária do ICMS, nas entradas:',cbbIND_AT.Text);
  cINI.WriteString('eDOC','Indicador de operações sujeitas ao IPI:',cbbIND_IPI.Text);
  cINI.WriteString('eDOC','Indicador de apresentação avulsa do Registro de Inventário:',cbbIND_RI.Text);

end;

procedure TFrmSEF2.LeINI;
var cINI : TIniFile;
I : Integer;
begin
  if Not FileExists(ExtractFilePath(Application.ExeName)+'REG_030.ini') then
    Exit;

  cINI := TIniFile.Create(ExtractFilePath(Application.ExeName)+'REG_030.ini');
  cbbIND_ED.Text := cINI.ReadString('eDOC','Indicador de entrada de dados','0- Digitação de dados');
  cbbIND_ARQ.Text := cINI.ReadString('eDOC','Indicador do documento contido no arquivo:','5- Livros de resultados e obrigações');
  cbbPRF_ISS.Text := cINI.ReadString('eDOC','Indicador de exigibilidade da escrituração do ISS:','9- Não obrigado a escriturar');
  cbbPRF_ICMS.Text := cINI.ReadString('eDOC','Indicador de exigibilidade da escrituração do ICMS:','2- Sim, com regime integral de escrituração e apuração normal do imposto');
  cbbPRF_RIDF.Text := cINI.ReadString('eDOC','Indicador de exigibilidade do Registro de Impressão de Documentos Fiscais:','1- Não');
  cbbPRF_RUDF.Text := cINI.ReadString('eDOC','Indicador de exigibilidade do Registro de Utilização de Documentos Fiscais:','1- Não');
  cbbPRF_LMC.Text := cINI.ReadString('eDOC','Indicador de exigibilidade do Livro de Movimentação de Combustíveis:','1- Não');
  cbbPRF_RV.Text := cINI.ReadString('eDOC','Indicador de exigibilidade do Registro de Veículos:','1- Não');
  cbbPRF_RI.Text := cINI.ReadString('eDOC','Indicador de exigibilidade anual do Registro de Inventário:','1- Não');
  cbbIND_EC.Text := cINI.ReadString('eDOC','Indicador de apresentação da escrituração contábil:','9- Não obrigado a escriturar');
  cbbIND_ISS.Text := cINI.ReadString('eDOC','Indicador de operações sujeitas ao ISS:','1- Não');
  cbbIND_RT.Text := cINI.ReadString('eDOC','Indicador de operações sujeitas à retenção tributária do ISS, na condição de contribuinte-substituído:','1- Não');
  cbbIND_ICMS.Text := cINI.ReadString('eDOC','Indicador de operações sujeitas ao ICMS:','0- Sim');
  cbbIND_ST.Text := cINI.ReadString('eDOC','Indicador de operações sujeitas à substituição tributária do ICMS, na condição de contribuinte-substituto:','1- Não');
  cbbIND_AT.Text := cINI.ReadString('eDOC','Indicador de operações sujeitas à antecipação tributária do ICMS, nas entradas:','1- Não');
  cbbIND_IPI.Text := cINI.ReadString('eDOC','Indicador de operações sujeitas ao IPI:','1- Não');
  cbbIND_RI.Text := cINI.ReadString('eDOC','Indicador de apresentação avulsa do Registro de Inventário:','1- Não');

end;
procedure TFrmSEF2.FormCreate(Sender: TObject);
begin
  LeInI;
end;

procedure TFrmSEF2.FormShow(Sender: TObject);
var wPathCompleto: String;
begin
  wPathCompleto:= ExtractFilePath(Application.ExeName);
  ACBrSEF21.Path    := ExtractFilePath(wPathCompleto);
  ACBrSEF21.Arquivo := 'sef2.txt';
  EdtDatai.Date := PrimeiroDia(Now);
  EdtDataf.Date := UltimoDia(Now);
  PgcSEF2.ActivePage := TbsGerar;
end;

procedure TFrmSEF2.Bloco_0;
var wIndiceOpcao: Integer;
    Q : TSQLQuery;
begin
  GravaINI;

  Q := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    //
    ACBrSEF21.DT_INI := EdtDatai.Date;
    ACBrSEF21.DT_FIN := EdtDataf.Date;

    ACBrSEF21.Delimitador := '|';
    ACBrSEF21.CurMascara  := '#0.00';
    ACBrSEF21.IniciaGeracao;

    with ACBrSEF21.Bloco_0 do
    begin
       with Registro0000New do
       begin
          NOME_EMPR := DmWorkCom.CdsEmpresa.FieldByName('RAZAO_SOCIAL').AsString;
          CNPJ      := DmWorkCom.CdsEmpresa.FieldByName('CNPJ_CPF').AsString;
          UF        := DmWorkCom.CdsEmpresa.FieldByName('UF').AsString;
          IE        := DmWorkCom.CdsEmpresa.FieldByName('INSCRICAO_RG').AsString;
          COD_MUN   := DmWorkCom.CdsEmpresa.FieldByName('COD_MUNICIPIO').AsString;
          IM        := DmWorkCom.CdsEmpresa.FieldByName('INSC_MUNIC').AsString;
          SUFRAMA   := DmWorkCom.CdsEmpresa.FieldByName('COD_SUFRAMA').AsString;
          FANTASIA  := DmWorkCom.CdsEmpresa.FieldByName('FANTASIA').AsString;
          CPF       := '';
          NIRE      := DmWorkCom.CdsEmpresa.FieldByName('NIRE').AsString;
          PAIS      := '1058';
          COD_VER   := vlVersao2000;
          if RdFinalidade.ItemIndex = 0 then
             COD_FIN   := raOriginal
          else
             COD_FIN   := raSubstituto;
          //
          if rgConteudoArquivo.ItemIndex = 0 then
             COD_CTD := caLancOpResultFiscal
          else if rgConteudoArquivo.ItemIndex = 1 then
             COD_CTD := caExtratodocfiscais;
          //
          with Registro0001New do
          begin
             IND_MOV := icContConteudo;

             with Registro0005New do
             begin
                NOME_RESP := DmWorkCom.CdsEmpresa.FieldByName('NOME_RESP').AsString;
                case DmWorkCom.CdsEmpresa.FieldByName('NOME_RESP').AsInteger of
                   0: COD_ASSIN := qaDiretor;
                   1: COD_ASSIN := qaConsAdministracao;
                   2: COD_ASSIN := qaAdministrador;
                   3: COD_ASSIN := qaAdmGrupo;
                   4: COD_ASSIN := qaAdmSociedadeFiliada;
                   5: COD_ASSIN := qaAdmJudicialPessoaFisica;
                   6: COD_ASSIN := qaAdmJudicialPessoaJuridica;
                   7: COD_ASSIN := qaAdmJudicial;
                   8: COD_ASSIN := qaGestorJudicial;
                   9: COD_ASSIN := qaProcurador;
                  10: COD_ASSIN := qaInventariante;
                  11: COD_ASSIN := qaLiquidante;
                  12: COD_ASSIN := qaInterventor;
                  13: COD_ASSIN := qaEmpresario;
                  14: COD_ASSIN := qaContador;
                  15: COD_ASSIN := qaOutros;
                end;
                CPF_RESP  := DmWorkCom.CdsEmpresa.FieldByName('CPF_RESP').AsString;
                CEP       := DmWorkCom.CdsEmpresa.FieldByName('CEP_RESP').AsString;
                ENDERECO  := DmWorkCom.CdsEmpresa.FieldByName('END_RESP').AsString;
                NUM       := DmWorkCom.CdsEmpresa.FieldByName('NUM_RESP').AsString;
                COMPL     := DmWorkCom.CdsEmpresa.FieldByName('COMPL_RESP').AsString;
                BAIRRO    := DmWorkCom.CdsEmpresa.FieldByName('BAIRRO_RESP').AsString;
                CEP_CP    := '';
                CP        := '';
                FONE      := DmWorkCom.CdsEmpresa.FieldByName('FONE_RESP').AsString;
                FAX       := DmWorkCom.CdsEmpresa.FieldByName('FAX_RESP').AsString;
                EMAIL     := DmWorkCom.CdsEmpresa.FieldByName('EMAIL_RESP').AsString;
             end;

             if ACBrSEF21.TipoArquivo = aSEF then
             begin
                with Registro0025New do
                begin
                   COD_BF_ICMS := bfNenhum;
                   COD_BF_ISS  := '0';
                end;
             end;

             with Registro0030New do
             begin
                wIndiceOpcao := cbbIND_ED.ItemIndex;
                case wIndiceOpcao of
                   0: IND_ED := entDigitacao;
                   1: IND_ED := entImportacao;
                   2: IND_ED := entValidacao;
                end;

                wIndiceOpcao := cbbIND_ARQ.ItemIndex;
                case wIndiceOpcao of
                   0: IND_ARQ := arqOriginal;
                   1: IND_ARQ := arqTranscricaoEmissaoPropria;
                   2: IND_ARQ := arqTranscricaoEmissaoTerceiros;
                   3: IND_ARQ := arqTrancricaoDigitalizacao;
                   4: IND_ARQ := arqTranscricaoEmissaoEquipEspecilizado;
                   5: IND_ARQ := arqLivrosResultadosObrigacoes;
                   6: IND_ARQ := arqLivroMapaControles;
                   7: IND_ARQ := arqGuiasInfEconomicasFiscais;
                   8: IND_ARQ := arqLivrosContabilidade;
                   9: IND_ARQ := arqExtratoDocumentos;
                end;

                wIndiceOpcao := cbbPRF_ISS.ItemIndex;
                case wIndiceOpcao of
                  0: PRF_ISS  := impSimRegimeSimplificado;
                  1: PRF_ICMS := impSimRegimeIntegral;
                end;

                wIndiceOpcao := cbbPRF_RUDF.ItemIndex;
                if wIndiceOpcao = 0 then
                   PRF_RUDF :=  exSim
                else
                   PRF_RUDF :=  exNao;

                wIndiceOpcao := cbbPRF_LMC.ItemIndex;
                if wIndiceOpcao = 0 then
                   PRF_LMC :=  exSim
                else
                   PRF_LMC :=  exNao;

                wIndiceOpcao := cbbPRF_RV.ItemIndex;
                if wIndiceOpcao = 0 then
                   PRF_RV :=  exSim
                else
                   PRF_RV :=  exNao;

                wIndiceOpcao := cbbPRF_RI.ItemIndex;
                if wIndiceOpcao = 0 then
                   PRF_RI :=  exSim
                else
                   PRF_RI :=  exNao;

                wIndiceOpcao := cbbIND_EC.ItemIndex;
                case wIndiceOpcao of
                   0: IND_EC := esCompletaArquivo;
                   1: IND_EC := esCompletaPapel;
                   2: IND_EC := esSimplificadaArquivo;
                   3: IND_EC := esSimplificadaPapel;
                   4: IND_EC := esLivroCaixaArquivo;
                   5: IND_EC := esLivroCaixaPapel;
                   6: IND_EC := esNaoObrigado;
                end;

                wIndiceOpcao := cbbIND_ISS.ItemIndex;
                if wIndiceOpcao = 0 then
                   IND_ISS :=  exSim
                else
                   IND_ISS :=  exNao;

                wIndiceOpcao := cbbIND_RT.ItemIndex;
                if wIndiceOpcao = 0 then
                   IND_RT :=  exSim
                else
                   IND_RT :=  exNao;

                wIndiceOpcao := cbbIND_ICMS.ItemIndex;
                if wIndiceOpcao = 0 then
                   IND_ICMS :=  exSim
                else
                   IND_ICMS :=  exNao;

                wIndiceOpcao := cbbIND_ST.ItemIndex;
                if wIndiceOpcao = 0 then
                   IND_ST :=  exSim
                else
                   IND_ST :=  exNao;

                wIndiceOpcao := cbbIND_AT.ItemIndex;
                if wIndiceOpcao = 0 then
                   IND_AT :=  exSim
                else
                   IND_AT :=  exNao;

                wIndiceOpcao := cbbIND_IPI.ItemIndex;
                if wIndiceOpcao = 0 then
                   IND_IPI :=  exSim
                else
                   IND_IPI :=  exNao;

                wIndiceOpcao := cbbIND_RI.ItemIndex;
                if wIndiceOpcao = 0 then
                   IND_RI :=  exSim
                else
                   IND_RI :=  exNao;

             end;

             with Registro0100New do
             begin
                NOME      := DmWorkCom.CdsContador.FieldByName('CONTABILIDADE').AsString;
                COD_ASSIN := qaContador;
                CNPJ      := DmWorkCom.CdsContador.FieldByName('CNPJ').AsString;
                CRC       := DmWorkCom.CdsContador.FieldByName('CRC_CONTADOR').AsString;
                CEP       := DmWorkCom.CdsContador.FieldByName('CEP').AsString;
                ENDERECO  := DmWorkCom.CdsContador.FieldByName('ENDERECO').AsString;
                NUM       := DmWorkCom.CdsContador.FieldByName('END_NUM').AsString;
                COMPL     := DmWorkCom.CdsContador.FieldByName('END_COMPL').AsString;
                BAIRRO    := DmWorkCom.CdsContador.FieldByName('BAIRRO').AsString;
                UF        := DmWorkCom.CdsContador.FieldByName('UF').AsString;
                COD_MUN   := DmWorkCom.CdsContador.FieldByName('COD_MUNICIPIO').AsInteger;
                CEP_CP    := 0;
                CP        := 0;
                FONE      := DmWorkCom.CdsContador.FieldByName('FONE').AsString;
                FAX       := DmWorkCom.CdsContador.FieldByName('FAX').AsString;
                EMAIL     := DmWorkCom.CdsContador.FieldByName('EMAIL').AsString;
             end;

             // partifipantes vendas
             Q.Close;
             Q.SQL.Clear;
             Q.SQL.Add('select p.idcliente,p.cliente,p.cnpjcpf,');
             Q.SQL.Add('p.uf_end_entrega,p.inscest,c.codcidade');
             Q.SQL.Add('from pedido p');
             Q.SQL.Add('inner join contato c on p.idcliente = c.id');
             Q.SQL.Add('where p.data_entrega between :pdatai and :pdataf');
             Q.SQL.Add('and p.idempresa = :pidempresa');
             Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
             Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
             Q.SQL.Add('and p.coo > 0');
             Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
             Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
             Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
             Q.Open;
             while not Q.Eof do
             begin
               with Registro0150New do
               begin
                  COD_PART := Q.FieldByName('idcliente').AsString;
                  NOME     := Q.FieldByName('cliente').AsString;
                  COD_PAIS := '1058';
                  if Length(FiltraNumero(Q.FieldByName('cnpjcpf').AsString)) <= 11 then
                  begin
                    CNPJ     := '';
                    CPF      := Q.FieldByName('cnpjcpf').AsString;
                  end
                  else
                  begin
                    CNPJ     := Q.FieldByName('cnpjcpf').AsString;
                    CPF      := '';
                  end;
                  UF       := Q.FieldByName('uf_end_entrega').AsString;
                  IE       := Q.FieldByName('inscest').AsString;
                  IE_ST    := '';
                  COD_MUN  := Q.FieldByName('codcidade').AsInteger;
                  IM       := '';
                  SUFRAMA  := '';
               end;
               Q.Next;
             end;

             // partifipantes compras
             Q.Close;
             Q.SQL.Clear;
             Q.SQL.Add('select p.idfornecedor,p.fornecedor,c.cnpj_cpf,');
             Q.SQL.Add('c.uf_end,c.insc_rg,c.codcidade');
             Q.SQL.Add('from compras p');
             Q.SQL.Add('inner join contato c on p.idfornecedor = c.id');
             Q.SQL.Add('where p.data_compra between :pdatai and :pdataf');
             Q.SQL.Add('and p.idempresa = :pidempresa');
             Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
             Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
             Q.SQL.Add('and (p.nota <> '' and p.nota is not null)');
             Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
             Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
             Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
             Q.Open;
             while not Q.Eof do
             begin
               with Registro0150New do
               begin
                  COD_PART := Q.FieldByName('idfornecedor').AsString;
                  NOME     := Q.FieldByName('fornecedor').AsString;
                  COD_PAIS := '1058';
                  if Length(FiltraNumero(Q.FieldByName('cnpj_cpf').AsString)) <= 11 then
                  begin
                    CNPJ     := '';
                    CPF      := Q.FieldByName('cnpj_cpf').AsString;
                  end
                  else
                  begin
                    CNPJ     := Q.FieldByName('cnpj_cpf').AsString;
                    CPF      := '';
                  end;
                  UF       := Q.FieldByName('uf_end').AsString;
                  IE       := Q.FieldByName('insc_rg').AsString;
                  IE_ST    := '';
                  COD_MUN  := Q.FieldByName('codcidade').AsInteger;
                  IM       := '';
                  SUFRAMA  := '';
               end;
               Q.Next;
             end;

             // Produtos vendas
             Q.Close;
             Q.SQL.Clear;
             Q.SQL.Add('select i.idproduto,i.descricao,i.ean13');
             Q.SQL.Add('from pedido p');
             Q.SQL.Add('inner join pedido_itens i on p.id = i.idpedido');
             Q.SQL.Add('inner join produtos pr on i.idproduto = pr.id');
             Q.SQL.Add('where p.data_entrega between :pdatai and :pdataf');
             Q.SQL.Add('and p.idempresa = :pidempresa');
             Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
             Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
             Q.SQL.Add('and p.coo > 0');
             Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
             Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
             Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
             Q.Open;
             while not Q.Eof do
             begin
               with Registro0200New do
               begin
                  COD_ITEM   := Q.FieldByName('idproduto').AsString;
                  DESCR_ITEM := Q.FieldByName('descricao').AsString;
                  COD_GEN    := Q.FieldByName('ean13').AsString;
                  COD_LST    := '';
               end;
               Q.Next;
             end;


             // Produtos vendas
             Q.Close;
             Q.SQL.Clear;
             Q.SQL.Add('select i.idproduto,i.descricao,pr.ean13');
             Q.SQL.Add('from compras c');
             Q.SQL.Add('inner join compras_itens i on c.id = i.idcompra');
             Q.SQL.Add('inner join produtos pr on pr.id = i.idproduto');
             Q.SQL.Add('where c.data_compra between :pdatai and :pdataf');
             Q.SQL.Add('and p.idempresa = :pidempresa');
             Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
             Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
             Q.SQL.Add('and (c.nota <> '' and c.nota is not null)');
             Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
             Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
             Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
             Q.Open;
             while not Q.Eof do
             begin
               with Registro0200New do
               begin
                  COD_ITEM   := Q.FieldByName('idproduto').AsString;
                  DESCR_ITEM := Q.FieldByName('descricao').AsString;
                  COD_GEN    := Q.FieldByName('ean13').AsString;
                  COD_LST    := '';
               end;
               Q.Next;
             end;

             with Registro0400New do
             begin
                COD_NAT   := '1102';
                DESCR_NAT := 'ENTRADA DE MERCADORIAS';
                COP       := 'EA10';
             end;

             with Registro0400New do
             begin
                COD_NAT   := '5102';
                DESCR_NAT := 'SAIDA DE MERCADORIAS';
                COP       := 'SP10';
             end;
          end;
       end;
    end;

    ACBrSEF21.WriteBloco_0;
  finally
    FreeAndNil(Q);
  end;

end;

procedure TFrmSEF2.Bloco_E;
var wRegistroE020: TRegistroSEFE020;
    wRegistroE025: TRegistroSEFE025;
    wRegistroE060: TRegistroSEFE060;
    wRegistroE065: TRegistroSEFE065;
    wRegistroE080: TRegistroSEFE080;
    wRegistroE085: TRegistroSEFE085;
    Q, I : TSQLQuery;
begin
   ACBrSEF21.Bloco_E.RegistroE001.IND_DAD :=  idDocEntrSaiAjuste;

   Q := TSQLQuery.Create(nil);
   I := TSQLQuery.Create(nil);
   try
     Q.SQLConnection := ConexaoDados;
     i.SQLConnection := ConexaoDados;

     // entradas
     Q.Close;
     Q.SQL.Clear;
     Q.SQL.Add('select c.id,c.idfornecedor,c.nota,c.chave_nfe,');
     Q.SQL.Add('c.data_compra,c.data_emissao,c.natop,c.valor_total,');
     Q.SQL.Add('c.desconto,c.acrescimo,c.valor,c.valor_frete,');
     Q.SQL.Add('c.valor_seguro,c.valor_outros,c.base_icms,');
     Q.SQL.Add('c.valor_icms,c.base_icms_st,c.valor_icms_st,c.valor_ipi');
     Q.SQL.Add('from compras c');
     Q.SQL.Add('where c.data_compra between :pdatai and :pdataf');
     Q.SQL.Add('and c.idempresa = :pidempresa');
     Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
     Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
     Q.SQL.Add('and (c.nota <> '' and c.nota is not null)');
     Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
     Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
     Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
     Q.Open;
     while not Q.Eof do
     begin

       wRegistroE020:= ACBrSEF21.Bloco_E.RegistroE020New;
       with wRegistroE020 do
       begin
          IND_OPER     := SefioEntrada;
          IND_EMIT     := SefieTerceiros;
          COD_PART     := Q.FieldByName('idfornecedor').AsString;
          COD_MOD      := SrefNF;
          COD_SIT      := SefcsEmissaonormal;
          SER          := '1';
          NUM_DOC      := Q.FieldByName('nota').AsInteger;
          CHV_NFE     := Q.FieldByName('chave_nfe').AsString;
          DT_EMIS     := Q.FieldByName('data_emissao').AsDateTime;
          DT_DOC      := Q.FieldByName('data_compra').AsDateTime;
          COD_NAT      := '1102';
          COP          := '1102';
          NUM_LCTO     := '0';
          IND_PGTO     := SefipAVista;
          VL_CONT      := Q.FieldByName('valor_total').AsFloat;
          VL_OP_ISS    := 0;
          VL_BC_ICMS   := Q.FieldByName('base_icms').AsFloat;
          VL_ICMS      := Q.FieldByName('valor_icms').AsFloat;
          VL_ICMS_ST   := 0;
          VL_ST_E      := 0;
          VL_ST_S      := 0;
          VL_AT        := 0;
          VL_ISNT_ICMS := 0;
          VL_OUT_ICMS  := Q.FieldByName('valor_outros').AsFloat;
          VL_BC_IPI    := 0;
          VL_IPI       := 0;
          VL_ISNT_IPI  := 0;
          VL_OUT_IPI   := 0;
          COD_INF_OBS  := '';

          wRegistroE025:= wRegistroE020.RegistroE025.New(wRegistroE020);

          //E025 - Detalhes
          I.Close;
          I.SQL.Clear;
          I.SQL.Add('select i.idproduto,i.unidade,i.valor,');
          I.SQL.Add('i.quantidade,i.desconto,i.acrescimo,i.valor_total,');
          I.SQL.Add('p.codigo_ncm,i.cst,i.cfop,i.base_icms,i.aliq_icms,');
          I.SQL.Add('i.valor_icms,i.base_icms_st,i.aliq_icms_st,');
          I.SQL.Add('i.valor_icms_st,i.base_ipi,i.aliq_ipi,i.valor_ipi');
          I.SQL.Add('from compras_itens i');
          I.SQL.Add('inner join produtos p on i.idproduto = p.id');
          I.SQL.Add('where i.idcompra = :pID');
          I.Params.ParamByName('pID').AsInteger := Q.FieldByName('id').AsInteger;
          I.Open;
          while not I.Eof do
          begin
            with wRegistroE025 do
            begin
               VL_CONT_P      := I.FieldByName('valor_total').AsFloat;
               VL_OP_ISS_P    := 0;
               CFOP           := I.FieldByName('CFOP').AsString;
               VL_BC_ICMS_P   := I.FieldByName('base_icms').AsFloat;
               ALIQ_ICMS      := I.FieldByName('aliq_icms').AsFloat;
               VL_ICMS_P      := I.FieldByName('valor_icms').AsFloat;
               VL_BC_ST_P     := I.FieldByName('base_icms_st').AsFloat;
               VL_ICMS_ST_P   := I.FieldByName('aliq_icms_st').AsFloat;
               VL_ISNT_ICMS_P := I.FieldByName('valor_icms_st').AsFloat;
               VL_BC_IPI_P    := I.FieldByName('base_ipi').AsFloat;
               VL_IPI_P       := I.FieldByName('valor_ipi').AsFloat;
               VL_ISNT_IPI_P  := 0;
               VL_OUT_IPI_P   := 0;
               IND_PETR       := 0;
               IND_IMUN       := 0;
            end;
            I.Next;
         end;
       end;
       Q.Next;
     end;

     // Saídas
     Q.Close;
     Q.SQL.Clear;
     Q.SQL.Add('select p.id,p.idcliente,p.numero_doc,p.chave_nfe,');
     Q.SQL.Add('p.data_entrega,p.data_pedido,p.natop,p.valor_total,');
     Q.SQL.Add('p.desconto,p.acrescimo,p.valor,p.valor_frete,');
     Q.SQL.Add('p.valor_seguro,p.valor_outros,p.valor_iss,p.base_icms,');
     Q.SQL.Add('p.valor_icms,p.base_icms_st,p.valor_icms_st,p.valor_ipi');
     Q.SQL.Add('from pedido p');
     Q.SQL.Add('where p.data_entrega between :pdatai and :pdataf');
     Q.SQL.Add('and p.idempresa = :pidempresa');
     Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
     Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
     Q.SQL.Add('and p.coo > 0');
     Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
     Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
     Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
     Q.Open;
     while not Q.Eof do
     begin
       wRegistroE020:= ACBrSEF21.Bloco_E.RegistroE020New;
       with wRegistroE020 do
       begin
         IND_OPER     := SefioSaida;
         IND_EMIT     := SefiePropria;
         COD_PART     := Q.FieldByName('idcliente').AsString;
         COD_MOD      := SrefNF;
         COD_SIT      := SefcsEmissaonormal;
         SER          := '1';
         NUM_DOC      := Q.FieldByName('numero_doc').AsInteger;
         CHV_NFE      := Q.FieldByName('chave_nfe').AsString;
         DT_EMIS      := Q.FieldByName('data_entrega').AsDateTime;
         DT_DOC       := Q.FieldByName('data_pedido').AsDateTime;
         COD_NAT      := '5102';
         COP          := '5102';
         NUM_LCTO     := '0';
         IND_PGTO     := SefipAVista;
         VL_CONT      := Q.FieldByName('valor_total').AsFloat;
         VL_OP_ISS    := 0;
         VL_BC_ICMS   := Q.FieldByName('base_icms').AsFloat;
         VL_ICMS      := Q.FieldByName('valor_icms').AsFloat;
         VL_ICMS_ST   := 0;
         VL_ST_E      := 0;
         VL_ST_S      := 0;
         VL_AT        := 0;
         VL_ISNT_ICMS := 0;
         VL_OUT_ICMS  := Q.FieldByName('valor_outros').AsFloat;
         VL_BC_IPI    := 0;
         VL_IPI       := 0;
         VL_ISNT_IPI  := 0;
         VL_OUT_IPI   := 0;
         COD_INF_OBS  := '';

         //LINHA E025: Detalhes
         wRegistroE025:= wRegistroE020.RegistroE025.New(wRegistroE020);

         I.Close;
         I.SQL.Clear;
         I.SQL.Add('select i.num_item,i.idproduto,i.unidade,i.valor,');
         I.SQL.Add('i.quantidade,i.desconto,i.acrescimo,i.valor_total,');
         I.SQL.Add('p.codigo_ncm,i.cst,i.cfop,i.base_icms,i.aliq_icms,');
         I.SQL.Add('i.valor_icms,i.base_icms_st,i.aliq_icms_st,');
         I.SQL.Add('i.valor_icms_st,i.base_ipi,i.aliq_ipi,i.valor_ipi');
         I.SQL.Add('from pedido_itens i');
         I.SQL.Add('inner join produtos p on i.idproduto = p.id');
         I.SQL.Add('where i.idpedido = :pID');
         I.Params.ParamByName('pID').AsInteger := Q.FieldByName('id').AsInteger;
         I.Open;
         while not I.Eof do
         begin
            with wRegistroE025 do
            begin
               VL_CONT_P      := I.FieldByName('valor_total').AsFloat;
               VL_OP_ISS_P    := 0;
               CFOP           := I.FieldByName('CFOP').AsString;
               VL_BC_ICMS_P   := I.FieldByName('base_icms').AsFloat;
               ALIQ_ICMS      := I.FieldByName('aliq_icms').AsFloat;
               VL_ICMS_P      := I.FieldByName('valor_icms').AsFloat;
               VL_BC_ST_P     := I.FieldByName('base_icms_st').AsFloat;
               VL_ICMS_ST_P   := I.FieldByName('aliq_icms_st').AsFloat;
               VL_ISNT_ICMS_P := I.FieldByName('valor_icms_st').AsFloat;
               VL_BC_IPI_P    := I.FieldByName('base_ipi').AsFloat;
               VL_IPI_P       := I.FieldByName('valor_ipi').AsFloat;
               VL_ISNT_IPI_P  := 0;
               VL_OUT_IPI_P   := 0;
               IND_PETR       := 0;
               IND_IMUN       := 0;
            end;
            I.Next;
          end;
        end;
        Q.Next;
     end;



     //
     wRegistroE060:= ACBrSEF21.Bloco_E.RegistroE060New;

     with wRegistroE060 do
     begin
        COD_MOD      := SrefCCF;
        ECF_CX       := 1;
        ECF_FAB      := 'BE091110100011282077';
        CRO          := 10;
        CRZ          := 10;
        DT_DOC       := StrToDate('01/01/2013');
        NUM_DOC_INI  := 1;
        NUM_DOC_FIN  := 10;
        GT_INI       := 0;
        GT_FIN       := 100;
        VL_BRT       := 100;
        VL_CANC_ICMS := 0;
        VL_DESC_ICMS := 0;
        VL_ACMO_ICMS := 0;
        VL_OP_ISS    := 0;
        VL_LIQ       := 100;
        VL_BC_ICMS   := 100;
        VL_ICMS      := 17;
        VL_ISN       := 0;
        VL_NT        := 0;
        VL_ST        := 0;
        COD_INF_OBS  := '';

       //rondado 2020
        //wRegistroE065:= wRegistroE060.RegistroE065.New(wRegistroE060);
        wRegistroE065:= wRegistroE060.RegistroE065.New();

        with wRegistroE065 do
        begin
           CFOP         := '5102';
           VL_BC_ICMS_P := 100;
           ALIQ_ICMS    := 17;
           VL_ICMS_P    := 17;
           IND_IMUN     := 0;
        end;
     end;

     with wRegistroE080 do
     begin
        IND_TOT      := 1;
        COD_MOD      := SrefNFVCCVC;
        NUM_MR       := 1;
        DT_DOC       := StrToDate('01/01/2013');
        VL_BRT       := 100;
        VL_CANC_ICMS := 0;
        VL_DESC_ICMS := 0;
        VL_ACMO_ICMS := 0;
        VL_OP_ISS    := 0;
        COP          := '5102';
        NUM_LCTO     := '1';
        VL_CONT      := 100;
        VL_BC_ICMS   := 100;
        VL_ICMS      := 17;
        VL_ISNT_ICMS := 0;
        VL_ST        := 0;
        IND_OBS      := 0;
     end;

     //rondado 2020
     //wRegistroE085:= wRegistroE080.RegistroE085.New(wRegistroE080);
     wRegistroE085:= wRegistroE080.RegistroE085.New();

     with wRegistroE085 do
     begin
        VL_CONT_P      := 100;
        VL_OP_ISS_P    := 0;
        VL_BC_ICMS_P   := 100;
        ALIQ_ICMS      := 17;
        VL_ISNT_ICMS_P := 0;
        VL_ST_P        := 0;
        IND_IMUN       := 0;
     end;
   finally
     FreeAndNil(Q);
     FreeAndNil(I);
   end;
end;

procedure TFrmSEF2.Bloco_F;
begin

end;

procedure TFrmSEF2.Bloco_G;
begin

end;

procedure TFrmSEF2.Bloco_H;
begin

end;

procedure TFrmSEF2.btnSalva_SEF2Click(Sender: TObject);
begin
  DmWorkCom.Dados_Empresa(sIDEmpresa);
  DmWorkCom.Dados_Contador(DmWorkCom.CdsEmpresa.FieldByName('IDCONTADOR').AsInteger);
  if rgConteudoArquivo.ItemIndex = 0 then // SEF2
  begin
    Bloco_0;
    Bloco_E;
    Bloco_F;
    Bloco_G;
    Bloco_H;
    ACBrSEF21.SaveFileTXT;
  end
  else if rgConteudoArquivo.ItemIndex = 1 then // eDOC
  begin
    Bloco_C;
    ACBrSEF21.SaveFileTXT;
  end;
end;

procedure TFrmSEF2.Bloco_C;
var ItemCompra: Integer;
    wRegistroC020: TRegistroSEFC020;
    wRegistroC300: TRegistroSEFC300;
    Q, I : TSQLQuery;
begin
  Q := TSQLQuery.Create(nil);
  I := TSQLQuery.Create(nil);
  try
    Q.SQLConnection := ConexaoDados;
    i.SQLConnection := ConexaoDados;

    with ACBrSEF21.Bloco_C do
    begin
       with RegistroC001New do
       begin
         IND_DAD := icContConteudo;

         // entradas
         Q.Close;
         Q.SQL.Clear;
         Q.SQL.Add('select c.id,c.idfornecedor,c.nota,c.chave_nfe,');
         Q.SQL.Add('c.data_compra,c.data_emissao,c.natop,c.valor_total,');
         Q.SQL.Add('c.desconto,c.acrescimo,c.valor,c.valor_frete,');
         Q.SQL.Add('c.valor_seguro,c.valor_outros,c.base_icms,');
         Q.SQL.Add('c.valor_icms,c.base_icms_st,c.valor_icms_st,c.valor_ipi');
         Q.SQL.Add('from compras c');
         Q.SQL.Add('where c.data_compra between :pdatai and :pdataf');
         Q.SQL.Add('and c.idempresa = :pidempresa');
         Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
         Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
         Q.SQL.Add('and (c.nota <> '' and c.nota is not null)');
         Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
         Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
         Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
         Q.Open;
         while not Q.Eof do
         begin
            wRegistroC020:= RegistroC020New;
            with wRegistroC020 do
            begin
               IND_OPER    := SefioEntrada;
               IND_EMIT    := SefieTerceiros;
               COD_PART    := Q.FieldByName('idfornecedor').AsString;
               COD_MOD     := SrefNFe;
               NUM_DOC     := Q.FieldByName('nota').AsInteger;
               COD_SIT     := SefcsEmissaonormal;
               SER         := '1';
               CHV_NFE     := Q.FieldByName('chave_nfe').AsString;
               DT_EMIS     := Q.FieldByName('data_emissao').AsDateTime;
               DT_DOC      := Q.FieldByName('data_compra').AsDateTime;
               COD_NAT     := '1102';
               IND_PGTO    := SefipAVista;
               VL_DOC      := Q.FieldByName('valor_total').AsFloat;
               VL_DESC     := Q.FieldByName('desconto').AsFloat;
               VL_ACMO     := Q.FieldByName('acrescimo').AsFloat;
               VL_MERC     := Q.FieldByName('valor').AsFloat;
               VL_FRT      := Q.FieldByName('valor_frete').AsFloat;
               VL_SEG      := Q.FieldByName('valor_seguro').AsFloat;
               VL_OUT_DA   := Q.FieldByName('valor_outros').AsFloat;
               VL_OP_ISS   := 0;
               VL_BC_ICMS  := Q.FieldByName('base_icms').AsFloat;
               VL_ICMS     := Q.FieldByName('valor_icms').AsFloat;
               VL_BC_ST    := Q.FieldByName('base_icms_st').AsFloat;
               VL_ICMS_ST  := Q.FieldByName('valor_icms_st').AsFloat;
               VL_AT       := 0;
               VL_IPI      := Q.FieldByName('valor_ipi').AsFloat;
               COD_INF_OBS := '';

               //LINHA C300: ITENS DO DOCUMENTO
               I.Close;
               I.SQL.Clear;
               I.SQL.Add('select i.idproduto,i.unidade,i.valor,');
               I.SQL.Add('i.quantidade,i.desconto,i.acrescimo,i.valor_total,');
               I.SQL.Add('p.codigo_ncm,i.cst,i.cfop,i.base_icms,i.aliq_icms,');
               I.SQL.Add('i.valor_icms,i.base_icms_st,i.aliq_icms_st,');
               I.SQL.Add('i.valor_icms_st,i.base_ipi,i.aliq_ipi,i.valor_ipi');
               I.SQL.Add('from compras_itens i');
               I.SQL.Add('inner join produtos p on i.idproduto = p.id');
               I.SQL.Add('where i.idcompra = :pID');
               I.Params.ParamByName('pID').AsInteger := Q.FieldByName('id').AsInteger;
               I.Open;
               ItemCompra := 0;
               while not I.Eof do
               begin
                  //rondado 2020
                  //wRegistroC300 := wRegistroC020.RegistrosC300.New(wRegistroC020);
                  wRegistroC300 := wRegistroC020.RegistrosC300.New();

                  Inc(ItemCompra);
                  with wRegistroC300 do
                  begin
                     NUM_ITEM     := ItemCompra;
                     COD_ITEM     := I.FieldByName('idproduto').AsString;
                     UNID         := I.FieldByName('unidade').AsString;
                     VL_UNIT      := I.FieldByName('valor').AsFloat;
                     QTD          := I.FieldByName('quantidade').AsFloat;
                     VL_DESC_I    := I.FieldByName('desconto').AsFloat;
                     VL_ACMO_I    := I.FieldByName('acrescimo').AsFloat;
                     VL_ITEM      := I.FieldByName('valor_total').AsFloat;
                     COD_NCM      := I.FieldByName('codigo_ncm').AsString;
                     CST          := I.FieldByName('cst').AsString;
                     CFOP         := I.FieldByName('CFOP').AsInteger;
                     VL_BC_ICMS_I := I.FieldByName('base_icms').AsFloat;
                     ALIQ_ICMS    := I.FieldByName('aliq_icms').AsFloat;
                     VL_ICMS_I    := I.FieldByName('valor_icms').AsFloat;
                     VL_BC_ST_I   := I.FieldByName('base_icms_st').AsFloat;
                     ALIQ_ST      := I.FieldByName('aliq_icms_st').AsFloat;
                     VL_ICMS_ST_I := I.FieldByName('valor_icms_st').AsFloat;
                     VL_BC_IPI    := I.FieldByName('base_ipi').AsFloat;
                     ALIQ_IPI     := I.FieldByName('aliq_ipi').AsFloat;
                     VL_IPI_I     := I.FieldByName('valor_ipi').AsFloat;
                  end;
                  I.Next;
               end;
            end;
            Q.Next;
         end;

         // Saídas
         Q.Close;
         Q.SQL.Clear;
         Q.SQL.Add('select p.id,p.idcliente,p.coo,p.ccf,p.numero_doc,p.chave_nfe,');
         Q.SQL.Add('p.data_entrega,p.data_pedido,p.natop,p.valor_total,');
         Q.SQL.Add('p.desconto,p.acrescimo,p.valor,p.valor_frete,');
         Q.SQL.Add('p.valor_seguro,p.valor_outros,p.valor_iss,p.base_icms,');
         Q.SQL.Add('p.valor_icms,p.base_icms_st,p.valor_icms_st,p.valor_ipi');
         Q.SQL.Add('from pedido p');
         Q.SQL.Add('where p.data_entrega between :pdatai and :pdataf');
         Q.SQL.Add('and p.idempresa = :pidempresa');
         Q.SQL.Add('and p.cancelado = '+QuotedStr('N'));
         Q.SQL.Add('and p.confirmada = '+QuotedStr('S'));
         Q.SQL.Add('and p.coo > 0');
         Q.Params.ParamByName('pidempresa').AsInteger := sIDEmpresa;
         Q.Params.ParamByName('pdatai').AsDate := EdtDatai.Date;
         Q.Params.ParamByName('pdataif').AsDate := EdtDataf.Date;
         Q.Open;
         while not Q.Eof do
         begin
            wRegistroC020:= RegistroC020New;
            with wRegistroC020 do
            begin
               IND_OPER    := SefioSaida;
               IND_EMIT    := SefiePropria;
               COD_PART    := Q.FieldByName('idcliente').AsString;
               if Q.FieldByName('numero_doc').AsString <> '' then
               begin
                 COD_MOD     := SrefNFe;
                 NUM_DOC     := Q.FieldByName('numero_doc').AsInteger;
               end
               else
               begin
                 COD_MOD     := SrefCCF;
                 NUM_DOC     := Q.FieldByName('ccf').AsInteger;
               end;
               COD_SIT     := SefcsEmissaonormal;
               SER         := '1';
               CHV_NFE     := Q.FieldByName('chave_nfe').AsString;
               DT_EMIS     := Q.FieldByName('data_entrega').AsDateTime;
               DT_DOC      := Q.FieldByName('data_pedido').AsDateTime;
               COD_NAT     := '5102';
               IND_PGTO    := SefipAVista;
               VL_DOC      := Q.FieldByName('valor_total').AsFloat;
               VL_DESC     := Q.FieldByName('desconto').AsFloat;
               VL_ACMO     := Q.FieldByName('acrescimo').AsFloat;
               VL_MERC     := Q.FieldByName('valor').AsFloat;
               VL_FRT      := Q.FieldByName('valor_frete').AsFloat;
               VL_SEG      := Q.FieldByName('valor_seguro').AsFloat;
               VL_OUT_DA   := Q.FieldByName('valor_outros').AsFloat;
               VL_OP_ISS   := Q.FieldByName('valor_iss').AsFloat;
               VL_BC_ICMS  := Q.FieldByName('base_icms').AsFloat;
               VL_ICMS     := Q.FieldByName('valor_icms').AsFloat;
               VL_BC_ST    := Q.FieldByName('base_icms_st').AsFloat;
               VL_ICMS_ST  := Q.FieldByName('valor_icms_st').AsFloat;
               VL_AT       := 0;
               VL_IPI      := Q.FieldByName('valor_ipi').AsFloat;
               COD_INF_OBS := '';

               //LINHA C300: ITENS DO DOCUMENTO
               I.Close;
               I.SQL.Clear;
               I.SQL.Add('select i.num_item,i.idproduto,i.unidade,i.valor,');
               I.SQL.Add('i.quantidade,i.desconto,i.acrescimo,i.valor_total,');
               I.SQL.Add('p.codigo_ncm,i.cst,i.cfop,i.base_icms,i.aliq_icms,');
               I.SQL.Add('i.valor_icms,i.base_icms_st,i.aliq_icms_st,');
               I.SQL.Add('i.valor_icms_st,i.base_ipi,i.aliq_ipi,i.valor_ipi');
               I.SQL.Add('from pedido_itens i');
               I.SQL.Add('inner join produtos p on i.idproduto = p.id');
               I.SQL.Add('where i.idpedido = :pID');
               I.Params.ParamByName('pID').AsInteger := Q.FieldByName('id').AsInteger;
               I.Open;
               while not I.Eof do
               begin
                  //rondado 2020

                  //wRegistroC300 := wRegistroC020.RegistrosC300.New(wRegistroC020);
                  wRegistroC300 := wRegistroC020.RegistrosC300.New();

                  with wRegistroC300 do
                  begin
                     NUM_ITEM     := I.FieldByName('num_item').AsInteger;
                     COD_ITEM     := I.FieldByName('idproduto').AsString;
                     UNID         := I.FieldByName('unidade').AsString;
                     VL_UNIT      := I.FieldByName('valor').AsFloat;
                     QTD          := I.FieldByName('quantidade').AsFloat;
                     VL_DESC_I    := I.FieldByName('desconto').AsFloat;
                     VL_ACMO_I    := I.FieldByName('acrescimo').AsFloat;
                     VL_ITEM      := I.FieldByName('valor_total').AsFloat;
                     COD_NCM      := I.FieldByName('codigo_ncm').AsString;
                     CST          := I.FieldByName('cst').AsString;
                     CFOP         := I.FieldByName('CFOP').AsInteger;
                     VL_BC_ICMS_I := I.FieldByName('base_icms').AsFloat;
                     ALIQ_ICMS    := I.FieldByName('aliq_icms').AsFloat;
                     VL_ICMS_I    := I.FieldByName('valor_icms').AsFloat;
                     VL_BC_ST_I   := I.FieldByName('base_icms_st').AsFloat;
                     ALIQ_ST      := I.FieldByName('aliq_icms_st').AsFloat;
                     VL_ICMS_ST_I := I.FieldByName('valor_icms_st').AsFloat;
                     VL_BC_IPI    := I.FieldByName('base_ipi').AsFloat;
                     ALIQ_IPI     := I.FieldByName('aliq_ipi').AsFloat;
                     VL_IPI_I     := I.FieldByName('valor_ipi').AsFloat;
                  end;
                  I.Next;
               end;
            end;
            Q.Next;
         end;

      end;
    end;

    ACBrSEF21.WriteBloco_C(true);
  finally
    FreeAndNil(Q);
    FreeAndNil(I);
  end;

end;

procedure TFrmSEF2.BitBtn1Click(Sender: TObject);
begin
  GravaINI;
end;

end.
