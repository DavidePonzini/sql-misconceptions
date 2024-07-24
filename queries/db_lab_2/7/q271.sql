SELECT studenti.cognome, studenti.nome, 'STUDENTE' as qualifica
FROM studenti
UNION
SELECT professori.cognome, professori.nome, 'PROFESSORE' as qualifica
FROM professori