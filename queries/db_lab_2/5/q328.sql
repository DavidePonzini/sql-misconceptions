select studenti.nome,studenti.cognome,professori.cognome from studenti join professori
on studenti.relatore=professori.id
order by studenti.cognome,studenti.nome;