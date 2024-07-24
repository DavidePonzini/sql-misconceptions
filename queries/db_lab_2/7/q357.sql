select Studenti.nome,Studenti.cognome, 'Studente' AS professione
from unicorsi.Studenti 
UNION
select professori.nome,professori.cognome,'Professore' AS professione
from unicorsi.Professori;