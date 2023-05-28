CREATE TABLE ItemType(
    name    VARCHAR(16)      UNIQUE,
    PRIMARY KEY(name)
);

CREATE TABLE ItemDetails(
    id              SMALLINT UNSIGNED   NOT NULL,
    type            VARCHAR(16)         NOT NULL,
    game            VARCHAR(16)         NOT NULL,
    name            VARCHAR(16)         NOT NULL,
    fling_dmg       TINYINT  UNSIGNED   DEFAULT 30,
    purchase_price  SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be bought',
    sell_price      SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be sold',
    description     TINYTEXT            NOT NULL COMMENT 'in game flavor text',
    details         TEXT                COMMENT 'details on use/purpose',
    PRIMARY KEY(id),
    FOREIGN KEY(type) REFERENCES ItemType(name),
    FOREIGN KEY(game) REFERENCES Game(display_name)
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
