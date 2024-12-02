CREATE TABLE my_table(
    id INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS my_table(
    id INT AUTO_INCREMENT PRIMARY KEY
);

DROP TABLE my_table;

DROP TABLE IF EXISTS my_table;

-- DROPING Table from a choosen DB :

DROP TABLE playground.subscriptions;

DROP TABLE IF EXISTS playground.subscriptions;