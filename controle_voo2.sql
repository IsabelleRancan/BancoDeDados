CREATE OR REPLACE FUNCTION Fn_Caracter_Aleatorio()
RETURNS char(1)
AS $$
BEGIN
    return chr(cast(65 + random()*25 as int));
END;
$$ LANGUAGE plpgsql;

--SELECT Fn_Caracter_Aleatorio();

CREATE OR REPLACE FUNCTION Fn_3Caracter_Aleatorio()
RETURNS char(3)
AS $$
BEGIN
    return Fn_Caracter_Aleatorio() 
         || Fn_Caracter_Aleatorio() 
         || Fn_Caracter_Aleatorio();
END;
$$ LANGUAGE plpgsql;

SELECT Fn_3Caracter_Aleatorio()
FROM generate_series(1,10)
order by 1;

SELECT * FROM VPrefixo_Aeronautico ORDER BY RANDOM() LIMIT 1;
SELECT Fn_PrefixoAero_Aleatorio() || '-' || Fn_3Caracter_aleatorio() 
FROM generate_series(1,10);