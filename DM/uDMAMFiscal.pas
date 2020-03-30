unit uDMAMFiscal;

interface

uses
  SysUtils, Classes, ACBrBase, ACBrECF, IniFiles, Forms, ACBrDevice;

type
  TDMAMFiscal = class(TDataModule)
    ACBrECF1: TACBrECF;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    gCaixa, gPorta : String;
    gModelo : Integer;
    procedure LeArquivoINI;
  public
    { Public declarations }
    function Gerar_EspelhoMFD(pInicio,pFim,pArquivo:String;pinterval: Boolean):Boolean;stdcall;
    function Gerar_ArquivoMFD(pInicio,pFim,pArquivo:String;pinterval: Boolean):Boolean;stdcall;
    function Gerar_AtoCotepe(pInicio,pFim,pNomeArq:String;pinterval: Boolean):Boolean;stdcall;
  end;


var
  DMAMFiscal: TDMAMFiscal;

implementation

{$R *.dfm}

procedure TDMAMFiscal.DataModuleCreate(Sender: TObject);
begin
  if not ACBrECF1.Ativo then
  begin
    LeArquivoINI;
    ACBrECF1.Operador := gCaixa;
    ACBrECF1.Modelo   := TACBrECFModelo(gModelo);
    ACBrECF1.Porta    := gPorta;
    ACBrECF1.Ativar;
  end;

end;

procedure TDMAMFiscal.LeArquivoINI;
var ArqINI : TIniFile;
    aux : String;
    auxvalor : double;
begin
  if FileExists(ExtractFilePath(Application.ExeName)+'ArqVerifica.ini') then
  begin
    ArqINI  := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArqVerifica.ini');
    gPorta  := ArqIni.ReadString('PAFECF','Porta','');
    gCaixa  := ArqINI.ReadString('PAFECF','CAIXA','');
    gModelo := ArqINI.ReadInteger('PAFECF','Modelo',0);
    ArqINI.Free;
  end;
  
end;


procedure TDMAMFiscal.DataModuleDestroy(Sender: TObject);
begin
  ACBrECF1.Desativar;

end;

function TDMAMFiscal.Gerar_ArquivoMFD(pInicio,pFim,pArquivo:String;
  pinterval:Boolean):Boolean;
begin
  // pinterval - true  = por data
  //             false = por redução
  Result := true;
  try
    if pinterval then
       DMAMFiscal.ACBrECF1.ArquivoMFD_DLL(StrToDate(pInicio),StrToDate(pFim),pArquivo,[docTodos])
    else
       DMAMFiscal.ACBrECF1.ArquivoMFD_DLL(StrToInt(pInicio),StrToInt(pFim),pArquivo,[docTodos]);
  except
    Result := false;
  end;

end;

function TDMAMFiscal.Gerar_AtoCotepe(pInicio,pFim,pNomeArq:String;pinterval:Boolean):Boolean;
begin
  // pinterval - true  = por data
  //             false = por redução
  Result := true;
  try
    if pInterval then
       DMAMFiscal.ACBrECF1.PafMF_LMFC_Cotepe1704(StrToDate(pInicio),StrToDate(pFim),pNomeArq)
    else
       DMAMFiscal.ACBrECF1.PafMF_LMFC_Cotepe1704(StrToInt(pInicio),StrToInt(pFim),pNomeArq);
  except
    Result := false;
  end;

end;

function TDMAMFiscal.Gerar_EspelhoMFD(pInicio,pFim,pArquivo:String;
  pinterval:Boolean):Boolean;
begin
  // pinterval - true  = por data
  //             false = por redução
  Result := true;
  try
    if pinterval then
       DMAMFiscal.ACBrECF1.EspelhoMFD_DLL(StrToDate(pInicio),StrToDate(pFim),pArquivo,[docTodos])
    else
       DMAMFiscal.ACBrECF1.EspelhoMFD_DLL(StrToInt(pInicio),StrToInt(pFim),pArquivo,[docTodos]);
  except
    Result := false;
  end;

end;


end.
