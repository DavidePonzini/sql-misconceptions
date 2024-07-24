SELECT DISTINCT studenti.cognome, studenti.nome
from unicorsi.studenti
JOIN unicorsi.pianidistudio on studenti.matricola = pianidistudio.studente
WHERE pianidistudio.anno = 5
AND studenti.corsodilaurea = (SELECT id from unicorsi.corsidilaurea WHERE corsidilaurea.denominazione = 'Informatica')
AND pianidistudio.annoaccademico = 2011
AND studenti.relatore is not null
ORDER by studenti.cognome DESC, studenti.nome DESC