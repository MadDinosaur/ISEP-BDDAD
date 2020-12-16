-- 5 --
Create or Replace Procedure prcAtualizarBonusCamareiras(
  p_mes in Integer,
  p_ano in Integer default (extract(year from sysdate))) 
as
    v_informacao sys_refcursor;
    v_id Camareira.id%type;
    v_nomeCamareira Funcionario.nome%type;
    v_totalConsumos Artigo_Consumo.preco%type;
    v_dataMin Linha_Conta_Consumo.data_registo%type;
    v_dataMax Linha_Conta_Consumo.data_registo%type;
    v_diasSemRegistos int;
    v_bonus artigo_consumo.preco%type;
    ex_valoresInvalidos exception;
begin
    v_informacao:=fncObterRegistoMensalCamareira(p_mes,p_ano);
    if v_informacao is null then 
        raise ex_valoresInvalidos;
    end if;
    loop
        fetch v_informacao into v_id,v_nomeCamareira,v_totalConsumos,v_dataMin,v_dataMax,v_diasSemRegistos;
        exit when v_informacao%notfound;
        if v_totalConsumos > 1000 then
            v_bonus:=0.15*v_totalConsumos;
        elsif v_totalConsumos >= 500 then
            v_bonus:=0.1*v_totalConsumos;
        elsif v_totalConsumos > 100 then
            v_bonus:=0.05*v_totalConsumos;
        else
            v_bonus:=0;
        end if;
        update Camareira
         set bonus=v_bonus
         where id=v_id;
    end loop;
exception
    when ex_valoresInvalidos then
        raise_application_error(-20011,'Parametro(s)s inválido(s)');
end;
/
-- Testes
alter trigger trgCorrigirAlteracaoBonus disable;

select * from Camareira;
/
call prcAtualizarBonusCamareiras(3,2020);
/
select * from Camareira;
rollback;

select * from Camareira;
call prcAtualizarBonusCamareiras(5,2020);
select * from Camareira;
rollback;

select * from Camareira;
call prcAtualizarBonusCamareiras(1);
select * from Camareira;
rollback;