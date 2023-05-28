CREATE TABLE TrainerClass(
    name VARCHAR(16) NOT NULL,
    PRIMARY KEY(name)
);

CREATE TABLE Trainer(
    -- id      SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT,
    name    VARCHAR(16)         NOT NULL,
    ot_id   SMALLINT UNSIGNED   NOT NULL,
    game    VARCHAR(16)         NOT NULL,
    class   VARCHAR(16),
    PRIMARY KEY(ot_id, game),
    FOREIGN KEY(game)   REFERENCES Game(display_name),
    FOREIGN KEY(class)  REFERENCES TrainerClass(name)
);
