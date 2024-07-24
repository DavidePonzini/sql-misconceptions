SELECT matricola
FROM unicorsi.studenti JOIN unicorsi.corsidilaurea ON corsidilaurea.id = studenti.corsodilaurea
WHERE laurea<'2009-11-01'AND facolta='informatica'
