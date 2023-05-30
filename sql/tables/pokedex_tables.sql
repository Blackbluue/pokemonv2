CREATE TABLE Pokedex(
    nat_id          SMALLINT UNSIGNED                   NOT NULL,
    reg_form        VARCHAR(16)                         COMMENT 'NULL for no regional form',
    gnd_form        ENUM('M', 'F')                      COMMENT 'NULL for no change in gender form',
    spc_form        BIT(5)                              COMMENT 'NULL for no special form',
    btl_form        VARCHAR(16)                         COMMENT 'NULL for no battle form',
    classification  VARCHAR(16)                         NOT NULL,
    height          DECIMAL(6,2) UNSIGNED               NOT NULL COMMENT 'measured in meters',
    weight          DECIMAL(6,2) UNSIGNED               NOT NULL COMMENT 'measured in kilograms',
    owned           ENUM("unknown", "seen", "owned")    NOT NULL,
    evo_nat_id      SMALLINT UNSIGNED,
    evo_reg_form    VARCHAR(16),
    evo_gnd_form    ENUM('M', 'F'),
    evo_spc_form    BIT(5),
    evo_btl_form    VARCHAR(16),
    PRIMARY KEY(nat_id, reg_form, gnd_form, spc_form, btl_form),
    FOREIGN KEY(reg_form)                                                           REFERENCES RegionalForm(moniker),
    FOREIGN KEY(btl_form)                                                           REFERENCES BattleForm(moniker),
    FOREIGN KEY(nat_id, reg_form, gnd_form, spc_form, btl_form)                     REFERENCES PokemonSpecies(nat_id, reg_form, gnd_form, spc_form, btl_form),
    FOREIGN KEY(evo_nat_id, evo_reg_form, evo_gnd_form, evo_spc_form, evo_btl_form) REFERENCES Pokedex(nat_id, reg_form, gnd_form, spc_form, btl_form)
);

CREATE TABLE RegionalPokedex(
    nat_id      SMALLINT UNSIGNED   NOT NULL,
    reg_form    VARCHAR(16)         COMMENT 'NULL for no regional form',
    gnd_form    ENUM('M', 'F')      COMMENT 'NULL for no change in gender form',
    spc_form    BIT(5)              COMMENT 'NULL for no special form',
    btl_form    VARCHAR(16),
    dex_game    VARCHAR(16)         NOT NULL,
    reg_id      SMALLINT UNSIGNED   NOT NULL,
    description TINYTEXT            NOT NULL,
    PRIMARY KEY(nat_id, reg_form, gnd_form, spc_form, btl_form, dex_game),
    FOREIGN KEY(reg_form)                                               REFERENCES RegionalForm(moniker),
    FOREIGN KEY(btl_form)                                               REFERENCES BattleForm(moniker),
    FOREIGN KEY(nat_id, reg_form, gnd_form, spc_form, btl_form)         REFERENCES Pokedex(nat_id, reg_form, gnd_form, spc_form, btl_form),
    FOREIGN KEY(dex_game)                                               REFERENCES Game(display_name)
);
