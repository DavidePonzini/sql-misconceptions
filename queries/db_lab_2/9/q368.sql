SELECT studenti.matricola, studenti.nome, studenti.cognome
FROM unicorsi.studenti
JOIN unicorsi.esami on studenti.matricola = esami.studente --combina le righe di studenti e esami dove matricola = esami.studente
JOIN unicorsi.corsi on esami.corso = corsi.id -- combina le righe di esami e corsi dove l'id del corso è lo stesso del corso associato all'esame
WHERE corsi.denominazione = 'Basi Di Dati 1'
AND esami.data >= '2010-06-01' and esami.data <= '2010-06-30' --hanno passato Basi di dati a giugno (fra l'1 e il 30 compresi)
AND studenti.corsodilaurea = (SELECT id from unicorsi.corsidilaurea where corsidilaurea.denominazione = 'Informatica') --gli studenti sono di informatica
INTERSECT --prende solo quelli che trova del primo AND del secondo select(?)
SELECT studenti.matricola, studenti.nome, studenti.cognome
FROM unicorsi.studenti
JOIN unicorsi.esami on studenti.matricola = esami.studente 
JOIN unicorsi.corsi on esami.corso = corsi.id 
WHERE corsi.denominazione = 'Interfacce Grafiche' 
AND esami.data >= '2010-06-01' and esami.data <= '2010-06-30' --hanno passato interfacce grafiche a giugno
AND studenti.corsodilaurea = (SELECT id from unicorsi.corsidilaurea where corsidilaurea.denominazione = 'Informatica')