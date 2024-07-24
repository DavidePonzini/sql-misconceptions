SELECT Studenti.cognome, Studenti.nome, 'studente' from Studenti
UNION
SELECT Professori.cognome, Professori.nome, 'professore' from Professori