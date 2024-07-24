SELECT nome, cognome, 'studente' AS qualifica
FROM studenti 
UNION ALL
SELECT nome, cognome, 'professore' AS qualifica
FROM professori;
