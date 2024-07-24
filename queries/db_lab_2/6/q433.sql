SELECT DISTINCT studenti.nome,studenti.cognome FROM unicorsi.studenti 
INNER JOIN unicorsi.pianidistudio ON pianidistudio.studente=studenti.matricola
WHERE pianidistudio.anno = 5 AND studenti.relatore  IS NOT NULL and pianidistudio.annoaccademico = 2011
ORDER BY studenti.cognome DESC
