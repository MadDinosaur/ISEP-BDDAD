-- 6 --
Create or Replace Trigger trgCorrigirAlteracaoBonus
    before update of bonus on Camareira
    for each row
begin
    if :new.bonus<:old.bonus or :new.bonus> 1.5*:old.bonus then
        :new.bonus:=:old.bonus;
        dbms_output.put_line('Bonus da camareira: ' || :new.id ||' não atualizado.' );
    else
        dbms_output.put_line('Bonus da camareira: ' || :new.id ||' atualizado.' );
    end if;
end trgCorrigirAlteracaoBonus;
/
-- Testes
SET SERVEROUTPUT ON;
alter trigger trgCorrigirAlteracaoBonus enable;
select * from Camareira;
begin
prcAtualizarBonusCamareiras(3,2020);
end;
/
select * from Camareira;
/
begin
prcAtualizarBonusCamareiras(5,2020);
end;
/
select * from Camareira;
/
begin
prcAtualizarBonusCamareiras(2,2020);
end;
/
select * from Camareira;
/
begin
prcAtualizarBonusCamareiras(1,2020);
end;
/
select * from Camareira;