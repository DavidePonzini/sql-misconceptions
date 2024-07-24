SELECT studenti.cognome, studenti.nome, 'studente' AS qualifica /*si crea una colonna virtuale con valore costante scelto da noi*/
FROM studenti

UNION 

SELECT professori.cognome, professori.nome, 'professore' AS qualifica
FROM professori;