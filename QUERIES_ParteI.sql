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