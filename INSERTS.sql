INSERT INTO tipoQuarto VALUES ('single');
INSERT INTO tipoQuarto VALUES ('twin');
INSERT INTO tipoQuarto VALUES ('superior');
INSERT INTO tipoQuarto VALUES ('suite');

INSERT INTO andar VALUES (1, 'primeiro');
INSERT INTO andar VALUES (2, 'segundo');
INSERT INTO andar VALUES (3, 'terceiro');
INSERT INTO andar VALUES (4, 'quarto');
INSERT INTO andar VALUES (5, 'quinto');

INSERT INTO epocaAno VALUES ('baixa', 1,1,31,5);
INSERT INTO epocaAno VALUES ('media', 1,10,31,12);
INSERT INTO epocaAno VALUES ('alta', 1,6,30,9);

insert into precoReserva values ('single', 'baixa',50);
insert into precoReserva values ('single', 'media',67);
insert into precoReserva values ('single', 'alta',100);

insert into precoReserva values ('twin', 'baixa',70);
insert into precoReserva values ('twin', 'media',93);
insert into precoReserva values ('twin', 'alta',140);

insert into precoReserva values ('superior', 'baixa',90);
insert into precoReserva values ('superior', 'media',120);
insert into precoReserva values ('superior', 'alta',180);

insert into precoReserva values ('suite', 'baixa',110);
insert into precoReserva values ('suite', 'media',146);
insert into precoReserva values ('suite', 'alta',220);

INSERT INTO cliente VALUES (111111111, 'AAA', NULL, NULL, 'Local1', 'Concelho1');
INSERT INTO cliente VALUES (222222222, 'AAA', NULL, NULL, 'Local1', 'Concelho1');
INSERT INTO cliente VALUES (333333333, 'BBB', NULL, NULL, 'Local2', 'Concelho1');
INSERT INTO cliente VALUES (444444444, 'CCC', NULL, NULL, 'Local3', 'Concelho1');
INSERT INTO cliente VALUES (555555555, 'DDD', NULL, NULL, 'Local1', 'Concelho2');
INSERT INTO cliente VALUES (666666666, 'EEE', NULL, NULL, 'Local2', 'Concelho2');
INSERT INTO cliente VALUES (777777777, 'José Silva', 'josesilvadealer@gmail.com', 912121212, 'Ramadas', 'Vila Real');
INSERT INTO cliente VALUES (888888888, 'José Silva', 'josesilvanotdealer@gmail.com', 912121211, 'Ermesinde', 'Valongo');
INSERT INTO cliente VALUES (999999999, 'Marco Silva', 'marcosilvadealer@gmail.com', 912121213, 'Ramadas', 'Vila Real');

-- Quartos --
--1º Andar
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 4, 'superior');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 5, 'suite');

--2º Andar
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 1, 'single');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 4, 'superior');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 5, 'suite');

--3º Andar
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 1, 'single');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 2, 'twin');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 5, 'suite');

--4º Andar
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 1, 'single');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 2, 'twin');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 5, 'suite');

--5º Andar
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 1, 'single');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 2, 'twin');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 4, 'superior');

INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (5, 5, 'suite');


INSERT INTO estadoReserva VALUES ('reservada');
INSERT INTO estadoReserva VALUES ('cancelada');
INSERT INTO estadoReserva VALUES ('ativa');
INSERT INTO estadoReserva VALUES ('finalizada');

INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-01', '2020-10-04', 'single', '2020-09-30', 1, 1, 111111111);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-01', '2020-10-04', 'suite', '2020-04-30', 2, 1, 111111111); -- deve falhar
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-01', '2020-10-04', 'suite', '2020-04-30', 2, 1, 222222222);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-02', '2020-10-03', 'twin', '2020-06-25', 2, 1, 333333333);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-01', '2020-10-03', 'superior', '2020-04-01', 3, 3, 444444444);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-01', '2020-10-04', 'suite', '2020-09-30', 2, 1, 555555555);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-15', '2020-10-14', 'single', '2020-05-15', 1, 1, 111111111); -- deve falhar
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-15', '2020-10-17', 'single', '2020-05-15', 1, 1, 111111111);

INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-09-23', '2020-09-25', 'single', '2020-08-15', 1, 1, 777777777);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-10-15', '2020-10-17', 'twin', '2020-05-15', 1, 1, 777777777);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-06-23', '2020-06-25', 'single', '2020-02-15', 1, 1, 888888888);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-05-16', '2020-05-17', 'twin', '2020-02-15', 1, 1, 888888888);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-06-26', '2020-06-27', 'single', '2020-02-15', 1, 1, 999999999);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-05-18', '2020-05-19', 'twin', '2020-02-15', 1, 1, 999999999);
INSERT INTO reserva (dataEntrada, dataSaida, tipoQuarto, dataReserva, numeroPessoas, numeroAndar, clienteNIF)
VALUES ('2020-03-18', '2020-09-19', 'single', '2020-02-15', 1, 1, 999999999);

INSERT INTO funcionario VALUES (100000000, 'AAA', 'm1', 111111111, 'aaa@mail.com');
INSERT INTO funcionario VALUES (200000000, 'BBB', 'm2', 222222222, 'BBB@mail.com');
INSERT INTO funcionario VALUES (300000000, 'CCC', 'm3', 333333333, 'CCC@mail.com');
INSERT INTO funcionario VALUES (400000000, 'DDD', 'm4', 444444444, 'DDD@mail.com');
INSERT INTO funcionario VALUES (500000000, 'EEE', 'm5', 555555555, 'EEE@mail.com');
INSERT INTO funcionario VALUES (600000000, 'FFF', 'm6', 666666666, 'FFF@mail.com');
INSERT INTO funcionario VALUES (700000000, 'GGG', 'm5', 777777777, 'GGG@mail.com');
INSERT INTO funcionario VALUES (800000000, 'HHH', 'm6', 888888888, 'HHH@mail.com');
INSERT INTO funcionario VALUES (900000000, 'III', 'm5', 999999999, 'III@mail.com');
INSERT INTO funcionario VALUES (110000000, 'JJJ', 'm6', 110000000, 'JJJ@mail.com');

INSERT INTO funcionarioManutencao VALUES (100000000, 111111111, NULL);
INSERT INTO funcionarioManutencao VALUES (200000000, 222222222, 100000000);
INSERT INTO funcionarioManutencao VALUES (300000000, 333333333, 100000000);
INSERT INTO funcionarioManutencao VALUES (400000000, 444444444, 100000000);

INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (1, 1, 100000000, 'microondas', '2020-11-14 08:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (2, 4, 100000000, 'microondas', '2020-10-01 08:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (2, 4, 200000000, 'forno', '2020-10-02 09:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (3, 7, 100000000, 'ar condicionado', '');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (4, 8, 200000000, 'microondas','2020-10-01 10:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (1, 1, 300000000, 'forno', null);
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (2, 4, 400000000, 'ar condicionado','2020-11-13 16:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (3, 7, 100000000, 'forno', '2020-10-02 08:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (1, 1, 300000000, 'forno', '2020-10-02 08:00:00');

insert INTO fatura (codReserva, total) 
values ((select codReserva from reserva where dataSaida < CURRENT_TIMESTAMP and clienteNif=777777777 and numeroSequencial=2), 125);

/*ATRIBUIÇÃO AUTOMÁTICA DE QUARTOS DISPONÍVEIS ÀS RESERVAS*/
UPDATE reserva r1
SET numeroAndar = 
(SELECT numeroAndar FROM (
/*QUERY COM OS QUARTOS NÃO RESERVADOS DO TIPO E LOTAÇÃO ADEQUADOS*/
SELECT numeroAndar, numeroSequencial
FROM quarto
WHERE tipoQuarto = r1.tipoQuarto
AND lotacaoMax >= r1.numeroPessoas
MINUS (
/*QUERY COM OS QUARTOS JÁ RESERVADOS*/
SELECT numeroAndar, numeroSequencial
FROM reserva
WHERE (dataEntrada <= r1.dataEntrada
  AND dataSaida >= r1.dataEntrada)
   OR (dataEntrada <= r1.dataSaida
  AND dataSaida >= r1.dataSaida)
  )
) WHERE ROWNUM = 1),
numeroSequencial  = (
SELECT numeroSequencial FROM (
/*QUERY COM OS QUARTOS NÃO RESERVADOS DO TIPO E LOTAÇÃO ADEQUADOS*/
SELECT numeroAndar, numeroSequencial
FROM quarto
WHERE tipoQuarto = r1.tipoQuarto
AND lotacaoMax >= r1.numeroPessoas
MINUS (
/*QUERY COM OS QUARTOS JÁ RESERVADOS*/
SELECT numeroAndar, numeroSequencial
FROM reserva
WHERE (dataEntrada <= r1.dataEntrada
  AND dataSaida >= r1.dataEntrada)
   OR (dataEntrada <= r1.dataSaida
  AND dataSaida >= r1.dataSaida)
  )
) WHERE ROWNUM = 1),
nomeEpoca=(
select nomeEpoca from EpocaAno
where (mesInicio<Extract(Month from r1.dataEntrada) or 
    (mesInicio=Extract(Month from r1.dataEntrada) and diaInicio<=Extract(Day from r1.dataEntrada))) 
and (Extract(Month from r1.dataEntrada)<mesFim) or 
    (Extract(Month from r1.dataEntrada) = mesFim and Extract(Day from r1.dataEntrada)<=diaFim));

insert into funcionarioCamareira values (500000000);
insert into funcionarioCamareira values (600000000);
insert into funcionarioCamareira values (700000000);
insert into funcionarioCamareira values (800000000);
insert into funcionarioCamareira values (900000000);
insert into funcionarioCamareira values (110000000);


insert into limpeza values (1,11, 500000000, '2020-02-05 19:00:00');
insert into limpeza values (1,11, 500000000, '2020-02-06 19:00:00');
insert into limpeza values (1,11, 500000000, '2020-10-05 19:00:00');
insert into limpeza values (1,2, 500000000, '2020-10-06 19:00:00');
insert into limpeza values (1,3, 500000000, '2020-10-08 19:00:00');
insert into limpeza values (1,11, 500000000, '2020-10-10 19:00:00');
insert into limpeza values (1,2, 600000000, '2020-10-05 19:00:00');
insert into limpeza values (1,2, 700000000, '2020-10-01 19:00:00');
insert into limpeza values (1,1, 500000000, '2020-10-02 19:00:00');
insert into limpeza values (1,11, 500000000, '2020-10-03 19:00:00');

-- PRODUTOS --
--Bebidas
insert into Produto (produto,custo) values ('Coca-Cola',5);
insert into Produto (produto,custo) values ('Fanta',4);
insert into Produto (produto,custo) values ('Champagne',30);
insert into Produto (produto,custo) values ('Vinho Tinto',15);
insert into Produto (produto,custo) values ('Àgua',2);
insert into Produto (produto,custo) values ('Leite de Soja',6);
insert into Produto (produto,custo) values ('Super Bock',5);
insert into Produto (produto,custo) values ('Vinho Verde',13);
insert into Produto (produto,custo) values ('Cidra',7);
--Sncaks mini-bar
insert into Produto (produto,custo) values ('Amendoins',3);
insert into Produto (produto,custo) values ('Cajus',5);
insert into Produto (produto,custo) values ('Lays',4);
insert into Produto (produto,custo) values ('MMs',3);
insert into Produto (produto,custo) values ('Chips Ahoy',5);
insert into Produto (produto,custo) values ('Pipocas',6);
insert into Produto (produto,custo) values ('Pretzels',8);

-- Contas --
insert into Conta (codReserva) values (1);
insert into Conta (codReserva) values (3);
insert into Conta (codReserva) values (4);
insert into Conta (codReserva) values (5);
insert into Conta (codReserva) values (6);
insert into Conta (codReserva) values (11);
insert into Conta (codReserva) values (8);
insert into Conta (codReserva) values (9);
insert into Conta (codReserva) values (10);


-- Consumos --
--Ultimos 6 meses 11-5
insert into Consumos values ('2020-10-02',1,1);
insert into Consumos values ('2020-10-01',10,2);
insert into Consumos values ('2020-10-16',6,9);
insert into Consumos values ('2020-10-02',4,3);
insert into Consumos values ('2020-10-03',13,1);
insert into Consumos values ('2020-10-03',16,4);
insert into Consumos values ('2020-10-15',1,9);
insert into Consumos values ('2020-06-24',3,6);
insert into Consumos values ('2020-10-15',2,7);
insert into Consumos values ('2020-10-02',16,5);
insert into Consumos values ('2020-10-17',2,9);
insert into Consumos values ('2020-09-24',7,8);
insert into Consumos values ('2020-10-01',12,2);
insert into Consumos values ('2020-10-15',11,7);
insert into Consumos values ('2020-10-03',5,5);
insert into Consumos values ('2020-09-23',14,8);
insert into Consumos values ('2020-10-03',12,3);
insert into Consumos values ('2020-06-25',4,6);
insert into Consumos values ('2020-05-16',10,9);--antes
insert into Consumos values ('2020-10-02',16,2);

--Antes dos ultimos 6 meses
/*insert into Consumos values (1,1);
insert into Consumos values (11,1);
insert into Consumos values (9,6);
insert into Consumos values (6,7);
insert into Consumos values (12,4);*/ --ainda por fazer

-- UPDATE da dataAbertura das contas
UPDATE Conta c1
set dataAbertura=(
select min(csm.dataConsumos) from Consumos csm
where csm.nrConta=c1.nrConta);
