unit uFrmCadClassPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoVertical, ExtCtrls, DBCtrls, StdCtrls,
  Mask, ComCtrls, ActnList, DB, Grids, DBGrids, System.Actions;

type
  TFrmCadClassPedido = class(TFrmCadPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DbID: TDBEdit;
    DbDescricao: TDBEdit;
    DbChMovimento: TDBCheckBox;
    DbEstoque: TDBCheckBox;
    DbRadioTipoMov: TDBRadioGroup;
    DbRadioTipo: TDBRadioGroup;
    Panel1: TPanel;
    Frame: TFrameBotaoVertical;
    DBGrid1: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    Label6: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DataCFOP: TDataSource;
    DBCheckBox3: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActIncluirExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadClassPedido: TFrmCadClassPedido;

implementation

Uses uLibrary, uDmWorkCom;

{$R *.dfm}

procedure TFrmCadClassPedido.FormShow(Sender: TObject);
begin
  DataWork.DataSet := DmWorkCom.CdsPedidoClass;
  DataCFOP.DataSet := DmWorkCom.CdsCFOP;
  inherited;
  DmWorkCom.Dados_PedidoClassificacao;
  DmWorkCom.Dados_CFOP;
  PageControl1.TabIndex := 0;
  DBGrid1.SetFocus;

end;

procedure TFrmCadClassPedido.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  AbilitaFrame(Frame,DataWork.DataSet);

end;

procedure TFrmCadClassPedido.ActIncluirExecute(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  inherited;
  DbDescricao.SetFocus;

end;

procedure TFrmCadClassPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataWork.DataSet.Close;
end;

procedure TFrmCadClassPedido.ActConfirmarExecute(Sender: TObject);
begin
  DataWork.DataSet.FieldByName('CFOP').AsString := DataCFOP.DataSet.FieldByName('CFCOD').AsString;
  inherited;
end;

end.
