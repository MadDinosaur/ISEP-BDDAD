CREATE OR REPLACE PROCEDURE prcRegistarReserva(p_tipo_quarto RESERVA.ID_TIPO_QUARTO%type,
                                               p_data_entrada RESERVA.DATA_ENTRADA%type,
                                               p_data_saida RESERVA.DATA_SAIDA%type,
                                               p_nr_pessoas RESERVA.NR_PESSOAS%type,
                                               p_id_cliente RESERVA.ID_CLIENTE%type DEFAULT NULL,
                                               p_nome_cliente RESERVA.NOME%type DEFAULT NULL,
                                               p_nif_cliente RESERVA.NIF%type DEFAULT NULL,
                                               p_telefone_cliente RESERVA.TELEFONE%type DEFAULT NULL,
                                               p_email_cliente RESERVA.EMAIL%type)
AS
    ex_demasiados_parametros EXCEPTION;
    ex_parametros_insuficientes EXCEPTION;

    v_validar_tipo_quarto  RESERVA.ID_TIPO_QUARTO%type;
    v_validar_data_entrada RESERVA.DATA_ENTRADA%type;
    v_validar_data_saida   RESERVA.DATA_SAIDA%type;
    v_validar_nr_pessoas   RESERVA.NR_PESSOAS%type;
BEGIN
    -- validação dos parâmetros obrigatórios
    select p_tipo_quarto into v_validar_tipo_quarto from reserva; -- raises no_data_found if invalid
    select p_data_entrada into v_validar_data_entrada from RESERVA; -- raises no_data_found if invalid
    select p_data_saida into v_validar_data_saida from RESERVA; -- raises no_data_found if invalid
    select p_nr_pessoas into v_validar_nr_pessoas from RESERVA;
    -- raises no_data_found if invalid
    -- validação dos parâmetros opcionais
    if p_id_cliente is not null then
        if p_nome_cliente is not null
            or p_nif_cliente is not null
            or p_telefone_cliente is not null
            or p_email_cliente is not null then
            raise ex_demasiados_parametros;
        end if;
    else
        if p_nome_cliente is null or p_nif_cliente is null then
            raise ex_parametros_insuficientes;
        end if;
    end if;
EXCEPTION
    WHEN ex_demasiados_parametros then
        raise_application_error(-20003,
                                'Não é possível especificar o nome, o NIF, o telefone nem o email juntamente com o id.');
    when ex_parametros_insuficientes then
        raise_application_error(-20004, 'É obrigatório preencher o nome e o nif caso não seja introduzido um id.');
end;
