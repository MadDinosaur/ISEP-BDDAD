CREATE OR REPLACE PROCEDURE prcCheckOut(pReserva reserva%ROWTYPE) 
AS

    vNumero int;
    vCheckoutDate checkout.data%TYPE; 
    vValorExtra checkout.valor_extra%TYPE := 0;
    vPrecoReserva fatura.valor_faturado_reserva%TYPE;
    vPrecoConsumo fatura.valor_faturado_consumo%TYPE;
    
    vIdMaximo fatura.id%TYPE;
    vNumeroMaximo fatura.id%TYPE;

    parametroInvalidoException EXCEPTION;

BEGIN

    IF (pReserva IS NULL) THEN
    
        RAISE parametroInvalidoException;
        
    END IF;
    
    SELECT COUNT(*) into vNumero
    FROM reserva
    GROUP BY id
    HAVING id=pReserva.id;
    
    IF vNumero!=0 THEN
    
        RAISE parametroInvalidoException;
        
    END IF;
    
    SELECT 
        SYSDATE INTO vCheckoutDate
    FROM DUAL;

    vValorExtra := (vCheckoutDate - pReserva.data_saida) * pReserva.custo_extra;
    vPrecoReserva := (pReserva.data_saida - pReserva.data_entrada) * pReserva.preco;

    SELECT SUM(lcc.preco_unitario * lcc.quantidade) INTO vPrecoConsumo
    FROM linha_conta_consumo lcc
    WHERE lcc.id_conta_consumo = (SELECT id FROM conta_consumo WHERE id_reserva = pReserva.id);
   
    SELECT MAX(id)+1 INTO vIdMaximo
    FROM fatura;
   
    IF vIdMaximo=null THEN
    vIdMaximo:=1;
    END IF;
   
    SELECT MAX(numero)+1 INTO vNumeroMaximo 
    FROM fatura;
    
    IF vNumeroMaximo=null THEN
    vIdMaximo:=1;
    END IF;

   INSERT INTO checkout(id_reserva, data, valor_extra) VALUES (pReserva.id, vCheckoutDate, vValorExtra);
   INSERT INTO fatura(id, numero, data, id_cliente, id_reserva, valor_faturado_reserva, valor_faturado_consumo) VALUES (vIdMaximo, NSEI, vCheckoutDate, pReserva.id_cliente, pReserva.id, vPrecoReserva, vPrecoConsumo);

    exception
        when parametroInvalidoException then
            RAISE_APPLICATION_ERROR(-20001, 'Parametro Inválido');
        
            
END;

