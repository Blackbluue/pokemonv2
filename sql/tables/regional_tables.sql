CREATE TABLE Region(
    name    VARCHAR(16)     NOT NULL,
    game    VARCHAR(16)     NOT NULL,
    PRIMARY KEY(name, game),
    FOREIGN KEY(game) REFERENCES Game(display_name)
);

CREATE TABLE Location(
    name    VARCHAR(16)     NOT NULL,
    region  VARCHAR(16)     NOT NULL,
    game    VARCHAR(16)     NOT NULL,
    PRIMARY KEY(name, region, game),
    FOREIGN KEY(region, game) REFERENCES Region(name, game)
);

CREATE TABLE SpawnMethod(
    method  VARCHAR(64)     NOT NULL,
    PRIMARY KEY(method)
);

-- TODO: may move to pokedex file
-- CREATE TABLE SpawnLocation(
--     loc_id          SMALLINT UNSIGNED       NOT NULL,
--     region          TINYINT  UNSIGNED       NOT NULL,
--     poke_id         SMALLINT UNSIGNED       NOT NULL,
--     min_level       TINYINT  UNSIGNED       NOT NULL,
--     max_level       TINYINT  UNSIGNED       NOT NULL,
--     spawn_rate      DECIMAL(5, 2)  UNSIGNED NOT NULL,
--     spawn_method    VARCHAR(64)             NOT NULL,
--     PRIMARY KEY(loc_id, poke_id),
--     FOREIGN KEY(loc_id)       REFERENCES Location(id),
--     FOREIGN KEY(poke_id)      REFERENCES UniversalPokeID(id),
--     FOREIGN KEY(spawn_method) REFERENCES SpawnMethod(method)
-- );
