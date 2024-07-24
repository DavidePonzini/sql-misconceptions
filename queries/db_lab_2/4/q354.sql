select 
	matricola
from 
	studenti as S JOIN 
	corsidilaurea as CL ON 
	CL.denominazione = 'informatica'
where
	laurea < DATE '1-11-2009';