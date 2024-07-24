SELECT studenti.cognome, studenti.nome, professori.cognome
FROM studenti JOIN professori on relatore=id 
ORDER BY studenti.cognome, studenti.nome ASC;