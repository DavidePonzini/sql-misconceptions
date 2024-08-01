SELECT p.nome
FROM Prodotto p
LEFT JOIN DettaglioOrdine d ON p.idProd = d.idProd
LEFT JOIN Ordine o ON d.idOrd = o.idOrd
LEFT JOIN Cliente c ON o.idClient = c.idClient
WHERE c.città IS NULL 
   OR c.città NOT IN ('Venezia', 'Brescia');
