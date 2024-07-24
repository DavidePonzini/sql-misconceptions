select distinct Studenti.Cognome, Studenti.Nome
from Studenti
join Pianidistudio on studenti.matricola = pianidistudio.studente
where pianidistudio.annoaccademico='2011' 
	and pianidistudio.anno='5' and studenti.corsodilaurea=(
		select id 
		from corsidilaurea 
		where denominazione='Informatica'
	)
	and studenti.relatore is not null
order by Studenti.Cognome desc;