select Studenti.matricola
from unicorsi.Studenti inner join unicorsi.esami on Studenti.matricola = esami.studente inner join unicorsi.Corsi on Corsi.id = esami.corso
where Corsi.denominazione = 'Basi Di Dati 1' AND esami.voto>17 AND esami.data >= '2010-06-01' AND esami.data <= '2010-06-30' 
INTERSECT
select Studenti.matricola
from unicorsi.Studenti inner join unicorsi.esami on Studenti.matricola = esami.studente inner join unicorsi.Corsi on Corsi.id = esami.corso
where Corsi.denominazione = 'Interfacce Grafiche' AND esami.voto<18 AND esami.data >= '2010-06-01' AND esami.data <= '2010-06-30';