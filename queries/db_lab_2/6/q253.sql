SELECT DISTINCT studenti.cognome, studenti.nome
FROM unicorsi.pianidistudio JOIN unicorsi.studenti 
ON pianidistudio.studente = studenti.matricola
JOIN unicorsi.corsidilaurea
ON studenti.corsodilaurea = corsidilaurea.id
WHERE pianidistudio.anno = 5 AND corsidilaurea.denominazione = 'Informatica'
AND pianidistudio.annoaccademico = 2011
AND studenti.relatore IS NOT NULL
ORDER BY studenti.cognome DESC, studenti.nome DESC