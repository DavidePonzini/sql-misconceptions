SELECT 			Studenti.matricola
FROM Studenti 	JOIN Esami ON Esami.Studente = Studenti.Matricola
				JOIN Corsi ON Esami.corso = Corsi.Id
			    JOIN CorsiDiLaurea ON Studenti.CorsoDiLaurea = CorsiDiLaurea.id
WHERE 			Corsidilaurea.denominazione='Informatica' AND Esami.Voto>17 
				AND Extract(MONTH FROM Esami.data)=6 AND EXTRACT (YEAR FROM Esami.data)= 2010
				AND Corsi.denominazione='Basi Di Dati 1'
INTERSECT

SELECT 			Studenti.matricola
FROM Studenti 	JOIN Esami ON Esami.Studente = Studenti.Matricola
				JOIN Corsi ON Esami.corso = Corsi.Id
			    JOIN CorsiDiLaurea ON Studenti.CorsoDiLaurea = CorsiDiLaurea.id
WHERE 			Corsidilaurea.denominazione='Informatica' AND Esami.Voto>17
				AND Extract(MONTH FROM Esami.data)=6 AND EXTRACT (YEAR FROM Esami.data)= 2010
				AND Corsi.denominazione='Interfacce Grafiche'

