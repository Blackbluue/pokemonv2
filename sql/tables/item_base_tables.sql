CREATE TABLE ItemType(
    id      TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name    VARCHAR(16)      UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE ItemDetails(
    id              SMALLINT UNSIGNED   NOT NULL,
    type            TINYINT  UNSIGNED   NOT NULL,
    game            TINYINT  UNSIGNED   NOT NULL,
    name            VARCHAR(16)         NOT NULL,
    fling_dmg       TINYINT  UNSIGNED   DEFAULT 30,
    purchase_price  SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be bought',
    sell_price      SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be sold',
    description     TINYTEXT            NOT NULL COMMENT 'in game flavor text',
    details         TEXT                COMMENT 'details on use/purpose',
    PRIMARY KEY(id),
    FOREIGN KEY(type) REFERENCES ItemType(id),
    FOREIGN KEY(game) REFERENCES Game(id)
);

-- TODO: add foreign key to Trainer table once built
CREATE TABLE Bag(
    trainer_id  SMALLINT UNSIGNED NOT NULL,
    item_id     SMALLINT UNSIGNED NOT NULL,
    count       TINYINT  UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(trainer_id, item_id),
    CONSTRAINT CHK_count CHECK(count <= 99),
    FOREIGN KEY(item_id) REFERENCES ItemDetails(id)
);
