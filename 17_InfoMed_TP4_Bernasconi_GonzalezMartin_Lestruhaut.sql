SELECT medicos.nombre, pacientes.nombre, COUNT(consultas.id_medico) AS ConsultasRealizadasXMedico
FROM consultas
LEFT JOIN medicos ON consultas.id_medico = medicos.id_medico
LEFT JOIN pacientes ON consultas.id_paciente = pacientes.id_paciente
GROUP BY medicos.id_medico, pacientes.id_paciente
ORDER BY medicos.nombre, pacientes.nombre
