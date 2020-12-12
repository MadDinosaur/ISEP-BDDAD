Create or Replace Procedure prcAtualizarBonusCamareiras(
  p_mes in Integer,
  p_ano in Integer default (extract(year from sysdate))) 
as
    v_informacao sys_refcursor;
    v_totalConsumos artigo_consumo.preco%type;
    v_bonus artigo_consumo.preco%type;
    ex_valoresInvalidos exception;
begin
    v_informacao:=fncObterRegistoMensalCamareira(p_mes,p_ano);
    if v_informcacao is null then 
        raise ex_valoresInvaidos;
    end if;
    loop
        fetch v_informacao into aaa;
        exit when v_informacao%notfound;
        v_totalConsumos:=v_informacao.totalPreco;
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
         where id=v_informacao.id;
    end loop;
exception
    when ex_valoresInvalidos then
        return null;
end;