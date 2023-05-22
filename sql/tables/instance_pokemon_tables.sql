
-- TODO: add extra info for an instance of a pokemon
CREATE TABLE Pokemon(
    id SMALLINT UNSIGNED NOT NULL COMMENT 'national pokédex number',
    FOREIGN KEY(id) REFERENCES NationalPokeDex(id)
);
