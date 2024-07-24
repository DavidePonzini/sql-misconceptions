SELECT s.cognome, s.nome, p.cognome FROM studenti AS s, professori AS p WHERE s.relatore=p.id ORDER BY s.cognome, s.nome
