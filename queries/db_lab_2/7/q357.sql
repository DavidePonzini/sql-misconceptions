select Studenti.nome,Studenti.cognome, 'Studente' AS professione
from Studenti 
UNION
select professori.nome,professori.cognome,'Professore' AS professione
from Professori;