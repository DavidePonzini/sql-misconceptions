SELECT matricola
FROM studenti JOIN corsidilaurea ON corsidilaurea.id = studenti.corsodilaurea
WHERE laurea<'2009-11-01'AND facolta='informatica'
