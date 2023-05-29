CREATE TABLE BasePokeStats(
    id              SMALLINT UNSIGNED   NOT NULL,
    ability_1       VARCHAR(16)         NOT NULL,
    ability_2       VARCHAR(16)         DEFAULT NULL,
    ability_hidden  VARCHAR(16)         DEFAULT NULL,
    stats_hp        TINYINT UNSIGNED    NOT NULL,
    stats_atk       TINYINT UNSIGNED    NOT NULL,
    stats_def       TINYINT UNSIGNED    NOT NULL,
    stats_sp_atk    TINYINT UNSIGNED    NOT NULL,
    stats_sp_def    TINYINT UNSIGNED    NOT NULL,
    stats_spd       TINYINT UNSIGNED    NOT NULL,
    ev_hp           BIT(2)              NOT NULL,
    ev_atk          BIT(2)              NOT NULL,
    ev_def          BIT(2)              NOT NULL,
    ev_sp_atk       BIT(2)              NOT NULL,
    ev_sp_def       BIT(2)              NOT NULL,
    ev_spd          BIT(2)              NOT NULL,
    exp_yield       SMALLINT UNSIGNED   NOT NULL,
    exp_growth_rate VARCHAR(16)         NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(ability_1)          REFERENCES Ability(name),
    FOREIGN KEY(ability_2)          REFERENCES Ability(name),
    FOREIGN KEY(exp_growth_rate)    REFERENCES ExpGrowth(growth_rate)
);

-- TODO: add egg group lookup table
CREATE TABLE PokeBreeding(
    id              SMALLINT UNSIGNED   NOT NULL,
    egg_cycles      TINYINT  UNSIGNED   NOT NULL,
    egg_group_1     VARCHAR(16)         NOT NULL,
    egg_group_2     VARCHAR(16)         DEFAULT NULL,
    happiness       TINYINT UNSIGNED    NOT NULL DEFAULT 50,
    PRIMARY KEY(id)
);

-- Must insert records into this table before any table that adds a reference column to it
CREATE TABLE UniversalPokeID(
    id              SMALLINT UNSIGNED   NOT NULL,
    base_stat_id    SMALLINT UNSIGNED   NOT NULL,
    breeding_id     SMALLINT UNSIGNED   DEFAULT NULL,
    ot_id           SMALLINT UNSIGNED,
    PRIMARY KEY(id),
    FOREIGN KEY(id)     REFERENCES BasePokeStats(id),
    FOREIGN KEY(id)     REFERENCES PokeBreeding(id)
);
