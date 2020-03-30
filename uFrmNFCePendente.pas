unit uFrmNFCePendente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, FMTBcd, Grids, DBGrids, SqlExpr, Provider, DB,
  DBClient, StdCtrls, Vcl.Menus;

type
  TFrmNFCePendente = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    DataNFCe: TDataSource;
    CdsNFCe: TClientDataSet;
    DspNFCe: TDataSetProvider;
    QryNFCe: TSQLQuery;
    DBGrid1: TDBGrid;
    QryNFCeID: TIntegerField;
    QryNFCeDATA_PEDIDO: TSQLTimeStampField;
    QryNFCeDATA_ENTREGA: TSQLTimeStampField;
    QryNFCeIDCLIENTE: TIntegerField;
    QryNFCeCLIENTE: TStringField;
    QryNFCeVALOR_TOTAL: TFloatField;
    CdsNFCeID: TIntegerField;
    CdsNFCeDATA_PEDIDO: TSQLTimeStampField;
    CdsNFCeDATA_ENTREGA: TSQLTimeStampField;
    CdsNFCeIDCLIENTE: TIntegerField;
    CdsNFCeCLIENTE: TStringField;
    CdsNFCeVALOR_TOTAL: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDPedido : Integer;
  end;

var
  FrmNFCePendente: TFrmNFCePendente;

implementation

uses uDmConexao, uDmWorkCom;

{$R *.dfm}

procedure TFrmNFCePendente.FormCreate(Sender: TObject);
begin
  inherited;
  sIDPedido := 0;
end;

procedure TFrmNFCePendente.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if CdsNFCe.RecordCount > 0 then
  begin
    sIDPedido := CdsNFCe.FieldByName('ID').AsInteger;
    Close;
  end;
     
end;

procedure TFrmNFCePendente.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    sIDPedido := 0;
    Close;
  end;
  if Key = #13 then
  begin
    DBGrid1DblClick(Sender);
  end;
end;

procedure TFrmNFCePendente.FormShow(Sender: TObject);
begin
  inherited;
  QryNFCe.SQLConnection := DmConexao.ConexaoDBX;
  DspNFCe.DataSet := QryNFCe;
  CdsNFCe.ProviderName := 'DspNFCe';
  DataNFCe.DataSet := CdsNFCe;
  CdsNFCe.Open;
  // formata campos
  CdsNFCeDATA_PEDIDO.DisplayFormat             := 'dd/mm/yyyy';
  CdsNFCe.FieldByName('DATA_PEDIDO').EditMask  := '!99/99/0000;1; ';
  CdsNFCeDATA_ENTREGA.DisplayFormat            := 'dd/mm/yyyy';
  CdsNFCe.FieldByName('DATA_ENTREGA').EditMask := '!99/99/0000;1; ';
  CdsNFCeVALOR_TOTAL.DisplayFormat             := DmWorkCom.PAFECF.gMascaraDec;
  CdsNFCeVALOR_TOTAL.EditFormat                := DmWorkCom.PAFECF.gMascaraDec;
  //
  DBGrid1.SetFocus;

end;

end.
