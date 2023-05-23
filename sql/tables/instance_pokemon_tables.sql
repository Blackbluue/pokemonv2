
-- TODO: add extra info for an instance of a pokemon
CREATE TABLE Pokemon(
    id  SMALLINT UNSIGNED   NOT NULL,
    FOREIGN KEY(id) REFERENCES UniversalPokeID(id)
);
