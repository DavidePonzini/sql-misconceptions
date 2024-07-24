SELECT studenti.*
FROM studenti 
JOIN corsidilaurea 
	ON studenti.corsodilaurea=corsidilaurea.id 
JOIN pianidistudio
	ON studenti.matricola=pianidistudio.studente
WHERE pianidistudio.anno=5
	AND pianidistudio.annoaccademico=2011
	AND denominazione='Informatica'
	AND studenti.relatore IS NOT NULL
ORDER BY studenti.cognome DESC, studenti.nome DESC;
