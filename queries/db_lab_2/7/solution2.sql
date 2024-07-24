SELECT nome, cognome, 'studente' AS qualifica
FROM studenti 
UNION
SELECT nome, cognome, 'professore' AS qualifica
FROM professori;
