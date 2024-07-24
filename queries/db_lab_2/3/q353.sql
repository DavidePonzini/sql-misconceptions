select 
	matricola,
	nome,
	cognome
from 
	studenti
where 
	cognome NOT IN ('Serra’, ‘Melogno’, ‘Giunchi') OR  residenza IN ('Genova' , 'La Spezia' , 'Savona' )
ORDER BY
	matricola DESC;