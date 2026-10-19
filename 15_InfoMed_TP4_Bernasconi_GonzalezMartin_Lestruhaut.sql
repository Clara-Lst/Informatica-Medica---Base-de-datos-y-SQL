SELECT medicamentos.nombre, COUNT(recetas.id_medicamento) AS CantidadMedicamento
FROM recetas
INNER JOIN medicamentos ON medicamentos.id_medicamento = recetas.id_medicamento
GROUP BY medicamentos.nombre
HAVING COUNT(recetas.id_medicamento) IN (
    SELECT DISTINCT COUNT(recetas.id_medicamento) AS cantidad
    FROM recetas
    GROUP BY recetas.id_medicamento
    ORDER BY cantidad DESC
    LIMIT 2
)
ORDER BY CantidadMedicamento DESC;