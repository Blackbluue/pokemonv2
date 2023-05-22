CREATE TABLE MoveTargeting(
    id      TINYINT UNSIGNED NOT NULL,
    name    VARCHAR(32),
    PRIMARY KEY(id)
);

CREATE TABLE MoveExtraData(
    id          SMALLINT UNSIGNED       NOT NULL,
    -- effect      TINYINT,
    -- effect_rate TINYINT     DEFAULT 100,
    -- condition   TINYINT,
    target      TINYINT UNSIGNED        NOT NULL,
    crit_rate   DECIMAL(5, 2) UNSIGNED  DEFAULT 4.17,
    priority    TINYINT                 NOT NULL DEFAULT 0,
    recoil      DECIMAL(3, 2)           DEFAULT NULL,
    crash       DECIMAL(3, 2)           DEFAULT NULL,
    contact     BIT                     NOT NULL DEFAULT 0,
    sound       BIT                     NOT NULL DEFAULT 0,
    punch       BIT                     NOT NULL DEFAULT 0,
    biting      BIT                     NOT NULL DEFAULT 0,
    snatch      BIT                     NOT NULL DEFAULT 0,
    slicing     BIT                     NOT NULL DEFAULT 0,
    bullet      BIT                     NOT NULL DEFAULT 0,
    wind        BIT                     NOT NULL DEFAULT 0,
    powder      BIT                     NOT NULL DEFAULT 0,
    gravity     BIT                     NOT NULL DEFAULT 0,
    defrost     BIT                     NOT NULL DEFAULT 0,
    reflect     BIT                     NOT NULL DEFAULT 0,
    block       BIT                     NOT NULL DEFAULT 1,
    copy        BIT                     NOT NULL DEFAULT 1,
    spc_eff     TINYTEXT                DEFAULT NULL,
    PRIMARY KEY(id),
    -- CONSTRAINT CHK_effect_rate CHECK(effect_rate <= 100),
    CONSTRAINT CHK_priority CHECK(priority >= -7 AND priority <= 5),
    FOREIGN KEY(target)     REFERENCES MoveTargeting(id)
);

CREATE TABLE Move(
    id          SMALLINT UNSIGNED       NOT NULL,
    name        VARCHAR(16)             NOT NULL,
    type        VARCHAR(16)             NOT NULL,
    category    TINYINT UNSIGNED        NOT NULL COMMENT 'values 0, 1, 2 for physical, special, other',
    pp          TINYINT UNSIGNED        NOT NULL,
    base_power  TINYINT UNSIGNED,
    accuracy    TINYINT UNSIGNED        DEFAULT 100,
    text        TINYTEXT                NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT CHK_accuracy CHECK(accuracy <= 100),
    CONSTRAINT CHK_pp CHECK(pp <= 64),
    FOREIGN KEY(id)         REFERENCES MoveExtraData(id),
    FOREIGN KEY(type)       REFERENCES TypeMatchup(name)
);

-- category:
    -- Physical
    -- Special
    -- Other

-- recoil: damage taken by user based on damage dealt to opponent

-- crash: damage taken by the user if the move misses

-- target:
    -- self
    -- single_adjacent_foe
    -- single_adjacent_any
    -- single_adjacent_ally
    -- single_any
    -- user_or_adjacent_ally
    -- all_adjacent_foe
    -- all_adjacent_any
    -- all_foes
    -- field
    -- team
    -- special

-- spc_eff: special attributes on a move that are not standard
