CREATE DATABASE Ecommerce_dio;
use ecommerce_dio;

CREATE TABLE cliente(
	id INT AUTO_INCREMENT PRIMARY KEY,
    pnome VARCHAR(45) NOT NULL,
    unome VARCHAR(45) NOT NULL,
    endereco VARCHAR(45) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    cpf CHAR(11),
    CONSTRAINT unique_cpf_cliente UNIQUE(Cpf)
);

CREATE TABLE produto(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(40) NOT NULL,
	categoria VARCHAR(45),
	descricao VARCHAR(300) NOT NULL,
	valor DECIMAL(7,2) NOT NULL,
	avaliacao INT 
);
CREATE TABLE terceiro_vendedor(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome_fantasia VARCHAR(45) NOT NULL,
    cnpj VARCHAR(20) NOT NULL,
    cpf CHAR(11) NOT NULL,
	razao_social VARCHAR(45) NOT NULL,
	local VARCHAR(45) NOT NULL,
    CONSTRAINT UNIQUE unique_terceiro_vendedorCNPJ (cnpj),
    CONSTRAINT UNIQUE unique_terceiro_vendedorCPF (cpf),
    CONSTRAINT UNIQUE unique_terceiro_vendedorRZ (razao_social)
);
    
CREATE TABLE pagamento(
		id INT AUTO_INCREMENT,
		cliente_id INT,
		tipo CHAR(1) NULL,
		codigo_pix VARCHAR(70) DEFAULT NULL,
		codigo_bolet VARCHAR(70) DEFAULT NULL,
		nome_cartao VARCHAR(45) DEFAULT NULL,
		numero_cartao VARCHAR(45) DEFAULT NULL,
		data_validade_cartao VARCHAR(4) DEFAULT NULL,
		PRIMARY KEY(id, cliente_id),
		CONSTRAINT fk_pagamento_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);
    
CREATE TABLE pedido(
		id INT AUTO_INCREMENT,
		cliente_id INT,
		pagamento_id INT,
		status_peddido ENUM('Aguardando pagamento', 'Processando', 'Enviado', 'Entregue'),
		frete FLOAT,
		PRIMARY KEY (id,cliente_id,pagamento_id),
		CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(id),
		CONSTRAINT fk_pedido_pagamento FOREIGN KEY (pagamento_id) REFERENCES pagamento(id)
);
    
CREATE TABLE estoque(
		id INT AUTO_INCREMENT PRIMARY KEY,
        local VARCHAR(45),
        quantidade INT NOT NULL
);
    
CREATE TABLE fornecedor(
		id INT AUTO_INCREMENT PRIMARY KEY,
        razao_social VARCHAR(45) NOT NULL,
        cnpj VARCHAR(25) NOT NULL,
        contato VARCHAR(20),
        CONSTRAINT UNIQUE unique_cnpj (cnpj)
        
);
CREATE TABLE produtos_terceiroVendedor(
		terceiro_vendedor_id INT,
        produto_id INT,
        quantidade INT,
        PRIMARY KEY (terceiro_vendedor_id, produto_id),
        CONSTRAINT fk_terceiro_vendedor FOREIGN KEY (terceiro_vendedor_id) REFERENCES terceiro_vendedor(id),
		CONSTRAINT fk_produto_terceiro FOREIGN KEY (produto_id) REFERENCES produto(id)
        
);
CREATE TABLE produto_fornecedor(
		produto_id INT,
        fornecedor_id INT,
        PRIMARY KEY (produto_id, fornecedor_id),
        CONSTRAINT fk_produto_fornecedor FOREIGN KEY (produto_id) REFERENCES produto(id),
		CONSTRAINT fk_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id)
	);
CREATE TABLE produto_em_estoque(
		produto_id INT,
        estoque_id INT,
        quantidade INT NOT NULL,
        PRIMARY KEY (produto_id, estoque_id),
        CONSTRAINT fk_produto_estoque FOREIGN KEY (produto_id) REFERENCES produto(id),
		CONSTRAINT fk_estoque FOREIGN KEY (estoque_id) REFERENCES estoque(id)
);
CREATE TABLE produto_pedido(
		pedido_id INT,
        produto_id INT,
        quantidade INT NOT NULL,
        PRIMARY KEY (pedido_id, produto_id),
        CONSTRAINT fk_pedido FOREIGN KEY (pedido_id) REFERENCES pedido(id),
		CONSTRAINT fk_produtopedido FOREIGN KEY (produto_id) REFERENCES produto(id)
);


show tables;