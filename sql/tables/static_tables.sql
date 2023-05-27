-- TODO: manually add in values to this table
-- TODO: make additions to this table be more dynamic for future proofing
CREATE TABLE TypeMatchup(
    name         VARCHAR(16)   NOT NULL,
    vs_normal    DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_fire      DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_fighting  DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_water     DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_flying    DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_grass     DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_poison    DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_electric  DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_ground    DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_psychic   DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_rock      DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_ice       DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_bug       DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_dragon    DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_ghost     DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_dark      DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_steel     DECIMAL(2, 1) NOT NULL DEFAULT 1,
    vs_fairy     DECIMAL(2, 1) NOT NULL DEFAULT 1,
    PRIMARY KEY(name)
);

CREATE TABLE Game(
    id              TINYINT UNSIGNED   NOT NULL,
    display_name    VARCHAR(16)        NOT NULL,
    abbreviation    VARCHAR(5)         NOT NULL,
    generation      TINYINT UNSIGNED   NOT NULL,
    PRIMARY KEY(id)
);

-- TODO: move this table into pokedex_tables.sql
CREATE TABLE Ability(
    name            VARCHAR(16)     NOT NULL,
    flavor_text     TINYTEXT        NOT NULL,
    PRIMARY KEY(name)
);

-- Must insert records into this table before any table that adds a reference column to it
CREATE TABLE UniversalPokeID(
    id SMALLINT UNSIGNED   NOT NULL,
    PRIMARY KEY(id)
);

-- TODO: manually add in values to this table
CREATE TABLE SpawnMethod(
    id      TINYINT UNSIGNED NOT NULL,
    method  TINYTEXT         NOT NULL,
    PRIMARY KEY(id)
);
