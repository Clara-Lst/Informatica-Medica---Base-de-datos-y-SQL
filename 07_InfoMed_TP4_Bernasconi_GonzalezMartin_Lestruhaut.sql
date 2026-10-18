SELECT p.ciudad, s.descripcion AS sexo, COUNT(*) AS cantidad
FROM Pacientes p
JOIN SexoBiologico s ON s.id_sexo = p.id_sexo
GROUP BY p.ciudad, s.descripcion
ORDER BY p.ciudad, s.descripcion;