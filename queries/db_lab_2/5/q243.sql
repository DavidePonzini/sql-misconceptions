select studenti.cognome, studenti.nome, professori.cognome
from studenti
inner join professori on relatore=professori.id
order by studenti.cognome asc, studenti.nome asc;