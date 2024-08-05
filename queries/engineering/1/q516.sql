-- 1. Find the ID of the "bevande" category
WITH BeveragesCategory AS (
    SELECT idCat
    FROM Categoria
    WHERE nome = 'bevande'
),

-- 2. Find products in the "bevande" category
BeveragesProducts AS (
    SELECT idProd, nome
    FROM Prodotto
    WHERE idCat = (SELECT idCat FROM BeveragesCategory)
),

-- 3. Find products that were ordered in 2023
OrderedProducts2023 AS (
    SELECT DISTINCT idProd
    FROM DettaglioOrdine do1
    JOIN Ordine o ON do1.idOrd = o.idOrd
    WHERE EXTRACT(YEAR FROM o.data) = 2023
)

-- 4. Select products in the "bevande" category that were NOT ordered in 2023
SELECT nome
FROM BeveragesProducts
WHERE idProd NOT IN (SELECT idProd FROM OrderedProducts2023);

