select studenti.cognome, studenti.nome, 'Studente' as Qualifica
from studenti
UNION
select professori.cognome, professori.nome, 'Professore' as Qualifica
from professori;