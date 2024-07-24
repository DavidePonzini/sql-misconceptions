SELECT studenti.nome,studenti.cognome,'STUDENTE' AS QUALIFICA FROM unicorsi.studenti UNION SELECT professori.nome,professori.cognome,'PROFESSORE' AS QUALIFICA FROM unicorsi.professori
