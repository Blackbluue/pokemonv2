CREATE TABLE Region(
    id      TINYINT UNSIGNED    NOT NULL,
    name    VARCHAR(16)         NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE Locations(
    id      TINYINT UNSIGNED    NOT NULL,
    region  TINYINT UNSIGNED    NOT NULL,
    name    VARCHAR(16)         NOT NULL,
);
