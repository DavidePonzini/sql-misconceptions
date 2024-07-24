SELECT DISTINCT cognome, nome
FROM unicorsi.studenti JOIN unicorsi.corsidilaurea on studenti.corsodilaurea = corsidilaurea.id 
JOIN unicorsi.pianidistudio on pianidistudio.studente = studenti.matricola
WHERE pianidistudio.anno = 5 AND pianidistudio.annoaccademico = '2011' and relatore IS NOT NULL
ORDER BY cognome DESC;