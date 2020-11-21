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

select avg(r.dataSaida - r.dataEntrada)
from reserva r
group by tipoQuarto;

-- selecionar os quartos com mais tempo de estadia do que a média

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

*/

-- solucao

SELECT DISTINCT
    EXTRACT(MONTH FROM(l.data)) AS mês,
    f.nome
FROM
    funcionario f, limpeza l, quarto q, tipoQuarto tq, reserva r, funcionarioCamareira fc
WHERE
    fc.funcionarioNIF = f.NIF AND l.funcionarioNIF = f.NIF AND q.numeroSequencial = l.numeroSequencial
    AND q.numeroAndar = l.numeroAndar   AND tq.tipoQuarto = q.tipoQuarto   AND q.numeroSequencial = r.numeroSequencial
    AND q.numeroAndar = r.numeroAndar   AND months_between(current_timestamp, l.data)<=6
    AND l.data < sysdate
    AND ( SELECT DISTINCT AVG(EXTRACT(DAY FROM(r.dataSaida)) - EXTRACT(DAY FROM(r.dataEntrada)))
        FROM reserva r, quarto q1, tipoQuarto tq1
        WHERE q1.numeroSequencial = r.numeroSequencial  AND q1.numeroAndar = r.numeroAndar 
        AND q1.tipoQuarto = tq1.tipoQuarto) < r.dataSaida - r.dataEntrada
    AND (SELECT COUNT(l.numeroSequencial)
        FROM limpeza l1, quarto q1, funcionarioCamareira fc1, funcionario  f1
        WHERE
            q1.numeroSequencial = l1.numeroSequencial AND q1.numeroAndar = l1.numeroAndar AND fc1.funcionarioNif = f.NIF
            AND fc1.funcionarioNif = f1.NIF AND q.numeroSequencial = q1.numeroSequencial AND q1.numeroAndar = q.numeroAndar
            AND f1.NIF != f.NIF
    ) < ALL (SELECT COUNT(l.numeroSequencial)
        FROM limpeza l1, quarto q1, funcionarioCamareira fc1, funcionario f1
        WHERE
            q.numeroSequencial = l1.numeroSequencial AND q1.numeroAndar = l1.numeroAndar AND fc.funcionarioNif = f.NIF
            AND fc.funcionarioNif = f1.NIF AND q.numeroSequencial = q1.numeroSequencial AND q1.numeroAndar = q.numeroAndar
            AND f1.NIF = f.NIF
    )
GROUP BY EXTRACT(MONTH FROM(l.data)), f.nome ORDER BY EXTRACT(MONTH FROM(l.data));

/*
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
*/



--Parte III --
--a)
with tabelaCount as (select r.numeroAndar, r.numeroSequencial, count(r.numeroSequencial) as countQuartos from Reserva r
                     Inner join quarto q1 on q1.numeroSequencial = r.numeroSequencial and q1.numeroAndar = r.numeroAndar
                     where r.estado != 'cancelada' 
                     group by r.numeroAndar, r.numeroSequencial)              
select a.numeroAndar as ANDAR, q.numeroSequencial, q.tipoQuarto from andar a
inner join Quarto q on a.numeroAndar = q.numeroAndar
group by  a.numeroAndar, q.numeroSequencial, q.tipoQuarto
having q.numeroSequencial not in(select numeroSequencial from Reserva
                                 group by numeroSequencial,tipoQuarto 
                                 having count(numeroSequencial) < 2 and tipoQuarto = 'single')
and count(q.numeroSequencial) in (select max(countQuartos) from tabelaCount
                                  where a.numeroAndar = numeroAndar and q.numeroSequencial = numeroSequencial);

--b)
with countProdutos as (select count(idProduto) as contador from Consumos 
                       where rowNum <= 2
                       order by 1)
select c.nome from cliente c
inner join Reserva r on r.clienteNIF = c.NIF
inner join Conta ct on ct.codReserva = r.codReserva
inner join Consumos csm on csm.nrConta = ct.nrConta
where r.tipoQuarto = 'suite' and r.nomeEpoca = 'alta' and Extract(YEAR from r.dataEntrada) >= 2019 
group by c.nome, csm.idProduto
having csm.idProduto in (select idProduto from Consumos 
                         group by idProduto
                         having count(idProduto) in (select contador from countProdutos))
order by (select sum(custo) from Produto 
          where csm.idProduto = idProduto);
