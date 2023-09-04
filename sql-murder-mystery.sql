-- Querying the hints given (murder, SQL City and Jan. 15th, 2018) --
SELECT * 
FROM crime_scene_report
WHERE date = 20180115 AND city LIKE 'SQL%' and type = 'murder';

-- Querying for the first witness info --
SELECT * 
FROM person 
WHERE address_street_name 
LIKE 'Northwestern%' 
ORDER BY address_number DESC;

-- Querying the first witness interview --
SELECT * 
FROM interview 
WHERE person_id = 14887;

-- Querying for the second witness info --
SELECT * 
FROM person 
WHERE name 
LIKE 'Annabel%' AND address_street_name LIKE 'Franklin%';

-- Querying the second witness interview --
SELECT * 
FROM interview 
WHERE person_id = 16371;

-- Querying using both the first and second witness transcripts --
SELECT * 
FROM get_fit_now_member 
JOIN get_fit_now_check_in 
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE check_in_date = 20180109 AND get_fit_now_member.membership_status = 'gold' 
ORDER BY get_fit_now_member.id DESC;

-- Querying using the plate number info --
SELECT * 
FROM drivers_license 
WHERE plate_number LIKE '%H42W%';

-- Querying using both the driver's license info and personal info --
SELECT name 
FROM drivers_license 
JOIN person 
ON drivers_license.id = person.license_id 
WHERE plate_number LIKE '%H42W%';

