SELECT medicos.nombre, medicamentos.nombre, COUNT(recetas.id_medicamento) AS CantidadMedicamentos
FROM recetas
LEFT JOIN medicos ON recetas.id_medico = medicos.id_medico
LEFT JOIN medicamentos ON recetas.id_medicamento = medicamentos.id_medicamento
WHERE recetas.id_medico = 2
GROUP BY medicos.nombre, medicamentos.nombre
HAVING COUNT(recetas.id_medicamento) > 1;
