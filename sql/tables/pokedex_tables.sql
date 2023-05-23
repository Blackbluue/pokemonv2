CREATE TABLE PokeStats(
    id              SMALLINT UNSIGNED                                   NOT NULL,
    universal_id    SMALLINT UNSIGNED                                   NOT NULL,
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
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id),
    FOREIGN KEY(ability_1)      REFERENCES Ability(name),
    FOREIGN KEY(ability_2)      REFERENCES Ability(name)
);
ALTER TABLE UniversalPokeID
    ADD stat_id SMALLINT UNSIGNED NOT NULL;

CREATE TABLE PokeBreeding(
    id              SMALLINT UNSIGNED   NOT NULL,
    universal_id    SMALLINT UNSIGNED   NOT NULL,
    egg_cycles      TINYINT UNSIGNED    NOT NULL,
    egg_group_1     VARCHAR(16)         NOT NULL,
    egg_group_2     VARCHAR(16)         DEFAULT NULL,
    happiness       TINYINT UNSIGNED    NOT NULL DEFAULT 50,
    PRIMARY KEY(id),
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id)
);
ALTER TABLE UniversalPokeID
    ADD breeding_id SMALLINT UNSIGNED DEFAULT NULL;

CREATE TABLE NationalPokeDex(
    id              SMALLINT UNSIGNED       NOT NULL COMMENT 'national pokédex number',
    universal_id    SMALLINT UNSIGNED       NOT NULL,
    name            VARCHAR(16)             NOT NULL UNIQUE,
    type_1          VARCHAR(16)             NOT NULL,
    type_2          VARCHAR(16)             DEFAULT NULL,
    stat_id         SMALLINT UNSIGNED       NOT NULL,
    classification  VARCHAR(16)             NOT NULL,
    height          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in meters',
    weight          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in kilograms',
    capture_rate    TINYINT UNSIGNED        NOT NULL,
    evolution       SMALLINT UNSIGNED       DEFAULT NULL COMMENT 'national pokédex number',
    description     TINYTEXT                NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id),
    FOREIGN KEY(type_1)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)        REFERENCES PokeStats(id),
    FOREIGN KEY(evolution)      REFERENCES NationalPokeDex(id)
);
ALTER TABLE UniversalPokeID
    ADD national_id SMALLINT UNSIGNED NOT NULL;

CREATE TABLE RegionalForm(
    id              SMALLINT UNSIGNED       NOT NULL,
    universal_id    SMALLINT UNSIGNED       NOT NULL,
    region          VARCHAR(16)             NOT NULL,
    type_1          VARCHAR(16)             NOT NULL,
    type_2          VARCHAR(16)             DEFAULT NULL,
    stat_id         SMALLINT UNSIGNED       NOT NULL,
    classification  VARCHAR(16)             NOT NULL,
    height          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in meters',
    weight          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in kilograms',
    capture_rate    TINYINT UNSIGNED        NOT NULL,
    evolution       SMALLINT UNSIGNED       DEFAULT NULL COMMENT 'national pokédex number',
    description     TINYTEXT                NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id),
    FOREIGN KEY(type_1)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)        REFERENCES PokeStats(id)
);
ALTER TABLE UniversalPokeID
    ADD region_form_id SMALLINT UNSIGNED DEFAULT NULL;

-- CREATE TABLE MoveLearnOrder(
--     pokemon_id  SMALLINT UNSIGNED   NOT NULL        COMMENT 'national pokédex number',
--     region_form_id     TINYINT UNSIGNED    DEFAULT NULL,
--     move_id     SMALLINT UNSIGNED   NOT NULL,
--     level       TINYINT UNSIGNED    NOT NULL        COMMENT '0 means learn on evolution',
--     PRIMARY KEY(pokemon_id, move_id, level),
--     CONSTRAINT CHK_level CHECK(level <= 100),
--     FOREIGN KEY(pokemon_id) REFERENCES NationalPokeDex(id),
--     FOREIGN KEY(move_id)    REFERENCES Move(id)
-- );

-- TODO: create item table
CREATE TABLE AlternateForm(
    id              SMALLINT UNSIGNED       NOT NULL,
    universal_id    SMALLINT UNSIGNED       NOT NULL,
    moniker         VARCHAR(16)             NOT NULL,
    type_1          VARCHAR(16)             NOT NULL,
    type_2          VARCHAR(16)             DEFAULT NULL,
    stat_id         SMALLINT UNSIGNED       NOT NULL,
    height          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in meters',
    weight          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in kilograms',
    description     TINYTEXT                NOT NULL,
    item_id         SMALLINT,
    PRIMARY KEY(id),
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id),
    FOREIGN KEY(type_1)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)        REFERENCES PokeStats(id)
);
ALTER TABLE UniversalPokeID
    ADD alt_form_id SMALLINT UNSIGNED DEFAULT NULL;

-- TODO: add region table
CREATE TABLE RegionalPokedex(
    id          SMALLINT UNSIGNED   NOT NULL COMMENT 'regional pokédex number',
    universal_id    SMALLINT UNSIGNED       NOT NULL,
    region_id   TINYINT UNSIGNED    NOT NULL,
    owned       ENUM("unknown", "seen", "owned")    NOT NULL,
    description TINYTEXT            NOT NULL,
    PRIMARY KEY(id, region_id),
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id)
    -- FOREIGN KEY(region_id)    REFERENCES Region(id),
);

-- CREATE TABLE CatchLocation(

-- );

-- TODO: possibly incorporate this table into regional pokedexes
-- CREATE TABLE EntryStatus(
--     universal_id    SMALLINT UNSIGNED       NOT NULL,
--     PRIMARY KEY(universal_id),
--     FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id)
-- );

-- AlternateForm.moniker
    -- Mega, Primal, Gigantamax
