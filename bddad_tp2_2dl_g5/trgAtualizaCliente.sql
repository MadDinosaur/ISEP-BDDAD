CREATE OR REPLACE TRIGGER trgAtualizaCliente
    BEFORE INSERT
    ON RESERVA
    for each row
DECLARE
    v_nome CLIENTE.NOME%type;
    v_nif CLIENTE.NIF%type;
    v_telefone CLIENTE.TELEFONE%type;
    v_email CLIENTE.EMAIL%type;
BEGIN
    if :new.ID_CLIENTE is not null then
        SELECT nome, nif, telefone, email into v_nome, v_nif, v_telefone, v_email FROM CLIENTE where CLIENTE.ID = :new.ID_CLIENTE; -- raises no_data_found if invalid
        :new.NOME := v_nome;
        :new.NIF := v_nif;
        :new.TELEFONE := v_telefone;
        :new.EMAIL := v_email;
    end if;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20006, 'ID de Cliente inválido');
end trgAtualizaCliente;
/
alter trigger trgAtualizaCliente enable;

-- cliente inválido, gera uma exceção
begin
    DBMS_OUTPUT.PUT_LINE('====== Teste 1: Cliente inválido (não existente) ======');
end;
insert into reserva(ID, ID_CLIENTE, ID_TIPO_QUARTO) values (3651, 4000, 1);

-- cliente válido, insere a linha com o nome, nif, telefone e email
begin
    DBMS_OUTPUT.PUT_LINE('====== Teste 2: Cliente válido ======');
end;
SELECT * FROM RESERVA WHERE ID = 3651;
insert into RESERVA(ID, ID_CLIENTE, ID_TIPO_QUARTO) values (3651, 1, 1);
SELECT * FROM RESERVA WHERE ID = 3651;
rollback;
