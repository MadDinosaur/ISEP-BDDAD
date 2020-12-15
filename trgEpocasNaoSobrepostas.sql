CREATE OR REPLACE TRIGGER trgEpocasNaoSobrepostas
AFTER INSERT OR UPDATE ON EPOCA
    
    DECLARE
    vValidarEpoca INTEGER;
    
    dataErradaException EXCEPTION;
    
BEGIN

    SELECT COUNT(*) INTO vValidarEpoca
    FROM epoca ep
    WHERE EXISTS (
        SELECT ep2.id 
        FROM epoca ep2
        WHERE (ep.data_fim BETWEEN ep2.data_ini AND ep2.data_fim OR
              ep.data_ini BETWEEN ep2.data_ini AND ep2.data_fim) 
           AND ep.ROWID != ep2.ROWID);

    IF vValidarEpoca > 0 THEN

            RAISE dataErradaException;
          
    END IF;
    
    EXCEPTION
        WHEN dataErradaException THEN
          RAISE_APPLICATION_ERROR(-20001, 'Datas Sobrepostas');
END;
/
    
-- falha insert
insert into epoca(id, nome, data_ini, data_fim) values(5, 'Época 9', to_date('2020-04-03', 'yyyy-mm-dd'), to_date('2020-06-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(5, 'Época 10', to_date('2021-04-03', 'yyyy-mm-dd'), to_date('2022-06-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(5, 'Época 11', to_date('2020-04-03', 'yyyy-mm-dd'), to_date('2021-06-30', 'yyyy-mm-dd'));

-- falha update

UPDATE epoca
SET data_ini = to_date('2020-04-03', 'yyyy-mm-dd')
where id=2;

UPDATE epoca
SET data_fim = to_date('2020-06-30', 'yyyy-mm-dd')
where id=2;

-- insert funcional


insert into epoca(id, nome, data_ini, data_fim) values(5, 'Época 2', to_date('2021-04-03', 'yyyy-mm-dd'), to_date('2021-06-30', 'yyyy-mm-dd'));

-- update funcional

UPDATE epoca
SET data_fim = to_date('2025-06-30', 'yyyy-mm-dd')
where id=2;

UPDATE epoca
SET data_ini = to_date('2025-04-03', 'yyyy-mm-dd')
where id=2;

