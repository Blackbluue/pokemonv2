CREATE TABLE BasePokeStats(
    nat_id     SMALLINT UNSIGNED   NOT NULL,
    reg_form   TINYINT  UNSIGNED,
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
    PRIMARY KEY(nat_id, reg_form),
    FOREIGN KEY(reg_form)           REFERENCES Region(id),
    FOREIGN KEY(ability_1)          REFERENCES Ability(name),
    FOREIGN KEY(ability_2)          REFERENCES Ability(name),
    FOREIGN KEY(exp_growth_rate)    REFERENCES ExpGrowth(growth_rate)
);

-- TODO: add egg group lookup table
CREATE TABLE PokeBreeding(
    nat_id     SMALLINT UNSIGNED   NOT NULL,
    reg_form   TINYINT  UNSIGNED,
    egg_cycles      TINYINT  UNSIGNED   NOT NULL,
    egg_group_1     VARCHAR(16)         NOT NULL,
    egg_group_2     VARCHAR(16)         DEFAULT NULL,
    happiness       TINYINT UNSIGNED    NOT NULL DEFAULT 50,
    PRIMARY KEY(nat_id, reg_form),
    FOREIGN KEY(reg_form)          REFERENCES Region(id)
);

-- Must insert records into this table before any table that adds a reference column to it
CREATE TABLE UniversalPokeID(
    -- id              SMALLINT UNSIGNED   NOT NULL,
    nat_id     SMALLINT UNSIGNED   NOT NULL,
    reg_form   TINYINT  UNSIGNED,
    name            VARCHAR(16)             NOT NULL,
    base_stat_id    SMALLINT UNSIGNED   NOT NULL,
    breeding_id     SMALLINT UNSIGNED,
    type_1          VARCHAR(16)         NOT NULL,
    type_2          VARCHAR(16),
    -- ot_id           SMALLINT UNSIGNED,
    PRIMARY KEY(nat_id, reg_form),
    FOREIGN KEY(nat_id, reg_form)   REFERENCES BasePokeStats(nat_id, reg_form),
    FOREIGN KEY(nat_id, reg_form)   REFERENCES PokeBreeding(nat_id, reg_form),
    FOREIGN KEY(reg_form)           REFERENCES Region(id),
    FOREIGN KEY(type_1)             REFERENCES Type(name),
    FOREIGN KEY(type_2)             REFERENCES Type(name)
);
