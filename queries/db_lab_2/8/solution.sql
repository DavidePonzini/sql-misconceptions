SELECT studente
FROM esami
WHERE
    corso = 'bdd1n'
    AND voto >= 18
    AND esami.data BETWEEN '2010-06-01' AND '2010-06-30'
EXCEPT
SELECT studente
FROM esami
WHERE
    corso = 'ig'
    AND voto >= 18
    AND esami.data BETWEEN '2010-06-01' AND '2010-06-30';