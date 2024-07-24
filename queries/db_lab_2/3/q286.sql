SELECT s.matricola, s.cognome, s.nome FROM studenti AS s WHERE s.cognome NOT IN ('Serra','Melogno','Giunchi') OR s.residenza IN ('Genova','La Spezia','Savona') ORDER BY s.matricola DESC
