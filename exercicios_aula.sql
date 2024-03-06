DROP VIEW IF EXISTS V2;
DROP VIEW IF EXISTS V1;


CREATE VIEW V1 AS 
	 SELECT 
        number AS id, 
        gender AS genero, 
        givenname AS nome_inicial, 
        surname AS sobrenome, 
        givenname || ' ' || maidenname || ' '|| surname AS nome_completo, 
        birthday, 
        to_date(birthday, 'MM/DD/YYYY') AS aniversario_data, 
        kilograms, 
        kilograms::numeric(5,2) AS massa_kg, 
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
		(massa_kg / POWER(centimeters::numeric / 100.0,2))::numeric(5,2) AS imc
    FROM v1;
SELECT * FROM V2 LIMIT 10;
