unit uFrmRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ActnList, uFrameConfirmaCancela, StdCtrls, ComCtrls,
  ExtCtrls, FMTBcd, DB, SqlExpr, System.Actions;

type
  TFrmRelatorios = class(TFrmPadrao)
    GrpPeriodo: TGroupBox;
    Datai: TDateTimePicker;
    Dataf: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    GrpTipoRel: TGroupBox;
    ComboTipo: TComboBox;
    ActionList1: TActionList;
    ActImprimir: TAction;
    ActEncerrar: TAction;
    RadioTipo: TRadioGroup;
    ChConfirmados: TCheckBox;
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    ChItens: TCheckBox;
    RadioOpcao: TRadioGroup;
    Edit1: TEdit;
    Label3: TLabel;
    RadioStatus: TRadioGroup;
    procedure ActImprimirExecute(Sender: TObject);
    procedure ActEncerrarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure MontaSQLProduto;
    procedure MontaSQLContato;
    procedure MontaSQLPedidos(pTipo:Integer);
  public
    { Public declarations }
  end;

var
  FrmRelatorios: TFrmRelatorios;

implementation

Uses uLibrary, uDmWorkCom, uDmRelatorios;

{$R *.dfm}

procedure TFrmRelatorios.ActImprimirExecute(Sender: TObject);
var aTipo:String;
begin
  inherited;
  case ComboTipo.ItemIndex of
    0 : begin // Contatos Cadastrados
          MontaSQLContato;
          DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ListaContatos.fr3');
          DmRelatorios.frxGeral.ShowReport();
        end;
    1 : begin //Tabela de Preço
          MontaSQLProduto;
          DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\TabPreco.fr3');
          DmRelatorios.frxGeral.ShowReport();
        end;
    2 : begin //Relatorio de Estoque
          MontaSQLProduto;
          DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\EstoqueProd.fr3');
          DmRelatorios.frxGeral.ShowReport();
        end;
    3 : begin //Pedidos/Orcamentos
          MontaSQLPedidos(0);
          DmRelatorios.PassaPeriodoRelatorio(Datai.Date,Dataf.Date);
          DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ListaPedidos.fr3');
          DmRelatorios.frxGeral.ShowReport();
        end;
    4 : begin //Cupons Fiscais Emitidos
          MontaSQLPedidos(1);
          DmRelatorios.PassaPeriodoRelatorio(Datai.Date,Dataf.Date);
          DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ListaCupons.fr3');
          DmRelatorios.frxGeral.ShowReport();
        end;
    5 : begin //NFe/NFCe Emitidas
          MontaSQLPedidos(2);
          DmRelatorios.PassaPeriodoRelatorio(Datai.Date,Dataf.Date);
          DmRelatorios.frxGeral.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ListaNotas.fr3');
          DmRelatorios.frxGeral.ShowReport();
        end;
  end;


end;

procedure TFrmRelatorios.ActEncerrarExecute(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TFrmRelatorios.FormShow(Sender: TObject);
begin
  inherited;
  Datai.Date := PrimeiroDia(SVData);
  Dataf.Date := UltimoDia(SVData);
  Edit1.Text:='';
  ComboTipo.SetFocus;

end;

procedure TFrmRelatorios.MontaSQLProduto;
begin
  DmRelatorios.CdsRelatorios.Close;
  DmRelatorios.CdsRelatorios.Params.Clear;
  DmRelatorios.QryRelatorios.Close;
  DmRelatorios.QryRelatorios.SQL.Clear;
  DmRelatorios.QryRelatorios.SQL.Add('select produtos.id,produtos.descricao,');
  DmRelatorios.QryRelatorios.SQL.Add('produtos.unidade,produtos.preco_compra,');
  DmRelatorios.QryRelatorios.SQL.Add('produtos.preco_venda,estoque.quantidade');
  DmRelatorios.QryRelatorios.SQL.Add('from produtos');
  DmRelatorios.QryRelatorios.SQL.Add('inner join estoque on (estoque.idproduto = produtos.id and');
  DmRelatorios.QryRelatorios.SQL.Add('                       estoque.idempresa = :pIDEmpresa)');
  DmRelatorios.QryRelatorios.SQL.Add('order by produtos.descricao');
  DmRelatorios.CdsRelatorios.FetchParams;
  DmRelatorios.CdsRelatorios.Params.ParamByName('pIDEmpresa').AsInteger := DmWorkCom.CdsEmpresa.FieldByName('ID').AsInteger;
  DmRelatorios.CdsRelatorios.Open;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('PRECO_VENDA')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('preco_compra')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('quantidade')).DisplayFormat := '###,###,###0.000';

end;

procedure TFrmRelatorios.MontaSQLContato;
begin
  DmRelatorios.CdsRelatorios.Close;
  DmRelatorios.CdsRelatorios.Params.Clear;
  DmRelatorios.QryRelatorios.Close;
  DmRelatorios.QryRelatorios.SQL.Clear;
  DmRelatorios.QryRelatorios.SQL.Add('select contato.id,contato.nome,contato.cidade_end,');
  DmRelatorios.QryRelatorios.SQL.Add('contato.telefone from contato');
  // verifica tipo contato
  if RadioTipo.ItemIndex = 0 then
  begin
    DmRelatorios.QryRelatorios.SQL.Add('where (contato.tipo_contato = '+QuotedStr('C')+' or ');
    DmRelatorios.QryRelatorios.SQL.Add('contato.tipo_contato = '+QuotedStr('A')+')');
  end
  else if RadioTipo.ItemIndex = 1 then
  begin
    DmRelatorios.QryRelatorios.SQL.Add('where (contato.tipo_contato = '+QuotedStr('F')+' or ');
    DmRelatorios.QryRelatorios.SQL.Add('contato.tipo_contato = '+QuotedStr('A')+')');
  end;

  DmRelatorios.QryRelatorios.SQL.Add('order by contato.nome');
  DmRelatorios.CdsRelatorios.FetchParams;
  DmRelatorios.CdsRelatorios.Open;

end;


procedure TFrmRelatorios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DmRelatorios.CdsRelatorios.Close;

end;

procedure TFrmRelatorios.MontaSQLPedidos(pTipo:Integer);
begin
  DmRelatorios.CdsRelatorios.Close;
  DmRelatorios.CdsRelatorios.Params.Clear;
  DmRelatorios.QryRelatorios.Close;
  DmRelatorios.QryRelatorios.SQL.Clear;
  DmRelatorios.QryRelatorios.SQL.Add('select pedido.id,pedido.pedido_num,pedido.cliente,');
  DmRelatorios.QryRelatorios.SQL.Add('pedido.data_pedido,pedido.valor_total,pedido.chave_nfe,');
  DmRelatorios.QryRelatorios.SQL.Add('pedido.coo,pedido.numero_doc,pedido.data_entrega');
  DmRelatorios.QryRelatorios.SQL.Add('from pedido');
  DmRelatorios.QryRelatorios.SQL.Add('where pedido.data_pedido between :pDatai and :pDataf');
  if pTipo = 0 then // pedidos e orçamentos
  begin
    DmRelatorios.QryRelatorios.SQL.Add('and pedido.confirmada = :pConfirmada');
    DmRelatorios.QryRelatorios.SQL.Add('and (pedido.coo is null or pedido.coo = 0)');
    DmRelatorios.QryRelatorios.SQL.Add('and (pedido.numero_doc is null or pedido.numero_doc = '+QuotedStr('')+')');
  end
  else if pTipo = 1 then // cupons fiscais
  begin
    DmRelatorios.QryRelatorios.SQL.Add('and pedido.coo > 0');
    if RadioOpcao.ItemIndex = 1 then
    begin
      DmRelatorios.QryRelatorios.SQL.Add('and pedido.cancelado = '+QuotedStr('S'));
    end
    else if RadioOpcao.ItemIndex = 2 then
    begin
      DmRelatorios.QryRelatorios.SQL.Add('and pedido.cancelado = '+QuotedStr('N'));
    end;
  end
  else if pTipo = 2 then // NFe ou NFCe
  begin
    DmRelatorios.QryRelatorios.SQL.Add('and pedido.numero_doc <> '+QuotedStr(''));
    if RadioOpcao.ItemIndex = 1 then
    begin
      DmRelatorios.QryRelatorios.SQL.Add('and pedido.cancelado = '+QuotedStr('S'));
    end
    else if RadioOpcao.ItemIndex = 2 then
    begin
      DmRelatorios.QryRelatorios.SQL.Add('and pedido.cancelado = '+QuotedStr('N'));
    end;

    if RadioStatus.ItemIndex = 1 then
    begin
      DmRelatorios.QryRelatorios.SQL.Add('and pedido.status_nfe = '+QuotedStr('100'));
    end
    else if RadioStatus.ItemIndex = 2 then
    begin
      DmRelatorios.QryRelatorios.SQL.Add('and pedido.status_nfe = '+QuotedStr('128'));
    end;



    if Edit1.Text <> '' then
    begin
          DmRelatorios.QryRelatorios.SQL.Add('and pedido.idcliente =  '+ Edit1.Text);
{
          if RadioTipo.ItemIndex = 0 then
             DmRelatorios.QryRelatorios.SQL.Add('and contato.tipo_contato = ' + QuotedStr('C'))
          else
          if RadioTipo.ItemIndex = 1 then
             DmRelatorios.QryRelatorios.SQL.Add('and contato.tipo_contato = ' + QuotedStr('F'))
}
    end;

  end;
  DmRelatorios.CdsRelatorios.FetchParams;
  DmRelatorios.CdsRelatorios.Params.ParamByName('pDatai').AsDate        := Datai.Date;
  DmRelatorios.CdsRelatorios.Params.ParamByName('pDataf').AsDate        := Dataf.Date;
  if pTipo = 0 then // PEDIDOS E ORCAMENTOS
  begin
    if ChConfirmados.Checked then
       DmRelatorios.CdsRelatorios.Params.ParamByName('pConfirmada').AsString := 'S'
    else if not ChConfirmados.Checked then
       DmRelatorios.CdsRelatorios.Params.ParamByName('pConfirmada').AsString := 'N';
  end;
  DmRelatorios.CdsRelatorios.Open;
  TFloatField(DmRelatorios.CdsRelatorios.FieldByName('VALOR_TOTAL')).DisplayFormat := DmWorkCom.PAFECF.gMascaraDec;

end;

end.
