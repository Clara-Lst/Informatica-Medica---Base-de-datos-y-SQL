SELECT pacientes.nombre, COUNT(recetas.id_paciente) AS CantidadRecetas
FROM recetas
RIGHT JOIN pacientes ON recetas.id_paciente = pacientes.id_paciente
GROUP BY pacientes.id_paciente
ORDER BY CantidadRecetas