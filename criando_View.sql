select * from vpiloto;

create or replace view pilotos_por_cidade as 
	select cidade_moradia, count(*) as quant_pilotos
	from VPiloto 
	group by cidade_moradia
	order by quant_pilotos desc;
	
select * from pilotos_por_cidade;