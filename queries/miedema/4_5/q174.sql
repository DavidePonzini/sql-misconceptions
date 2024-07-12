SELECT pname FROM product
JOIN inventory ON product.pid=inventory.pid
WHERE unit_price>(SELECT unit_price FROM inventory 
                                  JOIN product ON product.pid=inventory.pid
                                  WHERE pname='Banana'
                                 )