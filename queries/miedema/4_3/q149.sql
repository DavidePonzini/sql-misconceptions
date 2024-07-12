select X.cID,Y.cID from customer X, customer Y 
where X.city!=Y.city and X.street=Y.street;