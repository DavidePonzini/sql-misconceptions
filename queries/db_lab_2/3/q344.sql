select matricola, cognome, nome from unicorsi.studenti
where cognome NOT IN ('Serra', 'Melogno', 'Giunchi') OR residenza IN ('Genova', 'La Spezia', 'Savona')
order by matricola desc