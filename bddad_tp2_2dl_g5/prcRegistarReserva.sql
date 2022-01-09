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
    ex_parametros_invalidos EXCEPTION;
    ex_demasiados_parametros EXCEPTION;
    ex_parametros_insuficientes EXCEPTION;
    ex_reserva_indisponivel EXCEPTION;
    -- variáveis para validação dos parâmetros
    v_validar_tipo_quarto RESERVA.ID_TIPO_QUARTO%type;
    -- variáveis para inserção
    v_id_max              RESERVA.ID%type;
BEGIN
    -- validação dos parâmetros obrigatórios
    -- tipo de quarto
    select ID
    into v_validar_tipo_quarto
    from TIPO_QUARTO
    where id = p_tipo_quarto; -- query lança no_data_found se o parâmetro for inválido
    -- datas e número de pessoas
    if p_data_entrada >= p_data_saida or p_nr_pessoas < 1 then
        raise ex_parametros_invalidos;
    end if;

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
    values (v_id_max, p_id_cliente, p_nome_cliente, p_nif_cliente, p_email_cliente, p_telefone_cliente, p_tipo_quarto,
            sysdate,
            p_data_entrada, p_data_saida, p_nr_pessoas, 1);
EXCEPTION
    WHEN ex_parametros_invalidos then
        raise_application_error(-20002,
                                'Parâmetros inválidos: intervalo de datas errado ou número de pessoas inferior a 1');
    WHEN no_data_found then
        raise_application_error(-20003, 'Parâmetros não encontrados: tipo de quarto não existe.');
    WHEN ex_demasiados_parametros then
        raise_application_error(-20004,
                                'Não é possível especificar o nome, o NIF, o telefone nem o email juntamente com o id.');
    when ex_parametros_insuficientes then
        raise_application_error(-20005, 'É obrigatório preencher o nome e o nif caso não seja introduzido um id.');
    when ex_reserva_indisponivel then
        raise_application_error(-20006, 'Não é possível fazer a reserva para as datas selecionadas.');
end;
/
-- inserir data de entrada após data de saída --> gera exceção
begin
    DBMS_OUTPUT.PUT_LINE('====== Teste 1: Datas inválidas (Data de entrada após data de saída) ======');
end;
call prcRegistarReserva(1, TO_DATE('2020-01-08', 'yyyy-mm-dd'), TO_DATE('2020-01-06', 'yyyy-mm-dd'), 1, 1);

-- inserir id do cliente, juntamente com o nome e nif --> gera exceção
begin
    DBMS_OUTPUT.PUT_LINE('====== Teste 2: Parâmetros inválidos (Inserir ID do cliente juntamente com nome e NIF) ======');
end;
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1, 1, 'Cliente 1',
                        '123');

-- inserir apenas o nome do cliente, sem nif --> gera exceção
begin
    DBMS_OUTPUT.PUT_LINE('====== Teste 3: Parâmetros inválidos (Inserir apenas o nome do cliente, sem NIF) ======');
end;
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1, null,
                        'Cliente 1');

-- inserir reserva com o id de cliente
begin
    DBMS_OUTPUT.PUT_LINE('====== Teste 4: Registo de reserva para o cliente com ID: 1 ======');
end;
SELECT * FROM RESERVA WHERE ID = 3651;
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1, 1);
SELECT * FROM RESERVA WHERE ID = 3651;
ROLLBACK;

-- inserir reserva com o nome e nif do cliente
begin
    DBMS_OUTPUT.PUT_LINE('====== Teste 5: Registo de reserva para o cliente com o nome "Cliente novo" e NIF: 999 ======');
end;
SELECT * FROM RESERVA WHERE ID = 3651;
CALL prcRegistarReserva(1, TO_DATE('2020-01-06', 'yyyy-mm-dd'), TO_DATE('2020-01-08', 'yyyy-mm-dd'), 1, null,
                        'Cliente novo', '999');
SELECT * FROM RESERVA WHERE ID = 3651;
ROLLBACK;
