SELECT IdG 
FROM GIOCATORE 
JOIN GIOCAIN AS G ON GIOCATORE.IdG = G.IdG 
JOIN CATEGORIA ON G.IdCat = CATEGORIA.IdCat 
WHERE Genere = 'F' 
AND NomeCategoria = 'Singolo' IN (
SELECT IdG 
FROM GIOCATORE 
INNER JOIN GIOCAIN ON GIOCATORE.IdG = GIOCAIN.IdG 
INNER JOIN CATEGORIA ON GIOCAIN.IdCat = CATEGORIA.IdCat 
WHERE G.IdT = GIOCAIN.IdT 
AND GENERE = 'F' 
AND NomeGenere = 'Doppio';
)


