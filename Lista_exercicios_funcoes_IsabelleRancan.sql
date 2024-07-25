-- CREATE OR REPLACE FUNCTION NOME_DA_FUNCAO ([lista de parâmetros]) 
-- RETURNS TIPO_RETORNO 
-- AS $$
-- -- DECLARE xx tipox; yy tipoy; ...	
-- BEGIN
  
-- END;
-- $$ LANGUAGE plpgsql;


--receba o ID de uma pessoa e retorne seu CPF
CREATE OR REPLACE FUNCTION fn_cpf (p_ID int) 
RETURNS varchar(14) 
AS $$
BEGIN
  RETURN CPF
    from Pessoa
	WHERE Pessoa.id = p_ID;  
END;
$$ LANGUAGE plpgsql;


select fn_cpf(5);

select ID, nome, CPF, fn_cpf(ID+1) as CPF_PROX_PESSOA
from pessoa
ORDER BY ID
limit 5;


--receba o CPF de uma pessoa e retorne seu ID
CREATE OR REPLACE FUNCTION fn_pessoa_id (p_cpf varchar(14))
RETURNS int 
AS $$
   DECLARE _ID int; _nome varchar(40); _data_nasc date;
BEGIN
   SELECT id, nome, data_nasc INTO _ID, _nome, _data_nasc
   FROM Pessoa
	WHERE Pessoa.cpf = p_cpf;
	
	
  RAISE INFO 'ID: %; nome: %; idade: %', _id, _nome, AGE(_data_nasc);  

  RETURN _ID;
      
END;
$$ LANGUAGE plpgsql;


select id, cpf, fn_pessoa_id(cpf)
from pessoa 
limit 5;


-- receba a sigla de um aeroporto 
-- e retorne a concatenação da sigla com o nome do aeroporto e o nome da cidade de localização
	-- Fn_Cidade_Aeroporto: com junção
	-- Fn_Cidade_Aeroporto2: sem junção (variável aux)
CREATE OR REPLACE FUNCTION Fn_Cidade_Aeroporto (p_sigla char(3))
RETURNS text 
AS $$   
BEGIN
   
  RETURN A.sigla || ' - ' || A.nome || ' - ' || C.nome_cidade
  FROM Aeroporto A JOIN Cidade C ON A.cidade_id = C.codigo
  WHERE A.sigla = p_sigla;
      
END;
$$ LANGUAGE plpgsql;

SELECT Fn_Cidade_Aeroporto('GRU');

SELECT sigla, Fn_Cidade_Aeroporto(sigla) from aeroporto order by random() limit 5;

SELECT Fn_Cidade_Aeroporto(sigla)
FROM Aeroporto
ORDER BY sigla;


SELECT Fn_Cidade_Aeroporto2(sigla)
FROM Aeroporto
ORDER BY sigla;

-- Fn_Aeroporto_Brasileiro: receba a sigla de um aeroporto 
-- e retorne um booleano se brasileiro ou não
DROP FUNCTION Fn_Aeroporto_Brasileiro;

CREATE FUNCTION Fn_Aeroporto_Brasileiro(p_sigla VARCHAR(3)) RETURNS text
AS $$
    DECLARE is_brasileiro BOOLEAN; pais INT;
BEGIN
	SELECT Cidade.pais_id INTO pais
	FROM Aeroporto
	JOIN Cidade ON Aeroporto.cidade_id = Cidade.codigo
	WHERE Aeroporto.sigla = p_sigla;
	
	IF pais = 1 THEN
		is_brasileiro := TRUE;
	ELSE 
		is_brasileiro := FALSE;
	END IF;
	RETURN is_brasileiro;
END;
$$ LANGUAGE plpgsql;

SELECT Fn_Cidade_Aeroporto('GRU');

SELECT Fn_Aeroporto_Brasileiro('PEK');

SELECT * FROM Aeroporto;

--select Fn_Cidade_Aeroporto(sigla), Fn_Aeroporto_Brasileiro(sigla)
--from Aeroporto
--order by 2, 1;

--Fn_Pessoa_nascimento: receba uma data de nascimento
	-- SE existir apenas uma pessoa nascida naquela data retornar o ID e nome (concatenados)
	-- SE existirem várias pessoas nascidas naquela data retorna NULL e dar msg
	-- SE nenhuma pessoa nascida naquela data, imprimir mensagem e retornar NULL
	
CREATE OR REPLACE FUNCTION Fn_Pessoa_nascimento (p_data_nasc DATE) 
RETURNS TEXT 
AS $$
DECLARE 
    total_linhas INT;
    _id INT;
    _nome VARCHAR(255);
BEGIN
    SELECT COUNT(*) INTO total_linhas FROM pessoa WHERE data_nasc = p_data_nasc;
  
    IF total_linhas = 1 THEN
        SELECT id, nome INTO _id, _nome FROM Pessoa WHERE data_nasc = p_data_nasc;
        RETURN _id || ' ' || _nome;
    ELSIF total_linhas > 1 THEN 
        RAISE INFO 'Muitas pessoas encontradas!';
        RETURN NULL;
    ELSE
        RAISE INFO 'Nenhuma pessoa nascida na data';
        RETURN NULL;
    END IF;
END;
$$ LANGUAGE plpgsql;


--SELECT data_nasc FROM pessoa WHERE data_nasc = '1977-02-28'::date;

SELECT Fn_Pessoa_nascimento('1957-02-01'::date);
SELECT Fn_Pessoa_nascimento('2000-10-01'::date);
SELECT Fn_Pessoa_nascimento('1977-02-28'::date);


-- receba uma data de nascimento e 
-- retorne uma tabela 
-- com ID, CPF e nome das pessoas nascidas naquela data

--drop function Fn_Pessoas_Nascidas_Em (p_data date);

CREATE OR REPLACE FUNCTION Fn_Pessoas_Nascidas_Em (p_data date) 
RETURNS TABLE 
    (
	   id int,
	   cpf varchar(14),
	   nome varchar(60),
	   data_nasc date
	)
AS $$
BEGIN
    RETURN QUERY 
	   SELECT Pessoa.id, Pessoa.cpf, Pessoa.nome, Pessoa.data_nasc
	   FROM Pessoa
	   WHERE Pessoa.data_nasc = p_data;
END;
$$ LANGUAGE plpgsql;


SELECT data_nasc, CPF, ID, nome from Fn_Pessoas_Nascidas_Em ('1977/02/28'::date);


-- receba dois inteiros que representam dia e mês de nascimento de uma pessoa 
-- retorne uma tabela 
-- com ID, CPF e nome das pessoas nascidas naquele dia e mês (independente de ano) 

CREATE OR REPLACE FUNCTION Fn_Pessoas_Nascidas_Em (dia int, mes int) 
RETURNS TABLE 
    (
	   id int,
	   cpf varchar(14),
	   nome varchar(60),
	   data_nasc date
	)
AS $$
BEGIN
    RETURN QUERY 
	   SELECT Pessoa.id, Pessoa.cpf, Pessoa.nome, Pessoa.data_nasc
	   FROM Pessoa
	   WHERE date_part('day', Pessoa.data_nasc) = dia
	     AND date_part('month', Pessoa.data_nasc) = mes;
END;
$$ LANGUAGE plpgsql;



SELECT * FROM Fn_Pessoas_Nascidas_Em (29, 02);

SELECT * FROM Fn_Pessoas_Nascidas_Em (30, 06)
WHERE ID < 5000;


--Fn_IMC: receba o ID (number) de uma pessoa (fakenames) e retorne seu IMC
drop function Fn_IMC;
CREATE OR REPLACE FUNCTION Fn_IMC (p_number int) 
RETURNS float
AS $$
BEGIN

	RETURN (kilograms::numeric/(centimeters::numeric/100.0*centimeters::numeric/100.0))::numeric(4,2) as imc
	FROM fakenames
	WHERE fakenames.number = p_number;
  
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fakenames;

select number, Fn_IMC(number)
FROM fakenames
order by 2
limit 5;

-- Fn_IMC2: receba o ID de uma pessoa (fakenames) e 
-- e um BOOLEAN (print_info) que diz se as msgs de console serao exibidas
-- e retorne seu IMC

drop function Fn_IMC2;
CREATE OR REPLACE FUNCTION Fn_IMC2 (p_number int, print_info boolean) 
RETURNS float
AS $$
DECLARE
    id int;
    nome varchar (250);
    massa float;
    altura float;
    imc float;
BEGIN
    SELECT 
        fakenames.number,
        givenname || ' ' || surname AS nome,
        kilograms::numeric,
        centimeters::numeric,
        (kilograms::numeric/(centimeters::numeric/100.0*centimeters::numeric/100.0))::numeric(4,2)
    INTO 
        id, 
        nome, 
        massa, 
        altura, 
        imc
    FROM 
        fakenames
    WHERE 
        fakenames.number = p_number;
    
    IF print_info THEN
        RAISE INFO 'ID: %, 
	Nome: %, 
	Massa: %, 
	Altura: %, 
	IMC: %', id, nome, massa, altura, imc;
    END IF;

    RETURN imc;
END;
$$ LANGUAGE plpgsql;




select number, Fn_IMC2(number, true)
FROM fakenames
order by surname, number
limit 3;

/* exemplo de execução do comando anterior passando print_info = TRUE

INFO:  
  ID: 6
  nome: Fernanda Almeida 
  massa(kg): 102.60 
 altura(metros): 1.59 
  IMC: 40.58
INFO:  
  ID: 54
  nome: Isabella Almeida 
  massa(kg): 87.40 
 altura(metros): 1.61 
  IMC: 33.72
INFO:  
  ID: 56
  nome: Diego Almeida 
  massa(kg): 85.30 
 altura(metros): 1.78 
  IMC: 26.92
 number | fn_imc2 
--------+---------
      6 |   40.58
     54 |   33.72
     56 |   26.92
(3 rows)

*/


/* exemplo de execução do comando anterior passando print_info = FALSE
 number | fn_imc2 
--------+---------
      6 |   40.58
     54 |   33.72
     56 |   26.92
(3 rows)

*/


-- select number, Fn_IMC2(number, true)
-- FROM fakenames
-- order by 2 DESC
-- limit 5;