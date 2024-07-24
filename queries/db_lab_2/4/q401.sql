SELECT matricola
FROM studenti JOIN corsidilaurea on corsodilaurea=id
WHERE corsodilaurea = 9 AND laurea < '2009-11-01';