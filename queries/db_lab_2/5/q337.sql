SELECT studenti.nome, studenti.cognome, professori.cognome FROM unicorsi.studenti join unicorsi.professori on studenti.relatore=professori.id
ORDER BY studenti.cognome, professori.cognome ASC;
