select 
	matricola,
	nome,
	cognome
from 
	unicorsi.studenti
where 
	iscrizione < 2007 AND relatore=NULL ;