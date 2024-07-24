SELECT 
	matricola, nome, cognome
FROM 
	studenti
where 
	iscrizione < 2007 AND relatore IS NULL;