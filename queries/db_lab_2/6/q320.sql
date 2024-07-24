SELECT DISTINCT studenti.cognome, studenti.nome
FROM unicorsi.studenti 
JOIN unicorsi.pianidistudio ON studenti.matricola = pianidistudio.studente 
JOIN unicorsi.corsidilaurea ON studenti.corsodilaurea = corsidilaurea.id 

WHERE 
pianidistudio.anno = '5'
AND pianidistudio.annoaccademico = '2011'
AND corsidilaurea.denominazione = 'Informatica' /*ATTENZIONE: maiuscole e minuscole*/
AND studenti.relatore IS NOT NULL

ORDER BY studenti.cognome DESC, studenti.nome DESC;