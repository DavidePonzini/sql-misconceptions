select studenti.cognome,studenti.nome,professori.cognome
from studenti join professori on relatore = id
order by studenti.cognome asc , studenti.nome asc;