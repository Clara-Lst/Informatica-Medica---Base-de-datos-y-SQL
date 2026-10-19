SELECT medicos.nombre, COUNT (consultas.id_paciente) AS ConsultasXPaciente
FROM consultas
RIGHT JOIN medicos ON medicos.id_medico = consultas.id_medico
GROUP BY medicos.nombre
ORDER BY ConsultasXPaciente DESC;