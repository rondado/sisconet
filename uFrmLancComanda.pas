unit uFrmLancComanda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadPadrao, uFrameBotaoHorizontal, ExtCtrls, StdCtrls,
  ActnList, DB;

type
  TFrmLancComanda = class(TFrmCadPadrao)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    FrameBotaoHorizontal1: TFrameBotaoHorizontal;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLancComanda: TFrmLancComanda;

implementation

{$R *.dfm}

end.
