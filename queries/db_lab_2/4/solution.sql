SELECT matricola
FROM studenti s
    JOIN corsidilaurea c ON s.corsodilaurea = c.id
WHERE
    laurea < '2009-11-01'
	AND denominazione = 'Informatica';
