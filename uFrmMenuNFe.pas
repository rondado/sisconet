unit uFrmMenuNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ImgList, ToolWin, Menus, StdCtrls, jpeg,
  Buttons, System.ImageList;

type
  TFrmMenuNFe = class(TForm)
    ImageList1: TImageList;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    GerarNFe1: TMenuItem;
    CancelamentoNFe1: TMenuItem;
    InutilizarNmerao1: TMenuItem;
    Sair1: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ImgLogo: TImage;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure InutilizarNmerao1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure GerarNFe1Click(Sender: TObject);
  private
    procedure CarregarConfiguracao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuNFe: TFrmMenuNFe;

implementation

uses uFrmClientes, uFrmCadClassPedido, uFrmCadFormaPag, uFrmLancPedidos,
  uLibrary, uFrmPedidosConsulta, uFrmProdutos, uDmWorkCom, uFrmLoginUsuario,
  uFrmGeraNFe, uFrmInutiliza, uFuncoesPAFECF, uMensagem, uDMClientes;

{$R *.dfm}

procedure TFrmMenuNFe.FormShow(Sender: TObject);
begin
  FrmMenuNFe.WindowState := wsMaximized;
  DmWorkCom.PAFECF.LeArquivoINI;

end;

procedure TFrmMenuNFe.Timer1Timer(Sender: TObject);
var formMensagem: TFormMensagem;
    aux : Integer;
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
    try
      formMensagem := TFormMensagem.Create('Aguarde... enquanto o sistema é inicializado!',550,150,clBlack,clSilver);
      formMensagem.mostrar;
      Refresh;
      DmWorkCom.PAFECF.gMD5 := DmWorkCom.PAFECF.GeraMD5PAFECF;
    finally
      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
    end;
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
        DmWorkCom.PAFECF.gNomeOperador  := DmClientes.CdsUsuariosUSUARIO.AsString;
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

procedure TFrmMenuNFe.CarregarConfiguracao;
begin
  // tela principal
  if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg') then
  begin
    ImgLogo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg');
    ImgLogo.Visible  := true;
  end;

end;

procedure TFrmMenuNFe.InutilizarNmerao1Click(Sender: TObject);
begin
  AbreForm(TFrmInutiliza,FrmInutiliza);

end;

procedure TFrmMenuNFe.FormCreate(Sender: TObject);
begin
  CarregarConfiguracao;
  sPAFNFCe := 0;

end;

procedure TFrmMenuNFe.SpeedButton1Click(Sender: TObject);
begin
  AbreForm(TFrmGeraNFe,FrmGeraNFe);

end;

procedure TFrmMenuNFe.SpeedButton2Click(Sender: TObject);
begin
  Application.Terminate;

end;

procedure TFrmMenuNFe.GerarNFe1Click(Sender: TObject);
begin
  AbreForm(TFrmGeraNFe,FrmGeraNFe);
end;

end.
