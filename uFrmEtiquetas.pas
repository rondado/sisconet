unit uFrmEtiquetas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ExtCtrls, StdCtrls, Grids, DBGrids, DB, DBClient,
  ActnList, Buttons, System.Actions;

type
  TFrmEtiquetas = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DsEtiquetas: TDataSource;
    CdsEtiquetas: TClientDataSet;
    DBGrid1: TDBGrid;
    CdsEtiquetasNOME: TStringField;
    CdsEtiquetasENDERECO: TStringField;
    CdsEtiquetasCIDADE: TStringField;
    CdsEtiquetasUF: TStringField;
    CdsEtiquetasCEP: TStringField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ActionList1: TActionList;
    ActIncluirEtq: TAction;
    ActExcluirEtq: TAction;
    ActIncluirTodos: TAction;
    ActImprimirEtq: TAction;
    ActFechar: TAction;
    procedure ActIncluirEtqExecute(Sender: TObject);
    procedure ActExcluirEtqExecute(Sender: TObject);
    procedure ActIncluirTodosExecute(Sender: TObject);
    procedure ActImprimirEtqExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure Imprimir;
  public
    { Public declarations }
  end;

var
  FrmEtiquetas: TFrmEtiquetas;

implementation

uses uDmWorkCom, uLibrary, uFrmClientes, uDMClientes, uMensagem;

{$R *.dfm}

procedure TFrmEtiquetas.ActIncluirEtqExecute(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TFrmClientes,FrmClientes);
    FrmClientes.sApenasConsulta := true;
    FrmClientes.ShowModal;
    if FrmClientes.sCodCli > 0 then
    begin
      if DmClientes.Dados_Contato(FrmClientes.sCodCli) then
      begin
        CdsEtiquetas.Append;
        CdsEtiquetasNOME.AsString     := DmClientes.CdsContatosNOME.AsString;
        CdsEtiquetasENDERECO.AsString := Trim(DmClientes.CdsContatosENDERECO.AsString)+', '+
                                         Trim(DmClientes.CdsContatosNUM_END.AsString)+' - '+
                                         Trim(DmClientes.CdsContatosBAIRRO_END.AsString);
        CdsEtiquetasCIDADE.AsString   := DmClientes.CdsContatosCIDADE_END.AsString;
        CdsEtiquetasUF.AsString       := DmClientes.CdsContatosUF_END.AsString;
        CdsEtiquetasCEP.AsString      := DmClientes.CdsContatosCEP_END.AsString;
        CdsEtiquetas.Post;
      end;
    end;
  finally
    FreeAndNil(FrmClientes);
  end;

end;

procedure TFrmEtiquetas.ActExcluirEtqExecute(Sender: TObject);
begin
  inherited;
  if CdsEtiquetas.RecordCount > 0 then
  begin
    if Confirmacao('Confirma a exclusão da etiqueta?') then
       CdsEtiquetas.Delete;
  end;
  
end;

procedure TFrmEtiquetas.ActIncluirTodosExecute(Sender: TObject);
var formMensagem: TFormMensagem;
begin
  inherited;
  if Confirmacao('Confirma a inclusão de todos os clientes do cadastro?') then
  begin
    try
      formMensagem := TFormMensagem.Create('Aguarde... enquanto o sistema é inicializado!',550,150,clBlack,clSilver);
      formMensagem.mostrar;
      Refresh;
      //
      CdsEtiquetas.EmptyDataSet;
      if DmClientes.Dados_Contato('C') then
      begin
        while not DmClientes.CdsContatos.Eof do
        begin
          CdsEtiquetas.Append;
          CdsEtiquetasNOME.AsString     := DmClientes.CdsContatosNOME.AsString;
          CdsEtiquetasENDERECO.AsString := Trim(DmClientes.CdsContatosENDERECO.AsString)+', '+
                                           Trim(DmClientes.CdsContatosNUM_END.AsString)+' - '+
                                           Trim(DmClientes.CdsContatosBAIRRO_END.AsString);
          CdsEtiquetasCIDADE.AsString   := DmClientes.CdsContatosCIDADE_END.AsString;
          CdsEtiquetasUF.AsString       := DmClientes.CdsContatosUF_END.AsString;
          CdsEtiquetasCEP.AsString      := DmClientes.CdsContatosCEP_END.AsString;
          CdsEtiquetas.Post;
          //
          DmClientes.CdsContatos.Next;
        end;
      end;
    finally
      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
    end;
  end;

end;

procedure TFrmEtiquetas.ActImprimirEtqExecute(Sender: TObject);
begin
  inherited;
  if CdsEtiquetas.RecordCount > 0 then
     Imprimir;

end;

procedure TFrmEtiquetas.ActFecharExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmEtiquetas.FormCreate(Sender: TObject);
begin
  inherited;
  if not CdsEtiquetas.Active then
     CdsEtiquetas.CreateDataSet;
  CdsEtiquetas.EmptyDataSet;
     
end;

procedure TFrmEtiquetas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CdsEtiquetas.Close;
  CdsEtiquetas.Free;
end;

procedure TFrmEtiquetas.Imprimir;
var Linha : Integer;
    Nome1, Endereco1, Cidade1, UF1, CEP1 : String;
    Nome2, Endereco2, Cidade2, UF2, CEP2 : String;
begin
  // prepara relatorio
{
  RDprint1.OpcoesPreview.PreviewZoom := 100;
  RDprint1.OpcoesPreview.Preview     := true;
  RDprint1.TamanhoQteLinhas          := 60;
  RDprint1.TamanhoQteColunas         := 80;
  RDprint1.Abrir;
  //
  Linha := 1;
  CdsEtiquetas.First;
  while not CdsEtiquetas.Eof do
  begin
    Nome1     := CdsEtiquetasNOME.AsString;
    Endereco1 := CdsEtiquetasENDERECO.AsString;
    Cidade1   := CdsEtiquetasCIDADE.AsString;
    UF1       := CdsEtiquetasUF.AsString;
    CEP1      := CdsEtiquetasCEP.AsString;
    // proximo registro
    CdsEtiquetas.Next;
    if not CdsEtiquetas.Eof then
    begin
      Nome2     := CdsEtiquetasNOME.AsString;
      Endereco2 := CdsEtiquetasENDERECO.AsString;
      Cidade2   := CdsEtiquetasCIDADE.AsString;
      UF2       := CdsEtiquetasUF.AsString;
      CEP2      := CdsEtiquetasCEP.AsString;
      CdsEtiquetas.Next;
    end
    else
    begin
      Nome2     := '';
      Endereco2 := '';
      Cidade2   := '';
      UF2       := '';
      CEP2      := '';
    end;
    RDprint1.ImpF(Linha,01,Nome1,[comp17]);
    RDprint1.ImpF(Linha,40,Nome2,[comp17]);
    Inc(Linha);
    RDprint1.ImpF(Linha,01,Endereco1,[comp17]);
    RDprint1.ImpF(Linha,40,Endereco2,[comp17]);
    Inc(Linha);
    RDprint1.ImpF(Linha,01,Cidade1+' - '+UF1,[comp17]);
    if UF2 <> '' then
       RDprint1.ImpF(Linha,40,Cidade2+' - '+UF2,[comp17])
    else
       RDprint1.ImpF(Linha,40,Cidade2,[comp17]);
    Inc(Linha);
    RDprint1.ImpF(Linha,01,'CEP: '+CEP1,[comp17]);
    if CEP2 <> '' then
       RDprint1.ImpF(Linha,40,'CEP: '+CEP2,[comp17])
    else
       RDprint1.ImpF(Linha,40,'',[comp17]);
    Inc(Linha);
    Inc(Linha);
    if Linha >= 60 then
    begin
      RDprint1.Novapagina;
      Linha := 1;
    end;
  end;
  RDprint1.Fechar;
}
end;

end.
