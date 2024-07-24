select matricola from studenti join esami on studenti.matricola=esami.studente
where (corsodilaurea=9 and voto>=18 and esami.corso='bdd1n' and data>'2010-05-31' and data<'2010-07-01')
intersect select matricola from studenti join esami on studenti.matricola=esami.studente
where (corsodilaurea=9 and voto>=18 and esami.corso='graf' and data>'2010-05-31' and data<'2010-07-01');