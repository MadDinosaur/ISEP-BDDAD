CREATE OR REPLACE PROCEDURE prcRegistarReserva(p_tipo_quarto RESERVA.ID_TIPO_QUARTO%type,
                                               p_data_entrada RESERVA.DATA_ENTRADA%type,
                                               p_data_saida RESERVA.DATA_SAIDA%type,
                                               p_nr_pessoas RESERVA.NR_PESSOAS%type,
                                               p_id_cliente RESERVA.ID_CLIENTE%type DEFAULT NULL,
                                               p_nome_cliente RESERVA.NOME%type DEFAULT NULL,
                                               p_nif_cliente RESERVA.NIF%type DEFAULT NULL,
                                               p_telefone_cliente RESERVA.TELEFONE%type DEFAULT NULL,
                                               p_email_cliente RESERVA.EMAIL%type DEFAULT NULL)
AS
    ex_demasiados_parametros EXCEPTION;
    ex_parametros_insuficientes EXCEPTION;
    ex_reserva_indisponivel EXCEPTION;
    -- variáveis para validação dos parâmetros
    v_validar_tipo_quarto  RESERVA.ID_TIPO_QUARTO%type;
    -- variáveis para inserção
    v_id_max RESERVA.ID%type;
BEGIN
    -- validação dos parâmetros obrigatórios
    select ID_TIPO_QUARTO
    into v_validar_tipo_quarto
    from reserva
    where ID_TIPO_QUARTO = p_tipo_quarto
    group by ID_TIPO_QUARTO; -- gera no_data_found se não existir

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
    -- validação da disponibilidade da reserva
    if not FNCDISPONIBILIDADERESERVA(p_tipo_quarto, p_data_entrada, (p_data_saida - p_data_entrada), p_nr_pessoas) then
        raise ex_reserva_indisponivel;
    end if;
    -- registo da reserva
    select max(id) + 1 into v_id_max from RESERVA; -- procura o próximo id na tabela

    insert into RESERVA(id, id_cliente, nome, nif, email, telefone, id_tipo_quarto, data, data_entrada, data_saida,
                        nr_pessoas, id_estado_reserva)
    values(v_id_max, p_id_cliente, p_nome_cliente, p_nif_cliente, p_email_cliente, p_telefone_cliente, p_tipo_quarto, sysdate,
            p_data_entrada, p_data_saida, p_nr_pessoas, 1);
EXCEPTION
    WHEN ex_demasiados_parametros then
        raise_application_error(-20003,
                                'Não é possível especificar o nome, o NIF, o telefone nem o email juntamente com o id.');
    when ex_parametros_insuficientes then
        raise_application_error(-20004, 'É obrigatório preencher o nome e o nif caso não seja introduzido um id.');
    when ex_reserva_indisponivel then
        raise_application_error(-20005, 'Não é possível fazer a reserva para as datas selecionadas.');
end;
/
-- inserir id do cliente, juntamente com o nome e nif --> gera exceção
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1, 1, 'Cliente 1', '123');

-- inserir apenas o nome do cliente, sem nif --> gera exceção
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1,null, 'Cliente 1');

-- inserir reserva com o id de cliente
SELECT * FROM RESERVA WHERE ID = 3651;
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1, 1);
SELECT * FROM RESERVA WHERE ID = 3651;
ROLLBACK;

-- inserir reserva com o nome e nif do cliente
SELECT * FROM RESERVA WHERE ID = 3651;
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1, null, 'Cliente novo', '999');
SELECT * FROM RESERVA WHERE ID = 3651;
ROLLBACK;
