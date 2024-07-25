-- p_data_inicio, p_data_fim,  p_tempo_voo, p_tipo_aeronave, p_aeroporto_decolagem char(3),
--      p_aeroporto_pouso char(3)

DELETE FROM PASSAGEIRO;

INSERT INTO Passageiro (pessoa_id)
SELECT pessoa_id from funcionario
UNION
SELECT ID from pessoa where ID not IN (select pessoa_id from funcionario) LIMIT 25000;

UPDATE passageiro
SET necessidade_especial = TRUE
WHERE pessoa_ID IN 
(
   select pessoa_id from passageiro
   order by random()
   limit 1000
);



--https://www.postgresqltutorial.com/plpgsql-loop-statements/
select aeronave, SUM(data_hora_pouso - data_hora_decolagem), 
   cast(
      EXTRACT(hour FROM SUM(data_hora_pouso - data_hora_decolagem)) +
      EXTRACT(minute FROM SUM(data_hora_pouso - data_hora_decolagem))/60.0
      AS numeric(10,2)
      )
from Voo
group by aeronave
order by aeronave;


select EXTRACT(hour FROM  data_hora_pouso), count(*)
from Voo where aeroporto_pouso = 'GRU'
group by 1
order by 1;


/*
"pt-BR"	90%
"pt-PT" 80%
"en-US" 60%
"es"    70%
"fr"    30%
"ru"     0%
"it"    40%
"de"    30%
"ja"    10%
"zh-CN"  1%
*/

SELECT * FROM idioma_Funcionario;

--ALTER SEQUENCE idioma_funcionario_id_seq START 1;
-- CREATE SEQUENCE idioma_funcionario_id_seq START 1;
-- 

-- ALTER TABLE Idioma_funcionario 
-- ALTER COLUMN id 
-- SET DEFAULT nextval('idioma_funcionario_id_seq');



CREATE OR REPLACE FUNCTION Fn_Insere_Idioma_Funcionarios
   (p_idioma varchar(5), p_percentual numeric(6,3))
RETURNS int
AS $$
   DECLARE 
     limite integer;
     existentes integer;
BEGIN
   IF (p_percentual = 0) THEN
     RAISE NOTICE 'Percentual = 0 => nada a inserir!';
     return 0;
   END IF;

   SELECT count(*) INTO existentes
   FROM idioma_funcionario 
   WHERE idioma = p_idioma;

   IF (existentes > 0) THEN
     RAISE 'Idioma ''%'' já tinha sido cadastrado para funcionarios', p_idioma;
     RETURN 0;
   END IF;

   SELECT count(*) * p_percentual INTO limite
   FROM Funcionario;
   
   RAISE NOTICE 'limite : %', limite;

   INSERT INTO idioma_funcionario (pessoa_id, idioma)
       SELECT pessoa_id, p_idioma
       FROM Funcionario
       ORDER BY random()
       LIMIT limite;   

   RETURN limite;  
END
$$ LANGUAGE plpgsql;

SELECT Fn_Insere_Idioma_Funcionarios('pt-BR', .9);
SELECT Fn_Insere_Idioma_Funcionarios('pt-PT', .8);
SELECT Fn_Insere_Idioma_Funcionarios('en-US', .6);
SELECT Fn_Insere_Idioma_Funcionarios('es',    .7);
SELECT Fn_Insere_Idioma_Funcionarios('fr',    .3);
SELECT Fn_Insere_Idioma_Funcionarios('ru',    .0);
SELECT Fn_Insere_Idioma_Funcionarios('it',    .4);
SELECT Fn_Insere_Idioma_Funcionarios('de',    .3);
SELECT Fn_Insere_Idioma_Funcionarios('ja',    .1);
SELECT Fn_Insere_Idioma_Funcionarios('zh-CN', .01);


SELECT I.sigla, I.nome, count(*)
FROM idioma_funcionario IF JOIN Idioma I ON (IF.idioma = I.sigla)
GROUP BY i.sigla
ORDER BY I.nome;

SELECT I.sigla, I.nome, count(IF.id)
FROM idioma_funcionario IF JOIN Idioma I ON (IF.idioma = I.sigla)
   JOIN aeromoca A ON (A.pessoa_id = IF.pessoa_id)
GROUP BY i.sigla
ORDER BY I.nome;

-- TRIGGERS
-- https://www.devmedia.com.br/trabalhando-com-triggers-no-postgresql/33531

-- CREATE TABLE Passagem
-- (
--     id int NOT NULL PRIMARY KEY,
--     voo_id int NOT NULL REFERENCES voo(id),
--     passageiro_id int NOT NULL REFERENCES Passageiro(Pessoa_ID),
--     data_hora_compra timestamp NOT NULL,
--     numero_assento smallint NOT NULL
-- );


ALTER TABLE Passagem ALTER COLUMN passageiro_id DROP NOT NULL;
ALTER TABLE Passagem ALTER COLUMN data_hora_compra DROP NOT NULL;

ALTER TABLE Passagem ADD CONSTRAINT Assento_Unico
    UNIQUE (voo_id, numero_assento);


CREATE SEQUENCE passagem_id_seq START 1;

-- 

ALTER TABLE Passagem 
  ALTER COLUMN id 
  SET DEFAULT nextval('passagem_id_seq');

SELECT * FROM Passagem;

--INSERT INTO Passagem(voo_id, s)


CREATE OR REPLACE FUNCTION Fn_Insere_Passagens_Voo (p_voo_id int)
RETURNS int
AS $$
   DECLARE 
     quantidade_assentos integer;     
BEGIN

   IF ( (
          SELECT COUNT(*) 
          FROM Passagem WHERE voo_id = p_voo_id
         ) > 0
      ) THEN
     RAISE 'Passagens já cadastradas para o voo de ID ''%''', p_voo_id;
     RETURN 0;
   END IF;

   SELECT quant_assentos INTO quantidade_assentos
   FROM Voo JOIN Aeronave A ON (Voo.aeronave = A.codigo)
     JOIN Tipo_Aeronave Tipo ON (Tipo.sigla = A.tipo_sigla)
   WHERE Voo.ID = p_voo_id;
   
   INSERT INTO Passagem (voo_id, numero_assento)
       SELECT p_voo_id, S
       FROM generate_series(1, quantidade_assentos) S;   

   RETURN quantidade_assentos;    
END
$$ LANGUAGE plpgsql;

SELECT Fn_Insere_Passagens_Voo(3);

-- CURSORES
-- VIDE FIGURA
--https://www.postgresqltutorial.com/plpgsql-cursor/

CREATE OR REPLACE FUNCTION Fn_Insere_Passagens_Todos_Voos() 
RETURNS bigint
AS $$
   DECLARE 
     total_passagens bigint; 
     p_voo_id int;   
     passagens_voo int;

     cursor_passagens CURSOR FOR
       SELECT id
       FROM Voo
       WHERE id NOT IN (SELECT Voo_id FROM Passagem);
BEGIN

   total_passagens := 0;

   OPEN cursor_passagens;

   LOOP
     FETCH NEXT FROM cursor_passagens INTO p_voo_id;      
     EXIT WHEN NOT FOUND; -- SAI QUANDO NÃO EXISTIREM MAIS VOOS

     passagens_voo := Fn_Insere_Passagens_Voo(p_voo_id);
     RAISE NOTICE 'VOO %: % passagens inseridas',  p_voo_id, passagens_voo;

     total_passagens := total_passagens + passagens_voo;
     
   END LOOP;

   CLOSE cursor_passagens;

   RETURN total_passagens;    
END
$$ LANGUAGE plpgsql;

--CUIDADO ANTES DE EXECUTAR ISTO!
SELECT Fn_Insere_Passagens_Todos_Voos();
