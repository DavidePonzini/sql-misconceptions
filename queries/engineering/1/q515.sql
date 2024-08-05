-- Step 1: Find the category ID for "bevande"
WITH BevandeCategory AS (
    SELECT idCat
    FROM Categoria
    WHERE nome = 'bevande'
),

-- Step 2: Find products ordered in 2023
OrderedIn2023 AS (
    SELECT DISTINCT idProd
    FROM DettaglioOrdine do1
    JOIN Ordine o ON do1.idOrd = o.idOrd
    WHERE EXTRACT(YEAR FROM o.data) = 2023
)

-- Step 3: Select product names in "bevande" category not ordered in 2023
SELECT p.nome
FROM Prodotto p
JOIN BevandeCategory bc ON p.idCat = bc.idCat
LEFT JOIN OrderedIn2023 o2023 ON p.idProd = o2023.idProd
WHERE o2023.idProd IS NULL;

