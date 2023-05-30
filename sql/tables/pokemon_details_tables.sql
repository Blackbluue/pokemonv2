-- TODO: move ev/exp info to separate table
-- TODO: move ability info to separate table
CREATE TABLE SpeciesStats(
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
    happiness       TINYINT UNSIGNED    NOT NULL DEFAULT 50,
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
    PRIMARY KEY(id)
);

-- Must insert records into this table before any table that adds a reference column to it
-- TODO: make lookup table for regional/battle form moniker names
CREATE TABLE PokemonSpecies(
    nat_id          SMALLINT UNSIGNED   NOT NULL,
    reg_form        VARCHAR(16)         COMMENT 'NULL for no regional form',
    gnd_form        BIT                 COMMENT 'NULL for no change in gender form',
    spc_form        BIT(5)              COMMENT 'NULL for no special form',
    btl_form        VARCHAR(16),
    name            VARCHAR(16)         NOT NULL COMMENT 'changes in special form name included here',
    base_stat_id    SMALLINT UNSIGNED   NOT NULL,
    breeding_id     SMALLINT UNSIGNED,
    type_1          VARCHAR(16)         NOT NULL,
    type_2          VARCHAR(16),
    capture_rate    TINYINT  UNSIGNED   NOT NULL,
    PRIMARY KEY(nat_id, reg_form, gnd_form, spc_form, btl_form),
    FOREIGN KEY(base_stat_id)   REFERENCES SpeciesStats(id),
    FOREIGN KEY(breeding_id)    REFERENCES PokeBreeding(id),
    FOREIGN KEY(type_1)         REFERENCES Type(name),
    FOREIGN KEY(type_2)         REFERENCES Type(name)
);

-- btl_form.moniker
    -- Mega, Primal, Gigantamax
