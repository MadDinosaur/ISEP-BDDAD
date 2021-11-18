--1
select * from CD;
--2
select * from MUSICA;

--A1
select TITULO, DATACOMPRA from CD;
--A2
select distinct DATACOMPRA from cd;
--A3
select distinct CODCD, INTERPRETE from MUSICA;
--A4
select distinct codcd as "Código do CD", INTERPRETE from MUSICA;
--A5
select TITULO, VALORPAGO, (ROUND((VALORPAGO*0.23)/1.23,2)) as IVA from CD;

--B1
select * from MUSICA where CODCD = 2;
--B2
select * from MUSICA where CODCD <> 2;
--B3
select * from MUSICA where CODCD = 2 and DURACAO between 4 and 6;
--B4
select * from MUSICA where CODCD = 2 and DURACAO < 4 or DURACAO > 6;
--B5
select * from MUSICA where NRMUSICA in (1,3,5,6);
--B6
select * from MUSICA where NRMUSICA not in (1,3,5,6);
--B7
select * from MUSICA where lower(INTERPRETE) like ('orquestra%');
--B8

