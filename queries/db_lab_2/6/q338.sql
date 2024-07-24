SELECT DISTINCT studenti.cognome, studenti.nome FROM studenti join pianidistudio on 
studenti.matricola=pianidistudio.studente
WHERE pianidistudio.anno=5 AND pianidistudio.annoaccademico=2011 AND studenti.relatore IS NOT NULL
ORDER BY studenti.cognome DESC;
