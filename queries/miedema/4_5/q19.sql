SELECT p_other.pName AS higher_priced_items
FROM inventory i_banana
JOIN product p_banana ON i_banana.pID = p_banana.pID
JOIN inventory i_other ON i_banana.sID = i_other.sID AND i_other.pID <> i_banana.pID
JOIN product p_other ON i_other.pID = p_other.pID
WHERE p_banana.pName = 'Banana' 
AND i_other.unit_price > i_banana.unit_price;
