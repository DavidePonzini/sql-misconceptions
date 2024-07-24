Select 
	studenti.cognome, studenti.nome, professori.cognome
From
	Studenti, Professori
Where
	studenti.relatore = professori.id
Order by studenti.cognome, professori.cognome ASC;