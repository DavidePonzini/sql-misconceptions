SELECT studenti.nome, studenti.cognome, professori.cognome FROM studenti join professori on studenti.relatore=professori.id
ORDER BY studenti.cognome, professori.cognome ASC;
