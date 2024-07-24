select Matricola, Cognome, Nome
from Studenti
where (Cognome not in ('Serra', 'Melogno', 'Giunchi') or Residenza in ('Genova', 'La Spezia', 'Savona'))
order by Matricola desc;
