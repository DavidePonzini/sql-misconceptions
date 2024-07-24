select cognome,nome from studenti join pianidistudio on studenti.matricola=pianidistudio.studente
where (anno=5 and annoaccademico=2011 and relatore is not null)
order by cognome desc;
