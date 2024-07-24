select cognome, nome from studenti
join pianidistudio on studente = matricola
where pianidistudio.anno = '5' 
AND pianidistudio.annoaccademico = '2011'
AND studenti.relatore IS NOT NULL
ORDER BY cognome desc