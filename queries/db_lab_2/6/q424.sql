select distinct cognome , nome
from pianidistudio join studenti on studente = matricola
where annoaccademico = 2011 and anno = 5 and relatore is not null
order by cognome desc , nome desc;