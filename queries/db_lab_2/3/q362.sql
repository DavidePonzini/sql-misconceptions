SELECT studenti.matricola, studenti.nome, studenti.cognome
FROM studenti
WHERE studenti.cognome NOT IN ('Serra','Melogno','Giunchi') 
	OR studenti.residenza IN ('Genova','La Spezia','Savona')
ORDER BY studenti.matricola DESC