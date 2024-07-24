SELECT studenti.matricola
FROM studenti 
JOIN esami
	ON esami.studente=studenti.matricola
JOIN corsi
	ON corsi.id=esami.corso
WHERE corsi.denominazione='Basi Di Dati 1'
	AND esami.voto>17
	AND esami.data>='2010-06-01'
	AND esami.data<='2010-06-30'
UNION 
SELECT studenti.matricola
FROM studenti 
JOIN esami
	ON esami.studente=studenti.matricola
JOIN corsi
	ON corsi.id=esami.corso
WHERE corsi.denominazione='Interfacce Grafiche'
	AND esami.voto>17
	AND esami.data>='2010-06-01'
	AND esami.data<='2010-06-30';


