CREATE TABLE Pokedex(
    poke_id         SMALLINT UNSIGNED                   NOT NULL,
    classification  VARCHAR(16)                         NOT NULL,
    height          DECIMAL(6,2) UNSIGNED               NOT NULL COMMENT 'measured in meters',
    weight          DECIMAL(6,2) UNSIGNED               NOT NULL COMMENT 'measured in kilograms',
    owned           ENUM("unknown", "seen", "owned")    NOT NULL,
    evo_id          SMALLINT UNSIGNED,
    PRIMARY KEY(poke_id),
    FOREIGN KEY(poke_id)    REFERENCES SpeciesID(id),
    FOREIGN KEY(evo_id)     REFERENCES Pokedex(poke_id)
);

-- TODO: add language based descriptions, currently assumes EN
CREATE TABLE RegionalPokedex(
    poke_id SMALLINT UNSIGNED   NOT NULL,
    game    VARCHAR(16)         NOT NULL,
    reg_id  SMALLINT UNSIGNED   NOT NULL,
    description TINYTEXT        NOT NULL,
    PRIMARY KEY(poke_id, game),
    FOREIGN KEY(poke_id)    REFERENCES Pokedex(poke_id),
    FOREIGN KEY(game)       REFERENCES Game(display_name)
);
