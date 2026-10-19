SELECT medicamentos.nombre, medicos.nombre, pacientes.nombre, COUNT (recetas.id_medicamento) AS RecetaPrescriptaMedicamento
FROM recetas
LEFT JOIN medicamentos ON medicamentos.id_medicamento = recetas.id_medicamento
LEFT JOIN medicos ON medicos.id_medico = recetas.id_medico
LEFT JOIN pacientes ON pacientes.id_paciente = recetas.id_paciente
GROUP BY medicamentos.id_medicamento, medicos.id_medico, pacientes.id_paciente
ORDER BY RecetaPrescriptaMedicamento DESC;