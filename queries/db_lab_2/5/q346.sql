select studenti.cognome, studenti.nome, professori.cognome as relatore from unicorsi.studenti
join unicorsi.professori on id = relatore