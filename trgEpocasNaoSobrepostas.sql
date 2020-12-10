CREATE OR REPLACE TRIGGER trgEpocasNaoSobrepostas

BEFORE INSERT OR UPDATE ON EPOCA
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 

/*
    CURSOR cDataInicio IS
        SELECT data_ini
        FROM epoca;
   
    CURSOR cDataFim is
        SELECT data_fim
        FROM epoca;

*/
    vDataInicio epoca.data_ini%TYPE;
    vDataFim epoca.data_fim%TYPE;
    
    dataInicioException EXCEPTION;
    dataFimException EXCEPTION;
    
    
BEGIN

    LOOP
      --  FETCH cDataInicio INTO vDataInicio;
      --  FETCH cDataFim INTO vDataFim;
            
        IF(:new.data_ini between vDataInicio AND vDataFim) THEN
    
            raise dataInicioException;
    
        END IF;
    
        IF(:new.data_fim between vDataInicio AND vDataFim) THEN
    
            raise dataFimException;
    
        END IF;
    END LOOP;

EXCEPTION
    WHEN dataInicioException THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data Início Inválida');
        
    WHEN dataFimException THEN
        raise_application_error(-20002, 'Data Fim Inválida.');
END;
/

alter trigger trgEpocasNaoSobrepostas enable;
set SERVEROUTPUT on;
    
insert into epoca(id, nome, data_ini, data_fim) values(5, 'Época 2', to_date('2020-04-03', 'yyyy-mm-dd'), to_date('2020-06-30', 'yyyy-mm-dd'));
    