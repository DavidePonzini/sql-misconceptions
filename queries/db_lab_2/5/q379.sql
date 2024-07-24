SELECT studenti.cognome, studenti.nome, professori.cognome FROM studenti, professori WHERE studenti.relatore = professori.id ORDER BY studenti.cognome ASC , studenti.nome ASC;
