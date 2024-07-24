SELECT matricola
FROM unicorsi.studenti, unicorsi.corsidilaurea
WHERE laurea<'2009-11-01'AND facolta='informatica' AND corsidilaurea.id = studenti.corsodilaurea