CREATE TABLE USUARIOS (
	ID INTEGER PRIMARY KEY NOT NULL,
	STR_DIR_IMG TEXT ,
	STR_NOME VARCHAR(100) NOT NULL ,
	STR_CELULAR VARCHAR(50) NOT NULL ,
	STR_EMAIL VARCHAR(100) NOT NULL  ,
	STR_GENERO CHAR(1) NOT NULL ,
	INT_CGC INT NOT NULL  ,
	STR_SENHA TEXT NOT NULL  ,
	DAT_NASC DATE NOT NULL  ,
	DAT_CADASTRO DATE NULL DEFAULT current_timestamp
);

--DATE DATA E HORA
--CURRENT_TIMESTAMPEGA DATA/HORA DO SISTEMA POR PADRÃO
--CGC - CNPJ OU CPF

CREATE TABLE ONGS (
	ID INT PRIMARY KEY not null,
	STR_DIR_IMG TEXT ,
	STR_NOME VARCHAR(100) NOT NULL ,
	STR_DESC TEXT ,
	STR_TELEFONE VARCHAR(50) NOT NULL ,
	STR_EMAIL VARCHAR(100) NOT NULL  ,
	INT_CNPJ INT NOT NULL  ,
	DAT_CADASTRO DATE NULL DEFAULT current_timestamp
);

CREATE TABLE ENDERECO (
	ID INT PRIMARY KEY NOT NULL,
	STR_CEP CHAR(9) ,
	STR_LOGRADOURO VARCHAR(100) ,
	STR_BAIRRO VARCHAR(100) ,
	STR_NUMERO VARCHAR(20) ,
	STR_CIDADE VARCHAR(50) ,
	STR_ESTADO CHAR(2) ,
	STR_ORIGEM VARCHAR(20) ,
	ID_ORIGEM INT ,
	DAT_CADASTRO DATE NULL DEFAULT current_timestamp
);

--TABELA PARA QUEM FOR UTILIZAR OS RECURSOS DA ONG E NÃO POSSUEM TODOS OS DADOS, COMO OS MORADORES DE RUA.
--COMO MORADORES DE RUAS N POSSUEM CEL OU EMAIL NAO É OBRIGATÓRIO
CREATE TABLE BENEFICIARIOS(
	ID INT PRIMARY KEY NOT NULL,
	STR_NOME VARCHAR(100) NOT NULL ,
	STR_CELULAR VARCHAR(50) ,
	STR_EMAIL VARCHAR(100) ,
	STR_GENERO CHAR(1) NOT NULL ,
	INT_CGC INT NOT NULL  ,
	DAT_NASC DATE NOT NULL  ,
	DAT_CADASTRO DATE NULL DEFAULT current_timestamp
);

CREATE TABLE BENEFICIARIOS_ONGS(
	ID INT PRIMARY KEY NOT NULL,
	ID_BENEFICIARIO INT REFERENCES BENEFICIARIOS(ID),
	ID_ONG INT REFERENCES ONGS(ID)
);

CREATE TABLE PROJETOS(
	ID INT PRIMARY KEY NOT NULL,
	STR_DESC TEXT ,
	ID_USUARIO INT REFERENCES USUARIOS(ID),
	ID_ONG INT REFERENCES ONGS(ID),
	DAT_INICIO DATE NOT NULL  ,
	DAT_FIM DATE
);

CREATE TABLE POSTAGENS(
	ID INT PRIMARY KEY NOT NULL,
	STR_TEXTO TEXT ,
	ID_USUARIO INT REFERENCES USUARIOS(ID),
	DAT_DATA DATE NULL DEFAULT current_timestamp
);

--TABELA ONDE IRÁ TODOS OS ARQUIVOS DE POSTAGENS E PROJETOS
--COMO O ID DE USUARIO JÁ ESTÁ RELACIONADO COM O PROJETO OU POSTAGEM NÃO PRECISA REPETIR
CREATE TABLE ARQUIVOS(
	ID INT PRIMARY KEY NOT NULL,
	STR_DIR TEXT NOT NULL ,
	STR_DESC_FT TEXT ,
	ID_PROJETO INT REFERENCES PROJETOS(ID),
	STR_ORIGEM VARCHAR(20) ,
	ID_ORIGEM INT
);

--TABELA PARA COMENTARIOS DE UMA POSTAGEM OU PROJETO
--STR_ORIGEM PEGA O NOME DA TABELA PRA VER SE É POSTAGEM OU PROJETO EM QUE FOI COMENTADO
--ID-ORIGEM PEGA O ID DO PROJETO OU POSTAGEM
--ID-USUARIO QUEM FEZ O COMENTARIO
CREATE TABLE COMENTARIOS(
	ID INT PRIMARY KEY NOT NULL,
	STR_COMENT TEXT ,
	DAT_DATA DATE NULL DEFAULT current_timestamp ,
	ID_USUARIO INT REFERENCES USUARIOS(ID),
	STR_ORIGEM VARCHAR(20) ,
	ID_ORIGEM INT
);

--TABELA DE CURTIDAS ONDE PODE SER DE UM COMENTÁRIO OU DE UMA POSTAGEM
CREATE TABLE CURTIDAS(
	ID INT PRIMARY KEY NOT NULL,
	ID_USUARIO INT REFERENCES USUARIOS(ID),
	STR_ORIGEM VARCHAR(20) ,
	ID_ORIGEM INT ,
	DAT_DATA DATE NULL DEFAULT current_timestamp
);