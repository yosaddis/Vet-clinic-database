CREATE DATABASE vet_clinic;
CREATE TABLE animals (id INT GENERATED BY DEFAULT AS IDENTITY,  name VARCHAR(200) NOT NULL, date_of_birth DATE NOT NULL, escape_attempts INT NOT NULL, neutered BOOLEAN,  weight_kg DECIMAL);
ALTER TABLE
  animals
ADD
  COLUMN species VARCHAR(55);
  