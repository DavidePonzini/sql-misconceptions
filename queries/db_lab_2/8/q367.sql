SELECT studenti.matricola, studenti.nome, studenti.cognome
FROM studenti
JOIN esami on studenti.matricola = esami.studente --combina le righe di studenti e esami dove matricola = esami.studente
JOIN corsi on esami.corso = corsi.id -- combina le righe di esami e corsi dove l'id del corso è lo stesso del corso associato all'esame
WHERE corsi.denominazione = 'Basi Di Dati 1'
AND esami.data >= '2010-06-01' and esami.data <= '2010-06-30' --hanno passato Basi di dati a giugno (fra l'1 e il 30 compresi)
AND studenti.corsodilaurea = (SELECT id from corsidilaurea where corsidilaurea.denominazione = 'Informatica') --gli studenti sono di informatica
    --ora bisogna specificare che NON vogliamo quelli che hanno passato interfacce grafiche sempre a giugno del 2010, quindi dobbiamo escluderli
EXCEPT 
SELECT studenti.matricola, studenti.nome, studenti.cognome
FROM studenti
JOIN esami on studenti.matricola = esami.studente 
JOIN corsi on esami.corso = corsi.id 
WHERE corsi.denominazione = 'Interfacce Grafiche' --cambia solo questo
AND esami.data >= '2010-06-01' and esami.data <= '2010-06-30'
AND studenti.corsodilaurea = (SELECT id from corsidilaurea where corsidilaurea.denominazione = 'Informatica')