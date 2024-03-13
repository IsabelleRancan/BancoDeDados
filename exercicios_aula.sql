DROP VIEW IF EXISTS V3;
DROP VIEW IF EXISTS V2;
DROP VIEW IF EXISTS V1;


CREATE VIEW V1 AS 
	 SELECT 
        number AS id, 
		CASE WHEN gender = 'male' THEN 'masculino'
			ELSE 'feminino'END AS genero, 
        givenname AS nome_inicial, 
        surname AS sobrenome, 
        givenname || ' ' || maidenname || ' '|| surname AS nome_completo, 
        birthday, 
        to_date(birthday, 'MM/DD/YYYY') AS aniversario_data, 
        kilograms, 
        kilograms::numeric(5,2) AS massa_kg, --CAST(kilograms as numeric (5,2))
        centimeters,
        ROUND(centimeters::numeric / 100.0, 2) AS altura_metros
    FROM fakenames;
SELECT * FROM V1 LIMIT 10;
	
-------------------------------------EXERCICIO 2-----------------------------------

CREATE VIEW V2 AS 
	 SELECT 
        id, 
        genero, 
        nome_inicial, 
        sobrenome, 
        nome_completo, 
        aniversario_data,
		AGE(CURRENT_DATE, to_date(birthday, 'MM/DD/YYYY')) AS idade,
		EXTRACT(YEAR FROM AGE(CURRENT_DATE, to_date(birthday, 'MM/DD/YYYY'))) AS idade_anos, 
        massa_kg, 
        altura_metros, 
		(massa_kg /(altura_metros*altura_metros))::numeric(5,2) AS imc
    FROM v1;
SELECT * FROM V2 LIMIT 10;

-------------------------------------EXERCICIO 3-----------------------------------

CREATE VIEW V3 AS 
	SELECT * FROM V2,
	CASE WHEN imc < 18.5 THEN -1 
		WHEN imc < 25 THEN 0
		WHEN imc < 30 THEN 1
		WHEN imc < 35 THEN 2
		WHEN imc < 40 THEN 3 
		ELSE 4 
	END classificacao_imc_num,
	CASE WHEN imc < 18.5 THEN 'magreza' 
		WHEN imc < 25 THEN 'normal'
		WHEN imc < 30 THEN 'sobrepeso'
		WHEN imc < 35 THEN 'obesidade G1'
		WHEN imc < 40 THEN 'obesidade G2'
		ELSE 'obesidade G3'
	END classificacao_imc,
	CASE WHEN imc < 18.5 THEN 'magreza' 
		WHEN imc < 25 THEN 'normal'
		WHEN imc < 30 THEN 'sobrepeso'
		ELSE 'obeso'
	END classificacao_imc2;
	
SELECT * FROM V3 LIMIT 20;

