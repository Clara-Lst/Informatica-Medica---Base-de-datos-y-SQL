SELECT pacientes.nombre, consultas.diagnostico, consultas.fecha AS UltimaConsulta
FROM consultas
LEFT JOIN pacientes ON pacientes.id_paciente = consultas.id_paciente
WHERE consultas.fecha = (SELECT MAX (c.fecha) FROM consultas c WHERE consultas.id_paciente = c.id_paciente)
ORDER BY UltimaConsulta ASC;