select Studenti.matricola
from Studenti inner join esami on Studenti.matricola = esami.studente inner join Corsi on Corsi.id = esami.corso
where Corsi.denominazione = 'Basi Di Dati 1' AND esami.voto>17 AND esami.data >= '2010-06-01' AND esami.data <= '2010-06-30' 
INTERSECT
select Studenti.matricola
from Studenti inner join esami on Studenti.matricola = esami.studente inner join Corsi on Corsi.id = esami.corso
where Corsi.denominazione = 'Interfacce Grafiche' AND esami.voto>18 AND esami.data >= '2010-06-01' AND esami.data <= '2010-06-30';