unit uFrmRecargaPre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ActnList, uFrameConfirmaCancela, ExtCtrls, StdCtrls,
  Mask, System.Actions;

type
  TFrmRecargaPre = class(TFrmPadrao)
    Panel1: TPanel;
    FrameConfirmaCancela1: TFrameConfirmaCancela;
    ActionList1: TActionList;
    ActConfirmar: TAction;
    ActCancelar: TAction;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    EdtDDD1: TMaskEdit;
    EdtDDD2: TMaskEdit;
    GroupBox6: TGroupBox;
    EdtCEP: TMaskEdit;
    EdtCelular1: TMaskEdit;
    EdtCelular2: TMaskEdit;
    PnInforma: TLabel;
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActConfirmarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtCEPKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRecargaPre: TFrmRecargaPre;

implementation

uses uLibrary, uDmWorkCom, uFuncoesPAFECF, DB;

{$R *.dfm}

procedure TFrmRecargaPre.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmRecargaPre.ActConfirmarExecute(Sender: TObject);
var Aprovado, Impresso, EhCheque, aControlePAF_NFCe : Boolean;
    Mensagem : String;
    aVias : Integer;
begin
  inherited;
  // compara os dados do celular
  if FiltraNumero(EdtDDD1.Text) <> FiltraNumero(EdtDDD2.Text) then
  begin
    MessageDlg('DDD diferente. Verifique!',mtWarning,[mbOK],0);
    EdtDDD1.SelectAll;
    EdtDDD1.SetFocus;
    Exit;
  end;
  if FiltraNumero(EdtCelular1.Text) <> FiltraNumero(EdtCelular2.Text) then
  begin
    MessageDlg('Nº do celular diferente. Verifique!',mtWarning,[mbOK],0);
    EdtCelular1.SelectAll;
    EdtCelular1.SetFocus;
    Exit;
  end;
  // valida o CEP
  if not ValidaCEP(FiltraNumero(EdtCEP.Text)) then
  begin
    MessageDlg('CEP inválido. Verifique!',mtWarning,[mbOK],0);
    EdtCEP.SelectAll;
    EdtCEP.SetFocus;
    Exit;
  end;
  //
  if Confirmacao('Confirma a recarga?') then
  begin
    Impresso := false;
    DmWorkCom.PAFECF.ApagaArquivosTEF(1);
    // captura informação da bandeira
    DmWorkCom.PAFECF.CarregarDadosPathTEF;
    // verifica gerenciador padrão
    if not DmWorkCom.PAFECF.VerificaGerenciadorPadrao then
    begin
      DmWorkCom.PAFECF.RestauraAplicativo;
      ShowMessage('Gerenciador padrão desativado e será ativado automaticamente!');
      DmWorkCom.PAFECF.AbreGerenciadorPadrao;
    end;
    DmWorkCom.PAFECF.FuncaoVendaRecarga(FiltraNumero(EdtDDD1.Text),
                                        FiltraNumero(EdtCelular1.Text),
                                        FiltraNumero(EdtCEP.Text));
    Mensagem := '';
    DmWorkCom.PAFECF.AnalizaArquivoRetorno(Aprovado,Mensagem,EhCheque,1);
    DmWorkCom.PAFECF.RestauraAplicativo;
    // define numero de vias
    aVias := 2;
    if not DmWorkCom.PAFECF.sTEFViaUnica then
       aVias := 1;
    if not DmWorkCom.PAFECF.gPossuiCampo29 then
       aVias := 1;
    //
    if not Aprovado then
    begin
      DmWorkCom.PAFECF.ApagaArquivosTEF(1);
      DmWorkCom.PAFECF.RestauraAplicativo;
      ShowMessage(Mensagem);
    end
    else
    begin
      // Grava os dados da transação no banco de dados
      DmWorkCom.GravaDadosRecarga(EdtDDD1.Text,EdtCelular1.Text);
      // trava o teclado
      if DmWorkCom.PAFECF.sTipoTEF = 0 then
         BlockInput(true);
      // exibe a mensagem
      if DmWorkCom.PAFECF.gQuantLinhas > 0 then
      begin
//        DmWorkCom.PAFECF.ExibeMensagem(5,Mensagem); alterado para ficar mais rapido
        DmWorkCom.PAFECF.ExibeMensagem(2,Mensagem);
        while not Impresso do
        begin
          // verifica o tipo de sistema
          if sPAFNFCe = 0 then // paf-ecf
             aControlePAF_NFCe := DmWorkCom.PAFECF.ImprimeTransacaoTEF(1,aVias,1,'0','0',0)
          else
             aControlePAF_NFCe := DmWorkCom.PAFECF.ImprimeTransacaoTEFNFCe(1,aVias,1,'0','0',0);
          //
          if not aControlePAF_NFCe then
          begin
            if DmWorkCom.PAFECF.sTipoTEF = 0 then
               BlockInput(false);
            if Confirmacao('Impressora não responde. Tentar novamente? ') then
            begin
              if DmWorkCom.PAFECF.sTipoTEF = 0 then
                 BlockInput(true);
//              DmWorkCom.PAFECF.FechaCupomNaoFiscalECF(1);
              Impresso := false;
            end
            else
            begin
              if DmWorkCom.PAFECF.sTipoTEF = 0 then
                 BlockInput(false);
              if DmWorkCom.PAFECF.sTipoTEF = 0 then // tef discado
              begin
                 DmWorkCom.PAFECF.NaoConfirmaTransacao(1,'');
                 Impresso := true;
              end
              else
              begin
                DmWorkCom.PAFECF.ConfirmaTransacao(1,'');
                MessageDlg('Transação TEF confirmada. Favor reimprimir a ultima transação!', mtInformation, [mbOK], 0);
              end;
              DmWorkCom.PAFECF.ApagaArquivosTEF(1);
              DmWorkCom.PAFECF.ApagaArquivosTemporariosTEF;
            end;
          end
          else
          begin
            if DmWorkCom.PAFECF.sTipoTEF = 0 then
               BlockInput(false);
            DmWorkCom.PAFECF.ConfirmaTransacao(1,'');
            DmWorkCom.PAFECF.ApagaArquivosTEF(1);
            DmWorkCom.PAFECF.ApagaArquivosTemporariosTEF;
            Impresso := true;
          end;
        end;
      end
      else
      begin
        if DmWorkCom.PAFECF.sTipoTEF = 0 then
           BlockInput(false);
        DmWorkCom.PAFECF.ConfirmaTransacao(1,'');
        DmWorkCom.PAFECF.ApagaArquivosTEF(1);
        ShowMessage(Mensagem);
      end;
      //
      if DmWorkCom.PAFECF.sTipoTEF = 0 then
         BlockInput(false);
    end;
    EdtDDD1.Text := '';
    EdtDDD2.Text := '';
    EdtCelular1.Text := '';
    EdtCelular2.Text := '';
    PnInforma.Caption := 'Aguardando os dados para recarga';
    EdtDDD1.SetFocus;
  end;

end;

procedure TFrmRecargaPre.FormShow(Sender: TObject);
begin
  inherited;
  DmWorkCom.Dados_Empresa(sIDEmpresa);
  DmWorkCom.PAFECF.Painel := PnInforma;
  PnInforma.Caption := 'Aguardando os dados para recarga';
  EdtDDD1.Text := '';
  EdtDDD2.Text := '';
  EdtCelular1.Text := '';
  EdtCelular2.Text := '';
  EdtCEP.Text := DmWorkCom.CdsEmpresaCEP.AsString;
  EdtDDD1.SetFocus;

end;

procedure TFrmRecargaPre.EdtCEPKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
end;

end.
