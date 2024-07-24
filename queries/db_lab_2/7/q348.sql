select studenti.cognome, studenti.nome, 'studente' as qualifica from unicorsi.studenti
UNION
select professori.cognome, professori.nome, 'professore' as qualifica from unicorsi.professori 