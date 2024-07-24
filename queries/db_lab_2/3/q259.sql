select matricola,nome,cognome from studenti
where cognome not in ('Serra','Melogno','Giunchi') or 
residenza in ('Genova','La Spezia','Savona')
order by matricola desc;