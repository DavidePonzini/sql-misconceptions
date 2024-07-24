select matricola from unicorsi.studenti
join unicorsi.esami on studente = matricola
join unicorsi.corsi on id = corso
where denominazione = 'Basi Di Dati 1' AND voto >= 18 and data BETWEEN '2010-06-01' AND '2010-06-30'
except
select matricola from unicorsi.studenti
join unicorsi.esami on studente = matricola
join unicorsi.corsi on id = corso
where denominazione = 'Interfacce Grafiche' AND voto >= 18 and data BETWEEN '2010-06-01' AND '2010-06-30'