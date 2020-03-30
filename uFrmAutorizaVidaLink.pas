unit uFrmAutorizaVidaLink;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, StdCtrls, Buttons, ComCtrls, unitVidaLink,
  ActnList;

type
  TFrmAutorizaVidaLink = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    RichEdit1: TRichEdit;
    Label1: TLabel;
    EdtAutorizacao: TEdit;
    BtnLocalizar: TBitBtn;
    BtnConfirma: TBitBtn;
    BtnCancelar: TBitBtn;
    ActionList1: TActionList;
    ActMenuFiscal: TAction;
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnConfirmaClick(Sender: TObject);
    procedure EdtAutorizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ActMenuFiscalExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sIDPedido : Integer;
  end;

var
  FrmAutorizaVidaLink: TFrmAutorizaVidaLink;

implementation

{$R *.dfm}

uses uDmWorkCom, uLibrary, uFrmMenuFiscal, uDmAuxiliar;

procedure TFrmAutorizaVidaLink.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DmAuxiliar.PBMVidaLink1.Solicitacao.Clear;
  sIDPedido := 0;
  Close;
end;

procedure TFrmAutorizaVidaLink.BtnConfirmaClick(Sender: TObject);
begin
  inherited;
  if DmAuxiliar.PBMVidaLink1.Solicitacao.Autorizacao = '' then
  begin
    MessageDlg('É necessário selecionar uma autorização!',mtWarning,[mbOK],0);
    Abort;
  end;
  // verifica se a autorização já foi gravada
  if DmWorkCom.VerificaAutorizacao(DmAuxiliar.PBMVidaLink1.Solicitacao.Autorizacao) then
  begin
    MessageDlg('Foi encontrado um cupom emitido para esta autorização!',mtWarning,[mbOK],0);
    Abort;
  end;

  sIDPedido := DmWorkCom.RegistraCupomAutorizaaco;
  Close;

end;

procedure TFrmAutorizaVidaLink.BtnLocalizarClick(Sender: TObject);
var i : Integer;
begin
  inherited;
  if DmAuxiliar.PBMVidaLink1.VerificaAutorizacao(EdtAutorizacao.Text) then
  begin
    with DmAuxiliar.PBMVidaLink1 do
    begin
      for i := 0 to Solicitacao.Count-1 do
      begin
        RichEdit1.Lines.Add( 'EAN...........: '+Solicitacao.Items[i].Ean);
        RichEdit1.Lines.Add( 'Qtd Autorizada: '+FormatFloat('0', Solicitacao.Items[i].Qtd_Autorizada) );
        RichEdit1.Lines.Add( 'Preço Medio...: '+FormatFloat('0.00',Solicitacao.Items[i].Preco_Medio ));
        RichEdit1.Lines.Add( 'Preço Venda...: '+FormatFloat('0.00',Solicitacao.Items[i].Preco_Venda ) );
        RichEdit1.Lines.Add( 'Preço Vista...: '+FormatFloat('0.00',Solicitacao.Items[i].Preco_AVista ) );
        RichEdit1.Lines.Add( 'Preço Receber.: '+FormatFloat('0.00',Solicitacao.Items[i].Preco_AReceber ) );
        RichEdit1.Lines.Add( 'Vlr. Subsidio.: '+FormatFloat('0.00',Solicitacao.Items[i].Valor_Subsidio ) );
        RichEdit1.Lines.Add( 'Vlr. Reembolso: '+FormatFloat('0.00',Solicitacao.Items[i].Valor_Reembolso ) );
        RichEdit1.Lines.Add( '% Reposição...: '+FormatFloat('0.00',Solicitacao.Items[i].Percentual_Repos ) );
        RichEdit1.Lines.Add( '% Vidalink....: '+FormatFloat('0.00',Solicitacao.Items[i].Percentual_VidaLink ) );
        RichEdit1.Lines.Add( '---------------------------------------------------------------------------');
      end;
    end;
  end;

end;

procedure TFrmAutorizaVidaLink.EdtAutorizacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TabEnter(Self,key);
end;

procedure TFrmAutorizaVidaLink.FormCreate(Sender: TObject);
begin
  inherited;
  sIDPedido := 0;

end;

procedure TFrmAutorizaVidaLink.FormShow(Sender: TObject);
begin
  inherited;
  EdtAutorizacao.SetFocus;
end;

procedure TFrmAutorizaVidaLink.ActMenuFiscalExecute(Sender: TObject);
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
