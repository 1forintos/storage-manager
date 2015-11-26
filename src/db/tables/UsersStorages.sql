CREATE TABLE UsersStorages
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    storage_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (storage_id) REFERENCES Storages(storage_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    UNIQUE `unique_records`(`storage_id`, `user_id`)
)