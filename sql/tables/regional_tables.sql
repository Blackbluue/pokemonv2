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

CREATE TABLE SpawnLocation(
    loc_name        VARCHAR(16)                 NOT NULL,
    region          VARCHAR(16)                 NOT NULL,
    game            VARCHAR(16)                 NOT NULL,
    poke_id         SMALLINT UNSIGNED           NOT NULL,
    min_level       BIT(7)                      NOT NULL,
    max_level       BIT(7)                      NOT NULL,
    spawn_rate      DECIMAL(5, 2)  UNSIGNED     NOT NULL,
    spawn_method    VARCHAR(64)                 NOT NULL,
    PRIMARY KEY(loc_name, region, game, poke_id),
    CONSTRAINT CHK_level                CHECK(max_level <= 100 AND min_level <= max_level),
    FOREIGN KEY(loc_name, region, game) REFERENCES Location(name, region, game),
    FOREIGN KEY(poke_id)                REFERENCES SpeciesStats(id),
    FOREIGN KEY(spawn_method)           REFERENCES SpawnMethod(method)
);
