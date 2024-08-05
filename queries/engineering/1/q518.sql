SELECT nome
FROM prodotto
WHERE idCat IN (
    SELECT idCat
    FROM categoria
    WHERE nome = 'bevande'
)
AND idProd NOT IN (
    SELECT do1.idProd
    FROM ordine o
    INNER JOIN DettaglioOrdine do1 ON o.idOrd = do1.idOrd
    WHERE EXTRACT(YEAR FROM o.data) = 2023
);
