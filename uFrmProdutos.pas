unit uFrmProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmConsPadrao, Data.FMTBcd, inifiles, //fabricio inifiles
  System.Actions, Vcl.ActnList, Vcl.ImgList, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, frxClass, frxDBSet, System.ImageList;

type
  TFrmProdutos = class(TFrmConsPadrao)
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    BitBtn2: TBitBtn;
    ActEstoqueLoja: TAction;
    ActClonarProduto: TAction;
    QryConsultaID: TIntegerField;
    QryConsultaEAN13: TStringField;
    QryConsultaDESCRICAO: TStringField;
    QryConsultaREFERENCIA: TStringField;
    QryConsultaUNIDADE: TStringField;
    QryConsultaCST_INTERNO: TStringField;
    QryConsultaCFOP_INTERNO: TStringField;
    QryConsultaQUANTIDADE: TFloatField;
    QryConsultaPRECO_VENDA: TFloatField;
    QryConsultaIPPT: TStringField;
    QryConsultaIAT: TStringField;
    QryConsultaALIQUOTA_ICMS: TFloatField;
    QryConsultaID_COR: TIntegerField;
    QryConsultaID_TAMANHO: TIntegerField;
    QryConsultaNOME: TStringField;
    QryConsultaMETRAGEM: TFloatField;
    CdsConsultaID: TIntegerField;
    CdsConsultaEAN13: TStringField;
    CdsConsultaDESCRICAO: TStringField;
    CdsConsultaREFERENCIA: TStringField;
    CdsConsultaUNIDADE: TStringField;
    CdsConsultaCST_INTERNO: TStringField;
    CdsConsultaCFOP_INTERNO: TStringField;
    CdsConsultaQUANTIDADE: TFloatField;
    CdsConsultaPRECO_VENDA: TFloatField;
    CdsConsultaIPPT: TStringField;
    CdsConsultaIAT: TStringField;
    CdsConsultaALIQUOTA_ICMS: TFloatField;
    CdsConsultaID_COR: TIntegerField;
    CdsConsultaID_TAMANHO: TIntegerField;
    CdsConsultaNOME: TStringField;
    CdsConsultaMETRAGEM: TFloatField;
    BtnClonar: TBitBtn;
    BitBtn3: TBitBtn;
    DataProdAliq: TDataSource;
    BtnMargem: TBitBtn;
    procedure ActLocalizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActAlterarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure GridDadosDblClick(Sender: TObject);
    procedure GridDadosKeyPress(Sender: TObject; var Key: Char);
    procedure CbxTipoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtLocalizarExit(Sender: TObject);
    procedure ActImprimirExecute(Sender: TObject);
    procedure ActEstoqueLojaExecute(Sender: TObject);
    procedure ActClonarProdutoExecute(Sender: TObject);
    procedure EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure BtnMargemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDProd, xIDCor, xIDTamanho : Integer;
    xNomeCor, xTamanho : String;
    sPermitirCombustivel, sApenasConsulta : Boolean;
  end;

var
  FrmProdutos: TFrmProdutos;

implementation

{$R *.dfm}

uses uLibrary, uDmWorkCom, uFrmCadProdutos, uDmProdutos, uFrmEstoqueLojas,
  uFrmProdutoCores, uFrmProdutoTamanho, uDmConexao;

procedure TFrmProdutos.ActAlterarExecute(Sender: TObject);
begin
  inherited;
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    try
      Application.CreateForm(TFrmCadProdutos,FrmCadProdutos);
      FrmCadProdutos.sIDProduto := DataConsulta.DataSet.FieldByName('ID').AsInteger;
      FrmCadProdutos.ShowModal;
      ActLocalizarExecute(Sender);
    finally
      FreeAndNil(FrmCadProdutos);
    end;
  end;

end;

procedure TFrmProdutos.ActClonarProdutoExecute(Sender: TObject);
var aIDProduto,aIDCod,aIDTamanho,aIDProdClone : integer;
begin
  inherited;
  // se tiver configurado Grade, solicita a mesma
  if CdsConsulta.RecordCount > 0 then
  begin
    aIDProduto := CdsConsulta.FieldByName('ID').AsInteger;
    // seleciona a cor
    try
      Application.CreateForm(TFrmProdutoCores,FrmProdutoCores);
      FrmProdutoCores.sApenasConsulta := True;
      FrmProdutoCores.ShowModal;
      aIDCod := FrmProdutoCores.sIDCor;
    finally
      FreeAndNil(FrmProdutoCores);
    end;
    // seleciona o tamanho
    try
      Application.CreateForm(TFrmProdutoTamanho,FrmProdutoTamanho);
      FrmProdutoTamanho.sApenasConsulta := True;
      FrmProdutoTamanho.ShowModal;
      aIDTamanho := FrmProdutoTamanho.sIDTamanho;
    finally
      FreeAndNil(FrmProdutoTamanho);
    end;
    // verifica se existe a grade do produto
    if not DmWorkCom.VerificaProdutoGrade(aIDProduto,aIDCod,aIDTamanho) then
    begin
      // se não existe realiza o clone do produto.
      aIDProdClone := DmWorkCom.ClonarProdutoCodTamanho(aIDProduto,aIDCod,aIDTamanho);
      if aIDProdClone <= 0 then
      begin
        MessageDlg('Erro ao clonar o produto. Verifique!!!',mtWarning,[mbOK],0);
        Exit;
      end;
      DmProdutos.Dados_Produto(aIDProdClone);
    end;
  end;

end;

procedure TFrmProdutos.ActEstoqueLojaExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmEstoqueLoja,FrmEstoqueLoja);
    FrmEstoqueLoja.sIDProduto := CdsConsulta.FieldByName('ID').AsInteger;
    FrmEstoqueLoja.ShowModal;
  finally
    FreeAndNil(FrmEstoqueLoja);
  end;

end;

procedure TFrmProdutos.ActExcluirExecute(Sender: TObject);
begin
  inherited;
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    if DmProdutos.Dados_Produto(DataConsulta.DataSet.FieldByName('ID').AsInteger) then
    begin
      if Confirmacao('Confirma a exclusão do produto selecionado?') then
      begin
        DmProdutos.CdsProdutos.Delete;
        Grava_Dados(DmProdutos.CdsProdutos);
        ActLocalizarExecute(Sender);
      end;
    end;
  end;

end;

procedure TFrmProdutos.ActImprimirExecute(Sender: TObject);
begin
  inherited;
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\RelProdutos.fr3');
  frxReport1.ShowReport;
end;

procedure TFrmProdutos.ActLocalizarExecute(Sender: TObject);
begin
  inherited;
  CdsConsulta.Close;
  CdsConsulta.Params.Clear;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;
  QryConsulta.SQL.Add('select produtos.id,produtos.EAN13,produtos.descricao,');
  QryConsulta.SQL.Add('produtos.referencia,produtos.unidade,produtos.cst_interno,');
  QryConsulta.SQL.Add('produtos.cfop_interno,estoque.quantidade,produtos.preco_venda,');
  QryConsulta.SQL.Add('produtos.ippt,produtos.iat,produtos.ALIQUOTA_ICMS,produtos.id_cor,');
  QryConsulta.SQL.Add('produtos.id_tamanho,produto_cores.nome,produto_tamanho.metragem from produtos');
  QryConsulta.SQL.Add('left outer join estoque on (estoque.idproduto = produtos.id and');
  QryConsulta.SQL.Add('                            estoque.idempresa = :pIDEmpresa)');
  QryConsulta.SQL.Add('left outer join grupo on produtos.grupo = grupo.id');
  QryConsulta.SQL.Add('left outer join produto_cores on produtos.id_cor = produto_cores.id');
  QryConsulta.SQL.Add('left outer join produto_tamanho on produtos.id_tamanho = produto_tamanho.id');
  QryConsulta.SQL.Add('where produtos.ativo = '+QuotedStr('T'));
  if not sPermitirCombustivel then
     QryConsulta.SQL.Add('and produtos.combustivel = '+QuotedStr('N'));
  if CbxTipoPesq.ItemIndex = 0 then // ID
     QryConsulta.SQL.Add('and produtos.id = :pID')
  else if CbxTipoPesq.ItemIndex = 1 then // Descricao
     QryConsulta.SQL.Add('and produtos.descricao like :pLoc')
  else if CbxTipoPesq.ItemIndex = 2 then // Referencia
     QryConsulta.SQL.Add('and produtos.referencia like :pLoc')
  else if CbxTipoPesq.ItemIndex = 3 then // Grupo
     QryConsulta.SQL.Add('and produtos.ean13 = :pLoc');
  //
  QryConsulta.SQL.Add('group by produtos.id,produtos.EAN13,produtos.descricao,');
  QryConsulta.SQL.Add('produtos.referencia,produtos.unidade,produtos.cst_interno,');
  QryConsulta.SQL.Add('produtos.cfop_interno,estoque.quantidade,produtos.preco_venda,');
  QryConsulta.SQL.Add('produtos.ippt,produtos.iat,produtos.ALIQUOTA_ICMS,produtos.id_cor,');
  QryConsulta.SQL.Add('produtos.id_tamanho,produto_cores.nome,produto_tamanho.metragem');
  // passa párametros
  CdsConsulta.FetchParams;
  CdsConsulta.Params.ParamByName('pIDEmpresa').AsInteger := sIDEmpresa;
  //
  if CbxTipoPesq.ItemIndex = 0 then // codigo
     CdsConsulta.Params.ParamByName('pID').AsInteger := StrToInt(Edtlocalizar.Text)
  else if (CbxTipoPesq.ItemIndex = 1) or (CbxTipoPesq.ItemIndex = 2) then // descricao // referencia
     CdsConsulta.Params.ParamByName('pLoc').AsString := '%'+UpperCase(Edtlocalizar.Text)+'%'
  else if (CbxTipoPesq.ItemIndex = 3) then // descricao // referencia
     CdsConsulta.Params.ParamByName('pLoc').AsString := Edtlocalizar.Text;
  // verifica dados
  CdsConsulta.Open;
  TFloatField(DataConsulta.DataSet.FieldByName('PRECO_VENDA')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(DataConsulta.DataSet.FieldByName('QUANTIDADE')).DisplayFormat := '###,###,###0.000';
  TFloatField(DataConsulta.DataSet.FieldByName('ALIQUOTA_ICMS')).DisplayFormat := '###,###0.00';
  GridDados.SetFocus;

//fabricio incluir
     GridDados.columns[0].Width:=110;
end;

procedure TFrmProdutos.ActNovoExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmCadProdutos,FrmCadProdutos);
    FrmCadProdutos.sIDProduto := 0;
    FrmCadProdutos.ShowModal;
    ActLocalizarExecute(Sender);
  finally
    FreeAndNil(FrmCadProdutos);
  end;

end;

procedure TFrmProdutos.BitBtn3Click(Sender: TObject);
//fabricio botao incluir botao cad. tributos
var
LArqIni: TInifile;
achei: boolean;
begin
  inherited;
  LArqIni      := TIniFile.Create(ExtractFilePath(Application.ExeName)+'tributos.ini');
  traliquota_icms       := LArqINI.ReadString('TRIBUTOS','ALIQUOTA_ICMS','');
  traliquota_ipi       := LArqINI.ReadString('TRIBUTOS','ALIQUOTA_IPI','');
  trtributacao       := LArqINI.ReadString('TRIBUTOS','TRIBUTACAO','');
  traliquota_pis       := LArqINI.ReadString('TRIBUTOS','ALIQUOTA_PIS','');
  traliquota_cofins       := LArqINI.ReadString('TRIBUTOS','ALIQUOTA_COFINS','');
  trcst_interno       := LArqINI.ReadString('TRIBUTOS','CST_INTERNO','');
  trcfop_interno       := LArqINI.ReadString('TRIBUTOS','CFOP_INTERNO','');
  trsct_pis       := LArqINI.ReadString('TRIBUTOS','CST_PIS','');
  trcst_cofins       := LArqINI.ReadString('TRIBUTOS','CST_COFINS','');
  trcsosn_interno       := LArqINI.ReadString('TRIBUTOS','CSOSN_INTERNO','');
  traliquotauf       := LArqINI.ReadString('TRIBUTOS','AliquotaUF','');
  traliquotacst       := LArqINI.ReadString('TRIBUTOS','AliquotaCST','');
  traliquotacfop       := LArqINI.ReadString('TRIBUTOS','AliquotaCFOP','');
  traliquotaaliquota       := LArqINI.ReadString('TRIBUTOS','AliquotaALIQUOTA','');
  traliquotareducao_base       := LArqINI.ReadString('TRIBUTOS','REDUCAO_BASE','');
  traliquotacson       := LArqINI.ReadString('TRIBUTOS','AliquotaCSOSN','');
  LArqIni.Free;

CdsConsulta.First;
while not CdsConsulta.Eof do
begin
 if DmProdutos.Dados_Produto(CdsConsulta.FieldByName('ID').AsInteger) then
 begin

  if not (dmprodutos.CdsProdutos.State in [dsEdit,dsInsert]) then
    dmprodutos.CdsProdutos.Edit;
    DmProdutos.CdsProdutosALIQUOTA_ICMS.AsString:= traliquota_icms;
    DmProdutos.CdsProdutosALIQUOTA_IPI.AsString:= traliquota_ipi;
    DmProdutos.CdsProdutosTRIBUTACAO.AsString:= trtributacao;
    DmProdutos.CdsProdutosALIQUOTA_PIS.AsString:= traliquota_pis;
    DmProdutos.CdsProdutosALIQUOTA_COFINS.AsString:= traliquota_cofins;
    DmProdutos.CdsProdutosCST_INTERNO.AsString:= trcst_interno;
    DmProdutos.CdsProdutosCFOP_INTERNO.AsString:= trcfop_interno;
    DmProdutos.CdsProdutosCST_PIS.AsString:= trsct_pis;
    DmProdutos.CdsProdutosCST_COFINS.AsString:= trcst_cofins;
    DmProdutos.CdsProdutosCSOSN_INTERNO.AsString:= trcsosn_interno;

    if DmProdutos.Dados_Produto_Aliquota(CdsConsulta.FieldByName('ID').AsInteger) then
    begin
      DmProdutos.CdsProduto_Aliquota.First;
      achei:=false;
      while not DmProdutos.CdsProduto_Aliquota.Eof do
      begin
         if DmProdutos.CdsProduto_AliquotaUF.AsString = traliquotauf then
         begin
          DmProdutos.CdsProduto_Aliquota.Edit;
//        DmProdutos.CdsProduto_AliquotaUF.AsString          := traliquotauf;
          DmProdutos.CdsProduto_AliquotaCST.AsString         := traliquotacst;
          DmProdutos.CdsProduto_AliquotaCFOP.AsString        := traliquotacfop;
          DmProdutos.CdsProduto_AliquotaALIQUOTA.AsString     := traliquotaaliquota;
          DmProdutos.CdsProduto_AliquotaREDUCAO_BASE.AsString:= traliquotareducao_base;
          DmProdutos.CdsProduto_AliquotaCSOSN.AsString:= traliquotacson;
          Grava_Dados(DataProdAliq.DataSet);
          achei:=true;
         end;
          DmProdutos.CdsProduto_Aliquota.Next;
      end;
      if not achei then
      begin
        DataProdAliq.DataSet.Append;
        DmProdutos.CdsProduto_AliquotaUF.AsString          := traliquotauf;
        DmProdutos.CdsProduto_AliquotaCST.AsString         := traliquotacst;
        DmProdutos.CdsProduto_AliquotaCFOP.AsString        := traliquotacfop;
        DmProdutos.CdsProduto_AliquotaALIQUOTA.AsString     := traliquotaaliquota;
        DmProdutos.CdsProduto_AliquotaREDUCAO_BASE.AsString:= traliquotareducao_base;
        DmProdutos.CdsProduto_AliquotaCSOSN.AsString:= traliquotacson;
        Grava_Dados(DataProdAliq.DataSet);

      end;

    end
    else
    begin
        DataProdAliq.DataSet.Append;
        DmProdutos.CdsProduto_AliquotaUF.AsString          := traliquotauf;
        DmProdutos.CdsProduto_AliquotaCST.AsString         := traliquotacst;
        DmProdutos.CdsProduto_AliquotaCFOP.AsString        := traliquotacfop;
        DmProdutos.CdsProduto_AliquotaALIQUOTA.AsString     := traliquotaaliquota;
        DmProdutos.CdsProduto_AliquotaREDUCAO_BASE.AsString:= traliquotareducao_base;
        DmProdutos.CdsProduto_AliquotaCSOSN.AsString:= traliquotacson;
        Grava_Dados(DataProdAliq.DataSet);
    end;

    Grava_Dados(DmProdutos.CdsProdutos);
 end
 else
    ShowMessage('Produto ' + CdsConsulta.FieldByName('ID').AsString + ' não encontrado !');

 CdsConsulta.Next;
end;
end;
procedure TFrmProdutos.BtnMargemClick(Sender: TObject);
begin
  inherited;
//fabricio inicio

CdsConsulta.First;
while not CdsConsulta.Eof do
begin
 if DmProdutos.Dados_Produto(CdsConsulta.FieldByName('ID').AsInteger) then
 begin

  if not (dmprodutos.CdsProdutos.State in [dsEdit,dsInsert]) then
    dmprodutos.CdsProdutos.Edit;
    DmProdutos.CdsProdutosMARGEM_LUCRO.AsFloat:= DmWorkCom.CdsConfigMARGEM_LUCRO.AsFloat;
    Grava_Dados(DmProdutos.CdsProdutos);
 end
 else
    ShowMessage('Produto ' + CdsConsulta.FieldByName('ID').AsString + ' não encontrado !');

 CdsConsulta.Next;
end;

end;

//fabricio fim



procedure TFrmProdutos.CbxTipoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,key);
end;

procedure TFrmProdutos.EdtLocalizarExit(Sender: TObject);
begin
  inherited;
  ActLocalizarExecute(Sender);

end;

procedure TFrmProdutos.EdtLocalizarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  sPermitirCombustivel := true;
  sApenasConsulta := False;
  BtnClonar.Visible := (DmWorkCom.sClonarProdutos = 'S');

end;

procedure TFrmProdutos.GridDadosDblClick(Sender: TObject);
begin
  inherited;
  if DataConsulta.DataSet.RecordCount > 0 then
  begin
    if not sApenasConsulta then
    begin
      ActAlterarExecute(Sender);
    end
    else
    begin
      sIDProd := CdsConsulta.FieldByName('ID').AsInteger;
      xIDCor := CdsConsulta.FieldByName('id_cor').AsInteger;
      xIDTamanho := CdsConsulta.FieldByName('id_tamanho').AsInteger;
      xNomeCor := CdsConsulta.FieldByName('NOME').AsString;
      xTamanho := CdsConsulta.FieldByName('METRAGEM').AsString;
      Close;
    end;
  end;

end;

procedure TFrmProdutos.GridDadosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = #13) then
  begin
    if DataConsulta.DataSet.RecordCount > 0 then
    begin
      if not sApenasConsulta then
      begin
        ActAlterarExecute(Sender);
      end
      else
      begin
        sIDProd := CdsConsulta.FieldByName('ID').AsInteger;
        xIDCor := CdsConsulta.FieldByName('id_cor').AsInteger;
        xIDTamanho := CdsConsulta.FieldByName('id_tamanho').AsInteger;
        xNomeCor := CdsConsulta.FieldByName('NOME').AsString;
        xTamanho := CdsConsulta.FieldByName('METRAGEM').AsString;
        Close;
      end;
    end;
  end;
end;

end.
