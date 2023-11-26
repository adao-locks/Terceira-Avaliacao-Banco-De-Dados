# Terceira-Avaliacao-Banco-De-Dados

##PEDIDO:

Crie a estrutura abaixo e implemente os objetos em banco de Dados:

Funcionarios (Codigo, PrimeiroNome, SegundoNome, UltimoNome, DataNasci, CPF, RG, Endereco, CEP, Cidade, Fone, CodigoDepartamento, Funcao, Salario) 

Departamentos(Codigo, Nome, Localizacao, CodigoFuncionario,Gerente)

Considerando as informações primárias a cima (outras tabelas/atributos podem ser criados se necessário durante a elaboração da solução)

Realize a normalização
Estruture o modelo conceitual
Estrutura o modelo lógico
Estruture o modelo físico
Aplique no SGBD
Implemente os mecanismos apresentados em aula (Procedures / Functions.)
Crie uma função que recebe como parâmetro os nomes (PrimeiroNome, SegundoNome, UltimoNome )  e retorne o nome completo.
Crie uma função para calcular o reajuste de salário de um funcionário passado como parâmetro, de acordo com um percentual de reajuste também passado como parâmetro.
Crie uma procedure Acerto_Salario que recebe os a identificação do funcionário, o valor do salário , o % e o tipo de correção (“D” – Débito / “C” – Crédito) com objetivo realizar a correção do salário daquele funcionário.
Implemente uma tabela de Log para esse registro.(Trigger)
