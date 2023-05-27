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
    -- TODO: make this a lookup table instead of an enum
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

-- TODO: restructure Pokedex tables to be more logical and less redundant
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
    region          TINYINT  UNSIGNED       NOT NULL,
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
    FOREIGN KEY(region)         REFERENCES Region(id),
    FOREIGN KEY(type_1)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)        REFERENCES PokeStats(id)
);
ALTER TABLE UniversalPokeID
    ADD region_form_id SMALLINT UNSIGNED DEFAULT NULL;

-- CREATE TABLE MoveLearnOrder(
--     universal_id    SMALLINT UNSIGNED       NOT NULL,
--     move_id     SMALLINT UNSIGNED   NOT NULL,
--     level       TINYINT UNSIGNED    NOT NULL        COMMENT '0 means learn on evolution',
--     PRIMARY KEY(pokemon_id, move_id, level),
--     CONSTRAINT CHK_level CHECK(level <= 100),
--     FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id),
--     FOREIGN KEY(move_id)    REFERENCES Move(id)
-- );

-- TODO: make lookup table for alt form moniker names
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
    item_id         SMALLINT UNSIGNED,
    PRIMARY KEY(id),
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id),
    FOREIGN KEY(type_1)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(type_2)         REFERENCES TypeMatchup(name),
    FOREIGN KEY(stat_id)        REFERENCES PokeStats(id),
    FOREIGN KEY(item_id)        REFERENCES ItemDetails(id)
);
ALTER TABLE UniversalPokeID
    ADD alt_form_id SMALLINT UNSIGNED DEFAULT NULL;

CREATE TABLE RegionalPokedex(
    universal_id    SMALLINT UNSIGNED                   NOT NULL,
    region_id       TINYINT  UNSIGNED                   NOT NULL,
    id              SMALLINT UNSIGNED                   NOT NULL COMMENT 'regional pokédex number',
    owned           ENUM("unknown", "seen", "owned")    NOT NULL,
    description     TINYTEXT                            NOT NULL,
    PRIMARY KEY(universal_id, region_id),
    FOREIGN KEY(universal_id) REFERENCES UniversalPokeID(id),
    FOREIGN KEY(region_id)    REFERENCES Region(id)
);

-- AlternateForm.moniker
    -- Mega, Primal, Gigantamax
