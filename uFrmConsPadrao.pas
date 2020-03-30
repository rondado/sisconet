unit uFrmConsPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.FMTBcd, Vcl.Grids, Vcl.DBGrids, Data.DB, Data.SqlExpr, Datasnap.DBClient,
  Datasnap.Provider, System.Actions, Vcl.ActnList, Vcl.ImgList, System.ImageList;

type
  TFrmConsPadrao = class(TForm)
    QryConsulta: TSQLQuery;
    DspConsulta: TDataSetProvider;
    CdsConsulta: TClientDataSet;
    DataConsulta: TDataSource;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActNovo: TAction;
    ActAlterar: TAction;
    ActExcluir: TAction;
    ActImprimir: TAction;
    ActLocalizar: TAction;
    ActFechar: TAction;
    PnConsulta: TPanel;
    GrpTipoPesq: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    CbxTipoPesq: TComboBox;
    EdtLocalizar: TEdit;
    SbLocalizar: TBitBtn;
    Panel2: TPanel;
    SbNovo: TBitBtn;
    SbAlterar: TBitBtn;
    SbExcluir: TBitBtn;
    SbImprimir: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    GridDados: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActAlterarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure ActImprimirExecute(Sender: TObject);
    procedure ActLocalizarExecute(Sender: TObject);
    procedure GridDadosTitleClick(Column: TColumn);
    procedure GridDadosEnter(Sender: TObject);
    procedure GridDadosExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActFecharExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsPadrao: TFrmConsPadrao;

implementation

{$R *.dfm}

uses uDmConexao, uLibrary;

procedure TFrmConsPadrao.ActAlterarExecute(Sender: TObject);
begin
  //

  end;

procedure TFrmConsPadrao.ActExcluirExecute(Sender: TObject);
begin
  //

end;

procedure TFrmConsPadrao.ActFecharExecute(Sender: TObject);
begin
  close;
end;

procedure TFrmConsPadrao.ActImprimirExecute(Sender: TObject);
begin
  //

end;

procedure TFrmConsPadrao.ActLocalizarExecute(Sender: TObject);
begin
  //

end;

procedure TFrmConsPadrao.ActNovoExecute(Sender: TObject);
begin
  //

end;

procedure TFrmConsPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataConsulta.DataSet.Close;

end;

procedure TFrmConsPadrao.FormShow(Sender: TObject);
begin
//fabricio novo incluir linha abaixo
   qryconsulta.Close;

  QryConsulta.SQLConnection := DmConexao.ConexaoDBX;
  DspConsulta.DataSet       := QryConsulta;
  CdsConsulta.ProviderName  := 'DspConsulta';
  DataConsulta.DataSet      := CdsConsulta;
  CdsConsulta.Close;
  EdtLocalizar.SetFocus;

end;

procedure TFrmConsPadrao.GridDadosEnter(Sender: TObject);
begin
  GridDados.Tag := 1;

end;

procedure TFrmConsPadrao.GridDadosExit(Sender: TObject);
begin
  GridDados.Tag := 0;

end;

procedure TFrmConsPadrao.GridDadosTitleClick(Column: TColumn);
begin
  GridOrdem(CdsConsulta,GridDados,Column);

end;

end.
