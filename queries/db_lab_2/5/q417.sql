Select 
	studenti.cognome, studenti.nome, professori.cognome
From
	unicorsi.Studenti, unicorsi.Professori
Where
	studenti.relatore = professori.id
Order by studenti.cognome, professori.cognome ASC;