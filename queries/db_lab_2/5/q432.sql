SELECT studenti.nome,studenti.cognome,professori.cognome FROM unicorsi.studenti 
INNER JOIN unicorsi.professori ON professori.id=studenti.relatore
ORDER BY studenti.cognome,studenti.nome ASC
