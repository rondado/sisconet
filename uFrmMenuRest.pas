unit uFrmMenuRest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls, ImgList, ToolWin, jpeg, Buttons,
  System.ImageList;

type
  TFrmMenuRest = class(TForm)
    MainMenu1: TMainMenu;
    Mesas1: TMenuItem;
    Sair1: TMenuItem;
    CadastrarMesas1: TMenuItem;
    MovimentaodemESAS1: TMenuItem;
    ImageList1: TImageList;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    ImgLogo: TImage;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure CadastrarMesas1Click(Sender: TObject);
    procedure MovimentaodemESAS1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    procedure CarregarConfiguracao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuRest: TFrmMenuRest;

implementation

uses uDmWorkCom, uFrmLoginUsuario, uLibrary, uFrmCadMesas, uFrmMovMesas, uFrmMovMesas2, //fabricio novo uFrmMovMesas2
  uDMClientes;

{$R *.dfm}

procedure TFrmMenuRest.FormShow(Sender: TObject);
begin
  DmWorkCom.PAFECF.LeArquivoINI;
  DmWorkCom.PAFECF.ArqTemp := ExtractFilePath(Application.ExeName)+'INTPOS.001';
  StatusBar1.Panels.Items[0].Text := DateToStr(SVData);
  StatusBar1.Panels.Items[1].Text := 'IP: '+RetornaIP;
  StatusBar1.Panels.Items[4].Text := 'Controle de Mesas';
  FrmMenuRest.WindowState := wsMaximized;
  
end;

procedure TFrmMenuRest.CadastrarMesas1Click(Sender: TObject);
begin
  // Cadastro de Mesas
  AbreForm(TFrmCadMesas,FrmCadMesas);
  
end;

procedure TFrmMenuRest.MovimentaodemESAS1Click(Sender: TObject);
begin
  // Movimento de mesas
  AbreForm(TFrmMovMesas,FrmMovMesas);

end;

procedure TFrmMenuRest.Sair1Click(Sender: TObject);
begin
  Application.Terminate;

end;

procedure TFrmMenuRest.SpeedButton4Click(Sender: TObject);
begin
   // Movimento de mesas
  AbreForm(TFrmMovMesas2,FrmMovMesas2);

end;

procedure TFrmMenuRest.Timer1Timer(Sender: TObject);
var aux : Integer;
begin
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

procedure TFrmMenuRest.CarregarConfiguracao;
begin
  // tela principal
  if FileExists(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg') then
  begin
    ImgLogo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'imagens\fundosys.jpg');
    ImgLogo.Visible  := true;
  end;
end;

procedure TFrmMenuRest.FormCreate(Sender: TObject);
begin
  CarregarConfiguracao;
  
end;

end.
