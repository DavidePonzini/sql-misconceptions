select nome,cognome, 'studente' as qualifica from studenti UNION select nome,cognome, 'professore' as qualifica from professori;
