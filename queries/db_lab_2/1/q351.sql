select 
	matricola,
	nome,
	cognome
from 
	studenti
where 
	iscrizione < 2007 AND relatore=NULL ;