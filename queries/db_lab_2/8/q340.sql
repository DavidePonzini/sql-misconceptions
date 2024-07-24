(SELECT studenti.matricola FROM studenti JOIN esami 
ON studenti.matricola = esami.studente
WHERE esami.corso = 'bdd1n' AND esami.voto >= 18 
  AND esami.data >= '2010-06-01' AND esami.data <= '2010-06-30')
EXCEPT
(SELECT studenti.matricola FROM studenti JOIN esami 
ON studenti.matricola = esami.studente
WHERE esami.corso = 'ig' AND esami.voto >= 18 
  AND esami.data >= '2010-06-01' AND esami.data <= '2010-06-30'); 