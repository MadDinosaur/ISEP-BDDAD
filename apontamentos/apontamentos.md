# Bases de Dados
## Níveis
1. **Conceptual** - Modelo **E-R**

    | --- Normalização

    v

2. **Lógico** - Modelo **Relacional** (derivado do E-R)
3. **Físico** - **SQL**

## Notação
 E-R | Relacional
-----|------------
![](notacao.svg) | ![](notacao_2.png)

## Modelo Relacional

1. Cada entidade -> Tabela

2. Cada relação N:N -> Tabela

3. Chaves estrangeiras ficam do lado do N (1:N)

## Linguagem SQL
- SELECT
- FROM
- WHERE
- GROUP BY
- HAVING
- ORDER BY

### Subqueries
- Podem retornar **múltiplas linhas** - operador de conjuntos IN, ANY, ...
- Podem ser **correlacionadas** - o SELECT interno é executado a cada linha do SELECT externo
