SELECT cID 
FROM customer c1 , customer c2
where c1.city <> c2.city
group by street;