unit uFrmEstoqueFisico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, DB, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons;

type
  TFrmEstoqueFisico = class(TFrmPadrao)
    DataEstFisico: TDataSource;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstoqueFisico: TFrmEstoqueFisico;

implementation

uses uDmWorkCom, uLibrary, uDmPosto;

{$R *.dfm}

procedure TFrmEstoqueFisico.FormShow(Sender: TObject);
begin
  inherited;
  DataEstFisico.DataSet := DmPosto.CdsTanques;
  DmPosto.Dados_Tanque;

end;

procedure TFrmEstoqueFisico.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
var Estoque : Double;
    aux : String;
begin
  inherited;
  if (key = #13) then
  begin
    aux := '0';
    if InputQuery('Estoque Fsico','Quantidade',aux) then
    begin
      try
        Estoque := StrToFloat(aux);
        if Estoque < 0 then
        begin
          MessageDlg('O Estoque não pode ser negativo!',mtWarning,[mbOK],0);
          Exit;
        end;
        DmPosto.GravaEstoqueFisico(DataEstFisico.DataSet.FieldByName('ID').AsInteger,
                                   Estoque);
        DmPosto.Dados_Tanque;
      except
        on E : Exception do ShowMessage(e.Message);
      end;
    end;
  end;

end;

procedure TFrmEstoqueFisico.BitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmEstoqueFisico.FormClose(Sender: TObject; var Action: TCloseAction);
var aTanques : String;
begin
  inherited;
  if DataEstFisico.DataSet.State in [dsinsert,dsedit] then
  begin
    Grava_Dados(DataEstFisico.DataSet);
  end;
  if DmPosto.VerificaInformacaoEstFisico(aTanques) then
  begin
    MessageDlg('O(s) tanque(s) '+aTanques+' estão sem informação.'+#13+#10+
               'É obrigatorio o preenchimento do estoque de todos os tanques.',mtWarning,[mbOK],0);
    DBGrid1.SetFocus;
    Abort;
  end;
  // confronta o estoque fisico com o estoque atual
  DmPosto.ConfrontaEstoqueFisico;

end;

end.
