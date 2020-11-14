INSERT INTO tipoQuarto VALUES ('single');
INSERT INTO tipoQuarto VALUES ('twin');
INSERT INTO tipoQuarto VALUES ('superior');
INSERT INTO tipoQuarto VALUES ('suite');

INSERT INTO andar VALUES (1, 'primeiro');
INSERT INTO andar VALUES (2, 'segundo');
INSERT INTO andar VALUES (3, 'terceiro');
INSERT INTO andar VALUES (4, 'quarto');
INSERT INTO andar VALUES (5, 'quinto');


INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 1, 'single');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (1, 3, 'suite');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (2, 2, 'twin');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (3, 4, 'superior');
INSERT INTO quarto (numeroAndar, lotacaoMax, tipoQuarto) VALUES (4, 4, 'superior');

INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (1, 10, 000000001, 'microondas', '2020-10-01 08:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (2, 12, 000000001, 'microondas', '2020-10-01 08:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (2, 12, 000000002, 'forno', '2020-10-02 09:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (3, 15, 000000001, 'ar condicionado', '');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (4, 16, 000000002, 'microondas','2020-10-01 10:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (1, 11, 000000003, 'forno', null);
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (2, 12, 000000004, 'ar condicionado','2020-10-04 16:00:00');
INSERT INTO manutencao (numeroandar, numeroSequencial, funcionarioNIF, equipamento, data) VALUES (3, 15, 000000001, 'forno', '2020-10-02 08:00:00');
