CREATE DATABASE OficinaDIO;
USE OficinaDIO;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Pnome VARCHAR(15) NOT NULL,
    Snome VARCHAR(15) NOT NULL,
    Endereco VARCHAR(45) NOT NULL,
    Telefone CHAR(11) NOT NULL
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    idPlaca CHAR(7) PRIMARY KEY,
    Cliente_idCliente INT,
    Modelo VARCHAR(30),
    Cor VARCHAR(20),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Mecanico
CREATE TABLE Mecanico (
    idCodigo INT AUTO_INCREMENT PRIMARY KEY,
    Pnome VARCHAR(15),
    Snome varchar(15),
    Especialidade VARCHAR(45)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    Mecanico_idCodigo INT,
    FOREIGN KEY (Mecanico_idCodigo) REFERENCES Mecanico(idCodigo)
);

-- Tabela Oficina
CREATE TABLE Oficina (
    idOficina INT AUTO_INCREMENT PRIMARY KEY,
    Endereco VARCHAR(50),
    CNPJ VARCHAR(14),
    Conserto VARCHAR(200),
    Revisao VARCHAR(200)
);

-- Tabela Tabela de Referência
CREATE TABLE TabelaReferencia (
    idTabelaReferencia INT AUTO_INCREMENT PRIMARY KEY,
    MaoDeObra DECIMAL(10, 2),
    ValorPecas DECIMAL(10, 2)
);

-- Tabela Ordem de Servico
CREATE TABLE OrdemServico (
    idNumero INT AUTO_INCREMENT PRIMARY KEY,
    DataEmissao DATE,
    DataConclusao DATE,
    Veiculo_idPlaca VARCHAR(10),
    Equipe_idEquipe INT,
    TabelaReferencia_idTabelaReferencia INT,
    Status VARCHAR(50),
    FOREIGN KEY (Veiculo_idPlaca) REFERENCES Veiculo(idPlaca),
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe),
    FOREIGN KEY (TabelaReferencia_idTabelaReferencia) REFERENCES TabelaReferencia(idTabelaReferencia)
);

-- Tabela Peca
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100),
    ValorUnitario DECIMAL(10, 2)
);

-- Tabela Relacionamento Peca/Ordem de Servico
CREATE TABLE RelacionamentoPecaOS (
    OrdemServico_idNumero INT,
    Peca_idPeca INT,
    PRIMARY KEY (OrdemServico_idNumero, Peca_idPeca),
    FOREIGN KEY (OrdemServico_idNumero) REFERENCES OrdemServico(idNumero),
    FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca)
);

-- Inserção de dados para testes
INSERT INTO Cliente (Nome, Endereco, Telefone) VALUES ('João Silva', 'Rua A, 123', '9999-1234'), ('Maria Oliveira', 'Rua B, 456', '9888-5678');

INSERT INTO Veiculo (idPlaca, Cliente_idCliente, Modelo, Cor) VALUES ('ABC1234', 1, 'Civic', 'Preto'), ('DEF5678', 2, 'Corolla', 'Branco');

INSERT INTO Mecanico (Nome, Especialidade) VALUES ('Carlos Santos', 'Suspensão'), ('Bruno Ribeiro', 'Motor');

INSERT INTO Equipe (Mecanico_idCodigo) VALUES (1), (2);

INSERT INTO Oficina (Endereco, CNPJ, Conserto, Revisao) VALUES ('Rua Oficina, 10', '12.345.678/0001-90', 'Freio', 'Revisão geral');

INSERT INTO TabelaReferencia (MaoDeObra, ValorPecas) VALUES (200.00, 500.00), (300.00, 1200.00);

INSERT INTO OrdemServico (DataEmissao, DataConclusao, Veiculo_idPlaca, Equipe_idEquipe, TabelaReferencia_idTabelaReferencia, Status) VALUES
('2025-01-01', '2025-01-05', 'ABC1234', 1, 1, 'Concluído'),
('2025-01-10', '2025-01-15', 'DEF5678', 2, 2, 'Pendente');

INSERT INTO Peca (Descricao, ValorUnitario) VALUES ('Filtro de óleo', 50.00), ('Pastilha de freio', 150.00);

INSERT INTO RelacionamentoPecaOS (OrdemServico_idNumero, Peca_idPeca) VALUES
(1, 1),
(1, 2),
(2, 1);


-- Recuperação simples
SELECT * FROM Cliente;

-- Filtro com WHERE
SELECT * FROM OrdemServico WHERE Status = 'Concluído';

-- Expressão para gerar atributos derivados
SELECT idNumero, DataEmissao, DataConclusao, 
       DATEDIFF(DataConclusao, DataEmissao) AS DiasExecucao 
FROM OrdemServico;

-- Ordenação dos dados
SELECT * FROM Peca ORDER BY ValorUnitario DESC;

-- Filtro por grupos com HAVING
SELECT Equipe_idEquipe, COUNT(*) AS TotalServicos
FROM OrdemServico
GROUP BY Equipe_idEquipe
HAVING COUNT(*) > 1;
