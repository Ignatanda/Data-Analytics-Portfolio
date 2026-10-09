-- A. Crearea bazei de date
-- Am creat baza technova_hr si am importat cele 3 tabele(Import Flat File).
-- Am adaugat Primary Key pentru fiecare tabel
--Foreign Keys pentru a face legatura intre angajati, departamente si evaluari.


ALTER TABLE angajati
ADD CONSTRAINT FK_angajati_departamente
FOREIGN KEY (id_departament)
REFERENCES departamente(id_departament);

ALTER TABLE evaluari
ADD CONSTRAINT FK_evaluari_angajati
FOREIGN KEY (id_angajat)
REFERENCES angajati(id_angajat);

-- Verificarea datelor importate
-- Verific numarul de randuri din fiecare tabel
-- si daca emailurile lipsa au fost importate ca NULL.

SELECT COUNT(*) AS nr_departamente FROM departamente;
SELECT COUNT(*) AS nr_angajati FROM angajati;
SELECT COUNT(*) AS nr_evaluari FROM evaluari;

SELECT
    COUNT(*) AS emailuri_lipsa
FROM angajati
WHERE email IS NULL;

SELECT
    COUNT(*) AS data_plecare_lipsa
FROM angajati
WHERE data_plecarii IS NULL;

SELECT
    COUNT(*) AS motiv_plecare_lipsa
FROM angajati
WHERE motiv_plecare IS NULL;

--B. Interogări obligatorii (12)
-- 1. Numărul total de angajați, câți sunt activi și câți au plecat.


SELECT
    COUNT(*) AS total_angajati,
    SUM(plecat) AS angajati_plecati,
    COUNT(*) -SUM(plecat) AS angajati_activi
FROM angajati

--2. Numărul de angajați pe departament (cu numele departamentului), 
--ordonat descrescător. (JOIN)

SELECT
    d.nume_departament as departament,
    COUNT(*) AS angajati
FROM angajati as a
JOIN departamente as d
ON d.id_departament = a.id_departament
GROUP BY d.nume_departament
ORDER BY angajati DESC;

--3. Salariul mediu, minim și maxim pe fiecare nivel.

SELECT
    nivel as Nivel,
    ROUND(AVG(salariu_brut_lunar), 2) as Salariul_mediu,
    MIN(salariu_brut_lunar) as Salariul_min,
    MAX(salariu_brut_lunar) as Salariul_max
FROM angajati
GROUP BY nivel

--4. Rata de plecare pe departament

SELECT
    d.nume_departament as Departament,
    COUNT(*) as Total_angajati,
    SUM(CASE 
            WHEN a.status = 'Plecat' THEN 1 
            ELSE 0 
            END) as Angajati_plecati,
    CAST(
         100.0 * SUM(CASE 
                         WHEN a.status = 'Plecat' THEN 1 
                         ELSE 0 
                         END) 
           / COUNT(*) AS DECIMAL (5,2))
           as Rata_plecare
FROM angajati as a
JOIN departamente as d
ON d.id_departament = a.id_departament
GROUP BY d.nume_departament

--5.Departamentele cu o rată de plecare mai mare de 20%.

SELECT
    d.nume_departament as Departament,
    CAST(100.0 * SUM(CASE
                        WHEN a.status = 'Plecat' THEN 1
                        ELSE 0
                        END) / COUNT(*) AS DECIMAL(5,2) 
        ) AS Rata_plecare     
FROM angajati as a
JOIN departamente as d
on d.id_departament = a.id_departament
GROUP BY d.nume_departament
HAVING 100.0 * SUM(CASE
                        WHEn a.status = 'Plecat' THEN 1
                        ELSE 0
                        END) / COUNT(*) > 20
ORDER BY d.nume_departament DESC;

--6. Salariul mediu pe gen în fiecare departament.

SELECT 
    d.nume_departament Departament,
    ROUND(AVG(a.salariu_brut_lunar), 2) as Salariu_mediu,
    a.gen as Gen
FROM angajati as a
JOIN departamente as d
on d.id_departament = a.id_departament
GROUP BY d.nume_departament,a.gen

--7. Top 10 cei mai bine plătiți angajați activi: nume, prenume, 
--departament, nivel, salariu.

SELECT TOP 10
    a.nume as Nume,
    a.prenume as Prenume, 
    d.nume_departament as Departament,
    a.nivel as Nivel,
    a.salariu_brut_lunar
FROM angajati as a
JOIN departamente as d
on d.id_departament = a.id_departament
WHERE a.status = 'Activ'
ORDER BY a.salariu_brut_lunar DESC

--8. Motivele de plecare, cu numărul de angajați plecați 
--pentru fiecare motiv și procentul din totalul 
--angajaților plecați.


SELECT  
    motiv_plecare as Motiv_plecare,
    COUNT(*) as Angajati_plecati,
    CAST(100.0 * COUNT(*) /
        (SELECT COUNT(*)
         FROM angajati
         WHERE status = 'Plecat') 
         AS DECIMAL (5,2)
         ) AS Procent
FROM angajati
WHERE status = 'Plecat'
GROUP BY motiv_plecare
ORDER BY Angajati_plecati DESC

--9. Angajații al căror salariu este mai mare decât media 
--departamentului lor; media se calculează pe toți 
--angajații departamentului. (subinterogare)


SELECT 
      a.nume as Nume,
      a.prenume as Prenume,
      d.nume_departament as Departament,
      a.salariu_brut_lunar as Salariu,

      (SELECT AVG(a2.salariu_brut_lunar)
     FROM angajati AS a2
     WHERE a2.id_departament = a.id_departament
    ) AS Salariu_mediu_departament
FROM angajati as a
JOIN departamente as d
on d.id_departament = a.id_departament
WHERE a.salariu_brut_lunar > (
    SELECT AVG(a2.salariu_brut_lunar)
    FROM angajati as a2
    WHERE a2.id_departament = a.id_departament)
   
--10. Angajații care nu au nicio evaluare: câți sunt și ce status
--au? (LEFT JOIN + IS NULL)

SELECT 
    a.status as Status,
    COUNT(*) as Numar_anjati_fara_evaluari
FROM angajati as a
LEFT JOIN evaluari as e
on e.id_angajat = a.id_angajat
WHERE e.id_angajat IS NULL
GROUP BY a.status

--11. Numărul de evaluări din 2025 pe categorii de satisfacție: 
--Scăzută (1–4), Medie (5–7), Ridicată (8–10). (CASE WHEN)

SELECT 
    CASE
        WHEN satisfactie_angajat <= 4 THEN 'Scazuta'
        WHEN satisfactie_angajat <= 7 THEN 'Medie'
        WHEN satisfactie_angajat <= 10 THEN 'Ridicata'
    END AS Categorie_satisfactie,
    COUNT(*) AS Numar_de_evaluari
FROM evaluari
WHERE an_evaluare = 2025
GROUP BY CASE
        WHEN satisfactie_angajat <= 4 THEN 'Scazuta'
        WHEN satisfactie_angajat <= 7 THEN 'Medie'
        WHEN satisfactie_angajat <= 10 THEN 'Ridicata'
    END

--12. Scorul mediu de performanță, bonusul mediu și orele
--suplimentare medii pe departament,
--pentru evaluările din 2025. (JOIN pe toate cele 3 tabele)

SELECT 
    d.nume_departament as Departament,
    AVG(e.scor_performanta) as Media_performantei,
    AVG(e.procent_bonus) as Media_bonus,
    AVG(e.ore_suplimentare_lunare) as Medie_ore_suplimentare
FROM angajati as a
JOIN departamente as d
on d.id_departament = a.id_departament
JOIN evaluari as e
on e.id_angajat = a.id_angajat
WHERE e.an_evaluare = 2025
GROUP BY d.nume_departament

