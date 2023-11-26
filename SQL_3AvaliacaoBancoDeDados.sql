create database TerceiraAvaliacaoDB;
use TerceiraAvaliacaoDB;

/* Lógico_2: */

CREATE TABLE Funcionarios (
    Codigo_Func INT PRIMARY KEY,
    PrimeiroNome VARCHAR(50),
    SegundoNome VARCHAR(50),
    UltimoNome VARCHAR(50),
    DataNasci DATE,
    CPF VARCHAR(14) UNIQUE,
    RG VARCHAR(20),
    Endereco VARCHAR(255),
    CEP VARCHAR(10),
    Cidade VARCHAR(100),
    Fone VARCHAR(15),
    Funcao VARCHAR(50),
    Salario DECIMAL(10,2),
    Codigo_Departamentos INT
);

CREATE TABLE Departamentos (
    Codigo_Dep INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Localizacao VARCHAR(255),
    Gerente INT
);
 
ALTER TABLE Funcionarios ADD CONSTRAINT FK_Funcionarios
    FOREIGN KEY (Codigo_Departamentos)
    REFERENCES Departamentos (Codigo_Dep)
    ON DELETE RESTRICT;
    
/* Função para Retornar Nome Completo ---------------------------------------------------------------------------------------------------- */

DELIMITER //
CREATE FUNCTION NomeCompleto(pPrimeiroNome VARCHAR(50), pSegundoNome VARCHAR(50), pUltimoNome VARCHAR(50))
RETURNS VARCHAR(150)
BEGIN
    DECLARE nomeCompleto VARCHAR(150);
    SET nomeCompleto = CONCAT(pPrimeiroNome, ' ', pSegundoNome, ' ', pUltimoNome);
    RETURN nomeCompleto;
END //
DELIMITER ;

/* Função para Calcular Reajuste de Salário ---------------------------------------------------------------------------------------------------- */

DELIMITER //
CREATE FUNCTION ReajusteSalario(pCodigoFuncionario INT, pPercentualReajuste DECIMAL(5,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE novoSalario DECIMAL(10,2);
    SELECT Salario * (1 + pPercentualReajuste / 100) INTO novoSalario FROM Funcionarios WHERE Codigo_Func = pCodigoFuncionario;
    RETURN novoSalario;
END //
DELIMITER ;

/* Procedure Acerto_Salario ---------------------------------------------------------------------------------------------------- */

-- Tabela de Log
CREATE TABLE Log_Acerto_Salario (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    CodigoFuncionario INT,
    ValorAntigo DECIMAL(10,2),
    ValorNovo DECIMAL(10,2),
    TipoCorrecao CHAR(1),
    Data TIMESTAMP
);

-- Procedure Acerto_Salario
DELIMITER //
CREATE PROCEDURE Acerto_Salario(
    IN pCodigoFuncionario INT,
    IN pNovoSalario DECIMAL(10,2),
    IN pPercentualCorrecao DECIMAL(5,2),
    IN pTipoCorrecao CHAR(1)
)
BEGIN
    DECLARE salarioAtual DECIMAL(10,2);
    
    -- Obter o salário atual do funcionário
    SELECT Salario INTO salarioAtual FROM Funcionarios WHERE Codigo_Func = pCodigoFuncionario;

    -- Realizar a correção do salário
    IF pTipoCorrecao = 'D' THEN
        -- Lógica para débito
        UPDATE Funcionarios
        SET Salario = pNovoSalario
        WHERE Codigo_Func = pCodigoFuncionario;

    ELSEIF pTipoCorrecao = 'C' THEN
        -- Lógica para crédito
        UPDATE Funcionarios
        SET Salario = salarioAtual * (1 + pPercentualCorrecao / 100)
        WHERE Codigo_Func = pCodigoFuncionario;
    END IF;

    -- Inserir registro de log
    INSERT INTO Log_Acerto_Salario (CodigoFuncionario, ValorAntigo, ValorNovo, TipoCorrecao, Data)
    VALUES (pCodigoFuncionario, salarioAtual, pNovoSalario, pTipoCorrecao, NOW());
END //
DELIMITER ;

-- Trigger para correção de salário
DELIMITER //
CREATE TRIGGER Trigger_Acerto_Salario
AFTER UPDATE ON Funcionarios
FOR EACH ROW
BEGIN
    IF NEW.Salario <> OLD.Salario THEN
        INSERT INTO Log_Acerto_Salario (CodigoFuncionario, ValorAntigo, ValorNovo, TipoCorrecao, Data)
        VALUES (NEW.Codigo_Func, OLD.Salario, NEW.Salario, 'U', NOW());
    END IF;
END;
//
DELIMITER ;
