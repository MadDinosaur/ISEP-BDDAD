-- 6 --
Create or Replace Trigger trgCorrigirAlteracaoBonus
    before update of bonus on Camareira
    for each row
begin
    if :old.bonus<>0 then
        if :new.bonus<:old.bonus or :new.bonus> 1.5*:old.bonus then
            :new.bonus:=:old.bonus;
            dbms_output.put_line('Bonus da camareira: ' || :new.id ||' não atualizado.' );
        else
            dbms_output.put_line('Bonus da camareira: ' || :new.id ||' atualizado.' );
        end if;
    end if;
end trgCorrigirAlteracaoBonus;
/
-- Testes
SET SERVEROUTPUT ON;
alter trigger trgCorrigirAlteracaoBonus enable;
select * from Camareira;
/
call prcAtualizarBonusCamareiras(3,2020);
/
select * from Camareira;
/
call prcAtualizarBonusCamareiras(5,2020);
/
select * from Camareira;
/
call prcAtualizarBonusCamareiras(2,2020);
/
select * from Camareira;
/
call prcAtualizarBonusCamareiras(1,2020);
/
select * from Camareira;
rollback;