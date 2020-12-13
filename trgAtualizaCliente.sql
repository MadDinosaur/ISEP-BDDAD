CREATE OR REPLACE TRIGGER trgAtualizaCliente
    AFTER INSERT or update of ID_CLIENTE
    ON RESERVA
    for each row
    DECLARE v_validar_id RESERVA.ID_CLIENTE%type;
BEGIN
    if :new.ID_CLIENTE is not null then
        SELECT id into v_validar_id FROM CLIENTE where CLIENTE.ID = :new.ID_CLIENTE; -- raises no_data_found if invalid
        update reserva
        set NOME     = (SELECT nome from CLIENTE where CLIENTE.id = :new.ID_CLIENTE),
            NIF      = (SELECT NIF from CLIENTE where CLIENTE.id = :new.ID_CLIENTE),
            TELEFONE = (SELECT TELEFONE FROM CLIENTE WHERE CLIENTE.id = :new.ID_CLIENTE),
            EMAIL    = (SELECT EMAIL FROM CLIENTE WHERE CLIENTE.id = :new.ID_CLIENTE);
    end if;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20006, 'ID de Cliente inválido');
end trgAtualizaCliente;
/
alter trigger trgAtualizaCliente disable ;
BEGIN
    insert into reserva(ID, ID_CLIENTE, ID_TIPO_QUARTO) values (501,2000, 1); -- cliente inválido, gera uma exceção
    insert into RESERVA(ID, ID_CLIENTE, ID_TIPO_QUARTO) values (501, 1, 1); -- ativa o trigger
end;
/