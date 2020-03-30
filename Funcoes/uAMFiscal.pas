unit uAMFiscal;

interface

uses
  SysUtils, Classes, ACBrBase, ACBrECF, IniFiles, Forms, ACBrDevice;

function Gerar_EspelhoMFD(pDatai,pDataf:TDateTime;pInicio,pFim,pArquivo:String;pinterval: Boolean):Boolean;stdcall;
function Gerar_ArquivoMFD(pDatai,pDataf:TDateTime;pInicio,pFim,pArquivo:String;pinterval: Boolean):Boolean;stdcall;
function Gerar_AtoCotepe(pDatai,pDataf:TDateTime;pInicio,pFim,pNomeArq:String;pinterval: Boolean):Boolean;stdcall;

implementation

uses uDMAMFiscal;

function Gerar_ArquivoMFD(pDatai,pDataf:TDateTime;pInicio,pFim,pArquivo:String;
  pinterval:Boolean):Boolean;
begin
  // pinterval - true  = por data
  //             false = por redução
  Result := true;
  try
    if pinterval then
       DMAMFiscal.ACBrECF1.ArquivoMFD_DLL(pDatai,pDataf,pArquivo,[docTodos])
    else
       DMAMFiscal.ACBrECF1.ArquivoMFD_DLL(StrToInt(pInicio),StrToInt(pFim),pArquivo,[docTodos]);
  except
    Result := false;
  end;

end;

function Gerar_AtoCotepe(pDatai,pDataf:TDateTime;pInicio,pFim,pNomeArq:String;pinterval:Boolean):Boolean;
begin
  // pinterval - true  = por data
  //             false = por redução
  Result := true;
  try
    if pInterval then
       DMAMFiscal.ACBrECF1.PafMF_LMFC_Cotepe1704(pDatai,pDataf,pNomeArq)
    else
       DMAMFiscal.ACBrECF1.PafMF_LMFC_Cotepe1704(StrToInt(pInicio),StrToInt(pFim),pNomeArq);
  except
    Result := false;
  end;



end;

function Gerar_EspelhoMFD(pDatai,pDataf:TDateTime;pInicio,pFim,pArquivo:String;
  pinterval:Boolean):Boolean;
begin
  // pinterval - true  = por data
  //             false = por redução
  Result := true;
  try
    if pinterval then
       DMAMFiscal.ACBrECF1.EspelhoMFD_DLL(pDatai,pDataf,pArquivo,[docTodos])
    else
       DMAMFiscal.ACBrECF1.EspelhoMFD_DLL(StrToInt(pInicio),StrToInt(pFim),pArquivo,[docTodos]);
  except
    Result := false;
  end;

end;


end.
