create or replace FUNCTION fncGetQuartoReserva(pReserva reserva.id%TYPE) RETURN quarto.id%TYPE
IS 

    vIdQuarto quarto.id%TYPE;
    vIdQuarto2 quarto.id%TYPE;
    vUmAnoAtras DATE;
    vNumero INT;
    vEstadoReserva reserva.id_estado_reserva%TYPE;
    vDiasNoQuarto INT;
    vDiasMin INT;

    -- exceções

    idReservaIsNull exception;
    idReservaDoesntExist exception;
    reservasAlreadyHasARoom exception;
    reservaIsNotOpened exception;
    theresNoAvailableRoom exception;
    
    
    -- cursor
    
    CURSOR cQuarto IS
     
    WITH 
    
    -- quartos do mesmo tipo do enviado por parametro
    quartosMesmoTipo as
    
    (SELECT id FROM quarto q
    WHERE q.id_tipo_quarto = (SELECT id_tipo_quarto FROM reserva WHERE id = pReserva)),
    
    -- quartos indisponíveis
    quartosNaoDisponiveis as 
    
    (SELECT ci.id_quarto
    FROM checkIn ci, reserva r
    where ci.id_reserva = r.id AND (SELECT data_entrada from reserva where id=pReserva) BETWEEN r.data_entrada AND r.data_saida
    AND (SELECT data_saida from reserva where id=pReserva) BETWEEN r.data_entrada AND r.data_saida),
    
    --quartos disponiveis
    quartosDisponiveis AS
    
    (SELECT id FROM quartosMesmoTipo 
    WHERE id NOT IN 
    (SELECT id_quarto FROM quartosNaoDisponiveis)),
    
    --quartos por andar
    quartoPorAndar AS
    
    (SELECT qd.id, a.nr_andar
    FROM quartosDisponiveis qd 
    INNER JOIN quarto q ON q.id = qd.id INNER JOIN andar a ON q.id_andar = a.id)
    
    
    --quartos do menor andar
    SELECT id from quartoPorAndar 
    WHERE nr_andar = (SELECT MIN(nr_andar) FROM quartoPorAndar); 


BEGIN

-- retorna null, quando o id é null
    IF pReserva IS null THEN
        RAISE idReservaIsNull;
    END IF;

-- retorna null, quando o id não existe
    SELECT COUNT(*) INTO vNumero 
    FROM reserva 
    WHERE reserva.id = pReserva;
    
    IF vNumero = 0 THEN
        RAISE idReservaDoesntExist;
    END IF;

-- retorna null quando a reserva tem um quarto
    SELECT COUNT(*) INTO vNumero
    FROM checkin ci
    WHERE ci.id_reserva = pReserva;
    
    IF vNumero > 0 THEN
        RAISE reservasAlreadyHasARoom;
    END IF;

-- retorna null quando a reserva não está aberta
    SELECT r.id_estado_reserva into vEstadoReserva
    FROM reserva r
    WHERE r.id = pReserva;
    
    IF vEstadoReserva != 1 THEN
        RAISE reservaIsNotOpened;
    END IF;

--um ano atras
    SELECT
        ADD_MONTHS(TRUNC(sysdate),-12) INTO vUmAnoAtras
    FROM
      DUAL;
      
      vDiasMin:=999999;

        OPEN cQuarto;
        LOOP
            FETCH cQuarto into vIdQuarto;
            EXIT WHEN cQuarto%notfound;

            SELECT sum(diasDaReserva) INTO vDiasNoQuarto 
            FROM (SELECT (b.data - a.data) diasDaReserva 
            FROM checkin a INNER JOIN checkout b ON a.id_reserva = b.id_reserva
            WHERE a.id_quarto = vIdQuarto AND a.data >= vUmAnoAtras);
            
            IF vDiasNoQuarto < vDiasMin THEN
                vDiasMin:=vDiasNoQuarto;
                vIdQuarto2 := vIdQuarto;
            END IF;

        END LOOP;
        CLOSE cQuarto; 

       RETURN vIdQuarto2;

   EXCEPTION
        WHEN idReservaIsNull THEN
            RETURN NULL;
        
        when idReservaDoesntExist then
            RETURN NULL;
        
        when reservasAlreadyHasARoom then
            RETURN NULL;
            
        when reservaIsNotOpened then
            RETURN NULL;
            
        when theresNoAvailableRoom then
            RETURN NULL;

END;
/

SET SERVEROUTPUT ON;


-- reserva real

DECLARE

vReserva reserva.id%TYPE;
vIdQuarto quarto.id%TYPE;


Begin
    begin
    
    DELETE from reserva where id = 76565868;
    INSERT into reserva(id, id_cliente, nome, id_tipo_quarto, data, data_entrada, data_saida, nr_pessoas, preco, id_estado_reserva)
    VALUES (76565868, 196, null, 1, '2045-12-5', '2045-12-6', '2045-12-8', 1, 23, 1);
    SELECT id INTO vReserva
    from reserva 
    where id=76565868;
    
     vIdQuarto:= fncGetQuartoReserva(vReserva);
     dbms_output.put_line('');
     dbms_output.put_line('Id do quarto:' || vIdQuarto);
     
    end;
end;
/

-- reserva null

DECLARE

vReserva reserva.id%TYPE;
vIdQuarto quarto.id%TYPE;


Begin
    begin
    
     vIdQuarto:= fncGetQuartoReserva(null);
     dbms_output.put_line('');
     dbms_output.put_line('Id do quarto:' || vIdQuarto);
     
    end;
end;
/

-- reserva inexistente

DECLARE

vReserva reserva.id%TYPE;
vIdQuarto quarto.id%TYPE;


Begin
    begin
    
     vIdQuarto:= fncGetQuartoReserva(7656565868);
     dbms_output.put_line('');
     dbms_output.put_line('Id do quarto:' || vIdQuarto);
     
    end;
end;
/


-- reserva não aberta

DECLARE

vReserva reserva.id%TYPE;
vIdQuarto quarto.id%TYPE;


Begin
    begin
    
    DELETE from reserva where id = 716565868;
    INSERT into reserva(id, id_cliente, nome, id_tipo_quarto, data, data_entrada, data_saida, nr_pessoas, preco, id_estado_reserva)
    VALUES (716565868, 196, null, 1, '2045-12-5', '2045-12-6', '2045-12-8', 1, 23, 2);
    SELECT id INTO vReserva
    from reserva 
    where id=716565868;
    
     vIdQuarto:= fncGetQuartoReserva(vReserva);
     dbms_output.put_line('');
     dbms_output.put_line('Id do quarto:' || vIdQuarto);
     
    end;
end;
/