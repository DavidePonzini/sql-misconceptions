Select Distinct
	studenti.cognome, studenti.nome
From
	Studenti, pianidistudio, corsidilaurea
Where
	pianidistudio.anno = 5 AND pianidistudio.annoaccademico = 2011
	AND studenti.matricola = pianidistudio.studente
	AND studenti.relatore != null
Order by studenti.cognome, studenti.nome DESC;