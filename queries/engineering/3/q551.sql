SELECT NOME FROM PRODOTTO 
WHERE IDPROD NOT IN (
SELECT IDPROD FROM ORDINE
INNER JOIN DETTAGLIO_ORDINE 
ON ORDINE.IDORD = DETTAGLIOORDINE.IDORD
INNER JOIN CLIENTE
ON ORDINE.IDCLIENT=CLIENTE.IDCLIENT
WHERE città IN ("VENEZIA", "BRESCIA"))
