SELECT matricola FROM unicorsi.studenti join unicorsi.corsidilaurea on corsodilaurea=id
WHERE laurea<'2009-11-01' AND denominazione='Informatica';