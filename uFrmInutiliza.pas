unit uFrmInutiliza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, ActnList, ExtCtrls, StdCtrls, Buttons;

type
  TFrmInutiliza = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    EdtModelo: TEdit;
    EdtSerie: TEdit;
    EdtAno: TEdit;
    EdtInicio: TEdit;
    EdtFinal: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MemoJustifica: TMemo;
    Panel1: TPanel;
    ActionList1: TActionList;
    ActEnviar: TAction;
    ActFechar: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label7: TLabel;
    EdtCNPJ: TEdit;
    GroupBox2: TGroupBox;
    MemoRetorno: TMemo;
    procedure ActFecharExecute(Sender: TObject);
    procedure ActEnviarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInutiliza: TFrmInutiliza;

implementation

uses uDmAcBr, uDmWorkCom;

{$R *.dfm}

procedure TFrmInutiliza.ActFecharExecute(Sender: TObject);
begin
  inherited;
  Close;
  
end;

procedure TFrmInutiliza.ActEnviarExecute(Sender: TObject);
begin
  inherited;
  // verificações
  if (EdtCNPJ.Text = '') or (EdtModelo.Text = '') or (EdtSerie.Text = '') or
     (EdtAno.Text = '') or (EdtInicio.Text = '') or (EdtFinal.Text = '') or
     (MemoJustifica.Text = '') then
  begin
    ShowMessage('Todos os campos do formulário devem ser preenchidos!');
    Abort;
  end;
  //
  DmAcBr.ACBrNFe1.WebServices.Inutiliza(EdtCNPJ.Text,
                                        MemoJustifica.Text,
                                        StrToInt(EdtAno.Text),
                                        StrToInt(EdtModelo.Text),
                                        StrToInt(EdtSerie.Text),
                                        StrToInt(EdtInicio.Text),
                                        StrToInt(EdtFinal.Text));
  // captura retorno
  MemoRetorno.Lines.Text := UTF8Encode(DmAcBr.ACBrNFe1.WebServices.Inutilizacao.RetWS);



end;

procedure TFrmInutiliza.FormShow(Sender: TObject);
begin
  inherited;
  DmWorkCom.AtualizaConfigAcBr;
  
end;

end.
