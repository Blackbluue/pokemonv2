-- TODO: add item types
CREATE TABLE Pokeball(
    name        VARCHAR(16)     NOT NULL,
    game        VARCHAR(16)     NOT NULL,
    catch_rate  DECIMAL(5,2)    DEFAULT 1,
    PRIMARY KEY(name, game),
    CONSTRAINT CHK_catch_rate CHECK(catch_rate <= 255),
    FOREIGN KEY(name, game) REFERENCES ItemDetails(name, game),
    FOREIGN KEY(game)       REFERENCES Game(display_name)
);
INSERT INTO ItemType(name) VALUES('Pokeball');

CREATE TABLE HPRecovery(
    name        VARCHAR(16)         NOT NULL,
    game        VARCHAR(16)         NOT NULL,
    hp_recv     TINYINT UNSIGNED    NOT NULL,
    percentage  BIT                 NOT NULL DEFAULT 0,
    PRIMARY KEY(name, game),
    FOREIGN KEY(name, game) REFERENCES ItemDetails(name, game),
    FOREIGN KEY(game)       REFERENCES Game(display_name)
);
INSERT INTO ItemType(name) VALUES('HPRecovery');

CREATE TABLE PPRecovery(
    name        VARCHAR(16)         NOT NULL,
    game        VARCHAR(16)         NOT NULL,
    pp_recv     TINYINT UNSIGNED    NOT NULL,
    percentage  BIT                 NOT NULL DEFAULT 0,
    PRIMARY KEY(name, game),
    FOREIGN KEY(name, game) REFERENCES ItemDetails(name, game),
    FOREIGN KEY(game)       REFERENCES Game(display_name)
);
INSERT INTO ItemType(name) VALUES('PPRecovery');

CREATE TABLE KeyItem(
    name    VARCHAR(16)     NOT NULL,
    game    VARCHAR(16)     NOT NULL,
    PRIMARY KEY(name, game),
    FOREIGN KEY(name, game) REFERENCES ItemDetails(name, game),
    FOREIGN KEY(game)       REFERENCES Game(display_name)
);
INSERT INTO ItemType(name) VALUES('Key Item');
