SELECT matricola FROM unicorsi.esami
	INNER JOIN unicorsi.studenti ON esami.studente=studenti.matricola
	INNER JOIN unicorsi.corsi ON esami.corso=corsi.id
	INNER JOIN unicorsi.corsidilaurea ON corsidilaurea.id=corsi.corsodilaurea
WHERE corsidilaurea.denominazione LIKE 'Informatica' 
	AND 
		data BETWEEN '2010-05-31' AND '2010-07-01' AND corsi.denominazione LIKE'Basi Di Dati 1' 
except
SELECT matricola FROM unicorsi.esami
	INNER JOIN unicorsi.studenti ON esami.studente=studenti.matricola
	INNER JOIN unicorsi.corsi ON esami.corso=corsi.id
	INNER JOIN unicorsi.corsidilaurea ON corsidilaurea.id=corsi.corsodilaurea
	WHERE corsidilaurea.denominazione LIKE 'Informatica' 
	AND
		data BETWEEN '2010-05-31' AND '2010-07-01' AND corsi.denominazione  IN ( 'Interfacce Grafiche') 
	
ORDER BY matricola ASC