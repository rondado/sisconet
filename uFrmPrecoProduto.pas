unit uFrmPrecoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, jpeg, ExtCtrls, SqlExpr, ActnList,
  System.Actions;

type
  TFrmPrecoProduto = class(TFrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtCodigo: TEdit;
    EdtDescricao: TEdit;
    EdtPreco: TEdit;
    ActionList1: TActionList;
    ActMenuFiscal: TAction;
    function consultaean13: Boolean;
    function consultacodigo: Boolean;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCodigoExit(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
    procedure EdtDescricaoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure PreencheDadosProduto;
  public
    { Public declarations }
  end;

var
  FrmPrecoProduto: TFrmPrecoProduto;
  Q : TSQLQuery;

implementation

uses uLibrary, DB, uFrmMenuFiscal, uDmWorkCom;

{$R *.dfm}

function TFrmPrecoProduto.consultaean13: boolean;
begin
  Q := TSQLQuery.Create(nil);
  try
    with Q do
    begin
      SQLConnection := ConexaoDados;
      Close;
      SQL.Clear;
      SQL.Add('select p.ean13,p.descricao,p.preco_venda');
      SQL.Add('from produtos p');
      SQL.Add('where p.ean13 = '+QuotedStr(EdtCodigo.Text));
      Open;

      result:=false;
      if not IsEmpty then
      begin
        result:=true;
        EdtDescricao.Text := Q.FieldByname('descricao').AsString;
        EdtPreco.Text     := 'R$'+FormatFloat('0.00',Q.FieldByname('preco_venda').AsFloat);
      end;
{
      if not IsEmpty then
      begin
        EdtDescricao.Text := FieldByname('descricao').AsString;
        EdtPreco.Text     := 'R$'+FormatFloat('0.00',FieldByname('preco_venda').AsFloat);
      end
      else
      begin
        MessageDlg('Produto não encontrado no cadastro. Verifique!!!', mtWarning, [mbOK], 0);
        close;
      end;
}


    end;
  finally
    FreeAndNil(Q);
  end;
end;

function TFrmPrecoProduto.consultacodigo: boolean;
begin
  Q := TSQLQuery.Create(nil);
  try
    with Q do
    begin
      SQLConnection := ConexaoDados;
      Close;
      SQL.Clear;
      SQL.Add('select p.ean13,p.descricao,p.preco_venda');
      SQL.Add('from produtos p');
      SQL.Add('where p.id = '+EdtCodigo.Text);
      Open;

      result:=false;
      if not IsEmpty then
      begin
        result:=true;
        EdtDescricao.Text := Q.FieldByname('descricao').AsString;
        EdtPreco.Text     := 'R$'+FormatFloat('0.00',Q.FieldByname('preco_venda').AsFloat);
      end;
{
      if not IsEmpty then
      begin
        EdtDescricao.Text := FieldByname('descricao').AsString;
        EdtPreco.Text     := 'R$'+FormatFloat('0.00',FieldByname('preco_venda').AsFloat);
      end
      else
      begin
        MessageDlg('Produto não encontrado no cadastro. Verifique!!!', mtWarning, [mbOK], 0);
        close;
      end;
}


    end;
  finally
    FreeAndNil(Q);
  end;
end;





procedure TFrmPrecoProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #27) then
  begin
    Close;
  end;

end;

procedure TFrmPrecoProduto.EdtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);

end;

procedure TFrmPrecoProduto.EdtDescricaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
if key = #13 then
   close;
end;

procedure TFrmPrecoProduto.EdtCodigoExit(Sender: TObject);
begin
  inherited;
  if EdtCodigo.Text <> '' then
  begin
    PreencheDadosProduto;
  end;

end;
//fabricio novo mudei toda a rotina
procedure TFrmPrecoProduto.PreencheDadosProduto;
var aProdOk: boolean;
begin
  EdtDescricao.Clear;
  EdtPreco.Clear;
  aProdOk:=false;
//  if Length(EdtCodigo.Text) < 13 then
//     EdtCodigo.Text := ZeroEsquerda(EdtCodigo.Text,13);
  //

        if Length(EdtCodigo.Text) <= 6  then
        begin
           aProdOk := consultacodigo;
           if not(aProdOk) then
              aProdOk := consultaean13;
        end
        else
        begin
           aProdOk := consultaean13;
           if not(aProdOk) then
              aProdOk := consultacodigo;
        end;

      if not (aProdOk) then
      begin
        EdtDescricao.Text := '';
        EdtPreco.Text     := '';
        MessageDlg('Produto não encontrado no cadastro. Verifique!!!', mtWarning, [mbOK], 0);
        close;
      end;


end;

procedure TFrmPrecoProduto.ActMenuFiscalExecute(Sender: TObject);
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
