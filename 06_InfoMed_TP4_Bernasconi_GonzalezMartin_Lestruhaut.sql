UPDATE Pacientes
SET ciudad = regexp_replace(trim(ciudad), '\s+', ' ', 'g');

UPDATE Pacientes
SET ciudad = CASE
    WHEN lower(ciudad) IN ('bs aires', 'buenos aires', 'buenos aiers') THEN 'Buenos Aires'
    WHEN lower(ciudad) IN ('cordoba', 'córdoba', 'córodba')            THEN 'Cordoba'
    WHEN lower(ciudad) IN ('mendoza', 'mendzoa')                       THEN 'Mendoza'
    WHEN lower(ciudad) = 'rosario'                                     THEN 'Rosario'
    ELSE ciudad
END;