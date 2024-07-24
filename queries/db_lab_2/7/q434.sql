SELECT studenti.nome,studenti.cognome,'STUDENTE' AS QUALIFICA FROM studenti UNION SELECT professori.nome,professori.cognome,'PROFESSORE' AS QUALIFICA FROM professori
