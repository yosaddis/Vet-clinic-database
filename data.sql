INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Charmander', '2020-02-08', 0, false, -11),
  ('Plantmon', '2021-11-15', 2, true, -5.7),
  ('Squirtle', '1993-04-02', 3, false, -12.13),
  ('Angemon', '2005-06-12', 1, true, -45),
  ('Boarmon', '2005-06-07', 7, true, 20.4),
  ('Blossom', '1998-10-13', 3, true, 17),
  ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO
  species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

UPDATE
  animals
SET
  species_id = 2
WHERE
  name LIKE '%mon';

UPDATE
  animals
SET
  species_id = 1
WHERE
  species_id IS NULL;

UPDATE
  animals
SET
  owner_id = 1
WHERE
  name = 'Agumon';
UPDATE
  animals
SET
  owner_id = 2
WHERE
  name IN ('Gabumon', 'Pikachu');
UPDATE
  animals
SET
  owner_id = 3
WHERE
  name IN ('Devimon', 'Plantmon');
UPDATE
  animals
SET
  owner_id = 4
WHERE
  name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE
  animals
SET
  owner_id = 5
WHERE
  name IN ('Angemon', 'Boarmon');

INSERT INTO
  vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-07-08');

INSERT INTO
  visits (animal_id, vet_id, date)
VALUES
  ('1', '1', '2020-5-24'),
  ('1', '3', '2020-7-22'),
  ('2', '4', '2021-2-2'),
  ('3', '2', '2020-1-5'),
  ('3', '2', '2020-3-8'),
  ('3', '2', '2020-5-14'),
  ('4', '3', '2021-5-4'),
  ('5', '4', '2021-2-24'),
  ('6', '2', '2019-12-21'),
  ('6', '1', '2020-8-10'),
  ('6', '2', '2021-4-7'),
  ('7', '3', '2019-9-29'),
  ('8', '4', '2020-10-3'),
  ('8', '4', '2020-11-4'),
  ('9', '2', '2019-1-24'),
  ('9', '2', '2019-5-15'),
  ('9', '2', '2020-2-27'),
  ('9', '2', '2020-8-3'),
  ('10', '3', '2020-5-24'),
  ('10', '1', '2021-1-11');

