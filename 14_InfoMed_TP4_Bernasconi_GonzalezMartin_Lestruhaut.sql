SELECT nombre, EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))::int AS edad
FROM pacientes
where EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento)) >
	(SELECT AVG (EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))) FROM pacientes)
ORDER BY edad DESC;