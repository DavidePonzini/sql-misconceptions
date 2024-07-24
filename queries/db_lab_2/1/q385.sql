select Matricola, Cognome, Nome
from Studenti
where Relatore is null and Iscrizione < '2007';
