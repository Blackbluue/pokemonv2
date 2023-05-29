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
    FOREIGN KEY(type_1)         REFERENCES Type(name),
    FOREIGN KEY(type_2)         REFERENCES Type(name),
    FOREIGN KEY(stat_id)        REFERENCES BasePokeStats(id),
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
    FOREIGN KEY(type_1)         REFERENCES Type(name),
    FOREIGN KEY(type_2)         REFERENCES Type(name),
    FOREIGN KEY(stat_id)        REFERENCES BasePokeStats(id)
);
ALTER TABLE UniversalPokeID
    ADD region_form_id SMALLINT UNSIGNED DEFAULT NULL;

-- CREATE TABLE MoveLearnOrder(
--     universal_id     SMALLINT UNSIGNED       NOT NULL,
--     move             VARCHAR(16)   NOT NULL,
--     level            TINYINT UNSIGNED    NOT NULL        COMMENT '0 means learn on evolution',
--     PRIMARY KEY(pokemon_id, move_id, level),
--     CONSTRAINT CHK_level CHECK(level <= 100),
--     FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id),
--     FOREIGN KEY(move)    REFERENCES Move(name)
-- );

-- TODO: make lookup table for alt form moniker names
CREATE TABLE AlternateForm(
    id              SMALLINT UNSIGNED       NOT NULL,
    universal_id    SMALLINT UNSIGNED       NOT NULL,
    game            VARCHAR(16)             NOT NULL,
    moniker         VARCHAR(16)             NOT NULL,
    type_1          VARCHAR(16)             NOT NULL,
    type_2          VARCHAR(16)             DEFAULT NULL,
    stat_id         SMALLINT UNSIGNED       NOT NULL,
    height          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in meters',
    weight          DECIMAL(6,2) UNSIGNED   NOT NULL COMMENT 'measured in kilograms',
    description     TINYTEXT                NOT NULL,
    item_name       VARCHAR(16),
    PRIMARY KEY(id),
    FOREIGN KEY(universal_id)       REFERENCES UniversalPokeID(id),
    FOREIGN KEY(game)               REFERENCES Game(display_name),
    FOREIGN KEY(type_1)             REFERENCES Type(name),
    FOREIGN KEY(type_2)             REFERENCES Type(name),
    FOREIGN KEY(stat_id)            REFERENCES BasePokeStats(id),
    FOREIGN KEY(item_name, game)    REFERENCES ItemDetails(name, game)
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
