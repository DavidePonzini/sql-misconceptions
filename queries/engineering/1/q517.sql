-- Find the idCat of the 'bevande' category
WITH BevandeCategory AS (
    SELECT idCat
    FROM Categoria
    WHERE nome = 'bevande'
),

-- Find all products that are in the 'bevande' category
ProductsInBevande AS (
    SELECT idProd
    FROM Prodotto
    WHERE idCat IN (SELECT idCat FROM BevandeCategory)
),

-- Find all products that were ordered in 2023
OrderedProducts2023 AS (
    SELECT DISTINCT idProd
    FROM DettaglioOrdine do1
    JOIN Ordine o ON do1.idOrd = o.idOrd
    WHERE EXTRACT(YEAR FROM o.data) = 2023
)

-- Select products in the 'bevande' category that were not ordered in 2023
SELECT p.nome
FROM Prodotto p
WHERE p.idCat IN (SELECT idCat FROM BevandeCategory)
AND p.idProd NOT IN (SELECT idProd FROM OrderedProducts2023);
