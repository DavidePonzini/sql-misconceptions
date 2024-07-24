SELECT studenti.nome,studenti.cognome,professori.cognome FROM studenti 
INNER JOIN professori ON professori.id=studenti.relatore
ORDER BY studenti.cognome,studenti.nome ASC
