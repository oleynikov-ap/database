SELECT 
    city.id,
    city.title,
    country.title AS country,
    r.title AS region,
    city.important
FROM
    _cities city
        JOIN
    _countries country ON city.country_id = country.id
        JOIN
    _regions r ON city.region_id = r.id
    
    

SELECT 
    city.id,
    city.title,
    r.title AS region,
    city.important
FROM
    _cities city
        JOIN
    _regions r ON city.region_id = r.id
    WHERE r.title = 'Московская область'