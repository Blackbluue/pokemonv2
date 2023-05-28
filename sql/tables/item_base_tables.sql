CREATE TABLE ItemType(
    name    VARCHAR(16)      UNIQUE,
    PRIMARY KEY(name)
);

CREATE TABLE ItemDetails(
    name            VARCHAR(16)         NOT NULL,
    game            VARCHAR(16)         NOT NULL,
    type            VARCHAR(16)         NOT NULL,
    fling_dmg       TINYINT  UNSIGNED   DEFAULT 30,
    purchase_price  SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be bought',
    sell_price      SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be sold',
    description     TINYTEXT            NOT NULL COMMENT 'in game flavor text',
    details         TEXT                COMMENT 'details on use/purpose',
    PRIMARY KEY(name, game),
    FOREIGN KEY(type) REFERENCES ItemType(name),
    FOREIGN KEY(game) REFERENCES Game(display_name)
);

CREATE TABLE Bag(
    item_name   VARCHAR(16)       NOT NULL,
    trainer_id  SMALLINT UNSIGNED NOT NULL,
    game        VARCHAR(16)       NOT NULL,
    count       TINYINT  UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(item_name, trainer_id),
    CONSTRAINT CHK_count            CHECK(count <= 99),
    FOREIGN KEY(item_name, game)    REFERENCES ItemDetails(name, game),
    FOREIGN KEY(trainer_id, game)   REFERENCES Trainer(ot_id, game),
    FOREIGN KEY(game)               REFERENCES Game(display_name)
);
