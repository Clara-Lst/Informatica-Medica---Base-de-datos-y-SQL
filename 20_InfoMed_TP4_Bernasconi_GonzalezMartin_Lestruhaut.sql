SELECT medicos.nombre, COUNT(pacientes.id_paciente) AS ConsultasRealizadas, COALESCE(especialidades.nombre = 'Pediatría', FALSE) AS EsPediatra
FROM consultas
RIGHT JOIN medicos ON consultas.id_medico = medicos.id_medico
LEFT JOIN pacientes ON consultas.id_paciente = pacientes.id_paciente AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, pacientes.fecha_nacimiento)) < 18  
LEFT JOIN especialidades ON medicos.especialidad_id = especialidades.id_especialidad
GROUP BY medicos.id_medico, especialidades.nombre
ORDER BY ConsultasRealizadas DESC;