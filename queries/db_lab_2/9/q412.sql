SELECT DISTINCT S.Matricola
FROM Studenti AS S
	JOIN Esami AS E1 ON S.Matricola = E1.Studente 
	JOIN Corsi AS C1 ON E1.Corso = C1.Id AND C1.Denominazione = 'Basi Di Dati 1'
	JOIN CorsiDiLaurea AS CD1 ON C1.CorsoDiLaurea = CD1.Id AND CD1.Denominazione = 'Informatica'
WHERE E1.Data BETWEEN '2010-06-01' AND '2010-06-30'
	AND E1.Voto >= 18
INTERSECT
SELECT S.Matricola
FROM Studenti AS S
	JOIN Esami AS E2 ON S.Matricola = E2.Studente 
	JOIN Corsi AS C2 ON E2.Corso = C2.Id AND C2.Denominazione = 'Interfacce Grafiche'
	JOIN CorsiDiLaurea AS CD2 ON C2.CorsoDiLaurea = CD2.Id AND CD2.Denominazione = 'Informatica'
WHERE E2.Data BETWEEN '2010-06-01' AND '2010-06-30'
	AND E2.Voto >= 18;