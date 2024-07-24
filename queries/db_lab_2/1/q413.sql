SELECT 
	matricola, nome, cognome
FROM 
	unicorsi.studenti
where 
	iscrizione < 2007 AND relatore IS NULL;