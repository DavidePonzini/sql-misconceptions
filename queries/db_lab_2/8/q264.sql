select matricola from studenti,corsidilaurea,corsi,esami
where corsidilaurea.id=studenti.corsodilaurea 
	and corsi.corsodilaurea=corsidilaurea.id
	and esami.corso=corsi.id 
	and esami.studente=studenti.matricola
	and esami.voto>=18 
	and corsidilaurea.denominazione='Informatica' 
	and corsi.denominazione='Basi Di Dati 1'
	and esami.data BETWEEN '06/01/2010' and '06/30/2010'
EXCEPT
select matricola from studenti,corsidilaurea,corsi,esami
where corsidilaurea.id=studenti.corsodilaurea 
	and corsi.corsodilaurea=corsidilaurea.id
	and esami.corso=corsi.id 
	and esami.studente=studenti.matricola
	and corsidilaurea.denominazione='Informatica' 
	and corsi.denominazione='Interfacce Grafiche'
	and esami.data BETWEEN '06/01/2010' and '06/30/2010'