CREATE TABLE PokeStats(
    id              SMALLINT UNSIGNED   NOT NULL,
    ability         VARCHAR(16)         NOT NULL,
    stats_hp        SMALLINT UNSIGNED   NOT NULL,
    stats_atk       SMALLINT UNSIGNED   NOT NULL,
    stats_def       SMALLINT UNSIGNED   NOT NULL,
    stats_sp_atk    SMALLINT UNSIGNED   NOT NULL,
    stats_sp_def    SMALLINT UNSIGNED   NOT NULL,
    stats_spd       SMALLINT UNSIGNED   NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(ability)          REFERENCES Ability(name)
);

CREATE TABLE HiddenStats(
    id          SMALLINT UNSIGNED   NOT NULL,
    happiness   TINYINT  UNSIGNED   NOT NULL,
    ev_hp       TINYINT  UNSIGNED   NOT NULL,
    ev_atk      TINYINT  UNSIGNED   NOT NULL,
    ev_def      TINYINT  UNSIGNED   NOT NULL,
    ev_sp_atk   TINYINT  UNSIGNED   NOT NULL,
    ev_sp_def   TINYINT  UNSIGNED   NOT NULL,
    ev_spd      TINYINT  UNSIGNED   NOT NULL,
    iv_hp       BIT(5) NOT NULL,
    iv_atk      BIT(5) NOT NULL,
    iv_def      BIT(5) NOT NULL,
    iv_dp_atk   BIT(5) NOT NULL,
    iv_sp_def   BIT(5) NOT NULL,
    iv_spd      BIT(5) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE MoveList(
    id      SMALLINT UNSIGNED NOT NULL,
    move_1          VARCHAR(16) NOT NULL,
    move_1_pp_up    BIT(2) NOT NULL,
    move_2          VARCHAR(16),
    move_2_pp_up    BIT(2),
    move_3          VARCHAR(16),
    move_3_pp_up    BIT(2),
    move_4          VARCHAR(16),
    move_4_pp_up    BIT(2),
    PRIMARY KEY(id),
    FOREIGN KEY(move_1) REFERENCES Move(name),
    FOREIGN KEY(move_2) REFERENCES Move(name),
    FOREIGN KEY(move_3) REFERENCES Move(name),
    FOREIGN KEY(move_4) REFERENCES Move(name)
);

CREATE TABLE Pokemon(
    id              SMALLINT UNSIGNED   NOT NULL,
    universal_id    SMALLINT UNSIGNED   NOT NULL,
    ot_id           SMALLINT UNSIGNED,
    ot_name         VARCHAR(16),
    nickname        VARCHAR(16),
    date_met        DATE,
    level           TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT CHK_level        CHECK(level <= 100),
    FOREIGN KEY(id)             REFERENCES PokeStats(id),
    FOREIGN KEY(id)             REFERENCES HiddenStats(id),
    FOREIGN KEY(id)             REFERENCES MoveList(id),
    FOREIGN KEY(universal_id)   REFERENCES UniversalPokeID(id)
);
