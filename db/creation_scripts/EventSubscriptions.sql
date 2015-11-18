CREATE TABLE EventSubscriptions
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    event_id INT UNSIGNED NOT NULL,
    added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    UNIQUE `unique_subscriptions`(`user_id`, `event_id`)
)