select studenti.cognome,studenti.nome,'studente'as qualifica
from studenti
union 
select professori.cognome,professori.nome,'professori'as qualifica
from professori;