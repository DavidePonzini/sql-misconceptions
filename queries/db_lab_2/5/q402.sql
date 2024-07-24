SELECT studenti.cognome, studenti.nome, professori.cognome
FROM unicorsi.studenti JOIN unicorsi.professori on relatore=id 
ORDER BY studenti.cognome, studenti.nome ASC;