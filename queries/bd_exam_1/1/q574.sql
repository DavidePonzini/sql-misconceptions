SELECT IdG
FROM FROM GIOCATORE NATURAL JOIN CATEGORIA NATURAL JOIN TORNEO
NATURAL JOIN GIOCAIN
WHERE genere = F AND AND IdG IN (SELECT IdG
             FROM GIOCATORE NATURAL JOIN CATEGORIA NATURAL JOIN TORNEO
             NATURAL JOIN GIOCAIN
             WHERE genere = F AND genereCategoria = Doppi)