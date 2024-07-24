SELECT Studenti.matricola FROM Studenti, Esami
    WHERE Studenti.Matricola = Esami.studente AND (Esami.data >= '01/06/2010' AND Esami.data <= '30/06/2010') AND (Esami.corso = (
                SELECT id
                FROM Corsi
                WHERE Corsi.denominazione = 'Basi Di Dati 1'
             ) AND Esami.voto >= 18)
EXCEPT
    SELECT Studenti.matricola FROM Studenti, Esami
    WHERE Studenti.Matricola = Esami.studente AND (Esami.data >= '01/06/2010' AND Esami.data <= '30/06/2010') AND (Esami.corso = (
                SELECT id
                FROM Corsi
                WHERE Corsi.denominazione = 'Interfacce Grafiche'
             ) AND Esami.voto >= 18);