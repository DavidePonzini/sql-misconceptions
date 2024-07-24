select studenti.cognome, studenti.nome
from studenti
inner join pianidistudio on studenti.matricola=pianidistudio.studente
where studenti.relatore is not null
	AND pianidistudio.anno=5
order by studenti.cognome desc, studenti.nome desc;