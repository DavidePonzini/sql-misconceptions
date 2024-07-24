SELECT studenti.cognome, studenti.nome, professori.cognome
FROM studenti JOIN professori ON professori.id = studenti.relatore
ORDER BY studenti.cognome, studenti.nome;