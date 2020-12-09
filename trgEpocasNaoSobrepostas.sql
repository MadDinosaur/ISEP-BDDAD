CREATE OR REPLACE TRIGGER trgEpocasNaoSobrepostas

BEFORE INSERT OR UPDATE ON EPOCA

DECLARE 

    CURSOR cDataInicio IS
        SELECT data_ini
        FROM epoca;
   
    CURSOR cDataFim is
        SELECT data_ini
        FROM epoca;

    vDataInicio cDataInicio%ROWTYPE;
    vDataFim cDataFim%ROWTYPE;
    
    dataInicioException EXCEPTION;
    dataFimException EXCEPTION;
    
BEGIN

    LOOP
        FETCH cDataInicio INTO vDataInicio;
        FETCH cDataFim INTO vDataFim;
            
        IF(:new.data_ini>vDataInicio AND :new.data_ini<vDataFim) THEN
    
            raise dataInicioException;
    
        END IF;
    
        IF(:new.data_fim>vDataInicio AND :new.data_fim<vDataFim) THEN
    
            raise dataFimException;
    
        END IF;
    END LOOP;
END;

EXCEPTION
    WHEN dataInicioException THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data Início Inválida');
        RETURN null;
        
    WHEN dataFimException THEN
        raise_application_error(-20002, 'Data Fim Inválida.');
        RETURN null;
END;
/
    
    
    