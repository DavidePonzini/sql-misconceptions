select matricola, cognome, nome
from studenti
where (residenza like 'Genova'
    or residenza like 'La Spezia'
    or residenza like 'Savona'
    or cognome not like 'Serra'
    or cognome not like 'Melogno'
    or cognome not like 'Giunchi')
order by matricola desc;