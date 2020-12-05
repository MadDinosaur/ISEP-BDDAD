CREATE OR REPLACE FUNCTION fncDisponibilidadeReserva(p_tipo_quarto RESERVA.ID_TIPO_QUARTO%type,
                                                     p_data RESERVA.DATA%type, p_duracao integer,
                                                     p_nr_pessoas RESERVA.NR_PESSOAS%type)
    RETURN boolean IS
    exInvalidData EXCEPTION;

    v_num_quartos            integer;
    v_num_quartos_reservados integer;

    -- variáveis para select de validação de dados
    v_validar_tipo_quarto    RESERVA.ID_TIPO_QUARTO%type;
    v_validar_data           RESERVA.DATA%type;
    v_validar_nr_pessoas     RESERVA.NR_PESSOAS%type;
begin
    -- validação de dados
    select p_tipo_quarto into v_validar_tipo_quarto from reserva; -- raises no_data_found if invalid
    select p_data into v_validar_data from RESERVA; -- raises no_data_found if invalid
    select p_nr_pessoas into v_validar_nr_pessoas from RESERVA; -- raises no_data_found if invalid
    if p_duracao < 1 then
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
        RAISE_APPLICATION_ERROR(-20001, 'Duração inválida.');
        RETURN null;
    WHEN no_data_found THEN
        raise_application_error(-20002, 'Dados inválidos.');
        RETURN null;
end;
/