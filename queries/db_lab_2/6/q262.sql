select distinct cognome,nome from studenti join pianidistudio on pianidistudio.studente=studenti.matricola 
join corsidilaurea on studenti.corsodilaurea=corsidilaurea.id
where corsidilaurea.denominazione='Informatica' and pianidistudio.annoaccademico='2011' and pianidistudio.anno=5 and studenti.relatore is not null
order by cognome desc;