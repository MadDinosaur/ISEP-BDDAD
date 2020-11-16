/*Parte I*/
/*(a)*/
SELECT idManutencao, CAST(numeroAndar as varchar(10)) || CAST(numeroSequencial as varchar(10)) IDQUARTO, equipamento, funcionarionif
FROM manutencao
WHERE data IS NULL
AND funcionarioNIF NOT IN (SELECT funcionarioNIF FROM manutencao WHERE data >= CURRENT_TIMESTAMP - 2);
/*(b)*/
SELECT r.dataReserva, c.nome, c.localidade ZONA_DO_PAÍS
FROM reserva r INNER JOIN cliente c ON r.clienteNIF = c.NIF
WHERE REGEXP_LIKE(EXTRACT(month FROM dataReserva), '4|6')
AND c.NIF in (SELECT clienteNIF FROM reserva WHERE tipoQuarto LIKE 'suite')
UNION
SELECT r.dataReserva, c.nome, '' ZONA_DO_PAÍS
FROM reserva r INNER JOIN cliente c ON r.clienteNIF = c.NIF
WHERE REGEXP_LIKE(EXTRACT(month FROM dataReserva), '4|6')
AND c.NIF NOT IN (SELECT clienteNIF FROM reserva WHERE tipoQuarto LIKE 'suite');

--Parte II

-- (b)

select nome, localidade, concelho
from cliente c

where c.NIF in (

select r.clienteNIF
from reserva r

where r.numeroAndar in(

select r1.numeroAndar
from reserva r1
where r1.clienteNif in (select nif
from cliente 
where nome like 'José Silva' and concelho like 'Vila Real') and r1.estado like 'finalizada' and r.numeroSequencial in(

select r2.numeroSequencial
from reserva r2
where r2.clienteNif in (select nif
from cliente 
where nome like 'José Silva' and concelho like 'Vila Real') and r2.estado like 'finalizada')) and 
(c.NIF not in (select  r3.clienteNif from reserva r3 where 

nome like 'José Silva' and concelho like 'Vila Real')));


/*
-- selecionar José Silva
select nif --, nome
from cliente 
where nome like 'José Silva' and concelho like 'Vila Real';
*/

/*
-- selecionar quartos reservados pelo José Silva
select r.numeroAndar, r.numeroSequencial --, r.codReserva
from reserva r
where r.clienteNif = (select nif
from cliente 
where nome like 'José Silva' and concelho like 'Vila Real');
*/

/*
--selecionar quartos reservados pelos clientes

select r.numeroAndar, r.numeroSequencial-- ,r.codReserva
from reserva r;
*/

--Parte III --
--a)
with tabelaCount as (select count(r.numeroSequencial) as countQuartos from Reserva r
           Inner join quarto q on q.numeroSequencial=r.numeroSequencial 
           where r.estado!='cancelada')
select a.nome as ANDAR,q.numeroSequencial,q.tipoQuarto from andar a
inner join Quarto q on a.numeroAndar=q.numeroAndar
group by a.nome,q.numeroSequencial,q.tipoQuarto
having max(q.numeroSequencial) in (select max(countQuartos) from tabelaCount);
