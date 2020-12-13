create or replace function fncGetQuartoReseva(pReserva reserva.id%type) return 
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
    theresNoAvailableRoom exception;

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

-- obtem o quarto que respeita as condições
-- falta limitar a soma dos dias ao ultimo ano
    open cQuartoId for
        with ocupacao as (
        select ci.id_quarto, sum(co.data - ci.data - 1) as dias
        from checkin ci, checkout co
        where co.id_reserva = ci.id_reserva and ci.data > vDataEntrada - 365
        group by ci.id_quarto)
        
        select q.id
        from quarto q, andar a, ocupacao 
        where q.id_andar = a.id and o.id_quarto = q.id
        order by a.nr_andar, o.dias;
        
        loop
            fetch cQuartoId into vQuartoId;
            exit when cQuartoId%notfound;
            if not isQuartoIndisponivel(vQuartoId, vDataEntrada) then
                return vQuartoId;
            end if;
        end loop;
        
    close cQuartoId;
    
    raise theresnoAvailableRoom;
    
    exception
        when idReservaIsNull then
            return null;
        
        when idReservaDoesntExist then
            return null;
        
        when reservasAlreadyHasARoom then
            return null;
            
        when reservaIsNotOpened then
            return null;
            
        when theresNoAvailableRoom then
            return null;
            
end;