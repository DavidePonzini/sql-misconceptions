select matricola , cognome , nome
from studenti
where cognome not in('Serra','Melogno','Giunchi')
	  or residenza in ('Genova','Spezia','Savona')
order by matricola desc;