use TerceiraAvaliacaoDB;
        
INSERT INTO Departamentos (Codigo_Dep, Nome, Localizacao, Gerente)
VALUES 	(1, 'RH', 'Andar 2', 1),
		(2, 'TI', 'Andar 3', 2);
        
SELECT * FROM Departamentos;

INSERT INTO Funcionarios (Codigo_Func, PrimeiroNome, SegundoNome, UltimoNome, DataNasci, CPF, RG, Endereco, CEP, Cidade, Fone, Codigo_Departamentos, Funcao, Salario)
VALUES 	(1, 'Ana', 'Silva', 'Oliveira', '1995-05-15', '111.222.333-44', '67890', 'Rua B, 456', '54321-876', 'CidadeB', '987654321', 1, 'Analista', 6000.00),
		(2, 'Carlos', 'Santos', 'Pereira', '1988-10-20', '555.666.777-88', '54321', 'Rua C, 789', '12345-678', 'CidadeC', '876543210', 2, 'Engenheiro', 8000.00),
        (3, 'Lucia', 'Oliveira', 'Ribeiro', '1992-03-08', '999.888.777-66', '87654', 'Rua D, 1011', '98765-432', 'CidadeD', '654321098', 1, 'Gerente', 10000.00);

SELECT * FROM Funcionarios;

SELECT NomeCompleto(PrimeiroNome, SegundoNome, UltimoNome) AS Nome_Completo FROM Funcionarios WHERE Codigo_Func = 1;

SELECT ReajusteSalario(1, 10) AS Novo_Salario;

CALL Acerto_Salario(1, 5000.00, 5, 'D');

select * from Log_Acerto_Salario;
