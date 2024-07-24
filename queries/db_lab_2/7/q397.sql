SELECT cognome, nome, 'studente' AS qualifica
FROM studenti
UNION
SELECT cognome, nome, 'professore' AS qualifica
FROM professori;