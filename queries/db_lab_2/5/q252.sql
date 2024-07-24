SELECT studenti.cognome, studenti.nome, professori.cognome
FROM studenti  JOIN professori 
ON studenti.relatore = professori.id
WHERE studenti.relatore IS NOT NULL
ORDER BY studenti.cognome