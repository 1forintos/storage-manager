CREATE TABLE Users
(
    user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    login_name VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('admin', 'owner', 'manager', 'field_worker'), 
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
)