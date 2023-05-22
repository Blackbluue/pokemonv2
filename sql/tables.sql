-- DROP TABLE IF EXISTS Pokemon;
DROP TABLE IF EXISTS EntryStatus;
DROP TABLE IF EXISTS AlternateForm;
DROP TABLE IF EXISTS NationalPokeDex;
DROP TABLE IF EXISTS PokeBreeding;
DROP TABLE IF EXISTS PokeStats;
DROP TABLE IF EXISTS Ability;
DROP TABLE IF EXISTS TypeMatchup;

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

CREATE TABLE Ability(
    name        VARCHAR(16) NOT NULL,
    flavor_text TINYTEXT    NOT NULL,
    PRIMARY KEY(name)
);

-- TODO: add a moves tables
CREATE TABLE PokeStats(
    id              SMALLINT UNSIGNED                                   NOT NULL,
    ability_1       VARCHAR(16)                                         NOT NULL,
    ability_2       VARCHAR(16)                                         DEFAULT NULL,
    ability_hidden  VARCHAR(16)                                         DEFAULT NULL,
    stats_hp        TINYINT UNSIGNED                                    NOT NULL,
    stats_atk       TINYINT UNSIGNED                                    NOT NULL,
    stats_def       TINYINT UNSIGNED                                    NOT NULL,
    stats_sp_atk    TINYINT UNSIGNED                                    NOT NULL,
    stats_sp_def    TINYINT UNSIGNED                                    NOT NULL,
    stats_spd       TINYINT UNSIGNED                                    NOT NULL,
    ev_hp           BIT(2)                                              NOT NULL,
    ev_atk          BIT(2)                                              NOT NULL,
    ev_def          BIT(2)                                              NOT NULL,
    ev_sp_atk       BIT(2)                                              NOT NULL,
    ev_sp_def       BIT(2)                                              NOT NULL,
    ev_spd          BIT(2)                                              NOT NULL,
    exp_yield       SMALLINT UNSIGNED                                   NOT NULL,
    exp_growth_rate ENUM('err', 'fst', 'm_fst', 'm_slw', 'slw', 'flc')  NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(ability_1)     REFERENCES Ability(name),
    FOREIGN KEY(ability_2)     REFERENCES Ability(name)
);

CREATE TABLE PokeBreeding(
    id          SMALLINT UNSIGNED   NOT NULL COMMENT 'national pokédex number',
    egg_cycles  TINYINT UNSIGNED    NOT NULL,
    egg_group_1 VARCHAR(16)         NOT NULL,
    egg_group_2 VARCHAR(16)         DEFAULT NULL,
    happiness   TINYINT UNSIGNED    NOT NULL DEFAULT 50,
    PRIMARY KEY(id)
);

-- TODO: add tables for each regional pokedex
CREATE TABLE NationalPokeDex(
    id                      SMALLINT UNSIGNED       NOT NULL COMMENT 'national pokédex number',
    name                    VARCHAR(16)             NOT NULL UNIQUE,
    type_1                  VARCHAR(16)             NOT NULL,
    type_2                  VARCHAR(16)             DEFAULT NULL,
    stat_id                 SMALLINT UNSIGNED       NOT NULL,
    classification          VARCHAR(16)             NOT NULL,
    height                  DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in meters',
    weight                  DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in kilograms',
    capture_rate            TINYINT UNSIGNED        NOT NULL,
    evolution               SMALLINT UNSIGNED       DEFAULT NULL COMMENT 'national pokédex number',
    description             TINYTEXT                NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id)         REFERENCES PokeBreeding(id),
    FOREIGN KEY(type_1)     REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)     REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)    REFERENCES PokeStats(id),
    FOREIGN KEY(evolution)  REFERENCES NationalPokeDex(id)
);

-- TODO: create item table
CREATE TABLE AlternateForm(
    id                      TINYINT UNSIGNED        NOT NULL,
    base_id                 SMALLINT UNSIGNED       NOT NULL COMMENT 'national pokédex number',
    moniker                 VARCHAR(16)             NOT NULL,
    type_1                  VARCHAR(16)             NOT NULL,
    type_2                  VARCHAR(16)             DEFAULT NULL,
    stat_id                 SMALLINT UNSIGNED       NOT NULL,
    height                  DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in meters',
    weight                  DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in kilograms',
    description             TINYTEXT                NOT NULL,
    item_id                 SMALLINT,
    PRIMARY KEY(id),
    FOREIGN KEY(base_id)    REFERENCES NationalPokeDex(id),
    FOREIGN KEY(type_1)     REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)     REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)    REFERENCES PokeStats(id)
);

-- TODO: possibly incorporate this table into regional pokedexes
CREATE TABLE EntryStatus(
    base_id     SMALLINT UNSIGNED                   NOT NULL COMMENT 'national pokédex number',
    form_id     TINYINT UNSIGNED                    DEFAULT NULL,
    owned       ENUM("unknown", "seen", "owned")    NOT NULL,
    PRIMARY KEY(base_id, form_id),
    FOREIGN KEY(base_id)    REFERENCES NationalPokeDex(id),
    FOREIGN KEY(form_id)    REFERENCES AlternateForm(id)
);

-- TODO: add extra info for an instance of a pokemon
-- CREATE TABLE Pokemon(
--     id SMALLINT UNSIGNED NOT NULL COMMENT 'national pokédex number',
--     FOREIGN KEY(base_id) REFERENCES PokeStats(id),
-- );
