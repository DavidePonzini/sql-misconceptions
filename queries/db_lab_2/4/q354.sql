select 
	matricola
from 
	unicorsi.studenti as S JOIN 
	unicorsi.corsidilaurea as CL ON 
	CL.denominazione = 'informatica'
where
	laurea < DATE '1-11-2009';