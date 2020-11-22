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
AND EXTRACT(year FROM dataReserva) = EXTRACT(year FROM SYSDATE)
AND c.NIF in (SELECT clienteNIF FROM reserva WHERE tipoQuarto LIKE 'suite' AND dataReserva = r.dataReserva)
UNION
SELECT r.dataReserva, c.nome, ' ' ZONA_DO_PAÍS
FROM reserva r INNER JOIN cliente c ON r.clienteNIF = c.NIF
WHERE REGEXP_LIKE(EXTRACT(month FROM dataReserva), '4|6')
AND EXTRACT(year FROM dataReserva) = EXTRACT(year FROM SYSDATE)
AND c.NIF NOT IN (SELECT clienteNIF FROM reserva WHERE tipoQuarto LIKE 'suite' AND dataReserva = r.dataReserva)
AND dataReserva = r.dataReserva
ORDER BY 2,1;


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

-- (b)


/*
-- selecionar as limpezas dos últimos 6 meses
select *
from limpeza l
where months_between(current_timestamp, l.data)<=6;

--selecionar a média de estadia em cada quarto

select tipoQuarto, avg(r.dataSaida - r.dataEntrada)
from reserva r
group by tipoQuarto;

-- selecionar os quartos com mais tempo de estadia do que a média

select DISTINCT numeroAndar, numeroSequencial
from reserva r1
where (r1.dataSaida-r1.dataEntrada) > (select avg(r2.dataSaida - r2.dataEntrada)
                                        from reserva r2
                                        group by tipoQuarto
                                        having r1.tipoQuarto=r2.tipoQuarto);

-- selecionar nome camareira

select nome
from funcionario f, funcionarioCamareira fc
where fc.funcionarioNIF in f.nif;

-- selecionar camareira com mais intervencoes

select *
FROM limpeza
WHERE funcionarionif = (select funcionarionif from 
                            (select fc.funcionarionif, count(l.numeroSequencial)
                            from funcionarioCamareira fc inner join limpeza l on fc.funcionarioNIF = l.funcionarionif
                            group by fc.funcionarionif
                            order by 2 desc, 1) 
                        where rownum = 1);
*/                        
-- solucao
SELECT DISTINCT
    EXTRACT(MONTH FROM(l.data)) AS mês,
    f.nome,
    f.nif
FROM funcionario f INNER JOIN funcionarioCamareira fc ON f.nif = fc.funcionarionif
INNER JOIN limpeza l ON fc.funcionarioNIF = l.funcionarioNIF
WHERE months_between(current_timestamp, l.data)<=6
AND l.data < sysdate
AND f.nif = (select funcionarionif from 
                            (select fc.funcionarionif, count(l.numeroSequencial)
                            from funcionarioCamareira fc inner join limpeza l on fc.funcionarioNIF = l.funcionarionif
                            where l.numeroSequencial in (select DISTINCT numeroSequencial
                                                        from reserva r1
                                                        where (r1.dataSaida-r1.dataEntrada) > (select avg(r2.dataSaida - r2.dataEntrada)
                                                                                                from reserva r2
                                                                                                group by tipoQuarto
                                                                                                having r1.tipoQuarto=r2.tipoQuarto))
                            group by fc.funcionarionif
                            order by 2 desc, 1) 
                        where rownum = 1);
                        

--Parte III --
--a)
with tabelaCount as (select r.numeroAndar, r.numeroSequencial, count(r.numeroSequencial) as countQuartos from Reserva r
                     Inner join quarto q1 on q1.numeroSequencial = r.numeroSequencial and q1.numeroAndar = r.numeroAndar
                     where r.estado != 'cancelada' 
                     group by r.numeroAndar, r.numeroSequencial)              
select a.numeroAndar as ANDAR, r1.numeroSequencial, r1.tipoQuarto from andar a
inner join Reserva r1 on r1.numeroAndar=a.numeroAndar
group by  a.numeroAndar, r1.numeroSequencial, r1.tipoQuarto
having r1.numeroSequencial not in(select numeroSequencial from Reserva
                                 group by numeroSequencial,tipoQuarto 
                                 having count(numeroSequencial) < 2 and tipoQuarto = 'single')
and count(r1.numeroSequencial) in (select max(countQuartos) from tabelaCount 
                                  where a.numeroAndar = numeroAndar 
                                  group by numeroAndar)
order by a.numeroAndar;

--b) 12 e 16
with countProdutos as (select count(idProduto) as contador,idProduto from Consumos  
                       group by idProduto
                       order by 1 desc),
doisMaisConsumidos as (select idProduto from countProdutos
                 where rowNum<=2),
maisConsumido as (select idProduto from countProdutos
                 where rowNum=1),
segundoMaisConsumido as (select idProduto from doisMaisConsumidos
                        where idProduto <> (select idProduto from maisConsumido))
select c.nome,c.NIF, sum(p.custo) as totalCustos 
from cliente c
inner join Reserva r on r.clienteNIF = c.NIF
inner join Conta ct on ct.codReserva = r.codReserva
inner join Consumos csm on csm.nrConta = ct.nrConta
inner join Produto p on p.idProduto=csm.idProduto
where r.tipoQuarto = 'suite' and r.nomeEpoca = 'alta' and Extract(YEAR from r.dataEntrada) >= 2019 
and (select idProduto from segundoMaisConsumido) in (select idProduto from Consumos
                                                     where nrConta=ct.nrConta)
and (select idProduto from maisConsumido) in (select idProduto from Consumos
                                              where nrConta=ct.nrConta) 
group by c.nome, c.NIF
order by totalCustos desc;

