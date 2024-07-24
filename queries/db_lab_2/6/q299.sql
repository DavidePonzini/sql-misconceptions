select distinct cognome,nome from studenti join pianidistudio on matricola=studente and relatore is not null and annoaccademico=2011 and anno=5 order by studenti.cognome DESC, studenti.nome DESC;
