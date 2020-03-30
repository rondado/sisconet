unit uFrmListaContigencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, FMTBcd, ExtCtrls, DB, DBClient, Provider, Grids,
  DBGrids, SqlExpr, ActnList, StdCtrls, Buttons, System.Actions;

type
  TFrmListaContigencia = class(TFrmPadrao)
    QryNFCe: TSQLQuery;
    DBGrid1: TDBGrid;
    DspNFCe: TDataSetProvider;
    CdsNFCe: TClientDataSet;
    DataNFCe: TDataSource;
    Panel1: TPanel;
    QryNFCeID: TIntegerField;
    QryNFCeCHAVE_NFE: TStringField;
    QryNFCeDATA_ENTREGA: TSQLTimeStampField;
    CdsNFCeID: TIntegerField;
    CdsNFCeCHAVE_NFE: TStringField;
    CdsNFCeDATA_ENTREGA: TSQLTimeStampField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ActionList1: TActionList;
    ActEnviar: TAction;
    ActAjustar: TAction;
    ActFechar: TAction;
    OpenDialog1: TOpenDialog;
    QryNFCeHORA_ENTREGA: TSQLTimeStampField;
    QryNFCeDATA_PEDIDO: TSQLTimeStampField;
    QryNFCeHORA_PEDIDO: TSQLTimeStampField;
    CdsNFCeHORA_ENTREGA: TSQLTimeStampField;
    CdsNFCeDATA_PEDIDO: TSQLTimeStampField;
    CdsNFCeHORA_PEDIDO: TSQLTimeStampField;
    QryNFCeNFE_TIPOEMISS: TIntegerField;
    CdsNFCeNFE_TIPOEMISS: TIntegerField;
    MemoXML: TMemo;
    PnAjustes: TPanel;
    Label1: TLabel;
    EdtProtocolo: TEdit;
    Label2: TLabel;
    EdtRecibo: TEdit;
    RdTipoEmiss: TRadioGroup;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure ActEnviarExecute(Sender: TObject);
    procedure ActAjustarExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure EdtProtocoloKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure ListaNFCe;
  public
    { Public declarations }
  end;

var
  FrmListaContigencia: TFrmListaContigencia;

implementation

uses uDmConexao, uDmWorkCom, uDmAcBr, uLibrary, ACBrNFeConfiguracoes;

{$R *.dfm}

procedure TFrmListaContigencia.FormShow(Sender: TObject);
begin
  inherited;
  ListaNFCe;

end;

procedure TFrmListaContigencia.ActEnviarExecute(Sender: TObject);
var aChaveNfe, aProcolo, aRecibo, aNumLote, ArquivoXML : String;
    aContingenciaOff : Boolean;
    aDataHoraEmissao, aDataHoraSaida : TDateTime;
    AuxDataHora : String;
    aTpEmis, aTpEmisOld : Integer;
begin
  inherited;
  if CdsNFCe.RecordCount > 0 then
  begin
    // gera e emite a NFCe
    if DmWorkCom.LocalizaXMLBanco(MemoXML,CdsNFCe.FieldByName('CHAVE_NFE').AsString) then
    begin
      try
        // consulta a NFCe
        if not DmWorkCom.TestaNotaJaEnviada(CdsNFCe.FieldByName('ID').AsInteger,
                                            CdsNFCe.FieldByName('CHAVE_NFE').AsString) then
        begin
          DmAcBr.ACBrNFe1.NotasFiscais.Clear;
          DmAcBr.ACBrNFe1.NotasFiscais.LoadFromString(MemoXML.Text);
          // atualiza a data de emissão
          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi := Now;
          // define o lote
          aNumLote := FormatDateTime('hhmm',now);
          // enviar ao portal
          if DmAcBr.ACBrNFe1.Enviar(aNumLote,False) then
          begin
            aChaveNfe := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;
            aProcolo  := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt;
            aRecibo   := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec;
            // atualiza o XML
            DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                      DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
            DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                          aProcolo,
                                          aRecibo,
                                          aNumLote,
                                          DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NomeArq,
                                          IntToStr(DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat),
                                          DmWorkCom.sFormas,
                                          CdsNFCe.FieldByName('ID').AsInteger,
                                          DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].dhRecbto,
                                          DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].dhRecbto);
          end;
          ListaNFCe;
        end;
      except
        on E : Exception do
        begin
          ShowMessage(E.Message);
        end;
      end;
    end
    else
    begin
      if Confirmacao('Arquivo XML não localizado no banco de dados!'+#13+#10+
                     'Gerar um novo XML?') then
      begin
        aTpEmis := StrToInt(Copy(CdsNFCe.FieldByName('CHAVE_NFE').AsString,38,1));
        aTpEmisOld := DmWorkCom.sFormas;
        aContingenciaOff := false;
        if aTpEmis = 9 then
           aContingenciaOff := true
        else
           DmWorkCom.sFormas := aTpEmis - 1;
        if DmWorkCom.GerarNFe(CdsNFCe.FieldByName('ID').AsInteger,false,true,aContingenciaOff) then
        begin
          try
            DmWorkCom.sFormas := aTpEmisOld;
            AuxDataHora := FormatDateTime('DD/MM/YYYY',CdsNFCe.FieldByName('DATA_ENTREGA').AsDateTime)+' '+
                           FormatDateTime('HH:MM:SS',CdsNFCe.FieldByName('HORA_ENTREGA').AsDateTime);
            aDataHoraEmissao := StrToDateTime(AuxDataHora);
            AuxDataHora := FormatDateTime('DD/MM/YYYY',CdsNFCe.FieldByName('DATA_PEDIDO').AsDateTime)+' '+
                           FormatDateTime('HH:MM:SS',CdsNFCe.FieldByName('HORA_PEDIDO').AsDateTime);
            aDataHoraSaida := StrToDateTime(AuxDataHora);

            // ajusta a data de emissão
            DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi := aDataHoraEmissao;
            DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dSaiEnt := aDataHoraSaida;
            DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.hSaiEnt := aDataHoraSaida;
            // comandos para gerar arquivo XML
            DmAcBr.ACBrNFe1.NotasFiscais.Assinar;
            DmAcBr.ACBrNFe1.NotasFiscais.Items[0].GravarXML;
            // executa validação do arquivo
            DmAcBr.ACBrNFe1.NotasFiscais.Validar;
            // grava o arquivo XML
            DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                      DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
          except
            on E : Exception do
            begin
              ShowMessage(E.Message);
            end;
          end;
          //
          if DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID = CdsNFCe.FieldByName('CHAVE_NFE').AsString then
          begin
            MessageDlg('XML gerado e salvo com sucesso. Tente enviar novamente!',mtInformation,[mbOK],0);
            ListaNFCe;
          end;
        end;
      end
      else
      begin
        if Confirmacao('Deseja localizar nas pasta de arquivos?') then
        begin
          ArquivoXML := '';
          OpenDialog1.InitialDir := DmAcBr.ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
          OpenDialog1.Execute;
          ArquivoXML := OpenDialog1.FileName;
          if FileExists(ArquivoXML) then
          begin
            try
              DmAcBr.ACBrNFe1.NotasFiscais.Clear;
              DmAcBr.ACBrNFe1.NotasFiscais.LoadFromFile(ArquivoXML);
              // consulta a NFCe
              if not DmWorkCom.TestaNotaJaEnviada(CdsNFCe.FieldByName('ID').AsInteger,
                                                  CdsNFCe.FieldByName('CHAVE_NFE').AsString) then
              begin
                // atualiza a data de emissão
                DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi := Now;

                // define o lote
                aNumLote := FormatDateTime('hhmm',now);
                // enviar ao portal
                if DmAcBr.ACBrNFe1.Enviar(aNumLote,false) then
                begin
                  aChaveNfe := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;
                  aProcolo  := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt;
                  aRecibo   := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec;
                  // atualiza o XML
                  DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                            DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
                  DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                                aProcolo,
                                                aRecibo,
                                                aNumLote,
                                                ArquivoXML,
                                                IntToStr(DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat),
                                                DmWorkCom.sFormas,
                                                CdsNFCe.FieldByName('ID').AsInteger,
                                                DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].dhRecbto,
                                                DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].dhRecbto);
                end;
                ListaNFCe;
              end;
            except
              on E : Exception do
              begin
                ShowMessage(E.Message);
              end;
            end;
          end;
        end;
      end;
    end;
  end;

end;

procedure TFrmListaContigencia.ActAjustarExecute(Sender: TObject);
begin
  inherited;
  if DmWorkCom.Dados_Pedido(CdsNFCe.FieldByname('ID').AsInteger) then
  begin
    PnAjustes.Visible     := true; 
    EdtProtocolo.Text     := DmWorkCom.CdsPedidos.FieldByName('PROTOCOLO_NFE').AsString;
    EdtRecibo.Text        := DmWorkCom.CdsPedidos.FieldByName('RECIBO_NFE').AsString;
//fabricio novo colocar
RdTipoEmiss.ItemIndex := 0;
    //fabricio novo tirar    RdTipoEmiss.ItemIndex := DmWorkCom.CdsPedidos.FieldByName('NFE_TIPOEMISS').AsInteger - 1;
    EdtProtocolo.SelectAll;
    EdtProtocolo.SetFocus;
  end
  else MessageDlg('Pedido não localizado. Verifique!',mtWarning,[mbOK],0);


end;

procedure TFrmListaContigencia.ActFecharExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmListaContigencia.ListaNFCe;
begin
  CdsNFCe.Close;
  CdsNFCe.Open;
  DBGrid1.SetFocus;

end;

procedure TFrmListaContigencia.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
     ActFecharExecute(Sender);
  if Key = #13 then
     ActEnviarExecute(Sender);

end;

procedure TFrmListaContigencia.BitBtn5Click(Sender: TObject);
begin
  inherited;
  PnAjustes.Visible := false;
  ListaNFCe;
  
end;

procedure TFrmListaContigencia.BitBtn4Click(Sender: TObject);
begin
  inherited;
  if (Trim(EdtProtocolo.Text) = '') or (Trim(EdtRecibo.Text) = '') then
  begin
    MessageDlg('É necessário informar o protocolo e número do recibo.',mtWarning,[mbOK],0);
    EdtProtocolo.SelectAll;
    EdtProtocolo.SetFocus;
  end;
  if DmWorkCom.Dados_Pedido(CdsNFCe.FieldByname('ID').AsInteger) then
  begin
    MessageDlg('Confira novamente os dados para evitar problemas na geração do SPED Fiscal!',mtWarning,[mbOK],0);
    if Confirmacao('Confirma a gravação dos dados informados?') then
    begin
      DmWorkCom.CdsPedidos.Edit;
      DmWorkCom.CdsPedidos.FieldByName('STATUS_NFE').AsString     := '100';
      DmWorkCom.CdsPedidos.FieldByName('PROTOCOLO_NFE').AsString  := EdtProtocolo.Text;
      DmWorkCom.CdsPedidos.FieldByName('RECIBO_NFE').AsString     := EdtRecibo.Text;
      DmWorkCom.CdsPedidos.FieldByName('NFE_TIPOEMISS').AsInteger := RdTipoEmiss.ItemIndex + 1;
      Grava_Dados(DmWorkCom.CdsPedidos);
      PnAjustes.Visible := false;
    end;
    ListaNFCe;  
  end
  else MessageDlg('Pedido não localizado. Verifique!',mtWarning,[mbOK],0);

end;

procedure TFrmListaContigencia.EdtProtocoloKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
//fabricio novo
Bitbtn4.SetFocus;
//  TabEnter(Self,Key);
end;

end.
