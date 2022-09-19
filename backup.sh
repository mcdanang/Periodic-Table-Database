#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

echo -e "\n~~~~~ PERIODIC TABLE BACKUP ~~~~~\n"

RENAME_WEIGHT=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass")
RENAME_MELTING_POINT=$($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius")
RENAME_BOILING_POINT=$($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius")
SET_NOT_NULL_MELTING_POINT=$($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL")
SET_NOT_NULL_BOILING_POINT=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL")
SET_UNIQUE_SYMBOL=$($PSQL "ALTER TABLE elements ADD CONSTRAINT symbol_unique UNIQUE(symbol)")
SET_UNIQUE_NAME=$($PSQL "ALTER TABLE elements ADD CONSTRAINT name_unique UNIQUE(name)")
SET_NOT_NULL_SYMBOL=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL")
SET_NOT_NULL_NAME=$($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL")
FK_ATOMIC_NUMBER=$($PSQL "ALTER TABLE properties ADD CONSTRAINT properties_atomic_number_fkey FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number)")
CREATE_TYPES_TABLE=$($PSQL "CREATE TABLE types(type_id SERIAL PRIMARY KEY, type VARCHAR(50) NOT NULL)")
INSERT_TYPES_ROW=$($PSQL "INSERT INTO types(type) VALUES('nonmetal'), ('metal'), ('metalloid')")
INSERT_TYPE_ID_COLUMN=$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT CONSTRAINT properties_type_id_fkey REFERENCES types(type_id)")
UPDATE_TYPE_ID1=$($PSQL "UPDATE properties SET type_id = 1 WHERE type = 'nonmetal'")
UPDATE_TYPE_ID2=$($PSQL "UPDATE properties SET type_id = 2 WHERE type = 'metal'")
UPDATE_TYPE_ID3=$($PSQL "UPDATE properties SET type_id = 3 WHERE type = 'metalloid'")
SET_NOT_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL")
CAPITALIZED_FIRST_LETTER=$($PSQL "UPDATE elements SET symbol = INITCAP(symbol)")
DATA_TYPE_TO_DECIMAL=$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL")
REMOVE_TRAILING_ZEROS=$($PSQL "UPDATE properties SET atomic_mass = atomic_mass::REAL")
INSERT_FLUORINE1=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine')")
INSERT_FLUORINE2=$($PSQL "INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 'nonmetal', 18.998, -220, -188.1, 1)")
INSERT_NEON1=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon')")
INSERT_NEON2=$($PSQL "INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(10, 'nonmetal', 20.18, -248.6, -246.1, 1)")
DROP_TYPE_COLUMN=$($PSQL "ALTER TABLE properties DROP COLUMN type")
DELETE_ROW_PROPERTIES=$($PSQL "DELETE FROM properties WHERE atomic_number = 1000")
DELETE_ROW_ELEMENTS=$($PSQL "DELETE FROM elements WHERE atomic_number = 1000")

echo Selesai