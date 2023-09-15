##### Introduction

The SQL Murder Mystery is a detective-like task that required me to use my knowledge of writing SQL queries to figure out the murderer, 
using the three given clues and a database consisting of different tables to figure out the killer.
The clues: A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018 and that it took place in SQL City . 
Start by retrieving the corresponding crime scene report from the police department’s database.

##### Steps

1. First step I took was go through the crime scene report table (crime_scene_report) to look for the hints given (murder, SQL City and Jan. 18th, 2018) using the query:
SELECT * 
FROM crime_scene_report 
WHERE date = 20180115 AND city LIKE 'SQL%' and type = 'murder'

Answer: It brought out only one was the perfect fit according to the hints given.
According to the query, the description stated that “Security footage shows that there were 2 witnesses.
The first witness lives at the last house on Northwestern Dr.
The second witness, name Annabel, lives somewhere on Franklin Ave”

2. The next step was to look for who the two witnesses are.
   
i. For the first witness, he or she lives in the last house on Northwestern Dr.
I had to query the person table for that, to look for the personal info with the last number on the street of Northwestern Dr.
And the query below gave me that:
SELECT * 
FROM person 
WHERE address_street_name 
LIKE 'Northwestern%' 
ORDER BY address_number DESC

Answer: The query revealed to me that the first witness was Morty Schapiro with id 14887

ii. For the second witness, I had to query the same table to know more about Annabel, and the query below gave me that:
SELECT * 
FROM person 
WHERE name 
LIKE 'Annabel%' AND address_street_name LIKE 'Franklin%'

Answer: The query revealed to me that the second witness was Annabel Miller with id 16371

3. The next step was to go to the interview table to see what they know about what happened on the crime scene.
   
i. The query below gave the response for the first witness (Morty Schapiro) using his id from the person table (14887):
SELECT * 
FROM interview 
WHERE person_id = 14887

Answer: According to the transcript, he said I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". Only gold members have those bags. 
The man got into a car with a plate that included "H42W".

ii. For the second witness (Annabel Miller) also using her id from the person table (16371):
SELECT * 
FROM interview 
WHERE person_id = 16371

Answer: According to the transcript she said I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

The two queries above tells us that the murderer is a member in Get Fit Now Gym which takes us to the next step

4. Using the transcript both Morty and Annabel gave, we know part of the membership number (487), he is a gold member and he also checked in on 9th Jan, 2018.
But for us to query all these, we need to join the get fit now member (get_fit_now_member) and the get fit now check in (get_fit_now_check_in) tables using the membership number as the primary key and foreign key:
SELECT * 
FROM get_fit_now_member 
JOIN get_fit_now_check_in 
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE check_in_date = 20180109 AND get_fit_now_member.membership_status = 'gold' 
ORDER BY get_fit_now_member.id DESC

Answer: According to the query above I was able to detect that there were just two members that fit this profile, 
Joe Germuska and Jeremy Bowers because they were the only ones that membership number that included 487 in them (48Z7A and 48Z55 respectively) and are also gold members.

5. Now I had to use what Morty said about the murderer entering a car with plate number that included "H42W”, using the driver’s license table to get the query:
i. SELECT * 
FROM drivers_license 
WHERE plate_number LIKE '%H42W%'
From the query, it gave three possibilities for us to confirm if the owners of these cars are either Joe Germuska or Jeremy Bowers, but we don’t know because names were not listed on the table.
Therefore, we need to join the driver’s license table with the person info using license number from the (driver’s license table) as the primary and foreign key using part of the plate number ‘H42W’ to filter the list:

ii. SELECT name 
FROM drivers_license 
JOIN person 
ON drivers_license.id = person.license_id 
WHERE plate_number LIKE '%H42W%'

Answer: After running this query, the only name that appeared in the gym the same day with Annabel and has the plate number Morthy saw partially was Jeremy Bowers.

##### Conclusion
Jeremy Bowers was the murderer




