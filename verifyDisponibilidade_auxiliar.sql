create or replace function verifyDisponibilidade(pIdQuarto int, pData date) return boolean
is
  vCont int;
  
begin
  select count(*) into vCont
    from checkin a left join checkout b on (a.id_reserva = b.id_reserva)
   where a.id_quarto = pIdQuarto
     and ((a.data <= trunc(pData) and b.data >= trunc(pData)) or
     (a.data >= trunc(pData) and b.data is null));
  return (vCont > 0);
  
end;