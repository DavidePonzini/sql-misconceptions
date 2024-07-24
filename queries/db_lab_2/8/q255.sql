SELECT esami.studente
FROM unicorsi.esami
WHERE esami.corso = 'bdd1n' AND esami.voto >= 18 AND esami.data BETWEEN '2010-06-01' AND '2010-06-30' 
INTERSECT
SELECT esami.studente
FROM unicorsi.esami
WHERE esami.corso = 'ig' AND esami.voto < 18 AND esami.data BETWEEN '2010-06-01' AND '2010-06-30'