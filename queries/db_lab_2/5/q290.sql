SELECT s.cognome, s.nome, p.cognome FROM studenti AS s JOIN professori AS p ON s.relatore=p.id ORDER BY s.cognome, s.nome
