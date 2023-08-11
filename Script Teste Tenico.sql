Create Database TesteDelphi

-- Tabela Cliente

CREATE TABLE TAB_CLIENTE
(
  COD_CLIENTE    INT PRIMARY KEY IDENTITY(1,1),
  COD_STATUS     INT NOT NULL,
  DES_NOME       VARCHAR(50) NOT NULL, 
  DES_CPF        VARCHAR(12), 
  DTA_NASCIMENTO DATETIME,
  CONSTRAINT UQ_CPF UNIQUE (DES_CPF)
);

INSERT INTO TAB_CLIENTE (COD_STATUS, DES_NOME, DES_CPF, DTA_NASCIMENTO) values (0, 'ALVARO VIEIRA', '58422714604', '08/01/1966');
INSERT INTO TAB_CLIENTE (COD_STATUS, DES_NOME, DES_CPF, DTA_NASCIMENTO) values (0, 'ANA CRISTINA GODOY', '58452575491', '15/07/1970');

-- Tabela Fornecedor

CREATE TABLE TAB_FORNECEDOR
(
  COD_FORNECEDOR    INT PRIMARY KEY IDENTITY(1,1),
  COD_STATUS        INT NOT NULL,
  DES_RAZAO_SOCIAL  VARCHAR(50) NOT NULL, 
  DES_NOME_FANTASIA VARCHAR(50), 
  DES_CNPJ          VARCHAR(19) 
);

INSERT INTO TAB_FORNECEDOR (COD_STATUS, DES_RAZAO_SOCIAL, DES_NOME_FANTASIA, DES_CNPJ) values (0, 'PRIMUS TURISMO', 'PRIMUS', '21150875000142');
INSERT INTO TAB_FORNECEDOR (COD_STATUS, DES_RAZAO_SOCIAL, DES_NOME_FANTASIA, DES_CNPJ) values (0, 'AMV INFORMATICA LTDA', 'AMV INFO', '64238959000142');

-- Tabela Produto

CREATE TABLE TAB_PRODUTO
(
  COD_PRODUTO        INT PRIMARY KEY IDENTITY(1,1),
  COD_STATUS         INT NOT NULL,
  DES_DESCRICAO      VARCHAR(50), 
  VAL_PRECO_UNITARIO FLOAT, 
  COD_FORNECEDOR     INT NOT NULL, 
  CONSTRAINT TAB_PRODUTO_FK_FORNECEDOR FOREIGN KEY (COD_FORNECEDOR) REFERENCES TAB_FORNECEDOR(COD_FORNECEDOR) ON DELETE cascade 
);

INSERT INTO TAB_PRODUTO (COD_STATUS, DES_DESCRICAO, VAL_PRECO_UNITARIO, COD_FORNECEDOR) values (0, 'PACOTE PORTO SEGURO', '1500', 1);
INSERT INTO TAB_PRODUTO (COD_STATUS, DES_DESCRICAO, VAL_PRECO_UNITARIO, COD_FORNECEDOR) values (0, 'PACOTE OFFICE 365', '1500.30', 2);


-- Tabela Venda

CREATE TABLE TAB_VENDA (
  COD_VENDA INT PRIMARY KEY IDENTITY(1,1),
  COD_CLIENTE INT NOT NULL,
  DTA_VENDA DATETIME,
  VAL_TOTAL_VENDA FLOAT, 
  COD_STATUS INT
);

-- Tabela Venda_Produto

CREATE TABLE TAB_VENDA_ITENS (
  ID_ITEM INT PRIMARY KEY IDENTITY(1,1),
  COD_VENDA INT NOT NULL,
  COD_PRODUTO INT NOT NULL,
  DES_DESCRICAO VARCHAR(50), 
  VAL_PRECO_UNITARIO FLOAT, 
  VAL_QUANTIDADE INT NOT NULL,
  VAL_TOTAL_VENDA FLOAT,
  CONSTRAINT TAB_VENDA_ITENS_FK_VENDA FOREIGN KEY (COD_VENDA) REFERENCES TAB_VENDA(COD_VENDA) ON DELETE cascade,
  CONSTRAINT TAB_VENDA_ITENS_FK_PRODUTO FOREIGN KEY (COD_PRODUTO) REFERENCES TAB_PRODUTO(COD_PRODUTO) ON DELETE cascade 
);




