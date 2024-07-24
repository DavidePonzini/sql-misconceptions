SELECT studenti.cognome, studenti.nome, professori.cognome
FROM studenti  
JOIN professori
ON studenti.relatore = professori.id
ORDER BY studenti.cognome, studenti.nome