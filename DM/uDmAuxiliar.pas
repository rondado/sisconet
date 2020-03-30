unit uDmAuxiliar;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr, unitVidaLink,
  Windows, Messages, Variants, Graphics, Controls, Forms, ExtCtrls, ComCtrls,
  ImgList, Dialogs, Menus, uFuncoesPAFECF, uDmAcBr;

type
  TDmAuxiliar = class(TDataModule)
    PBMVidaLink1: TPBMVidaLink;
    QryGeral: TSQLQuery;
    DspGeral: TDataSetProvider;
    CdsRegistros: TClientDataSet;
    CdsRegAuxiliar: TClientDataSet;
    CdsRegAuxiliar1: TClientDataSet;
    CdsNFeXml: TClientDataSet;
    CdsGeral: TClientDataSet;
    QryAux: TSQLQuery;
    CdsRegAuxVP: TClientDataSet;
    CdsRegAuxVPRegistro: TStringField;
    CdsRegAuxVPTotal: TIntegerField;
    ControleLinhaBloco: TClientDataSet;
    ControleLinhaBlocoBLOCO: TStringField;
    ControleLinhaBlocoQUANT: TIntegerField;
    CdsListaEstoque: TClientDataSet;
    CdsListaEstoqueIDPRODUTO: TIntegerField;
    CdsListaEstoqueDESCRICAO: TStringField;
    CdsListaEstoqueUNIDADE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    // rotinas do Sintegra pelo Acbr
    function AbreDadosRegistro50(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro51(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro53(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro54(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro60M(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro60A(Cd_Reg60m:Integer):Boolean;
    function AbreDadosRegistro60D(DtaEmis:TDatetime):Boolean;
    function AbreDadosRegistro60I(DtaEmis:TDatetime):Boolean;
    function AbreDadosRegistro60R(pDatai,pdataf:TDatetime;pNumSerie:String):Boolean;
    function AbreDadosRegistro61(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro61R(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro70(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro71(pDatai,pdataf:TDatetime):Boolean;
    function AbreDadosRegistro74(pDtInvet:TDatetime):Boolean;
    function AbreDadosReg61R4(pDatai,pDataf:TDateTime):Boolean;
    function AbreDadosReg61R5(pDatai,pDataf:TDateTime):Boolean;
    function Dados_NFeXML(ChaveNFe:String):Boolean;
    procedure Exclui_NFeXML(ChaveNFe:String);
    function RetornaIDA2Movimento(pData: TDateTime; Descricao: String; Tipo: Integer): Integer;
  end;

var
  DmAuxiliar: TDmAuxiliar;

implementation

uses uDmConexao, uLibrary;

{$R *.dfm}

procedure TDmAuxiliar.DataModuleCreate(Sender: TObject);
begin
  // cria clientdataset temporario
  if not(CdsRegAuxVP.Active) then
     CdsRegAuxVP.CreateDataSet;
  CdsRegAuxVP.EmptyDataSet;
  // Controle de Linhas
  if not(ControleLinhaBloco.Active) then
     ControleLinhaBloco.CreateDataSet;
  ControleLinhaBloco.EmptyDataSet;
  // Controle de Lista de estoque
  if not CdsListaEstoque.Active then
     CdsListaEstoque.CreateDataSet;
  CdsListaEstoque.EmptyDataSet;

end;

procedure TDmAuxiliar.DataModuleDestroy(Sender: TObject);
begin
  CdsRegAuxVP.Free;
  ControleLinhaBloco.Free;

end;

function TDmAuxiliar.AbreDadosRegistro50(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_50(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro51(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_51(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro53(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_53(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro54(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_54(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro60A(Cd_Reg60m: Integer): Boolean;
begin
  with CdsRegAuxiliar do
  begin
    Close;
    CommandText := 'select * from proc_registro_60A(:pCdReg60m)';
    Params.ParamByName('pCdReg60m').AsInteger := Cd_Reg60m;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro60D(DtaEmis: TDatetime): Boolean;
begin
  try
    with CdsRegAuxiliar1 do
    begin
      Close;
      CommandText := 'select * from proc_registro_60d(:pDataEmis)';
      Params.ParamByName('pDataEmis').AsDate := DtaEmis;
      Open;
      Result := not IsEmpty;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;

end;

function TDmAuxiliar.AbreDadosRegistro60M(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_60M(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro61(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_61(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro61R(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_61R(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro70(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_70(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro71(pDatai,pdataf:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_71(:pDatai, :pDataf, :pEmpresa)';
    Params.ParamByName('pDatai').AsDate      := pDatai;
    Params.ParamByName('pDataf').AsDate      := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosRegistro74(pDtInvet:TDatetime): Boolean;
begin
  with CdsRegistros do
  begin
    Close;
    CommandText := 'select * from proc_registro_74(:pDtInvent,:pEmpresa)';
    Params.ParamByName('pDtInvent').AsDate   := pDtInvet;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.Dados_NFeXML(ChaveNFe: String): Boolean;
begin
  with DmAuxiliar.CdsNFeXml do
  begin
    Close;
    CommandText := 'select * from nfe_xml x '+
                   'where x.chave_nfe = '+QuotedStr('NFe'+ChaveNFe);
    Open;
    Result := not IsEmpty;
  end;

end;

procedure TDmAuxiliar.Exclui_NFeXML(ChaveNFe: String);
begin
  with DmAuxiliar.CdsGeral do
  begin
    Close;
    CommandText := 'delete from nfe_xml x '+
                   'where x.chave_nfe = '+QuotedStr('NFe'+ChaveNFe);
    Execute;
  end;

end;


function TDmAuxiliar.AbreDadosRegistro60I(DtaEmis: TDatetime): Boolean;
begin
  try
    with CdsRegAuxiliar1 do
    begin
      Close;
      CommandText := 'select * from proc_registro_60i(:pDataEmis)';
      Params.ParamByName('pDataEmis').AsDate := DtaEmis;
      Open;
      Result := not IsEmpty;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;

end;

function TDmAuxiliar.AbreDadosRegistro60R(pDatai,pdataf:TDatetime;
  pNumSerie: String): Boolean;
begin
  try
    with CdsRegAuxiliar1 do
    begin
      Close;
      CommandText := 'select * from PROC_REGISTRO_60R(:pDatai, :pDataf, :pNumSerie)';
      Params.ParamByName('pNumSerie').AsString := pNumSerie;
      Params.ParamByName('pDatai').AsDate      := pDatai;
      Params.ParamByName('pDataf').AsDate      := pdataf;
      Open;
      Result := not IsEmpty;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;

end;

function TDmAuxiliar.RetornaIDA2Movimento(pData: TDateTime;
  Descricao: String; Tipo: Integer): Integer;
begin
  Result := 0;
  try
    with CdsGeral do
    begin
      close;
      CommandText := 'select x.id from paf_registro_a2 x '+
                     'where x.data_movimento = :pData '+
                     'and x.descricao = :pDescricao '+
                     'and x.cod_tipo = '+IntToStr(Tipo);
      Params.ParamByName('pdata').AsDate := pData;
      Params.ParamByName('pDescricao').AsString := Descricao;
      Open;
      if not IsEmpty then
         Result := FieldByName('id').AsInteger;
      Close;
    end;
  except
    on Exc: Exception do MessageDlg(Exc.Message,mtError,[mbOK],0);
  end;

end;

function TDmAuxiliar.AbreDadosReg61R4(pDatai, pDataf: TDateTime): Boolean;
begin
  with CdsGeral do
  begin
    Close;
    CommandText := 'select r.num_ordem,r.data_emissao,c.nome, '+
                   '       c.cnpj_cpf,sum(r.valor) as valor '+
                   'from registro61 r '+
                   'inner join contato c on c.id = r.id_cliente '+
                   'where r.data_emissao between :pDatai and :pdataf '+
                   'and r.idempresa = :pEmpresa '+
                   'group by r.num_ordem,r.data_emissao,c.nome, '+
                   '         c.cnpj_cpf';
    Params.ParamByName('pDatai').AsDate   := pDatai;
    Params.ParamByName('pDataf').AsDate   := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

function TDmAuxiliar.AbreDadosReg61R5(pDatai,
  pDataf: TDateTime): Boolean;
begin
  with CdsGeral do
  begin
    Close;
    CommandText := 'select r.num_ordem,r.idproduto,r.descricao, '+
                   '       r.quantidade,p.unidade,r.valor, '+
                   '       r.total,r.cst,r.aliq_icms '+
                   'from registro61 r '+
                   'inner join produtos p on r.idproduto = p.id '+
                   'where r.data_emissao between :pdatai and :pdataf '+
                   'and r.idempresa = :pempresa';
    Params.ParamByName('pDatai').AsDate   := pDatai;
    Params.ParamByName('pDataf').AsDate   := pDataf;
    Params.ParamByName('pEmpresa').AsInteger := sIDEmpresa;
    Open;
    Result := not IsEmpty;
  end;

end;

end.
