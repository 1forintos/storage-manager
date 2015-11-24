CREATE TABLE StorageInformation
(
    storage_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    location VARCHAR(255) NOT NULL,
    notes VARCHAR(255),
    template_id INT UNSIGNED NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (storage_id),
    FOREIGN KEY (template_id) REFERENCES StorageTemplateInformation(template_id)
)