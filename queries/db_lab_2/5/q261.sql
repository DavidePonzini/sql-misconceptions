select studenti.nome,studenti.cognome,professori.cognome "relatore" from studenti join professori on studenti.relatore=professori.id
order by studenti.cognome asc