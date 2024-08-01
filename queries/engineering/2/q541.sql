SELECT Importo_totale= SUM Importo_Prodotto FROM
(SELECT Importo_prodotto = (prodotto.prezzo * Dettaglio_Oridne.quantità) FROM
Ordine O INNER JOIN Dettaglio_ORdine D ON O.idOrd = D.dord
INNER JOIN PRODOTTO P ON P.idprod = D.idProd
WHERE O.Data=MAX(O.data) 
AND O.idCLient='1234'
