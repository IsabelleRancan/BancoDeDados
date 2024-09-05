CREATE OR REPLACE FUNCTION Fn_Lista_Cidades(estado char(2), ordem char(1))
RETURNS int 
AS $$
	DECLARE cursor_cidade CURSOR FOR 
	SELECT codigo, nome_cidade 
	FROM cidade
	WHERE nome_cidade LIKE '%(' || estado || ')';
	
	cod int;
	cidade varchar(50);
	
	quant int := 0;

BEGIN 
	OPEN cursor_cidade;
	
	IF (ordem = 'd' or ordem = 'D') THEN
		FETCH LAST FROM cursor_cidade INTO cod, cidade;
		LOOP

			IF (cod IS NULL) THEN 
				EXIT;
			END IF;
			RAISE NOTICE '% - %', cod, cidade;
			quant := quant + 1;

			FETCH PRIOR FROM cursor_cidade INTO cod, cidade;

		END LOOP;
	END IF;
	
	CLOSE cursor_cidade;
	RETURN quant;
END 
$$ LANGUAGE plpgsql;

SELECT Fn_Lista_Cidades('MS', 'D');

--SELECT * FROM CIDADE WHERE nome_cidade LIKE '%(SP)';