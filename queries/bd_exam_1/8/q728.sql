Select IdT
From Torneo
Natural Join Giocain
Natural Join Giocatore
Group By IdT,
Having avg(DataN) <= ALL (Select avg(DataN)
From Giocatori
Natural Join giocain
GroupBy IdT)
