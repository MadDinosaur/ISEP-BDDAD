CREATE OR REPLACE FUNCTION fncDisponibilidadeReserva(p_tipo_quarto RESERVA.ID_TIPO_QUARTO%type,
                                                     p_data RESERVA.DATA_ENTRADA%type, p_duracao integer,
                                                     p_nr_pessoas RESERVA.NR_PESSOAS%type)
    RETURN boolean IS
    exInvalidData EXCEPTION;

    v_num_quartos            integer;
    v_num_quartos_reservados integer;

    -- variáveis para validação dos parâmetros
    v_validar_tipo_quarto    RESERVA.ID_TIPO_QUARTO%type;
begin
    -- validação dos parâmetros
    select ID_TIPO_QUARTO
    into v_validar_tipo_quarto
    from reserva
    where ID_TIPO_QUARTO = p_tipo_quarto
    group by ID_TIPO_QUARTO; -- raises no_data_found if invalid
    if p_duracao < 1 or p_nr_pessoas < 1 then
        raise exInvalidData;
    end if;
    -- obtém o número de quartos reservados com o mesmo tipo_quarto e no mesmo intervalo de datas do pretendido
    select count(id)
    into v_num_quartos_reservados
    from RESERVA
    where ID_TIPO_QUARTO = p_tipo_quarto
      and (DATA_ENTRADA BETWEEN p_data - p_duracao AND p_data + p_duracao
        OR DATA_SAIDA BETWEEN p_data - p_duracao AND p_data + p_duracao);
    -- obtém todos os quartos com o tipo_quarto e lotacao pretendidos
    SELECT count(id)
    into v_num_quartos
    FROM QUARTO
    WHERE ID_TIPO_QUARTO = p_tipo_quarto
      AND LOTACAO_MAXIMA >= p_nr_pessoas;
    -- verifica se existem quartos excedentes tendo em conta o número de reservas com as características pretendidas
    if v_num_quartos_reservados < v_num_quartos then
        return false;
    else
        return true;
    end if;

EXCEPTION
    WHEN exInvalidData THEN
        RAISE_APPLICATION_ERROR(-20001, 'Duração e número de pessoas devem ser valores maiores que zero.');
        RETURN null;
    WHEN no_data_found THEN
        raise_application_error(-20002, 'Dados inválidos.');
        RETURN null;
end;
/
SET SERVEROUTPUT ON;
BEGIN
    -- tipo de quarto inválido, gera exceção
    if not fncDisponibilidadeReserva(4, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 5, 1) then
        DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
    else
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    end if;
end;
/
begin
    -- duração inválida, gera exceção
    if not fncDisponibilidadeReserva(3, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 0, 1) then
        DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
    else
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    end if;
end;
/
begin
    -- número de pessoas inválido, gera exceção
    if not fncDisponibilidadeReserva(3, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 5, 0) then
        DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
    else
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    end if;
end;
/
begin
    -- número de pessoas inválido, gera exceção
    if not fncDisponibilidadeReserva(3, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 5, 0) then
        DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
    else
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    end if;
end;
/
begin
    -- reserva inválida
    if not fncDisponibilidadeReserva(2, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 5, 2) then
        DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
    else
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    end if;
end;
/
begin
    -- reserva válida
    if not fncDisponibilidadeReserva(1, TO_DATE('2020-12-01', 'yyyy-mm-dd'), 1, 1) then
        DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
    else
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    end if;
end;
/

