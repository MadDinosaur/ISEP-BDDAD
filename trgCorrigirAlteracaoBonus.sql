Create or Replace Trigger trgCorrigirAlteracaoBonus
    before update of bonus on Camareira
    for each row
begin
    if :new.bonus<:old.bonus or :new.bonus> 1.5*:old.bonus then
        raise_application_error(-20010,'Valor do bonus não cumpre os requisitos');
    end if;
end trgCorrigirAlteracaoBonus;
/