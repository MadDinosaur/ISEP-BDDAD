CREATE OR REPLACE PROCEDURE prcCheckOut(pReserva reserva%ROWTYPE) 
AS

    vNumero int;
    vCheckoutDate checkout.data%TYPE; 
    vValorExtra checkout.valor_extra%TYPE;
    vPrecoReserva fatura.valor_faturado_reserva%TYPE;
    vPrecoConsumo fatura.valor_faturado_consumo%TYPE;
    vReservaHasCheckout reserva.id%TYPE;
    vFatura fatura.id%TYPE;
    
    vIdMaximo fatura.id%TYPE;
    vNumeroMaximo fatura.id%TYPE;
    
    CURSOR cIdCheckout IS
    SELECT id_reserva
    FROM checkout;

    vIdCheckout checkout.id_reserva%TYPE;
    
    parametroInvalidoException EXCEPTION;
    checkoutJaFeito EXCEPTION;
    

BEGIN
    
    SELECT COUNT(*) into vNumero
    FROM reserva
    GROUP BY id
    HAVING id=pReserva.id;
    
    IF vNumero=0 THEN
    
        RAISE parametroInvalidoException;
        
    END IF;
    
    SELECT 
        SYSDATE INTO vCheckoutDate
    FROM DUAL;
    
    vValorExtra:=0;

    IF (pReserva.custo_extra is not null) THEN
    vValorExtra := (vCheckoutDate - pReserva.data_saida) * pReserva.custo_extra;
    END IF;
    
    vPrecoReserva := (pReserva.data_saida - pReserva.data_entrada) * pReserva.preco;

    SELECT SUM(lcc.preco_unitario * lcc.quantidade) INTO vPrecoConsumo
    FROM linha_conta_consumo lcc
    WHERE lcc.id_conta_consumo = (SELECT id FROM conta_consumo WHERE id_reserva = pReserva.id);
    
    SELECT MAX(numero)+1 INTO vNumeroMaximo 
    FROM fatura;
    
    IF vNumeroMaximo=null THEN
    vIdMaximo:=1;
    END IF;
    
    OPEN cIdCheckout;
        LOOP
        FETCH cIdCheckout INTO vIdCheckout;
        
        EXIT WHEN cIdCheckout%notfound;
        
        IF(pReserva.id = vIdCheckout) THEN
        
            RAISE checkoutJaFeito;
            
        END IF;
    
        END LOOP;
    CLOSE cIdCheckout;
    

    vFatura := seq_fatura.nextval;
    
    INSERT INTO checkout(id_reserva, data, valor_extra) VALUES (pReserva.id, vCheckoutDate, vValorExtra);
    INSERT INTO fatura(id, numero, data, id_cliente, id_reserva, valor_faturado_reserva, valor_faturado_consumo) VALUES (vFatura, vFatura, vCheckoutDate, pReserva.id_cliente, pReserva.id, vPrecoReserva, vPrecoConsumo);
    UPDATE reserva
    SET reserva.id_estado_reserva = 5;
    EXCEPTION
        WHEN parametroInvalidoException THEN
            RAISE_APPLICATION_ERROR(-20001, 'Parametro Inválido');
            
        WHEN CheckoutJaFeito THEN
            RAISE_APPLICATION_ERROR(-20002, 'Checkout desta reserva já foi feito');
            
END;
/

DECLARE

vReserva reserva%ROWTYPE;


Begin
    begin
    
    SELECT * INTO vReserva
    from reserva 
    where id=395;
    
       prcCheckOut(vReserva);
    end;
end;
/

DECLARE

vReserva reserva%ROWTYPE;
v_id_reserva reserva.id%TYPE;
vCheck checkout.id_reserva%TYPE;

Begin

    v_id_reserva := seq_reserva.nextval;
    
    INSERT INTO reserva(id, id_cliente, nome, id_tipo_quarto, data, data_entrada, data_saida, nr_pessoas, preco, id_estado_reserva)
    VALUES (v_id_reserva, 196, null, 1, '2045-12-5', '2045-12-6', '2045-12-8', 1, 23, 1);
    
    INSERT INTO checkin(id_reserva, data, id_quarto) VALUES(v_id_reserva, '2045-12-6', 19);
    
    SELECT * INTO vReserva
    FROM reserva 
    WHERE id=v_id_reserva;
    
    prcCheckOut(vReserva);
       
    SELECT id_reserva INTO vCheck
    FROM Checkout
    where id_reserva=v_id_reserva;
       
    dbms_output.put_line('id da reserva: ' || vCheck);
    ROLLBACK;
end;
/



set serveroutput on;


