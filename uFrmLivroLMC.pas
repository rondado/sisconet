unit uFrmLivroLMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.StdCtrls, Data.DB,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.Grids, Vcl.DBGrids, frxClass, frxDBSet, Data.FMTBcd, Data.SqlExpr,
  Datasnap.DBClient, Datasnap.Provider;

type
  TFrmLivroLMC = class(TFrmPadrao)
    GrpDadosLivro: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataLivro: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DataResponsavel: TDataSource;
    DataConferente: TDataSource;
    DataGerente: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    PnBotoesLivro: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    ActionList1: TActionList;
    ActGravarDadosLivro: TAction;
    ActCancelarDadosLivro: TAction;
    ActImprimirPagina: TAction;
    ActFecharTela: TAction;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DataLivroPag: TDataSource;
    DBGrid1: TDBGrid;
    frxReport1: TfrxReport;
    frxLivro: TfrxDBDataset;
    frxLivroPag: TfrxDBDataset;
    frxDbEstEntrada: TfrxDBDataset;
    CdsEstEntrada: TClientDataSet;
    SQLGeral: TSQLDataSet;
    DspGeral: TDataSetProvider;
    CdsEstEntradaTQ1: TStringField;
    CdsEstEntradaESTTQ1: TFloatField;
    CdsEstEntradaTQ2: TStringField;
    CdsEstEntradaESTTQ2: TFloatField;
    CdsEstEntradaTQ3: TStringField;
    CdsEstEntradaESTTQ3: TFloatField;
    CdsEstEntradaVR_NF1_NUM: TStringField;
    CdsEstEntradaVR_NF2_NUM: TStringField;
    CdsEstEntradaVR_NF3_NUM: TStringField;
    CdsEstEntradaVR_NF1_DATA: TDateField;
    CdsEstEntradaVR_NF2_DATA: TDateField;
    CdsEstEntradaVR_NF3_DATA: TDateField;
    CdsEstEntradaVR_NF1_TQ: TIntegerField;
    CdsEstEntradaVR_NF2_TQ: TIntegerField;
    CdsEstEntradaVR_NF3_TQ: TIntegerField;
    CdsEstEntradaVR_NF1_VOL: TFloatField;
    CdsEstEntradaVR_NF2_VOL: TFloatField;
    CdsEstEntradaVR_NF3_VOL: TFloatField;
    CdsEstEntradaEST_ENTRADAS: TFloatField;
    CdsEstEntradaVR_TOTAL_REC: TFloatField;
    CdsEstEntradaEST_TOTAL44: TFloatField;
    CdsEstEntradaVV_TQ1: TIntegerField;
    CdsEstEntradaVV_TQ2: TIntegerField;
    CdsEstEntradaVV_TQ3: TIntegerField;
    CdsEstEntradaVV_BC1: TStringField;
    CdsEstEntradaVV_BC2: TStringField;
    CdsEstEntradaVV_BC3: TStringField;
    CdsEstEntradaVV_FECHA1: TFloatField;
    CdsEstEntradaVV_FECHA2: TFloatField;
    CdsEstEntradaVV_FECHA3: TFloatField;
    CdsEstEntradaVV_ABRE1: TFloatField;
    CdsEstEntradaVV_ABRE2: TFloatField;
    CdsEstEntradaVV_ABRE3: TFloatField;
    CdsEstEntradaVV_AFER1: TFloatField;
    CdsEstEntradaVV_AFER2: TFloatField;
    CdsEstEntradaVV_AFER3: TFloatField;
    CdsEstEntradaVV_VENDA1: TFloatField;
    CdsEstEntradaVV_VENDA2: TFloatField;
    CdsEstEntradaVV_VENDA3: TFloatField;
    CdsEstEntradaVV_TOTAL: TFloatField;
    CdsEstEntradaVALOR_PROD: TFloatField;
    CdsEstEntradaEST_ESCRITURAL: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure ActGravarDadosLivroExecute(Sender: TObject);
    procedure ActCancelarDadosLivroExecute(Sender: TObject);
    procedure ActImprimirPaginaExecute(Sender: TObject);
    procedure ActFecharTelaExecute(Sender: TObject);
  private
    { Private declarations }
    procedure ImprimirPaginaLivro;
    procedure AbreDadosEstoqueEntrada;

  public
    { Public declarations }
  end;

var
  FrmLivroLMC: TFrmLivroLMC;

implementation

{$R *.dfm}

uses uDmPosto, uDmWorkCom, uDMClientes, uLibrary, uFrmLivroLMCProd, uDmConexao;

procedure TFrmLivroLMC.AbreDadosEstoqueEntrada;
begin
  with CdsEstEntrada do
  begin
     Close;
     CommandText := 'select TQ1,ESTTQ1,TQ2,ESTTQ2,TQ3,ESTTQ3,EST_ENTRADAS, '+
                    '       VR_NF1_NUM,VR_NF1_DATA,VR_NF1_TQ,VR_NF1_VOL, '+
                    '       VR_NF2_NUM,VR_NF2_DATA,VR_NF2_TQ,VR_NF2_VOL, '+
                    '       VR_NF3_NUM,VR_NF3_DATA,VR_NF3_TQ,VR_NF3_VOL, '+
                    '       VR_TOTAL_REC,EST_TOTAL44,VV_TQ1,VV_TQ2,VV_TQ3, '+
                    '       VV_BC1,VV_BC2,VV_BC3,VV_FECHA1,VV_FECHA2, '+
                    '       VV_FECHA3,VV_ABRE1,VV_ABRE2,VV_ABRE3,VV_AFER1, '+
                    '       VV_AFER2,VV_AFER3,VV_VENDA1,VV_VENDA2,VV_VENDA3, '+
                    '       VV_TOTAL,VALOR_PROD,EST_ESCRITURAL '+
                    'from proc_retorna_est_abertura(:pidproduto,:pdata)';
     Params.ParamByName('pidproduto').AsInteger := DataLivroPag.DataSet.FieldByName('ID_PRODUTO').AsInteger;
     Params.ParamByName('pdata').AsDate := DataLivroPag.DataSet.FieldByName('DATA_PAGINA').AsDateTime;
     Open;
  end;

end;

procedure TFrmLivroLMC.ActCancelarDadosLivroExecute(Sender: TObject);
begin
  inherited;
  DataLivro.DataSet.Cancel;
  PnBotoesLivro.Visible := false;
  GrpDadosLivro.Height  := 221;
  GrpDadosLivro.Enabled := false;
  DmPosto.Dados_LivroLMCPag(0);

end;

procedure TFrmLivroLMC.ActFecharTelaExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmLivroLMC.ActGravarDadosLivroExecute(Sender: TObject);
begin
  inherited;
  if Confirmacao('Confirma os dados do libro?') then
  begin
    Grava_Dados(DataLivro.DataSet);
    DmPosto.Dados_LivroLMCPag(DataLivro.DataSet.FieldByName('NUM_LIVRO').AsInteger);
    PnBotoesLivro.Visible := false;
    GrpDadosLivro.Height  := 221;
    GrpDadosLivro.Enabled := false;
  end;

end;

procedure TFrmLivroLMC.ActImprimirPaginaExecute(Sender: TObject);
begin
  inherited;
  if DataLivro.DataSet.RecordCount > 0 then
  begin
    try
      Application.CreateForm(TFrmLivroLMCProd,FrmLivroLMCProd);
      with FrmLivroLMCProd do
      begin
        ShowModal;
        if sIDProduto > 0 then
        begin
          // verifica se a data é maior que a data atual
          if StrToDate(FormatDateTime('dd/mm/yyyy',sDataMov)) >
             StrToDate(FormatDateTime('dd/mm/yyyy',Now)) then
          begin
            MessageDlg('A data não pode ser maior que a data atual!',mtWarning,[mbOK],0);
            Exit;
          end;
          // verificar se a data já existe pagina registrada para o produto selecionado
          if not DataLivroPag.DataSet.Locate('DATA_PAGINA;ID_PRODUTO',VarArrayOf([sDataMov,sIDProduto]),[]) then
          begin
            // verifica se é o primeiro produto da data e emite advertencia
            if DmPosto.VerificaPrimeiroItemDataLivro(sDataMov) then
            begin
              MessageDlg('Esse é o primeiro registro da data.',mtWarning,[mbOK],0);
            end;
            // verificar se pagina anterior para todos os produtos cadastrados
            if not DmPosto.VerificaPaginasUltimaMov(sDataMov) then
            begin
              MessageDlg('Foi identificado que falta produto para ser impresso'#13+#10+
                         'a pagina no ultimo moviento. Verifique!',mtWarning,[mbOK],0);
              Exit;
            end;
            // verifica se a data informada é maior ou igual a ultima pagina
            if DmPosto.VerificaDataUltimoMovimento(sDataMov) then
            begin
              MessageDlg('A data não pode ser menor que a do ultimo registro!',mtWarning,[mbOK],0);
              Exit;
            end;
            // grava os dados da nova pagina
            DmPosto.RegistraNovaPagina(DataLivro.DataSet.FieldByName('NUM_LIVRO').AsInteger,
                                       sIDProduto,sDataMov);
          end;
          // enviar o comando para imprimir.
          ImprimirPaginaLivro;
        end;
      end;
    finally
      FreeAndNil(FrmLivroLMCProd);
    end;

  end;

end;

procedure TFrmLivroLMC.FormShow(Sender: TObject);
begin
  inherited;
  DataLivro.DataSet := DmPosto.CdsLivroLMC;
  DataLivroPag.DataSet := DmPosto.CdsLivroLMCPag;
  DataResponsavel.DataSet := DmClientes.CdsFuncionarios;
  DataConferente.DataSet := DmClientes.CdsFuncionarios;
  DataGerente.DataSet := DmClientes.CdsFuncionarios;
  DmClientes.Dados_Funcionario;
  //
  if not DmPosto.Dados_LivroLMC then
  begin
    MessageDlg('Não foi localizado informações para o livro em andamento.'+#13+#10+
               'É necessário informar os dados.',mtWarning,[mbOK],0);
    PnBotoesLivro.Visible := true;
    GrpDadosLivro.Height  := 241;
    GrpDadosLivro.Enabled := true;
    DBEdit1.SetFocus;
  end
  else DmPosto.Dados_LivroLMCPag(DataLivro.DataSet.FieldByName('NUM_LIVRO').AsInteger);

end;

procedure TFrmLivroLMC.ImprimirPaginaLivro;
begin
  // abre os dados do estoque de entrada
  AbreDadosEstoqueEntrada;
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\LMC.fr3');
  frxReport1.ShowReport;
end;

end.
