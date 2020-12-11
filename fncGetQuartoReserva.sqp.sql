create or replace function fncGetQuartoReseva(vReserva reserva.id%type) return 
quarto.id%type

is
    vNumero int;
    vEstadoReserva reserva.id_estado_reserva%type;
    cQuartoId sys_refcursor;
    vDataEntrada reserva.data_entrada%type;
    vQuartoId quarto.id%type;
    
    idReservaIsNull exception;
    idReservaDoesntExist exception;
    reservasAlreadyHasARoom exception;
    reservaIsNotOpened exception;

begin

-- retorna null, quando o id é null
    if vReserva is null then
        raise idReservaIsNull;
    end if;

-- retorna null, quando o id não existe
    select count(*) into vNumero 
    from reserva 
    where reserva.id = vReserva;
    
    if vNumero = 0 then
        raise idReservaDoesntExist;
    end if;

-- retorna null quando a reserva tem um quarto
    select count(*) into vNumero
    from checkin ci
    where ci.id_reserva = vReserva;
    
    if vNumero > 0 then
        raise reservasAlreadyHasARoom;
    end if;

-- retorna null quando a reserva não está aberta
    select r.id_estado_reserva into vEstadoReserva
    from reserva r
    where r.id = vReserva;
    
    if vEstadoReserva != 1 then
        raise reservaIsNotOpened;
    end if;

-- obtem o tipo de quarto

    select r.id_tipo_quarto, r.data_entrada into vTipoQuarto, vDataEntrada
    from reserva r
    where r.id = vReserva;


    
    exception
        when idReservaIsNull then
            return null;
        
        when idReservaDoesntExist then
            return null;
        
        when reservasAlreadyHasARoom then
            return null;
            
        when reservaIsNotOpened then
            return null;
end;