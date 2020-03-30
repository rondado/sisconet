unit uFrmMenuDAVPV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, Menus, ExtCtrls, ImgList, ComCtrls, ToolWin,
  StdCtrls, Buttons, jpeg, System.ImageList;

type
  TFrmMenuDAVPV = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    EmitirDAVPreVenda1: TMenuItem;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    Timer1: TTimer;
    Panel1: TPanel;
    sbTabelaProduto: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ImgLogo: TImage;
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EmitirDAVPreVenda1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CarregarConfiguracao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuDAVPV: TFrmMenuDAVPV;

implementation

uses uFrmClientes, uFrmCadClassPedido, uFrmCadFormaPag, uFrmLancPedidos,
  uLibrary, uFrmPedidosConsulta, uFrmProdutos, uDmWorkCom, uFrmLoginUsuario,
  uDMClientes;

{$R *.dfm}

procedure TFrmMenuDAVPV.Sair1Click(Sender: TObject);
begin
  inherited;
  Application.Terminate;
  
end;

procedure TFrmMenuDAVPV.FormShow(Sender: TObject);
begin
  inherited;
  FrmMenuDAVPV.WindowState := wsMaximized;
  
end;

procedure TFrmMenuDAVPV.EmitirDAVPreVenda1Click(Sender: TObject);
begin
  inherited;
  // Lancamento de Encomendas
  Application.CreateForm(TFrmClientes,FrmClientes);
  Application.CreateForm(TFrmCadClassPedido,FrmCadClassPedido);
  Application.CreateForm(TFrmCadFormaPag,FrmCadFormaPag);
  Application.CreateForm(TFrmPedidosConsulta,FrmPedidosConsulta);
  Application.CreateForm(TfrmProdutos,FrmProdutos);
  Application.CreateForm(TFrmLancPedidos,FrmLancPedidos);
  try
    FrmLancPedidos.ShowModal;
  finally
    FrmLancPedidos.Destroy;
    FrmProdutos.Destroy;
    FrmPedidosConsulta.Destroy;
    FrmCadFormapag.Destroy;
    FrmCadClassPedido.Destroy;
    FrmClientes.Destroy;
  end;

end;

procedure TFrmMenuDAVPV.Timer1Timer(Sender: TObject);
var aux : Integer;
begin
  inherited;
  Timer1.Enabled := false;
  // verifica perfil
  if not DmClientes.Dados_Usuarios then
  begin
    DmClientes.Adciona_UsuarioPadrao;
  end;
  // verifica dados da empresa
  sIDEmpresa := 1;
//  if not DmWorkCom.Dados_Empresa(sIDEmpresa) then
  if not DmWorkCom.Dados_Empresa then
  begin
    MessageDlg('É necessário configurar o sistema!!!', mtWarning, [mbOK], 0);
    Application.Terminate;
  end
  else
  begin
    // login do usuario
    Application.CreateForm(TFrmLoginUsuario,FrmLoginUsuario);
    try
      FrmLoginUsuario.sOK := false;
      FrmLoginUsuario.ShowModal;
      if not FrmLoginUsuario.sOK then
         Application.Terminate
      else
      begin
        StatusBar1.Panels.Items[2].Text := DmClientes.CdsUsuariosUSUARIO.AsString;
      end;
    finally
      FrmLoginUsuario.Destroy
    end;
    // carrega dados do sistema
    DmWorkCom.Dados_Empresa(sIDEmpresa);
    StatusBar1.Panels.Items[3].Text := DmWorkCom.CdsEmpresaRAZAO_SOCIAL.AsString;
    DmWorkCom.CarregaDadosEmpresa;
  end;

end;

procedure TFrmMenuDAVPV.CarregarConfiguracao;
begin
  // tela principal
  if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg') then
  begin
    ImgLogo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg');
    ImgLogo.Visible  := true;
  end;

end;

procedure TFrmMenuDAVPV.FormCreate(Sender: TObject);
begin
  CarregarConfiguracao;
end;

end.
