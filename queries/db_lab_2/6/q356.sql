select distinct
	Studenti.cognome,Studenti.nome
from 
	Studenti inner JOIN 
	Pianidistudio ON 
	Studenti.matricola = Pianidistudio.Studente inner join Corsidilaurea on Corsidilaurea.denominazione = 'Informatica'
where
	Pianidistudio.anno = 5 AND	Pianidistudio.AnnoAccademico = 2011	AND Studenti.Relatore is Not NULL
	
ORDER BY 
	 Studenti.cognome DESC, Studenti.nome;