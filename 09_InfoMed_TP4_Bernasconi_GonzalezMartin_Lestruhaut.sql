SELECT medicos.nombre, COUNT(recetas.id_medico) AS CantidadRecetas 
FROM recetas
LEFT JOIN medicos ON recetas.id_medico = medicos.id_medico
GROUP BY medicos.nombre
ORDER BY medicos.nombre;
