unit unovobarras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, printers;

type
  TFbarras = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    eporta: TEdit;
    Impre: TComboBox;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ImpreChange(Sender: TObject);
    procedure eportaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fbarras: TFbarras;

implementation

uses uDmProdutos, unovobarras2;

{$R *.dfm}

procedure TFbarras.Button1Click(Sender: TObject);
var
aProdOk: boolean;
begin
  try
        if Length(edit1.Text) <= 6  then
           aProdOk := DmProdutos.Dados_Produto(StrToInt(edit1.Text))
        else
           aProdOk := DmProdutos.Dados_Produto(edit1.Text);
        if not(aProdOk) then
        begin
          ShowMessage('Produto não cadastrado!');
          Edit1.SetFocus;
        end;

//        DmProdutos.CdsProdutos.







{

           if length(DM.tblProdutocodigo.AsString) > 12 then
           begin
              QuickReport2.QrAsBarcode1.Enabled:=false;
              QuickReport2.QrAsBarcode2.Enabled:=true;
              QuickReport2.QRAsBarcode2.Text:=   DM.tblProdutocodigo.AsString;
            end
            else
            begin
              QuickReport2.QrAsBarcode2.Enabled:=false;
              QuickReport2.QrAsBarcode1.Enabled:=true;
              QuickReport2.QRAsBarcode1.Text:=   DM.tblProdutocodigo.AsString;
            end;

              QuickReport2.page.Width:= StrToFloat(Edit2.Text);
              QuickReport2.page.Length:=StrToFloat(Edit3.Text);

              QuickReport2.Codbarras.Caption:= DM.tblProdutocodigo.AsString + ' ';
              QuickReport2.descricao.Caption:= DM.tblProdutodescricao.asstring;
              QuickReport2.valor.Caption:= FormatFloat('R$ #,##0.00',dm.tblprodutovenda2.AsFloat) + ' ';
//  QrTotal.Caption:= FormatFloat('#,##0.00',etotal);
              QuickReport2.PrinterSettings.PrinterIndex:=StrToInt(eporta.Text);
              QuickReport2.Print;
}
  except
    ShowMessage('Não conectou a tabela dos Produtos ... Favor fechar o outro sistema !!! ');
  end;
  edit1.SetFocus;
  edit1.Text:='';
end;

procedure TFbarras.FormKeyPress(Sender: TObject; var Key: Char);
begin
  // Ao Teclar <ESC> Provoca a Saída do Form
  if key=#27 then
     Close;
end;

procedure TFbarras.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFbarras.FormShow(Sender: TObject);
begin
   edit1.SetFocus;
   impre.Items.Assign(Printer.Printers);
   impre.SetFocus;
end;

procedure TFbarras.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if (Key = #13) or (key =#09) then
begin
Button1.Click;

end;
end;

procedure TFbarras.ImpreChange(Sender: TObject);
begin
   eporta.Text:= IntToStr(impre.ItemIndex);
   edit1.SetFocus;
end;

procedure TFbarras.eportaKeyPress(Sender: TObject; var Key: Char);
begin
If not(key in['1'..'9']) then
 key:= #0;

end;

procedure TFbarras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=(vk_escape) then
close;
end;

end.
