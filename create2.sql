PRAGMA FOREIGN_KEYS = ON;

CREATE TABLE UTILIZADOR 
(
    ID NUMERIC(8,0) NOT NULL PRIMARY KEY, 
    NOME_COMPLETO VARCHAR(100) NOT NULL,
    NOME_UTILIZADOR VARCHAR(25) NOT NULL,
    EMAIL VARCHAR(100) NOT NULL UNIQUE,
    DATA_NASCIMENTO DATE NOT NULL,
    PALAVRA_PASSE VARCHAR(25) NOT NULL,
    GENERO VARCHAR(8) DEFAULT '-' CHECK (GENERO IN ('FEMININO','MASCULINO','OUTRO')),
    PAIS VARCHAR(50) DEFAULT '-',
    FOTO TEXT,
    BIOGRAFIA TEXT
);

CREATE TABLE LEITOR (
    ID NUMERIC(8,0) NOT NULL PRIMARY KEY,
    FOREIGN KEY (ID) REFERENCES UTILIZADOR(ID) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE AUTOR (
    ID NUMERIC(8,0) NOT NULL PRIMARY KEY,
    FOREIGN KEY (ID) REFERENCES UTILIZADOR(ID) ON DELETE CASCADE ON UPDATE CASCADE
    
);

CREATE TABLE LIVRO (
    ISBN NUMERIC(13,0) NOT NULL PRIMARY KEY,
    TITULO VARCHAR(50) NOT NULL,
    EDICAO INT NOT NULL, 
    DATA_LANCAMENTO DATE NOT NULL,
    NUMERO_DE_PAGINAS INT NOT NULL

);

CREATE TABLE EDITORA (
    NOME VARCHAR(50) NOT NULL PRIMARY KEY,
    DATA_DE_FUNDACAO DATE

);

CREATE TABLE COLECAO (
    NOME VARCHAR(50) NOT NULL PRIMARY KEY
);

CREATE TABLE GENERO (
    NOME VARCHAR(10) NOT NULL PRIMARY KEY CHECK(NOME IN ('ARTE', 'AUTO AJUDA', 'CIENCIA', 'FANTASIA', 'INFANTIL', 'NAO FICCAO', 'ROMANCE', 'TERROR'))
);

CREATE TABLE GRUPO (
    NOME VARCHAR(50) NOT NULL PRIMARY KEY,
    DESCRICAO TEXT,
    INFORMACOES TEXT
);

CREATE TABLE PUBLICACAO (
    ID_PUBLICACAO NUMERIC(8, 0) NOT NULL PRIMARY KEY, 
    TITULO VARCHAR(25) NOT NULL,
    DATA_E_HORA DATETIME NOT NULL,
    CONTEUDO TEXT NOT NULL
);

CREATE TABLE AMIGO (
    ID1 NUMERIC(8, 0) NOT NULL,
    ID2 NUMERIC(8, 0) NOT NULL CHECK (ID1 <> ID2),
    PRIMARY KEY (ID1, ID2),
    FOREIGN KEY (ID1) REFERENCES UTILIZADOR(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID2) REFERENCES UTILIZADOR(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PERTENCE_GRUPO (
    ID NUMERIC(8,0) NOT NULL,
    NOME VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID, NOME),
    FOREIGN KEY (ID) REFERENCES UTILIZADOR(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NOME) REFERENCES GRUPO(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PERTENCE_COLECAO (
    ISBN NUMERIC(13,0) NOT NULL PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    FOREIGN KEY (ISBN) REFERENCES LIVRO(ISBN) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NOME) REFERENCES COLECAO(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ESCREVEU (
    ID NUMERIC(8,0) NOT NULL,
    ISBN NUMERIC(13,0) NOT NULL,
    PRIMARY KEY (ID, ISBN),
    FOREIGN KEY (ID) REFERENCES AUTOR(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES LIVRO(ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LANCOU (
    ISBN NUMERIC(13,0) NOT NULL PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    FOREIGN KEY (ISBN) REFERENCES LIVRO(ISBN) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NOME) REFERENCES EDITORA(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE INSERIDO (
    ISBN NUMERIC(13,0) NOT NULL,
    NOME VARCHAR(50) NOT NULL,
    PRIMARY KEY (ISBN, NOME),
    FOREIGN KEY (ISBN) REFERENCES LIVRO(ISBN) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NOME) REFERENCES GENERO(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PREFERIDO(
    ID NUMERIC(8,0) NOT NULL,
    NOME VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID, NOME),
    FOREIGN KEY (ID) REFERENCES LEITOR(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NOME) REFERENCES GENERO(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PUBLICADO_EM(
    ID_PUBLICACAO NUMERIC(8,0) NOT NULL PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_PUBLICACAO) REFERENCES PUBLICACAO(ID_PUBLICACAO) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NOME) REFERENCES GRUPO(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PUBLICOU(
    ID_PUBLICACAO NUMERIC(8,0) NOT NULL PRIMARY KEY,
    ID NUMERIC(8,0) NOT NULL,
    FOREIGN KEY (ID_PUBLICACAO) REFERENCES PUBLICACAO(ID_PUBLICACAO) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID) REFERENCES UTILIZADOR(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SEGUIDOR(
    ID1 NUMERIC(8,0) NOT NULL,
    ID2 NUMERIC(8,0) NOT NULL CHECK (ID1 <> ID2),
    PRIMARY KEY (ID1, ID2),
    FOREIGN KEY (ID1) REFERENCES LEITOR(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID2) REFERENCES AUTOR(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LEITURA_ATUAL(
    ISBN NUMERIC(13,0) NOT NULL,
    ID NUMERIC(8,0) NOT NULL,
    DATA_DE_INICIO DATE,
    PAGINA_ATUAL INT,
    PERCENTAGEM NUMERIC(3,0) CHECK(PERCENTAGEM >= 0 AND PERCENTAGEM <= 100),   -- NO GOODREADS O UTILIZADOR PODE ATUALIZAR POR PERCENTAGEM (ELA NAO E CALCULADA)
    PRIMARY KEY (ISBN, ID),
    FOREIGN KEY (ISBN) REFERENCES LIVRO(ISBN) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID) REFERENCES LEITOR(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LEITURA(
    ISBN NUMERIC(13,0) NOT NULL,
    ID NUMERIC(8,0) NOT NULL,
    DATA_DE_INICIO DATE,
    DATA_DE_CONCLUSAO DATE,
    CLASSIFICACAO VARCHAR(5) DEFAULT '☆☆☆☆☆' CHECK (CLASSIFICACAO IN ('★☆☆☆☆','★★☆☆☆','★★★☆☆','★★★★☆','★★★★★')),
    REVIEW TEXT,
    PRIMARY KEY (ISBN, ID),
    FOREIGN KEY (ISBN) REFERENCES LIVRO(ISBN) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID) REFERENCES LEITOR(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LISTA_DE_LEITURA(
    ISBN NUMERIC(13,0) NOT NULL,
    ID NUMERIC(8,0) NOT NULL,
    TITULO VARCHAR(25) NOT NULL, 
    PRIMARY KEY (ISBN, ID),
    FOREIGN KEY (ISBN) REFERENCES LIVRO(ISBN) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (ID) REFERENCES LEITOR(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

