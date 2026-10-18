SELECT nombre, calle, numero, ciudad
FROM pacientes
WHERE ciudad iLIKE '%b%s%ai%';
