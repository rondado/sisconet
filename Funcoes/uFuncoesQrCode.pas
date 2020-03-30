unit uFuncoesQrCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;


// Declaração Dll Daruma
function rVerificarImpressoraLigada_ECF_Daruma(): Integer; StdCall; External 'DarumaFramework.dll';
function regAlterarValor_Daruma(pszPathChave:string;pszValor:string):Integer; StdCall; External 'DarumaFramework.dll';
function rAssinarRSA_ECF_Daruma(pszPathArquivo:string;pszChavePrivada:string;pszAssinaturaGerada:string): Integer; StdCall; External 'DarumaFramework.dll';
function eGerarQrCodeArquivo_DUAL_DarumaFramework(stPath: String; stCodigo: String): Integer; StdCall; External 'DarumaFrameWork.dll';
function rGerarRelatorio_ECF_Daruma(szRelatorio:string; szTipo:string; szInicial:string; szFinal:string): Integer; StdCall; External 'DarumaFramework.dll';
function rEfetuarDownloadMFD_ECF_Daruma(pszTipo:string;pszInicial:string;pszFinal:string;pszNomeArquivo:string): Integer; StdCall; External 'DarumaFramework.dll';
function rEfetuarDownloadMF_ECF_Daruma(pszNomeArquivo:string): Integer; StdCall; External 'DarumaFramework.dll';

// Rotinas internas
procedure GravaQrCode(Path,Codigo:String); stdcall; export;
function GeraArqAC1704(pTipoDado,pInicio,pFim,pDestino:String;pDatai,pDataf:TDateTime):Boolean; stdcall; export;
function GeraArqMF(pDestino,pChave:String):Boolean; stdcall; export;
function GeraArqMFD(pDestino,pChave:String):Boolean; stdcall; export;

implementation

procedure GravaQrCode(Path,Codigo:String); stdcall; export;
var iRetorno : Integer;
begin
  iRetorno := eGerarQrCodeArquivo_DUAL_DarumaFramework(Path, Codigo);
  if (iRetorno <> 1) then
  begin
    Application.MessageBox('Erro ao gerar QrCode', 'Sistema', MB_OK + MB_ICONERROR);
  end;

end;


function GeraArqAC1704(pTipoDado,pInicio,pFim,pDestino:String;pDatai,
  pDataf:TDateTime):Boolean; stdcall; export;
var sTipo, sInicio, sFim, str_LocalArquivos, sArquivoSintegra, sArquivoNFP, sLocalChavePrivada: string;
    iTam, Int_Retorno:integer;
    sRelatorio, Str_Valor_PIS: String;
    Str_Valor_COFINS: String;
begin
  sRelatorio := 'MFD';

  iTam := length(sRelatorio);
  Delete(sRelatorio,iTam,1);

  str_LocalArquivos:= pDestino;
  if str_LocalArquivos <> '' then
  begin
    Int_Retorno := regAlterarValor_Daruma('START\LocalArquivosRelatorios',str_LocalArquivos);
  end;

  sTipo:= pTipoDado;

  Int_Retorno:= rVerificarImpressoraLigada_ECF_Daruma();
  If Int_Retorno = 1 Then
     Exit;
  //

  If ((sTipo = 'COO') or (sTipo = 'CRZ')) then
  begin
    sInicio:= pInicio;
    sFim:= pFim;
    Int_Retorno:= rGerarRelatorio_ECF_Daruma(sRelatorio,sTipo,sInicio,sFim);
  end
  else
  begin
    Int_Retorno:= rGerarRelatorio_ECF_Daruma(sRelatorio,sTipo,FormatDateTime('ddMMyyyy',pDatai),FormatDateTime('ddMMyyyy',pDataf));
  end;

  Result := false;
  if Int_Retorno = 0 then
     Result := true;

end;

function GeraArqMF(pDestino,pChave:String):Boolean; stdcall; export;
var Int_Retorno : Integer;
    Str_EAD, Arquivo : String;
    cArquivo : TextFile;
    cConteudoArquivo: string;
begin
  Result := false;
  Int_Retorno:= rVerificarImpressoraLigada_ECF_Daruma();
  If Int_Retorno = 1 Then
     Exit;
  //   
  Int_Retorno := rEfetuarDownloadMF_ECF_Daruma(pDestino);
  if Int_Retorno = 1 then
  begin
    //
    SetLength(Str_EAD,256);
    Int_Retorno := rAssinarRSA_ECF_Daruma(pDestino,pChave,Str_EAD);
    Arquivo := Copy(pDestino,1,length(pDestino)-4)+'.TXT';
    if Int_Retorno = 1 then
    begin
      // gera o arquivo TXT
      cConteudoArquivo := Str_EAD;
      AssignFile(cArquivo,Arquivo);
      ReWrite(cArquivo);
      WriteLn(cArquivo,cConteudoArquivo);
      CloseFile(cArquivo);
      Result := true;
    end;  
  end;

end;

function GeraArqMFD(pDestino,pChave:String):Boolean; stdcall; export;
var Int_Retorno : Integer;
    str_Inicial,str_Final, Str_EAD, Arquivo: string;
    cArquivo : TextFile;
    cConteudoArquivo: string;
begin
  Result := false;
  str_Inicial := FormatDateTime('ddMMyyyy',Now-30);
  str_Final   := FormatDateTime('ddMMyyyy',Now);
  Int_Retorno:= rVerificarImpressoraLigada_ECF_Daruma();
  If Int_Retorno = 1 Then
     Exit;
  //
  Int_Retorno := rEfetuarDownloadMFD_ECF_Daruma('DATAM', str_Inicial, str_Final, pDestino);
  if Int_Retorno = 0 then
  begin
    SetLength(Str_EAD,256);
    Int_Retorno := rAssinarRSA_ECF_Daruma(pDestino,pChave,Str_EAD);
    Arquivo := Copy(pDestino,1,length(pDestino)-4)+'.TXT';
    if Int_Retorno = 1 then
    begin
      // gera o arquivo TXT
      cConteudoArquivo := Str_EAD;
      AssignFile(cArquivo,Arquivo);
      ReWrite(cArquivo);
      WriteLn(cArquivo,cConteudoArquivo);
      CloseFile(cArquivo);
      Result := true;
    end;
  end;

end;

end.
