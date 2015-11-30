CREATE TABLE Storages
(
    storage_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    location VARCHAR(255) NOT NULL,
    notes VARCHAR(255),
    owner_id INT UNSIGNED NOT NULL,
    template_id INT UNSIGNED,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (storage_id),
    FOREIGN KEY (template_id) REFERENCES StorageTemplates(template_id),
    FOREIGN KEY (owner_id) REFERENCES Users(user_id)
)