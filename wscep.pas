// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Artigo Novo\Fontes\wscep.xml
// Encoding : ISO-8859-1
// Version  : 1.0
// (29/11/2007 11:25:09 - 1.33.2.5)
// ************************************************************************ //

unit wscep;

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
  // !:integer         - "http://www.w3.org/2001/XMLSchema"


  // ************************************************************************ //
  // Namespace : urn:cepwsdl
  // soapAction: urn:cepwsdl#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : cepwsdlBinding
  // service   : cepwsdl
  // port      : cepwsdlPort
  // URL       : http://www.bases4you.com/wscep.php
  // ************************************************************************ //
  cepwsdlPortType = interface(IInvokable)
  ['{3E7EC10C-CAC0-3F39-B591-CA8F8E9208FB}']
    procedure ConsultarCEP(const user: WideString; const pass: WideString; const cep: WideString; out endereco: WideString; out bairro: WideString; out cidade: WideString; out uf: WideString); stdcall;
    procedure ObterCEP(const user: WideString; const pass: WideString; const endereco: WideString; const cidade: WideString; const uf: WideString; const startrecord: integer; out qtdrecords: integer; out cep_1: WideString; out bairro_1: WideString; out endereco_1: WideString; 
                       out cep_2: WideString; out bairro_2: WideString; out endereco_2: WideString; out cep_3: WideString; out bairro_3: WideString; out endereco_3: WideString); stdcall;
  end;

function GetcepwsdlPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): cepwsdlPortType;


implementation

function GetcepwsdlPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): cepwsdlPortType;
const
  defWSDL = 'C:\Artigo Novo\Fontes\wscep.xml';
  defURL  = 'http://www.bases4you.com/wscep.php';
  defSvc  = 'cepwsdl';
  defPrt  = 'cepwsdlPort';
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
    Result := (RIO as cepwsdlPortType);
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
  InvRegistry.RegisterInterface(TypeInfo(cepwsdlPortType), 'urn:cepwsdl', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(cepwsdlPortType), 'urn:cepwsdl#%operationName%');

end. 