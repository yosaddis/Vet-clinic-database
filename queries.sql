SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT * FROM animals WHERE neutered=true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name='Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE
  animals
SET
  species = 'unspecified';
SELECT
  *
FROM
  animals;
ROLLBACK;
SELECT
  *
FROM
  animals;

BEGIN;
UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon';
UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species IS NULL;
SELECT
  *
FROM
  animals;
COMMIT;
SELECT
  *
FROM
  animals;

  BEGIN;
DELETE FROM
  animals;
ROLLBACK;
SELECT
  *
FROM
  animals;

BEGIN;
DELETE FROM
  animals
WHERE
  date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE
  animals
SET
  weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE
  animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;
COMMIT;

SELECT
  COUNT(*)
FROM
  animals;
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;
SELECT
  AVG(weight_kg)
FROM
  animals;
SELECT
  neutered,
  MAX(escape_attempts)
FROM
  animals
GROUP BY
  neutered;
SELECT
  species,
  MIN(weight_kg),
  MAX(weight_kg)
FROM
  animals
GROUP BY
  species;
SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-01-01'
  AND '2000-12-31'
GROUP BY
  species;

SELECT
  name,
  full_name as owner
FROM
  animals
  JOIN owners ON animals.owner_id = owners.id
WHERE
  full_name = 'Melody Pond';

SELECT
  A.name as animal_name,
  S.name as type
FROM
  animals A
  JOIN species S ON A.species_id = S.id
WHERE
  S.name = 'Pokemon';

SELECT
  full_name,
  name as animal
FROM
  owners O
  LEFT JOIN animals A ON O.id = A.owner_id;

SELECT
  S.name AS type,
  Count(*) AS animals_count
FROM
  animals A
  JOIN species S ON A.species_id = S.id
GROUP BY
  S.name;

SELECT
  A.name as animal_name,
  full_name as owner,
  S.name AS species
FROM
  animals A
  JOIN owners O ON A.owner_id = O.id
  JOIN species S ON S.id = A.species_id
WHERE
  S.name = 'Digimon'
  AND full_name = 'Jennifer Orwell';

  SELECT
  A.name as animal_name,
  full_name as owner,
  escape_attempts
FROM
  animals A
  JOIN owners O ON A.owner_id = O.id
WHERE
  A.escape_attempts = 0
  AND O.full_name = 'Dean Winchester';

SELECT
  full_name,
  COUNT(*) AS animals_owned
FROM
  animals A
  JOIN owners O ON A.owner_id = O.id
GROUP BY
  O.full_name
ORDER BY
  animals_owned DESC;

-- Who was the last animal seen by William Tatcher ?
SELECT
  a.name,
  vt.name as vet,
  v.date
FROM
  animals a
  JOIN visits v ON v.animal_Id = a.id
  JOIN vets vt ON vt.id = v.vet_id
WHERE
  v.date =(
    SELECT
      MAX(visit_date)
    FROM
      (
        SELECT
          a.name as animal,
          vt.name as vet,
          vs.date as visit_date
        FROM
          animals a
          JOIN visits vs ON vs.animal_id = a.id
          JOIN vets vt ON vt.id = vs.vet_id
        WHERE
          vt.name = 'William Tatcher'
      ) AS subquery
  );

--How many different animals did Stephanie Mendez see ?
  SELECT
  COUNT(*) as no_of_animals_type_visited
FROM
  (
    SELECT
      COUNT(*)
    FROM
      vets vt
      JOIN visits vs ON vt.id = vs.vet_id
    WHERE
      vt.name = 'Stephanie Mendez'
    GROUP BY
      vs.animal_id
  ) AS subquery;

-- List all vets and their specialties, including vets with no specialties.
  SELECT
  v.name,
  s.name as speciality
FROM
  vets v
  LEFT JOIN specializations sp ON sp.vet_id = v.id
  LEFT JOIN species s ON s.id = sp.species_id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th,2020.
SELECT
  a.name,
  v.name as vet,
  date
FROM
  animals a
  JOIN visits ON visits.animal_id = a.id
  JOIN vets v ON visits.vet_id = v.id
WHERE
  v.name = 'Stephanie Mendez'
  AND date BETWEEN '2020-4-1'
  AND '2020-8-30';

--What animal has the most visits to vets ?
SELECT
  a.name AS animal,
  COUNT(*) AS visit_count
FROM
  animals a
  JOIN visits v ON a.id = v.animal_id
GROUP BY
  a.id,
  a.name
ORDER BY
  visit_count DESC
LIMIT
  1;

-- Who was Maisy Smith 's first visit?
SELECT
  a.name,
  v.name as vet,
  date
FROM
  animals a
  JOIN visits ON visits.animal_id = a.id
  JOIN vets v ON visits.vet_id = v.id
WHERE
  v.name = 'Maisy Smith'
ORDER BY
  date
LIMIT
  1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  a.name,
  a.date_of_birth,
  a.escape_attempts,
  a.neutered,
  a.weight_kg,
  v.name as vet_name,
  v.age as vet_age,
  v.date_of_graduation as vet_graduation_date,
  date as visit_date
FROM
  animals a
  JOIN visits ON visits.animal_id = a.id
  JOIN vets v ON visits.vet_id = v.id
ORDER BY
  visit_date DESC
LIMIT
  1;

--How many visits were with a vet that did not specialize in that animal 's species?
SELECT
  COUNT(*) as unspecialized_visits
FROM
  (
    SELECT
      a.id as animal_id,
      a.species_id as animal_species,
      sp.species_id as vet_specialization
    FROM
      animals a
      JOIN visits vs ON a.id = vs.animal_id
      JOIN specializations sp ON sp.vet_id = vs.vet_id
    WHERE
      a.species_id != sp.species_id
  ) AS subquery;

--What specialty should Maisy Smith consider getting ? Look for the species she gets the most.
SELECT
  species.name,
  COUNT(animals.id)
FROM
  visits
  JOIN animals ON visits.animal_id = animals.id
  JOIN species ON animals.species_id = species.id
WHERE
  visits.vet_id = 2
GROUP BY
  species.name
LIMIT 1;