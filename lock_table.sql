CREATE TABLE wallets(
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    total DECIMAL(10,2) DEFAULT 0.00,
    remaining DECIMAL(10,2) DEFAULT 0.00,
    onhold DECIMAL(10,2) DEFAULT 0.00,
    used DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO wallets(user_id,total,remaining) VALUES(1),(2),(3),(4),(5);

DROP TABLE wallets;

START TRANSACTION;
    SELECT * FROM wallets WHERE user_id = 5 FOR UPDATE;
    UPDATE wallets SET total = (total + 100), remaining = (remaining + 100) WHERE user_id = 5;
COMMIT;

START TRANSACTION;
    SELECT * FROM wallets WHERE user_id = 5 FOR UPDATE;
    UPDATE wallets SET total = (total + 100), remaining = (remaining + 100) WHERE user_id = 5;
COMMIT;

LOCK TABLES wallets READ;

LOCK TABLES wallets WRITE;

SHOW OPEN TABLES;

UNLOCK TABLES;