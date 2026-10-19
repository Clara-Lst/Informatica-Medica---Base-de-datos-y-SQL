SELECT especialidades.nombre, COUNT(medicos.id_medico)
FROM especialidades
LEFT JOIN medicos ON especialidades.id_especialidad = medicos.especialidad_id
GROUP BY especialidades.nombre
HAVING COUNT(medicos.id_medico) > 2;