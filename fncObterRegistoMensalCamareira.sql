-- 4 --
Create or Replace function fncObterRegistoMensalCamareira(
 p_mes in integer,
 p_ano in integer default (extract(year from sysdate)-1)) 
return sys_refcursor
is
    v_informacao sys_refcursor;
    ex_mesInvalido exception;
begin
    if p_mes < 1 or p_mes > 12 then
        raise ex_mesInvalido;
    end if;
    open v_informacao for
        select c.id, f.nome, sum(ac.preco), min(lcc.data_registo), max(lcc.data_registo),
        (31 - count(lcc.id_camareira))
          from camareira c
          inner join funcionario f on f.id=c.id
          inner join linha_conta_consumo lcc on lcc.id_camareira=c.id
          inner join artigo_consumo ac on ac.id=lcc.id_artigo_consumo
          where extract(year from lcc.data_registo) = p_ano 
          and extract(month from lcc.data_registo) = p_mes 
          group by c.id, f.nome;
    return (v_informacao);
exception
    when ex_mesInvalido then
        return null;
    when no_data_found then 
        return null;
end;
/
SET SERVEROUTPUT ON
declare
    v_informacao sys_refcursor;
    v_id Camareira.id%type;
    v_nomeCamareira Funcionario.nome%type;
    v_totalPreco Artigo_Consumo.preco%type;
    v_dataMin Linha_Conta_Consumo.data_registo%type;
    v_dataMax Linha_Conta_Consumo.data_registo%type;
    v_diasSemRegistos int;
begin
    v_informacao:=fncObterRegistoMensalCamareira(2,2020);
    if v_informacao is null then
        dbms_output.put_line('Mes Inválido');
    else    
        loop 
            fetch v_informacao 
             into v_id,v_nomeCamareira,v_totalPreco,v_dataMin,v_dataMax,v_diasSemRegistos;
             exit when v_informacao%notfound;
             dbms_output.put_line(v_id || ' | ' || v_nomeCamareira || ' | ' || v_totalPreco || ' | '  || v_dataMin || ' | '  || v_dataMax || ' | '  || v_diasSemRegistos);
        end loop;
    end if;
end;
/