DROP VIEW IF EXISTS V_Classif_IMC_Cidade;
DROP VIEW IF EXISTS V_Classif_IMC;
DROP VIEW IF EXISTS V_IMC;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Cidade;

CREATE TABLE Cidade
(
	codigo int primary key,
	nome varchar (50) not null
);

CREATE TABLE Pessoa
(
	id serial not null PRIMARY KEY,
	nome varchar(60) NOT NULL,
	genero char(1) NOT NULL,
	massa numeric(5,2) NOT NULL,
	altura int NOT NULL,
	cidade_id int NULL REFERENCES Cidade(codigo)
); 

INSERT INTO Cidade VALUES (1, 'Belo Horizonte');
INSERT INTO Cidade VALUES (2, 'Tres Lagoas');
INSERT INTO Cidade VALUES (3, 'Andradina');

INSERT INTO Pessoa (nome, genero, massa, altura, cidade_id)
	VALUES ('Cleiton', 'M', 108, 186, 2);
INSERT INTO Pessoa (nome, genero, massa, altura, cidade_id)
	VALUES ('Pedro', 'M', 79, 192, NULL);
INSERT INTO Pessoa (nome, genero, massa, altura)
	VALUES ('Maria', 'F', 123, 151);
INSERT INTO Pessoa (nome, genero, massa, altura, cidade_id)
	VALUES ('Patrick', 'M', 95, 189, 3);
INSERT INTO Pessoa (nome, genero, massa, altura)
	VALUES ('José', 'M', 45, 135);
INSERT INTO Pessoa (nome, genero, massa, altura, cidade_id)
	VALUES ('Gabriel', 'M', 115, 210, 1);
	
CREATE VIEW V_IMC AS 
	SELECT id, nome, genero, massa, altura, 
		(massa/(altura/100.0*altura/100.0))::numeric(4,2) imc --convertenda a altura de cm pra m, parte final é pra 2 casas decimais 
	FROM Pessoa;
	
SELECT * FROM V_IMC ORDER BY imc;

CREATE VIEW V_Classif_IMC AS 
	SELECT id, nome, genero, massa, altura, imc, 
		CASE WHEN imc < 18.5 THEN 'magreza'
			WHEN imc < 25 THEN 'normal' --como são valores sequenciais eu n preciso mandar testar o 18
			WHEN imc < 30 THEN 'sobrepeso'
			WHEN imc < 35 THEN 'obesidade g1'
			WHEN imc < 40 THEN 'obesidade g2'
			ELSE 'obesidade g3'
		END classificacao
	FROM V_IMC;

SELECT * FROM V_Classif_IMC ORDER BY imc;

CREATE VIEW V_Classif_IMC_Cidade AS 
SELECT Pessoa.id, Pessoa.nome, Pessoa.genero, Pessoa.massa, Pessoa.altura, imc, classificacao, Cidade.nome AS Cidade
FROM V_Classif_IMC INNER JOIN Pessoa ON V_Classif_IMC.ID = Pessoa.ID
	LEFT JOIN Cidade ON Pessoa.cidade_id = Cidade.codigo;

SELECT * FROM V_Classif_IMC_Cidade;