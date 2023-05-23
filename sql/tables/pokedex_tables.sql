
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
    id          SMALLINT UNSIGNED   NOT NULL,
    egg_cycles  TINYINT UNSIGNED    NOT NULL,
    egg_group_1 VARCHAR(16)         NOT NULL,
    egg_group_2 VARCHAR(16)         DEFAULT NULL,
    happiness   TINYINT UNSIGNED    NOT NULL DEFAULT 50,
    PRIMARY KEY(id)
);

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

CREATE TABLE RegionalForm(
    id                      TINYINT UNSIGNED        NOT NULL,
    base_id                 SMALLINT UNSIGNED       NOT NULL COMMENT 'national pokédex number',
    region                  VARCHAR(16)             NOT NULL,
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
    FOREIGN KEY(base_id)    REFERENCES NationalPokeDex(id),
    FOREIGN KEY(type_1)     REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)     REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)    REFERENCES PokeStats(id)
);

CREATE TABLE UniversalPokeID(
    id          SMALLINT UNSIGNED   NOT NULL,
    national_id SMALLINT UNSIGNED   NOT NULL,
    form_id     TINYINT UNSIGNED    DEFAULT NULL,
    breeding_id SMALLINT UNSIGNED   NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(national_id)    REFERENCES NationalPokeDex(id),
    FOREIGN KEY(form_id)    REFERENCES RegionalForm(id)
    FOREIGN KEY(breeding_id)    REFERENCES PokeBreeding(id)
);

-- CREATE TABLE MoveLearnOrder(
--     pokemon_id  SMALLINT UNSIGNED   NOT NULL        COMMENT 'national pokédex number',
--     form_id     TINYINT UNSIGNED    DEFAULT NULL,
--     move_id     SMALLINT UNSIGNED   NOT NULL,
--     level       TINYINT UNSIGNED    NOT NULL        COMMENT '0 means learn on evolution',
--     PRIMARY KEY(pokemon_id, move_id, level),
--     CONSTRAINT CHK_level CHECK(level <= 100),
--     FOREIGN KEY(pokemon_id) REFERENCES NationalPokeDex(id),
--     FOREIGN KEY(move_id)    REFERENCES Move(id)
-- );

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

-- TODO: add region table
CREATE TABLE RegionalPokedex(
    id          SMALLINT UNSIGNED   NOT NULL COMMENT 'regional pokédex number',
    national_id SMALLINT UNSIGNED   NOT NULL COMMENT 'national pokédex number',
    description TINYTEXT            NOT NULL,
    region_id   TINYINT UNSIGNED    NOT NULL,
    PRIMARY KEY(id, national_id),
    FOREIGN KEY(national_id)    REFERENCES NationalPokeDex(id)
);

-- CREATE TABLE CatchLocation(

-- );

-- TODO: possibly incorporate this table into regional pokedexes
CREATE TABLE EntryStatus(
    base_id     SMALLINT UNSIGNED                   NOT NULL COMMENT 'national pokédex number',
    form_id     TINYINT UNSIGNED                    DEFAULT NULL,
    owned       ENUM("unknown", "seen", "owned")    NOT NULL,
    PRIMARY KEY(base_id, form_id),
    FOREIGN KEY(base_id)    REFERENCES NationalPokeDex(id),
    FOREIGN KEY(form_id)    REFERENCES AlternateForm(id)
);

-- AlternateForm.moniker
    -- Mega, Primal, Gigantamax
