CREATE OR REPLACE FUNCTION fncDisponibilidadeReserva(p_tipo_quarto RESERVA.ID_TIPO_QUARTO%type,
                                                     p_data RESERVA.DATA%type, p_duracao integer,
                                                     p_nr_pessoas RESERVA.NR_PESSOAS%type)
    RETURN boolean IS
    exInvalidData EXCEPTION;
begin
    -- validação de dados
    select p_tipo_quarto from reserva; -- raises no_data_found if invalid
    select p_data from RESERVA; -- raises no_data_found if invalid
    select p_nr_pessoas from RESERVA;  -- raises no_data_found if invalid
    if p_duracao < 1 then
        raise exInvalidData;
    end if;

EXCEPTION
    WHEN exInvalidData THEN
        RAISE_APPLICATION_ERROR(-20001, 'Duração inválida.');
        RETURN null;
    WHEN no_data_found then
        raise_application_error(-20002, 'Dados inválidos.');
        RETURN null;
end;