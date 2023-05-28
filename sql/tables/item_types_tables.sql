-- TODO: add item types
CREATE TABLE Pokeball(
    id              SMALLINT UNSIGNED   NOT NULL,
    catch_rate      DECIMAL(5,2)        DEFAULT 1,
    PRIMARY KEY(id),
    CONSTRAINT CHK_catch_rate CHECK(catch_rate <= 255),
    FOREIGN KEY(id) REFERENCES ItemDetails(id)
);
INSERT INTO ItemType(name) VALUES('Pokeball');

CREATE TABLE HPRecovery(
    id          SMALLINT UNSIGNED   NOT NULL,
    hp_recv     TINYINT  UNSIGNED   NOT NULL,
    percentage  BIT                 NOT NULL DEFAULT 0,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES ItemDetails(id)
);
INSERT INTO ItemType(name) VALUES('HPRecovery');

CREATE TABLE PPRecovery(
    id          SMALLINT UNSIGNED   NOT NULL,
    pp_recv     TINYINT  UNSIGNED   NOT NULL,
    percentage  BIT                 NOT NULL DEFAULT 0,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES ItemDetails(id)
);
INSERT INTO ItemType(name) VALUES('PPRecovery');

CREATE TABLE KeyItem(
    id      SMALLINT UNSIGNED   NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES ItemDetails(id)
);
INSERT INTO ItemType(name) VALUES('Key Item');
