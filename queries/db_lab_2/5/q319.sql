SELECT studenti.cognome, studenti.nome, professori.cognome
FROM unicorsi.studenti JOIN unicorsi.professori ON professori.id = studenti.relatore
ORDER BY studenti.cognome, studenti.nome;