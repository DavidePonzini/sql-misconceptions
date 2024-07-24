SELECT s.nome, s.cognome, 'studente' AS qualifica FROM studenti AS s UNION SELECT p.nome, p.cognome, 'professore' AS qualifica FROM professori AS p
