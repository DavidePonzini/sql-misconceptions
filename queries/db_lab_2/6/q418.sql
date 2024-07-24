Select Distinct
	studenti.cognome, studenti.nome
From
	unicorsi.Studenti, unicorsi.pianidistudio, unicorsi.corsidilaurea
Where
	pianidistudio.anno = 5 AND pianidistudio.annoaccademico = 2011
	AND studenti.matricola = pianidistudio.studente
	AND studenti.relatore != null
Order by studenti.cognome, studenti.nome DESC;