CREATE TABLE ItemType(
    id      TINYINT UNSIGNED NOT NULL,
    name    VARCHAR(16)      UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE ItemDetails(
    id              SMALLINT UNSIGNED   NOT NULL,
    type            TINYINT  UNSIGNED   NOT NULL,
    purchase_price  SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be bought',
    sell_price      SMALLINT UNSIGNED   COMMENT 'NULL value means cannot be sold',
    description     TINYTEXT            NOT NULL COMMENT 'in game flavor text',
    PRIMARY KEY(id),
    FOREIGN KEY(type) REFERENCES ItemType(id)
);

CREATE TABLE Pokeball(
    id              SMALLINT UNSIGNED   NOT NULL,
    name            VARCHAR(16)         NOT NULL,
    catch_rate      DECIMAL(5,2)        DEFAULT 1,
    notes           TINYTEXT            COMMENT 'details on catch algorithm',
    PRIMARY KEY(id),
    CONSTRAINT CHK_catch_rate CHECK(catch_rate <= 255),
    FOREIGN KEY(id) REFERENCES ItemDetails(id)
);
INSERT INTO ItemType(id, name) VALUES(1, 'Pokeball');


CREATE TABLE Recovery(
    id      SMALLINT UNSIGNED   NOT NULL,
    name    VARCHAR(16)         NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES ItemDetails(id)
);
INSERT INTO ItemType(id, name) VALUES(2, 'Recovery');

-- TODO: add foreign key to Trainer table once built
CREATE TABLE Bag(
    trainer_id  SMALLINT UNSIGNED NOT NULL,
    item_id     SMALLINT UNSIGNED NOT NULL,
    count       TINYINT  UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(trainer_id, item_id),
    CONSTRAINT CHK_count CHECK(count <= 99),
    FOREIGN KEY(item_id) REFERENCES ItemDetails(id)
);
