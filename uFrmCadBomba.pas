unit uFrmCadBomba;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, StdCtrls, Mask, DBCtrls,
  uFrameBotaoVertical, ExtCtrls, Grids, DBGrids;

type
  TFrmCadBomba = class(TFrmCadPadrao)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    FrameBotaoVertical1: TFrameBotaoVertical;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    GroupBox2: TGroupBox;
    DataLacre: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure ActExcluirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadBomba: TFrmCadBomba;

implementation

uses uDmWorkCom, uLibrary, uDmPosto;

{$R *.dfm}

procedure TFrmCadBomba.FormShow(Sender: TObject);
begin
  DataWork.DataSet  := DmPosto.CdsBombas;
  DataLacre.DataSet := DmPosto.CdsBombasLacre;
  inherited;
  DmPosto.Dados_Bomba;

end;

procedure TFrmCadBomba.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(FrameBotaoVertical1,DataWork.DataSet);

end;

procedure TFrmCadBomba.DataWorkDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if DataWork.DataSet.RecordCount > 0 then
     DmPosto.Dados_Bomba_Lacre(DataWork.DataSet.FieldByName('ID').AsInteger);

  DBEdit2.ReadOnly := true;
  DBEdit3.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;
  DBEdit6.ReadOnly := true;
  if DataWork.DataSet.State in [dsedit] then
  begin
    DBEdit2.ReadOnly := true;
    DBEdit3.ReadOnly := true;
    DBEdit4.ReadOnly := true;
    DBEdit5.ReadOnly := true;
    DBEdit6.ReadOnly := true;
  end;


end;

procedure TFrmCadBomba.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
     Grava_Dados(DataLacre.DataSet);
     
end;

procedure TFrmCadBomba.ActExcluirExecute(Sender: TObject);
begin
  MessageDlg('Não é permitido excluir a Bomba do cadastro!',mtWarning,[mbOK],0);
  Abort;
  inherited;

end;

end.
