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
    -- tipo de quarto
    select ID
    into v_validar_tipo_quarto
    from TIPO_QUARTO
    where id = p_tipo_quarto; -- query lança no_data_found se o parâmetro for inválido
    -- duração | número de pessoas
    if p_duracao < 1 or p_nr_pessoas < 1 then
        raise exInvalidData;
    end if;

    -- obtém o número de quartos reservados com o mesmo tipo_quarto e no mesmo intervalo de datas do pretendido
    select count(id)
    into v_num_quartos_reservados
    from RESERVA
    where ID_TIPO_QUARTO = p_tipo_quarto
      AND p_data <= DATA_SAIDA
      AND p_data + p_duracao >= DATA_ENTRADA;

    -- obtém todos os quartos com o tipo_quarto e lotacao pretendidos
    SELECT count(id)
    into v_num_quartos
    FROM QUARTO
    WHERE ID_TIPO_QUARTO = p_tipo_quarto
      AND LOTACAO_MAXIMA >= p_nr_pessoas;

    -- verifica se existem quartos excedentes tendo em conta o número de reservas com as características pretendidas
    if v_num_quartos_reservados < v_num_quartos then
        return true;
    else
        return false;
    end if;

EXCEPTION
    WHEN exInvalidData THEN
        DBMS_OUTPUT.PUT_LINE('Reserva Inválida! Duração e/ou número de pessoas devem ser valores maiores que zero.');
        RETURN null;
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('Reserva Inválida! Tipo de quarto não existe.');
        RETURN null;
end;
/
SET SERVEROUTPUT ON;

DECLARE
    result boolean;
BEGIN
    -- tipo de quarto inválido, retorna null
    DBMS_OUTPUT.PUT_LINE('====== Tipo de quarto inválido ======');
    result := fncDisponibilidadeReserva(4, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 5, 1);
    if result then
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    else
        if not result then
            DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
        end if;
    end if;
end;
/
DECLARE
    result boolean;
begin
    -- duração inválida, retorna null
    DBMS_OUTPUT.PUT_LINE('====== Duração inválida ======');
    result := fncDisponibilidadeReserva(3, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 0, 1);
    if result then
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    else
        if not result then
            DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
        end if;
    end if;
end;
/
DECLARE
    result boolean;
begin
    -- número de pessoas inválido, retorna null
    DBMS_OUTPUT.PUT_LINE('====== Número de pessoas inválido ======');
    result := fncDisponibilidadeReserva(3, TO_DATE('2020-01-01', 'yyyy-mm-dd'), 5, 0);
    if result then
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    else
        if not result then
            DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
        end if;
    end if;
end;
/
DECLARE
    result boolean;
begin
    -- reserva inválida, retorna false
    DBMS_OUTPUT.PUT_LINE('====== Reserva para dia 03-01-2020 com duração 10 dias ======');
    DBMS_OUTPUT.PUT_LINE('====== Todos os quartos reservados (lotação esgotada)  ======');
    result := fncDisponibilidadeReserva(1, TO_DATE('2020-01-03', 'yyyy-mm-dd'), 10, 2);
    if result then
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    else
        if not result then
            DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
        end if;
    end if;
end;
/
DECLARE
    result boolean;
begin
     -- reserva válida, retorna true
    DBMS_OUTPUT.PUT_LINE('====== Reserva para dia 01-12-2021 com duração 1 dia ======');
    DBMS_OUTPUT.PUT_LINE('====== Sem quartos reservados ======');
    result := fncDisponibilidadeReserva(1, TO_DATE('2021-12-01', 'yyyy-mm-dd'), 1, 1);
    if result then
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    else
        if not result then
            DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
        end if;
    end if;
end;
/
DECLARE
    result boolean;
begin
    -- reserva válida, retorna true
    DBMS_OUTPUT.PUT_LINE('====== Reserva para dia 01-12-2021 com duração 1 dia ======');
    DBMS_OUTPUT.PUT_LINE('====== Apenas alguns quartos reservados ======');
    result := fncDisponibilidadeReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), 2, 1);
    if result then
        DBMS_OUTPUT.PUT_LINE('Reserva disponível.');
    else
        if not result then
            DBMS_OUTPUT.PUT_LINE('Reserva indisponível.');
        end if;
    end if;
end;
/

