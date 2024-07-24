select matricola
from studenti
inner join esami on studenti.matricola=esami.studente
	where esami.corso like 'bdd1%'
	and esami.voto >= 18
	and esami.data >= '2010-06-01'
	and esami.data <= '2010-06-30'
except
select matricola
	from studenti
inner join esami on studenti.matricola=esami.studente
	where esami.corso like 'ig%'
	and esami.voto >= 18
	and esami.data >= '2010-06-01'
	and esami.data <= '2010-06-30';