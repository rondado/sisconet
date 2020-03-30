unit uFrmCadFormaPag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, ExtCtrls, StdCtrls, Mask,
  DBCtrls, Grids, DBGrids, ComCtrls, ActnList, DB, System.Actions;

type
  TFrmCadFormaPag = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    DbID: TDBEdit;
    DbDescricao: TDBEdit;
    DbFormaPag: TDBEdit;
    Panel1: TPanel;
    Frame: TFrameBotaoVertical;
    DbRadioTipoPag: TDBRadioGroup;
    DbRadioTipoDoc: TDBRadioGroup;
    DbChContas: TDBCheckBox;
    DbChCaixa: TDBCheckBox;
    DbCHAtivo: TDBCheckBox;
    Label3: TLabel;
    DbQuantPagtos: TDBEdit;
    GrpOperadora: TGroupBox;
    DBEdit1: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FrameBotaoVertical1BtnPesquisarClick(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActIncluirExecute(Sender: TObject);
    procedure DbIDKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataWorkDataChange(Sender: TObject; Field: TField);
    procedure DbRadioTipoDocClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadFormaPag: TFrmCadFormaPag;

implementation

Uses uLibrary, uDmWorkCom;

{$R *.dfm}

procedure TFrmCadFormaPag.FormShow(Sender: TObject);
begin
  inherited;
  DataWork.DataSet := DmWorkCom.CdsFormaPag;
  DmWorkCom.Dados_FormaPagto;
  PageControl1.TabIndex := 0;
  DBGrid1.SetFocus;
  
end;

procedure TFrmCadFormaPag.FrameBotaoVertical1BtnPesquisarClick(
  Sender: TObject);
begin
  inherited;
  PageControl1.TabIndex := 0;
  
end;

procedure TFrmCadFormaPag.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);
  
end;

procedure TFrmCadFormaPag.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbDescricao.SetFocus; 

end;

procedure TFrmCadFormaPag.DataWorkDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  GrpOperadora.Visible := false;
  if DataWork.DataSet.FieldByName('TIPO_DOCUMENTO').AsInteger = 2 then
     GrpOperadora.Visible := true;

end;

procedure TFrmCadFormaPag.DbIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  TabEnter(Self,Key);
  
end;

procedure TFrmCadFormaPag.DbRadioTipoDocClick(Sender: TObject);
begin
  inherited;
  GrpOperadora.Visible := false;
  if DbRadioTipoDoc.ItemIndex = 2 then
     GrpOperadora.Visible := true;

end;

procedure TFrmCadFormaPag.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
  
end;

end.
