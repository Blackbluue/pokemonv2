CREATE TABLE Region(
    id      TINYINT UNSIGNED    NOT NULL,
    name    VARCHAR(16)         NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE Location(
    id      SMALLINT UNSIGNED    NOT NULL,
    region  TINYINT  UNSIGNED    NOT NULL,
    name    VARCHAR(16)          NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(region) REFERENCES Region(id)
);

CREATE TABLE SpawnLocation(
    loc_id        SMALLINT UNSIGNED         NOT NULL,
    poke_id       SMALLINT UNSIGNED         NOT NULL,
    min_level     TINYINT  UNSIGNED         NOT NULL,
    max_level     TINYINT  UNSIGNED         NOT NULL,
    spawn_rate    DECIMAL(5, 2)  UNSIGNED   NOT NULL,
    spawn_method  TINYINT  UNSIGNED         NOT NULL,
    PRIMARY KEY(loc_id, poke_id),
    FOREIGN KEY(loc_id)       REFERENCES Location(id),
    FOREIGN KEY(poke_id)      REFERENCES UniversalPokeID(id),
    FOREIGN KEY(spawn_method) REFERENCES SpawnMethod(id)
);
