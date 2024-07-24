select Facolta, Denominazione
from CorsiDiLaurea
where (Attivazione <'2006/2007') or (Attivazione >'2009/2010')
order by Facolta, Denominazione asc;