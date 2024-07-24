SELECT matricola, nome, cognome
FROM studenti  
WHERE NOT(nome IN('Serra','Melogno','Giunchi')) OR (residenza IN ('Genova', 'La Spezia', 'Savona'))
ORDER BY matricola DESC