SET NAMES NONE;

SET CLIENTLIB 'C:\Sisconet18\Exec\fbclient.dll';

CONNECT 'C:\Sisconet18\Exec\Dados\DADOS.FDB' USER 'SYSDBA' PASSWORD 'masterkey';


CREATE TABLE xmlcfg (
    idDFe integer NOT NULL PRIMARY KEY, 
    ultNSU integer,
    TimeInterval integer DEFAULT 1000,
    idDFeAutoInc INTEGER DEFAULT 0,
    AutoExecute INTEGER DEFAULT 0,
    AutoTimer INTEGER DEFAULT 1
);

CREATE TABLE xmlnfe (
    idDFe integer NOT NULL PRIMARY KEY,
    xNumeroNFe varchar (10), 
    xSerie varchar (3), 
    chNFe varchar (44), 
    CNPJCPF varchar (14), 
    xNome varchar (100), 
    IE varchar (18), 
    dhEmi timestamp,
    tpNF integer, 
    vNF numeric (18, 2) DEFAULT 0,
    digVal varchar (100), 
    dhRecbto timestamp,
    nProt varchar (20), 
    cSitNFe integer, 
    NSU integer, 
    NFe varchar (1) DEFAULT 'F',
    DFe varchar (1) DEFAULT 'F',
    IDEMPRESA integer NOT NULL
);

ALTER TABLE XMLCFG
ADD CONSTRAINT FK_XMLCFG_1
FOREIGN KEY (IDDFE)
REFERENCES EMPRESA(ID);

ALTER TABLE XMLNFE
ADD CONSTRAINT FK_XMLNFE_1
FOREIGN KEY (IDEMPRESA)
REFERENCES XMLCFG(IDDFE);

