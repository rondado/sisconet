unit uFrmFechaMesa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, StdCtrls, DB, ActnList, Buttons, Grids,
  DBGrids, System.Actions;

type
  TFrmFechaMesa = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    DataMesasAbertas: TDataSource;
    DBGrid1: TDBGrid;
    BtnConfere: TBitBtn;
    BtnFechar: TBitBtn;
    BtnEncerrar: TBitBtn;
    ActionList1: TActionList;
    ActConferencia: TAction;
    ActFecharMesa: TAction;
    ActEncerrar: TAction;
    DataMesaItens: TDataSource;
    ActMenuFiscal: TAction;
    procedure FormShow(Sender: TObject);
    procedure ActConferenciaExecute(Sender: TObject);
    procedure ActFecharMesaExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDPedido : Integer;
  end;

var
  FrmFechaMesa: TFrmFechaMesa;

implementation

uses uDmWorkCom, uLibrary, uFrmMenuFiscal, uDmAcBr;

{$R *.dfm}

procedure TFrmFechaMesa.FormShow(Sender: TObject);
begin
  inherited;
  DataMesasAbertas.DataSet := DmWorkCom.CdsMesasAbertas;
  DataMesaItens.DataSet    := DmWorkCom.CdsMesasItens;
  DmWorkCom.Dados_MesasAbertas;
  DBGrid1.SetFocus;

end;

procedure TFrmFechaMesa.ActConferenciaExecute(Sender: TObject);
begin
  inherited;
  if (DataMesaItens.DataSet.RecordCount > 0) and
     (DataMesasAbertas.DataSet.RecordCount > 0) then
  begin
    try
      if sPAFNFCe = 0 then // paf-ecf
      begin
        DmWorkCom.EmitirConferenciaMesa(DataMesasAbertas.DataSet.FieldByName('ID').AsInteger);
        DataMesasAbertas.DataSet.Edit;
        DataMesasAbertas.DataSet.FieldByName('CER_CONFERENCIA').AsInteger := DmWorkCom.PAFECF.sContaCER;
        DataMesasAbertas.DataSet.FieldByName('COO').AsInteger := StrToInt(DmAcBr.ACBrECF1.NumCOO);
        Grava_Dados(DataMesasAbertas.DataSet);
      end
      else
      begin
        DmWorkCom.EmitirConferenciaMesaNFCe(DataMesasAbertas.DataSet.FieldByName('ID').AsInteger);
      end;
    except
      MessageDlg('Erro ao emitir conferencia. Tente novamente!', mtWarning, [mbOK], 0);
    end;
  end
  else MessageDlg('Não itens para conferencia!!!', mtWarning, [mbOK], 0);

end;

procedure TFrmFechaMesa.ActFecharMesaExecute(Sender: TObject);
begin
  inherited;
  if (DataMesaItens.DataSet.RecordCount > 0) and
     (DataMesasAbertas.DataSet.RecordCount > 0) then
  begin
    try
      sIDPedido := DmWorkCom.RegistraFechamentoMesa(DataMesasAbertas.DataSet.FieldByname('ID').AsInteger);
      Close;
    except
      MessageDlg('Erro ao realizar o fechamento. Tente novamente!', mtWarning, [mbOK], 0);
    end;
  end
  else MessageDlg('Não itens para conferencia!!!', mtWarning, [mbOK], 0);

end;

procedure TFrmFechaMesa.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmFechaMesa.FormCreate(Sender: TObject);
begin
  inherited;
  sIDPedido := 0;
  
end;

procedure TFrmFechaMesa.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
   BtnFechar.Click;
end;

procedure TFrmFechaMesa.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  GridOrdem(DmWorkCom.CdsMesasAbertas,DBGrid1,Column);
end;

procedure TFrmFechaMesa.ActMenuFiscalExecute(Sender: TObject);
var aMensagem : String;
begin
  inherited;
  if not DmWorkCom.PAFECF.VerificaImpressoraLigada then
  begin
     DmWorkCom.PAFECF.sControleECFAtivo := 1;
  end
  else
  begin
    if not DmWorkCom.PAFECF.VerificacoesPAFECF(aMensagem) then
    begin
      ShowMessage(aMensagem);
      DmWorkCom.PAFECF.sControleECFAtivo := 2;
    end;
  end;  
   Application.CreateForm(TFrmMenuFiscal,FrmMenuFiscal);
   Try
      FrmMenuFiscal.ShowModal;
   Finally
      FrmMenuFiscal.Destroy;
   End;

end;

end.
