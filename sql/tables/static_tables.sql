CREATE TABLE Game(
    display_name    VARCHAR(16)        NOT NULL,
    abbreviation    VARCHAR(5)         NOT NULL,
    generation      TINYINT UNSIGNED   NOT NULL,
    PRIMARY KEY(display_name)
);

CREATE TABLE Type(
    name    VARCHAR(16)   NOT NULL,
    PRIMARY KEY(name)
);

CREATE TABLE TypeMatchup(
    attacker VARCHAR(16) NOT NULL,
    defender VARCHAR(16) NOT NULL,
    multiplier DECIMAL(2, 1) NOT NULL DEFAULT 1,
    PRIMARY KEY(attacker, defender),
    FOREIGN KEY(attacker) REFERENCES Type(name),
    FOREIGN KEY(defender) REFERENCES Type(name)
);

-- TODO: move this table into pokedex_tables.sql
CREATE TABLE Ability(
    name            VARCHAR(16)     NOT NULL,
    flavor_text     TINYTEXT        NOT NULL,
    PRIMARY KEY(name)
);

CREATE TABLE ExpGrowth(
    growth_rate VARCHAR(16) NOT NULL,
    PRIMARY KEY(growth_rate)
);
