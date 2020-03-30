program _ProcessaSat;

uses
  Forms,
  SqlExpr,
  SysUtils,
  Dialogs,
  uComandosSAT in 'Funcoes\uComandosSAT.pas',
  uDmAcBr in 'DM\uDmAcBr.pas' {DmAcBr: TDataModule},
  MD5 in 'Funcoes\MD5.pas',
  uLibrary in 'Funcoes\uLibrary.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Emissor de Documento Fiscal - SAT';
  Application.CreateForm(TDmAcBr, DmAcBr);
  try
    // verifica paramentro de NFe ou NFCe
    if ParamStr(1) <> '' then
    begin
      sNFeNFCe := StrToInt(ParamStr(1));
    end;
    // cria a valiável de conexão
    ConexaoDados := TSQLConnection.Create(Application);
    // verifica arquivo de configuração de acesso aos dados
    if not FileExists(ExtractFilePath(Application.ExeName)+'config.ini') then
       CriaArqIni;
    LeArqIni;
    // realiza conexao com o banco de dados
    with ConexaoDados do
    begin
      Connected      := false;
      ConnectionName := 'IBConnection';
      DriverName     := 'INTERBASE';
      LibraryName    := 'dbexpint.dll';
      VendorLib      := 'GDS32.DLL';
      GetDriverFunc  := 'getSQLDriverINTERBASE';
      LoginPrompt    := False;
      Params.Values['Database']  := sPath;
      Params.Values['User_Name'] := sUser;
      Params.Values['Password']  := sPass;
      Connected := true;
    end;
    // Executa comandos
    if ConexaoDados.Connected then
    begin
      // captura os dados da empresa
      CapturaDadosEmpresa;
      // captura os dados da empresa
      CapturaConfigNFe;
      // captura a configuração da NFe
      AtualizaConfigAcBr;
      // verifica pasta para gravar nfe existe
      if not DirectoryExists(ConfiguraNFe.sPathArq) then
         CreateDir(ConfiguraNFe.sPathArq);
      //
      if ParamStr(2) <> '' then
      begin
//        MessageDlg('Vai processar a nota: '+ParamStr(2),mtWarning,[mbOK],0);
        try
          QryPedidos  := TSQLQuery.Create(Application);
          QryItens    := TSQLQuery.Create(Application);
          QryFormaPag := TSQLQuery.Create(Application);
          QryClientes := TSQLQuery.Create(Application);
          QryProdutos := TSQLQuery.Create(Application);
          QryProdutos.SQLConnection := ConexaoDados;
          QryFormaPag.SQLConnection := ConexaoDados;
          QryItens.SQLConnection := ConexaoDados;
          QryPedidos.SQLConnection := ConexaoDados;
          QryClientes.SQLConnection := ConexaoDados;
          ProcessaNFeInformada(ParamStr(2));
        finally
          QryProdutos.Close;
          QryFormaPag.Close;
          QryItens.Close;
          QryPedidos.Close;
          QryClientes.Close;
          ConexaoDados.Close;
          FreeAndNil(QryPedidos);
          FreeAndNil(QryItens);
          FreeAndNil(QryFormaPag);
          FreeAndNil(QryClientes);
          FreeAndNil(QryProdutos);
          FreeAndNil(ConexaoDados);
        end;
      end;
    end;
  except
    on Exc: Exception do
    begin
      MessageDlg('Erro: '+Exc.Message, mtWarning, [mbOK], 0);
      Application.Terminate;
    end;
  end;
  //
  Application.Run;
end.
