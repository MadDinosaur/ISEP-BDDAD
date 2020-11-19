/*Parte I*/
/*(a)*/
SELECT idManutencao, CAST(numeroAndar as varchar(10)) || CAST(numeroSequencial as varchar(10)) IDQUARTO, equipamento, funcionarionif
FROM manutencao
WHERE data IS NULL
AND funcionarioNIF NOT IN (SELECT funcionarioNIF FROM manutencao WHERE data >= CURRENT_TIMESTAMP - 2);
/*(b)*/
SELECT r.dataReserva, c.nome, c.localidade ZONA_DO_PA�S
FROM reserva r INNER JOIN cliente c ON r.clienteNIF = c.NIF
WHERE REGEXP_LIKE(EXTRACT(month FROM dataReserva), '4|6')
AND c.NIF in (SELECT clienteNIF FROM reserva WHERE tipoQuarto LIKE 'suite')
UNION
SELECT r.dataReserva, c.nome, '' ZONA_DO_PA�S
FROM reserva r INNER JOIN cliente c ON r.clienteNIF = c.NIF
WHERE REGEXP_LIKE(EXTRACT(month FROM dataReserva), '4|6')
AND c.NIF NOT IN (SELECT clienteNIF FROM reserva WHERE tipoQuarto LIKE 'suite');

--Parte II

-- (a)

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
where nome like 'Jos� Silva' and concelho like 'Vila Real') and r1.estado like 'finalizada' and r.numeroSequencial in(

select r2.numeroSequencial
from reserva r2
where r2.clienteNif in (select nif
from cliente 
where nome like 'Jos� Silva' and concelho like 'Vila Real') and r2.estado like 'finalizada')) and 
(c.NIF not in (select  r3.clienteNif from reserva r3 where 

nome like 'Jos� Silva' and concelho like 'Vila Real')));


/*
-- selecionar Jos� Silva
select nif --, nome
from cliente 
where nome like 'Jos� Silva' and concelho like 'Vila Real';
*/

/*
-- selecionar quartos reservados pelo Jos� Silva
select r.numeroAndar, r.numeroSequencial --, r.codReserva
from reserva r
where r.clienteNif = (select nif
from cliente 
where nome like 'Jos� Silva' and concelho like 'Vila Real');
*/

/*
--selecionar quartos reservados pelos clientes

select r.numeroAndar, r.numeroSequencial-- ,r.codReserva
from reserva r;
*/

-- (b)

-- selecionar as limpezas dos �ltimos 6 meses
select *
from limpeza l
where months_between(current_timestamp, l.data)<=6;

--selecionar a m�dia de estadia em cada quarto

select avg(r.dataSaida - r.dataEntrada)
from reserva r
group by tipoQuarto;

-- selecionar os quartos com mais tempo de estadia do que a m�dia

select numeroAndar, numeroSequencial
from reserva r1
where (r1.dataSaida-r1.dataEntrada) > (select avg(r2.dataSaida - r2.dataEntrada)
from reserva r2
group by tipoQuarto
having r1.tipoQuarto=r2.tipoQuarto);

-- selecionar nome camareira

select nome
from funcionario f, funcionarioCamareira fc
where fc.funcionarioNIF in f.nif;

-- solucao

select nome
from funcionario f, funcionarioCamareira fc, limpeza l
where fc.funcionarioNIF in f.nif and fc.funcionarioNIF in l.funcionarioNIF and
months_between(current_timestamp, l.data)<=6 and (l.numeroAndar, l.numeroSequencial) in (
select r1.numeroAndar, r1.numeroSequencial
from reserva r1
where (r1.dataSaida-r1.dataEntrada) > (select avg(r2.dataSaida - r2.dataEntrada)
from reserva r2
group by tipoQuarto
having r1.tipoQuarto=r2.tipoQuarto));




--Parte III --
--a)
with tabelaCount as (select count(r.numeroSequencial) as countQuartos from Reserva r
           Inner join quarto q on q.numeroSequencial=r.numeroSequencial and q.numeroAndar=r.numeroAndar
           where r.estado!='cancelada')
select a.nome as ANDAR,q.numeroSequencial,q.tipoQuarto from andar a
inner join Quarto q on a.numeroAndar=q.numeroAndar
group by a.nome,q.numeroSequencial,q.tipoQuarto
having max(q.numeroSequencial) in (select max(countQuartos) from tabelaCount);

--b)
with totalConsumo as (select sum(custo) from Produto), --ainda por fazer
countProdutos as (select count(idProduto) as contador from Consumos 
                  where rowNum<=2
                  order by 1)
select c.nome from cliente c
inner join Reserva r on r.clienteNIF=c.NIF
inner join Conta ct on ct.codReserva=r.codReserva
inner join Consumos csm on csm.nrConta=ct.nrConta
where /*r.tipoQuarto='suite' and*/ r.nomeEpoca='alta' 
group by c.nome,csm.idProduto
having csm.idProduto in (select idProduto from Consumos 
                         group by idProduto
                         having count(idProduto) in (select contador from countProdutos))
order by c.nome
;
