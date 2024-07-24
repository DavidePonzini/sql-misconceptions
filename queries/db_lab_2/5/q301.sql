select studenti.nome,studenti.cognome,professori.nome,professori.cognome from studenti,professori where relatore=id order by studenti.cognome, studenti.nome ASC;
