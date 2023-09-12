CREATE DATABASE Oscorp

USE Oscorp

-- Tabela Departamento
CREATE TABLE Departamento (
    numero INT PRIMARY KEY,
    nome VARCHAR(255),
    ramal INT
);

-- Tabela Projeto
CREATE TABLE Projeto (
    numero INT PRIMARY KEY,
    nome VARCHAR(255),
    localizacao VARCHAR(255),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(numero)
);

-- Tabela Empregado
CREATE TABLE Empregado (
    CPF VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    salario DECIMAL(10, 2),
    RG VARCHAR(20),
    telefone VARCHAR(15),
    id_departamento INT,
    supervisor_cpf VARCHAR(14),
    FOREIGN KEY (id_departamento) REFERENCES Departamento(numero),
    FOREIGN KEY (supervisor_cpf) REFERENCES Empregado(CPF)
);

-- Tabela AlocacaoProjeto (relacionamento entre Empregado e Projeto)
CREATE TABLE AlocacaoProjeto (
    id_empregado VARCHAR(14),
    id_projeto INT,
    horas_semanais INT,
    PRIMARY KEY (id_empregado, id_projeto),
    FOREIGN KEY (id_empregado) REFERENCES Empregado(CPF),
    FOREIGN KEY (id_projeto) REFERENCES Projeto(numero)
);

-- Tabela Dependente
CREATE TABLE Dependente (
    id_dependente INT PRIMARY KEY,
    nome VARCHAR(255),
    data_nascimento DATE,
    parentesco VARCHAR(50),
    id_empregado VARCHAR(14),
    FOREIGN KEY (id_empregado) REFERENCES Empregado(CPF)
);

-- Inserir dados na tabela Departamento
INSERT INTO Departamento (numero, nome, ramal)
VALUES
    (1, 'Recursos Humanos', 100),
    (2, 'Engenharia', 200),
    (3, 'Vendas', 300);

	-- Inserir dados na tabela Projeto
INSERT INTO Projeto (numero, nome, localizacao, id_departamento)
VALUES
    (101, 'Projeto RH1', 'São Paulo', 1),
    (102, 'Projeto Eng1', 'Rio de Janeiro', 2),
    (103, 'Projeto Vendas1', 'Belo Horizonte', 3);

	-- Inserir dados na tabela Empregado
INSERT INTO Empregado (CPF, nome, endereco, salario, RG, telefone, id_departamento, supervisor_cpf)
VALUES
    ('11111111111', 'João Silva', 'Rua A, 123', 5000.00, '1234567', '123-4567', 1, NULL),
    ('22222222222', 'Maria Souza', 'Rua B, 456', 6000.00, '7654321', '987-6543', 2, NULL),
    ('33333333333', 'Pedro Santos', 'Rua C, 789', 5500.00, '9876543', '555-5555', 3, '11111111111');

	-- Inserir dados na tabela AlocacaoProjeto
INSERT INTO AlocacaoProjeto (id_empregado, id_projeto, horas_semanais)
VALUES
    ('11111111111', 101, 20),
    ('11111111111', 103, 15),
    ('22222222222', 102, 25),
    ('33333333333', 103, 30);

	-- Inserir dados na tabela Dependente
INSERT INTO Dependente (id_dependente, nome, data_nascimento, parentesco, id_empregado)
VALUES
    (1, 'Ana Silva', '2000-01-15', 'Filha', '11111111111'),
    (2, 'Lucas Souza', '1995-05-10', 'Filho', '22222222222'),
    (3, 'Carla Santos', '2010-08-20', 'Filha', '33333333333');

	-- Exibir todos os dados da tabela Departamento
SELECT * FROM Departamento;

-- Exibir todos os dados da tabela Projeto
SELECT * FROM Projeto;

-- Exibir todos os dados da tabela Empregado
SELECT * FROM Empregado;

-- Exibir todos os dados da tabela AlocacaoProjeto
SELECT * FROM AlocacaoProjeto;

-- Exibir todos os dados da tabela Dependente
SELECT * FROM Dependente;

-- Exibir empregados que trabalham no departamento de Engenharia
SELECT * FROM Empregado WHERE id_departamento = 2;

-- Exibir projetos localizados em São Paulo
SELECT * FROM Projeto WHERE localizacao = 'São Paulo';

-- Exibir dependentes com parentesco 'Filho'
SELECT * FROM Dependente WHERE parentesco = 'Filho';

-- Exibir informações do empregado e do departamento ao qual ele pertence
SELECT Empregado.*, Departamento.nome AS nome_departamento
FROM Empregado
JOIN Departamento ON Empregado.id_departamento = Departamento.numero;

-- Exibir empregados e os projetos em que estão alocados
SELECT Empregado.nome AS nome_empregado, Projeto.nome AS nome_projeto
FROM Empregado
JOIN AlocacaoProjeto ON Empregado.CPF = AlocacaoProjeto.id_empregado
JOIN Projeto ON AlocacaoProjeto.id_projeto = Projeto.numero;

-- Exibir empregados e seus dependentes
SELECT Empregado.nome AS nome_empregado, Dependente.nome AS nome_dependente
FROM Empregado
LEFT JOIN Dependente ON Empregado.CPF = Dependente.id_empregado;
