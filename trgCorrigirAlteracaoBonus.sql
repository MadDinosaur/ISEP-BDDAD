Create or Replace Trigger trgCorrigirAlteracaoBonus
    before update of bonus on Camareira
    for each row
begin
    if :new.bonus<:old.bonus or :new.bonus> 1.5*:old.bonus then
        dbms_output.put_line('Bonus da camareira: ' || :new.id ||' não atualizado.' );
        return;
    else
        dbms_output.put_line('Bonus da camareira: ' || :new.id ||' atualizado.' );
    end if;
end trgCorrigirAlteracaoBonus;
/
SET SERVEROUTPUT ON;
alter trigger trgCorrigirAlteracaoBonus enable;
begin
prcAtualizarBonusCamareiras(3,2020);
end;
/
begin
prcAtualizarBonusCamareiras(5,2020);
end;