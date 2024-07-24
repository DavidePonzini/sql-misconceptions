select 
	S.nome as nome_studente,
	S.cognome as cognome_studente,
	PR.nome as nome_relatore,
	PR.cognome as cognome_relatore
from 
	unicorsi.studenti as S JOIN 
	unicorsi.professori as PR ON 
	S.relatore = PR.id
	
ORDER BY 
	 S.cognome, S.nome ASC;