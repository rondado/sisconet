// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://desenvolvimento.setrem.com.br/wscep/wsCEP.exe/wsdl/ICEP
// Encoding : utf-8
// Version  : 1.0
// (01/06/2008 11:55:21 - 1.33.2.5)
// ************************************************************************ //

unit ICEP1;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"


  // ************************************************************************ //
  // Namespace : urn:CEPIntf-ICEP
  // soapAction: urn:CEPIntf-ICEP#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : ICEPbinding
  // service   : ICEPservice
  // port      : ICEPPort
  // URL       : http://desenvolvimento.setrem.com.br/wscep/wsCEP.exe/soap/ICEP
  // ************************************************************************ //
  ICEP = interface(IInvokable)
  ['{A68EF93D-CDE5-5E89-6766-97C9DDB9CB0E}']
    function  LogradourosPorCep(const CEP: WideString): WideString; stdcall;
    function  LogradourosPorNome(const Descricao: WideString; const UF: WideString; const TotalRegistrosRetorno: WideString): WideString; stdcall;
  end;


function GetICEP(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ICEP;


implementation

function GetICEP(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ICEP;
const
  defWSDL = 'http://desenvolvimento.setrem.com.br/wscep/wsCEP.exe/wsdl/ICEP';
  defURL  = 'http://desenvolvimento.setrem.com.br/wscep/wsCEP.exe/soap/ICEP';
  defSvc  = 'ICEPservice';
  defPrt  = 'ICEPPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ICEP);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(ICEP), 'urn:CEPIntf-ICEP', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ICEP), 'urn:CEPIntf-ICEP#%operationName%');

end. 