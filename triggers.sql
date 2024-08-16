create table audit_pessoa 
(
	id serial primary key,
	pessoa_id int not null references pessoa(id),
	data_hora timestamp not null,	
	nome_anterior varchar(60) not null,
	nome_novo varchar(60) not null	
);

CREATE OR REPLACE FUNCTION log_atualiza_nome_pessoa()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF (NEW.pessoa_nome != OLD.pessoa_nome) THEN
		INSERT INTO audit_pessoa (pessoa_id, data_hora, nome_anterior, nome_novo)
			VALUES(NEW.pessoa_id, now(), OLD.pessoa_nome, NEW.pessoa_nome); 
	END IF;
	
	RETURN NEW;
END;
$$;

CREATE TRIGGER atualiza_nome_pessoa
	BEFORE UPDATE
  ON pessoa
  FOR EACH ROW
		EXECUTE PROCEDURE log_atualiza_nome_pessoa();
		
		

create table audit_salario_funcionario
(
	id serial primary key,
	pessoa_id int not null references pessoa(id),
	data_hora timestamp not null,	
	salario_anterior varchar(60) not null,
	salario_novo varchar(60) not null	
);


CREATE OR REPLACE FUNCTION log_atualiza_salario_funcionario()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
  DECLARE piloto boolean;
BEGIN

--2) SE pilotos, os salários devem ser superiores a 8000
	IF EXISTS (SELECT 1 FROM piloto WHERE OLD.pessoa_id = piloto.pessoa_id) THEN --esse 1 faz apenas a verificação
		IF (NEW.salario <= 8000) THEN
			RAISE EXCEPTION 'Salário para piloto deve ser superior a 8000'
		END IF;
	END IF;
	
	IF (SELECT COUNT(*) FROM piloto WHERE pessoa_id = NEW.pessoa_id) > 0 and NEW.pessoa_salario < 8000 THEN 
		RAISE EXCEPTION 'Salário deve ser superior a 8000'
	
--3) salários não podem diminuir, exceto para o valor ZERO;
	IF (NEW.salario > 0 AND NEW.salario < OLD.salario) THEN
		RAISE EXCEPTION 'Salários não podem diminuir, exceto para o valor ZERO.';
		RETURN null;
	END IF;
	
--1) registrar salários anteriores e novos
	IF (NEW.salario != OLD.salario) THEN
		INSERT INTO audit_salario_funcionario (pessoa_id, data_hora, salario_anterior, salario_novo)
			VALUES(NEW.pessoa_id, now(), OLD.pessoa_salario, NEW.pessoa_salario); 
	END IF;
	
RETURN NEW;
	
END;
$$;

CREATE TRIGGER atualiza_salario_funcionario
	BEFORE UPDATE
  ON funcionario
  FOR EACH ROW
		EXECUTE PROCEDURE log_atualiza_salario_funcionario();