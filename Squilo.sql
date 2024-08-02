
CREATE DATABASE ciber -- Cria um banco de dados ciber
go -- espera o programa chegar la
USE ciber  -- vai pro database ciber
go
CREATE TABLE Sala(
	IDSala INT NOT NULL PRIMARY KEY,
	Nome VARCHAR(50) NOT NULL,
	Capacidade INT NOT NULL,
);

--USE master
--DROP TABLE Sala -- Exclui a sala
--DROP DATABASE ciber


INSERT INTO Sala VALUES(1, 'CIBER', 20) -- Colocar dados na tabela
INSERT INTO Sala (IDSala, Nome, Capacidade) VALUES (2, 'SISTEMAS', 30) -- Selecionar quais colunas quer usar
INSERT INTO Sala VALUES (3, 'PARA', 40),(4, 'AUTOMACOES', 50) -- Da para colocar valores diferentes

SELECT * FROM Sala -- Select mostra alguma coisa na tela ; * mostrar todas as colunas 
SELECT Nome, Capacidade FROM Sala -- Mostra as colunas selecionadas

SELECT * FROM Sala
order by Capacidade desc -- Mostrar na ordem decrescente

SELECT * FROM Sala
order by Nome -- Mostra na ordem crescente (normal)

SELECT * FROM Sala
order by Capacidade, Nome desc -- "Desempate pra organizar"

SELECT * FROM Sala WHERE Capacidade > 20 AND Capacidade < 30 -- Seleciona oq mostrar com base em algo

--------

CREATE TABLE Evento(
	IDEvento INT NOT NULL PRIMARY KEY,
	IDSala INT NOT NULL FOREIGN KEY REFERENCES Sala(IDSala), -- vai referenciar outra tabela -- Tabela(Coluna)
	Descricao VARCHAR(100) NOT NULL,
	DtHrInicio DATETIME NOT NULL,
	DtHrFim DATETIME NOT NULL,
);

INSERT INTO Evento VALUES (1, 2, 'sisteminhas sistemicos', '01-08-2024 13:01', '01-08-2024 13:02')
INSERT INTO Evento VALUES (
	(SELECT MAX(IDEvento) FROM Evento)+1, -- Pega o maior valor e coloca mais um (genial isso)
	3,
	'pararaa',
	'01-08-2024 13:01',
	'01-08-2024 13:02')

SELECT * FROM Evento
SELECT descricao 'Nome do evento' FROM Evento -- Da um "apelido"
---------

CREATE TABLE Equipamento(
	IDEquipamento INT NOT NULL PRIMARY KEY,
	IDSala INT FOREIGN KEY REFERENCES Sala(IDSala),
	Nome VARCHAR(50) NOT NULL,
	Tipo VARCHAR(100) NOT NULL,
);

INSERT INTO Equipamento (IDEquipamento, Nome, Tipo) VALUES (1,'luz','lalala')
INSERT INTO Equipamento VALUES (
	ISNULL((SELECT MAX(IDEquipamento) FROM Equipamento)+1,1), -- se for o primeiro ID ele vai comecar no 1
	2,'camera','lilili')

SELECT * FROM Equipamento


-- Como escloir
TRUNCATE TABLE Equipamento -- Exclui tudo que tem na tabela
DELETE FROM Equipamento WHERE IDEquipamento = 1 -- Exclui linha especifica
DROP TABLE Equipamento -- Exclui tabela

----------------------------

CREATE TABLE Aluno (
    IDAluno INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- Identity comeca no 1 e vai de 1 em 1
    Nome VARCHAR(255) NOT NULL,
    Idade INT,
    Nacionalidade VARCHAR(255) DEFAULT 'Brasil', -- Se deixar nulo coloca brasil
    CHECK (Idade>=18)
);





SELECT * FROM Evento
WHERE GETDATE() BETWEEN DthrInicio AND DtHrFim

UPDATE EVENTO SET
	DtHrInicio = '01-08-2024 13:00', DtHrFim = '01-08-2024 17:00'
	WHERE IDEvento = '01964C5JMFTJ'

SELECT
    CONVERT(VARCHAR(10), IDEvento, 103)
	FROM EVENTO


SELECT
	IDEvento,
	Descricao 'Descri��o do Evento',
    CONVERT(VARCHAR(10), DtHrInicio, 103) AS 'Data Inicio',
    CONVERT(VARCHAR(5), DtHrInicio, 108) AS 'Hora Inicio',
	CONVERT(VARCHAR(10), DtHrFim, 103) AS 'Data Fim',
    CONVERT(VARCHAR(5), DtHrFim, 108) AS 'Hora Fim',
	S.Nome 'Nome da Sala'
FROM Evento E 
	LEFT JOIN Sala S 
	ON E.IDSala = S.IDSala


SELECT * FROM Evento E -- apelido de E pra tabela Evento
	LEFT JOIN Sala S -- Apelido de S pra tabela Sala
	ON E.IDSala = S.IDSala -- Junta onde os IDs sao iguais

	
SELECT
	E.Descricao, -- Pega a descricao da tabela E
	S.Capacidade -- Pega a capacidade da tabela S
FROM Evento E 
	LEFT JOIN Sala S 
	ON E.IDSala = S.IDSala
ORDER BY S.Nome



CREATE TABLE Sala(
	IDSala INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Capacidade INT NOT NULL,
);

CREATE TABLE Evento(
	IDEvento INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDSala INT NOT NULL FOREIGN KEY REFERENCES Sala(IDSala), -- vai referenciar outra tabela -- Tabela(Coluna)
	Descricao VARCHAR(100) NOT NULL,
	DtHrInicio DATETIME NOT NULL,
	DtHrFim DATETIME NOT NULL,
);

CREATE TABLE Equipamento(
	IDEquipamento INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDSala INT FOREIGN KEY REFERENCES Sala(IDSala),
	Nome VARCHAR(50) NOT NULL,
	Tipo VARCHAR(100) NOT NULL,
);

CREATE TABLE EventoEquipamento(
	IDEventoEquipamento INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDEvento INT FOREIGN KEY REFERENCES Evento(IDEvento),
	IDEquipamento INT FOREIGN KEY REFERENCES Equipamento(IDEquipamento),
);

CREATE TABLE Pessoa(
	IDPessoa INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Categoria VARCHAR(20) NOT NULL,
);

CREATE TABLE EventoPessoa(
	IDEventoPessoa INT IDENTITY(1,1) PRIMARY KEY,
	IDEvento INT FOREIGN KEY REFERENCES Evento(IDEvento),
	IDPessoa INT FOREIGN KEY REFERENCES Pessoa(IDPessoa),
	PapelEvento VARCHAR(75) NOT NULL, 
	Presenca BIT NOT NULL,
);