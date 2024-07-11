INSERT INTO customer VALUES
(0, 'Noah', 'Koestraat', 'Ultrecht'),
(1, 'Sem', 'Rozemarijnstraat', 'Breda'),
(2, 'Lucas', 'Oude Leliestraat', 'Amsterdam'),
(3, 'Daan',  'Kalverstraat', 'Amsterdam'),
(100, 'test1', 'street1', 'Eindhoven'),     -- manually added for testing
(101, 'test2', 'street2', 'Eindhoven'),     -- manually added for testing
(102, 'test2', 'street1', 'not-Eindhoven'), -- manually added for testing
(103, 'test2', 'street2', 'not-Eindhoven')  -- manually added for testing
;

INSERT INTO store VALUES
(0, 'Coop', 'Kalverstraat', 'Amsterdam'),
(1, 'Lidl', 'Hoogstraat', 'Utrecht'),
(2, 'Lidl', 'Molenstraat', 'Eindhoven'),
(3, 'Hoogvliet', 'Rozemarijnstraat', 'Breda'),
(4, 'Sligro', 'Stationsplein', 'Breda'),
(100, 'SChain', 'street1', 'city1'),        -- manually added for testing
(101, 'SChain', 'street2', 'city2'),        -- manually added for testing
(102, 'SChain', 'street2', 'city3')         -- manually added for testing
;


INSERT INTO product VALUES
(1, 'Milk', '""'),
(2, 'Mushrooms', '""'),
(3, 'Apples', '""'),
(4, 'Tea', '""'),
(5, 'Banana', '""');

INSERT INTO transaction VALUES
(0, 0, 4, 3, '2020-05-12', 5, .4),
(1, 0, 4, 1, '2020-05-13', 2, .65),
(2, 2, 0, 4, '2020-05-13', 2, 1.3),
(3, 3, 0, 1, '2020-05-15', 1, .67),
(100, 0, 100, 5, '2020-05-15', 1, 1.9),     -- manually added for testing
(101, 0, 101, 5, '2020-05-15', 10, 1.9)     -- manually added for testing
;

INSERT INTO shoppinglist VALUES
(1, 2, 1, '2020-05-13'),
(1, 3, 6, '2020-05-13'),
(3, 1, 2, '2020-05-15');

INSERT INTO inventory VALUES
(0, 1, '2020-05-15', 55, .55),
(0, 2, '2020-05-15', 32, 2.3),
(1, 4, '2020-05-15', 12, 1.8),
(1, 1, '2020-05-15', 46, .6),
(3, 5, '2020-05-15', 1000, 1.1),        -- manually added for testing
(4, 5, '2020-05-15', 1001, 1.9)         -- manually added for testing
;
