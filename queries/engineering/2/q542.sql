SELECT SUM(PRODOTTO.PREZZO)
FROM PRODOTTO
INNER JOIN DETTAGLIO_ORDINE
ON PRODOTTO.IDPROD=DETTAGLIO_ORDINE.IDPROD
INNER JOIN ORDINE 
ON DETTAGLIO_ORDINE.IDORD=ORDINE.IDORD
WHERE ORDINE.DATA=
(SEELCT MAX (DATA)
FROM ORDINE INNER JOIN CLIENTE
ON ORDINE.IDCLIENT=CLIENTE.IDCLIENT
WHERE CLIENTE.IDCLIENT='1234' )
AND CLIENTE.IDCLIENT='1234' 
