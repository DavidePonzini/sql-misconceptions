SELECT studenti.nome, studenti.cognome, professori.cognome
FROM studenti JOIN professori ON studenti.relatore=professori.id
ORDER BY studenti.cognome ASC, studenti.nome ASC;
