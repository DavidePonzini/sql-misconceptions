select matricola
from studenti,corsidilaurea
where corsodilaurea = id and denominazione = 'informatica' and laurea < '2009-11-01';