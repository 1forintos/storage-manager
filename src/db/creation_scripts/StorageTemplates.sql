CREATE TABLE StorageTemplates
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    template_id INT UNSIGNED NOT NULL,
    item_type_id INT UNSIGNED NOT NULL,
    quantity INT DEFAULT 0,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (template_id) REFERENCES StorageTemplateInformation(template_id),
    FOREIGN KEY (item_type_id) REFERENCES ItemTypes(item_type_id),
    UNIQUE `unique_template_record`(`template_id`, `item_type_id`)
)