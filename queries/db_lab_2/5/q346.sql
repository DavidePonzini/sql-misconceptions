select studenti.cognome, studenti.nome, professori.cognome as relatore from studenti
join professori on id = relatore