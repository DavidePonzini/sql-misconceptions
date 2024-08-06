-- 1. Find the ID of the "beverages" category
WITH BeveragesCategory AS (
    SELECT idCat
    FROM Categoria
    WHERE nome = 'bevande'
),

-- 2. Find products in the "beverages" category
BeveragesProducts AS (
    SELECT idProd, nome
    FROM Prodotto
    WHERE idCat = (SELECT idCat FROM BeveragesCategory)
),

-- 3. Find products that were ordered in 2023
OrderedProducts2023 AS (
    SELECT DISTINCT idProd
    FROM DettaglioOrdine
    JOIN Ordine ON DettaglioOrdine.idOrd = Ordine.idOrd
    WHERE EXTRACT(YEAR FROM Ordine.data) = 2023
)

-- 4. Select products in the "beverages" category that were NOT ordered in 2023
SELECT nome
FROM BeveragesProducts
WHERE idProd NOT IN (SELECT idProd FROM OrderedProducts2023);
