unit uFrmCadTransporta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, ActnList, DB, StdCtrls, Mask, DBCtrls,
  uFrameBotaoHorizontal, ExtCtrls, System.Actions;

type
  TFrmCadTransporta = class(TFrmCadPadrao)
    Panel1: TPanel;
    FrameBotaoHorizontal1: TFrameBotaoHorizontal;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadTransporta: TFrmCadTransporta;

implementation

uses uDmWorkCom;

{$R *.dfm}

end.
