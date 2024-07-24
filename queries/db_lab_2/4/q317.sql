SELECT matricola
FROM studenti, corsidilaurea
WHERE laurea<'2009-11-01'AND facolta='informatica' AND corsidilaurea.id = studenti.corsodilaurea