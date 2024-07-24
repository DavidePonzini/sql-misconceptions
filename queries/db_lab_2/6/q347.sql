select cognome, nome from unicorsi.studenti
join unicorsi.pianidistudio on studente = matricola
where unicorsi.pianidistudio.anno = '5' 
AND unicorsi.pianidistudio.annoaccademico = '2011'
AND unicorsi.studenti.relatore IS NOT NULL
ORDER BY cognome desc