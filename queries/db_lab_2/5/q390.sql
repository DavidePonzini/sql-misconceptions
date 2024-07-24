select Studenti.Cognome, Studenti.Nome, Professori.Cognome
from Studenti
join Professori on Studenti.Relatore = Professori.Id
order by Studenti.Cognome asc;