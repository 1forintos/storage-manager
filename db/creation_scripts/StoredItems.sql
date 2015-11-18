CREATE TABLE StoredItems
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    storage_id INT UNSIGNED NOT NULL,
    item_type_id INT UNSIGNED NOT NULL,
    quantity INT DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (storage_id) REFERENCES StorageInformation(storage_id),
    FOREIGN KEY (item_type_id) REFERENCES ItemTypes(item_type_id),
    UNIQUE `unique_item_type`(`storage_id`, `item_type_id`)
)