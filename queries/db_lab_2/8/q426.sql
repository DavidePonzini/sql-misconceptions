select matricola, cognome, nome
from Esami join studenti on studente = matricola
		   join corsi on corsi.id = corso
		   join corsidilaurea  on corsidilaurea.id = studenti.corsodilaurea 
where corsi.denominazione = 'Basi Di Dati 1' and corsidilaurea.denominazione = 'Informatica'
	and voto >17 
	and data between '2010-06-01' and '2010-06-30'
	
except

select matricola, cognome, nome
from Esami join studenti on studente = matricola
		   join corsi on corsi.id = corso
		   join corsidilaurea  on corsidilaurea.id = studenti.corsodilaurea 
where corsi.denominazione = 'Interfacce Grafiche' and corsidilaurea.denominazione = 'Informatica'
	and voto >17 
	and data between '2010-06-01' and '2010-06-30';