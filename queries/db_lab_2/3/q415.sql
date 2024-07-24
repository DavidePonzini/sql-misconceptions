Select
	matricola, nome, cognome
From
	unicorsi.studenti
Where
	studenti.residenza = 'Genova' OR residenza = 'La Spezia' OR residenza = 'Savona'
	AND cognome != 'Serra' OR cognome != 'Melogno' OR cognome != 'Giunchi'
Order By matricola DESC;