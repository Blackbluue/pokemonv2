-- TODO: add lookup table for flavors
CREATE TABLE Nature(
    name            VARCHAR(16) NOT NULL,
    stat_up         BIT(3) COMMENT '0-4 = atk, def, sp_atk, sp_def, spd in order',
    stat_down       BIT(3),
    fav_flavor      VARCHAR(16) NOT NULL,
    hate_flavor     VARCHAR(16) NOT NULL,
    PRIMARY KEY(name)
);

-- TODO: decide if these stats should also include ev/IV/nature changes
CREATE TABLE PokeStats(
    id              SMALLINT UNSIGNED   NOT NULL,
    nature          VARCHAR(16)         NOT NULL,
    ability         VARCHAR(16)         NOT NULL,
    stats_hp        SMALLINT UNSIGNED   NOT NULL,
    stats_atk       SMALLINT UNSIGNED   NOT NULL,
    stats_def       SMALLINT UNSIGNED   NOT NULL,
    stats_sp_atk    SMALLINT UNSIGNED   NOT NULL,
    stats_sp_def    SMALLINT UNSIGNED   NOT NULL,
    stats_spd       SMALLINT UNSIGNED   NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(nature)           REFERENCES Nature(name),
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

-- TODO: add ribbon information
CREATE TABLE Pokemon(
    id              SMALLINT UNSIGNED   NOT NULL,
    nat_id          SMALLINT UNSIGNED   NOT NULL,
    reg_form        VARCHAR(16)         COMMENT 'NULL for no regional form',
    gender          BIT                 COMMENT '0 for male, 1 for female, NULL for genderless',
    spc_form        BIT(5)              COMMENT 'NULL for no special form',
    btl_form        VARCHAR(16),
    ot_id           SMALLINT UNSIGNED,
    game            VARCHAR(16)         NOT NULL,
    ot_name         VARCHAR(16),
    nickname        VARCHAR(16),
    held_item       VARCHAR(16),
    date_met        DATE,
    level           TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT CHK_level                                        CHECK(level <= 100),
    FOREIGN KEY(id)                                             REFERENCES PokeStats(id),
    FOREIGN KEY(id)                                             REFERENCES HiddenStats(id),
    FOREIGN KEY(id)                                             REFERENCES MoveList(id),
    FOREIGN KEY(nat_id, reg_form, gender, spc_form, btl_form)   REFERENCES UniversalPokeID(nat_id, reg_form, gnd_form, spc_form, btl_form),
    FOREIGN KEY(game)                                           REFERENCES Game(display_name),
    FOREIGN KEY(ot_id, game)                                    REFERENCES Trainer(ot_id, game),
    FOREIGN KEY(held_item, game)                                REFERENCES ItemDetails(name, game)
);
