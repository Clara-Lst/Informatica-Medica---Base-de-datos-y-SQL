# PARTE 1: Bases de Datos

Cuando una persona acude al centro de salud, se le toma nota en una ficha con sus datos personales: nombre, fecha de nacimiento, sexo biológico y dirección (calle, número y ciudad). Esta ficha queda registrada en el archivo de pacientes del centro. Los médicos del centro también tienen su ficha, donde se registran su nombre completo, especialidad y dirección profesional.

Cada vez que un médico realiza una consulta o tratamiento a un paciente, puede emitir una receta. Esta receta incluye la fecha, el nombre del paciente atendido, el médico que la emite, el medicamento o tratamiento indicado, y la enfermedad o condición que motivó la prescripción. Esta información queda registrada y organizada para facilitar tanto el seguimiento del paciente como las auditorías clínicas.

Los tratamientos pueden incluir medicamentos, indicaciones como reposo o fisioterapia, y suelen tener especificaciones temporales (por ejemplo, “tomar por 5 días” o “uso indefinido”). También se registran enfermedades o diagnósticos asociados, permitiendo análisis estadísticos o seguimiento epidemiológico.

El sistema busca reemplazar los registros en papel por una solución digital que permita realizar búsquedas rápidas, obtener estadísticas de distribución demográfica, sexo y especialidad, y mantener la información organizada para su integración con otros módulos médicos como historiales clínicos, turnos o recetas médicas.

Para los modelos conceptuales y la base de datos que se armará, se tomaron las siguientes entidades, relaciones y atributos. Para facilitar la visualización, se define las entidades con el color azul, las relaciones con el color naranja y por último, los atributos en verde.

1. La base de datos es del tipo relacional transaccional. Este tipo de base de datos permite relacionar datos en tablas con registros y atributos. Los datos se interconectan con claves del tipo primarias o foráneas. Al ser una base de datos clínica, esta se va a utilizar a diario

2. En este siguiente punto, se muestra el Diagrama Entidad-Relación de la base de datos propuesta. Con los mismos colores, se pueden identificar las entidades, los atributos y las relaciones.

![Figura 1](imagenes/fig1.png)

Figura 1: Entidades Paciente y Consulta con sus atributos y relación.

En la figura de arriba, podemos observar la entidad de Paciente y Consulta. Ambos tienen sus propios atributos y están relacionados entre sí mediante la acción “hace”. En este caso, se dice que el **paciente hace una consulta**. La participación de los Pacientes es parcial debido a que no necesariamente todos los pacientes van al médico a hacer una consulta. La participación de Consulta es total ya que todas las consultas fueron hechas por algún paciente. La cardinalidad es de Uno a Muchos, lo que se interpreta como un paciente puede tener muchas consultas asociadas, pero una consulta si o sí está hecha por un único paciente.

![Figura 2](imagenes/fig2.png)

Figura 2: Entidades de Consulta, Receta, Médico y Especialidad con sus atributos y relaciones.

Comenzando con Consulta, tiene dos relaciones más. Se relaciona con Médico mediante la relación **Médico realiza Consulta**. Acá ocurre lo mismo que la relación entre Paciente y Consulta. La participación y cardinalidad son iguales ya que tanto los médicos con personas como los pacientes. Luego, se ve una relación con Receta del estilo de **Consulta emite Receta** con Receta siendo un atributo débil. Esto ocurre ya que la Receta solo existe con la realización de una consulta y si es que se realiza una receta en dicha consulta. Puede haber circunstancias en las cuales no sea necesario emitir una recta. Acá, la participación es parcial de la Consulta ya que no siempre una consulta va a emitir una receta pero total de Receta porque todas las recetas emitidas fueron hechas en una consulta. La cardinalidad es de Uno a Muchos.

Luego, se tiene la relación de **Médico tiene Especialidad**. Esta relación fue creada para poder tener una tabla propia de Especialidades dentro de la base de datos. La cardinalidad vista es Muchos a Uno y la participación es total por parte de Médico y parcial por parte de Especialidad. Vemos que todos los médicos tienen una especialidad, pero pueden haber especialidades cuyos puestos no están ocupados por ningún médico.

![Figura 3](imagenes/fig3.png)

Figura 3: Entidades de Receta, Enfermedad y Tratamiento con sus atributos y relaciones.

Por último, la relación que tiene Receta con Tratamiento es del estilo de **Receta prescribe Tratamiento** y la relación entre Receta y Enfermedad es **Receta registran Enfermedad**. Con Tratamiento, la cardinalidad es de Muchos a Muchos y la participación es total por ambas entidades. Con Enfermedad, se ve una participación total de Rectas y una participación parcial de Enfermedad. La cardinalidad corresponde a un Muchos a Uno.

3. En la siguiente figura, se puede observer el Modelo Relacional de la base de datos, ya con los atributos, las claves primarias y foráneas y las relaciones entre las tablas.

![Figura 4](imagenes/fig4.png)

Figura 4: Modelo Relacional

4. Las siguientes tablas violan diferentes formas normales de base de datos.

Para el **<ins>Caso 1</ins>**, se está violando la <ins>Forma Normal 1</ins> ya que existe una celda en la tabla que tiene dos valores a diferencia del único valor que puede tener.

![Figura 5](imagenes/fig5.png)

Figura 5: Caso 1

Para el **<ins>Caso 2</ins>**, la forma normal que se está violando es la <ins>3</ins>. En esta forma normal, se debe cumplir con 1NF, 2NF y además que las demás columnas no tengan dependencias transitivas. Se observa que el CódigoPostal depende de la Ciudad que a su vez la Ciudad va a estar relacionada con el PacienteID.

![Figura 6](imagenes/fig6.png)

Figura 6: Caso 2

Pasando al **<ins>Caso 3</ins>**, está violando la forma normal <ins>2</ins> mediante el incumplimiento de que todos sus atributos deben depender totalmente de sus claves primarias. Acá se ve que NombrePaciente depende de PacienteID y Especialidad depende de MédicoID, pero si intercambias los atributos, no tienen ninguna relación.

![Figura 7](imagenes/fig7.png)

Figura 7: Caso 3

Por último, el **<ins>Caso 4</ins>** viola la forma normal <ins>4</ins> ya que existen las dependencias multivaluadas. La tabla está mezclando dos hechos independientes sobre un mismo paciente. No hay relación entre Enfermedad y Medicamento.

![Figura 8](imagenes/fig8.png)

Figura 8: Caso 4

# PARTE 2 : SQL

**1.** Cuando se realizan consultas sobre la tabla paciente agrupando por ciudad los tiempos de respuesta son demasiado largos. Proponer mediante una query SQL una solución a este problema.

```sql
CREATE INDEX idx_pacientes_ciudad ON pacientes (ciudad);
```

![Output 1](imagenes/01.png)

**2.** Se tiene la fecha de nacimiento de los pacientes. Se desea calcular la edad de los pacientes y almacenarla de forma dinámica en el sistema ya que es un valor típicamente consultado, junto con otra información relevante del paciente.

```sql
CREATE VIEW vista_pacientes_edad AS
SELECT id_paciente, nombre, fecha_nacimiento,
      EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))::int AS edad, id_sexo, calle, numero, ciudad
FROM pacientes;

SELECT * FROM vista_pacientes_edad;
```

![Output 2](imagenes/02.png)

**3.** Obtener nombre y edad de pacientes menores de edad.

```sql
SELECT nombre, edad
FROM vista_pacientes_edad
WHERE edad < 18;
```

![Output 3](imagenes/03.png)

**4.** La paciente, “Luciana Gómez”, ha cambiado de dirección. Antes vivía en “Avenida Las Heras 121” en “Buenos Aires”, pero ahora vive en “Calle Corrientes 500” en “Buenos Aires”. Actualizar la dirección de este paciente en la base de datos.

```sql
UPDATE pacientes
SET calle = 'Calle Corrientes',
    numero = '500'
WHERE id_paciente = 1;
```

![Output 4a](imagenes/04a.png)

![Output 4b](imagenes/04b.png)

**5.** Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires.

```sql
SELECT nombre, calle, numero, ciudad
FROM pacientes
WHERE ciudad iLIKE '%b%s%ai%';
```

![Output 5](imagenes/05.png)

**6.** Puede pasar que haya inconsistencias en la forma en la que están escritos los nombres de las ciudades, ¿cómo se corrige esto? Agregar la query correspondiente.

```sql
UPDATE Pacientes
SET ciudad = regexp_replace(trim(ciudad), '\s+', ' ', 'g');
UPDATE Pacientes
SET ciudad = CASE
   WHEN lower(ciudad) IN ('bs aires', 'buenos aires', 'buenos aiers') THEN 'Buenos Aires'
   WHEN lower(ciudad) IN ('cordoba', 'córdoba', 'córodba')            THEN 'Cordoba'
   WHEN lower(ciudad) IN ('mendoza', 'mendzoa')                       THEN 'Mendoza'
   WHEN lower(ciudad) = 'rosario'                                     THEN 'Rosario'
   ELSE ciudad
END;
```

![Output 6](imagenes/06.png)

**7.** Cantidad de pacientes por sexo que viven en cada ciudad.

```sql
SELECT p.ciudad, s.descripcion AS sexo, COUNT(*) AS cantidad
FROM Pacientes p
JOIN SexoBiologico s ON s.id_sexo = p.id_sexo
GROUP BY p.ciudad, s.descripcion
ORDER BY p.ciudad, s.descripcion;
```

![Output 7](imagenes/07.png)

**8.** Obtener todas las consultas médicas realizadas por el médico con ID igual a 3 durante el mes de agosto de 2024.

```sql
select * from Consultas
where id_medico = '3' and fecha < '2024-08-31' and fecha > '2024-08-01';
```

![Output 8](imagenes/08.png)

**9.** Obtener la cantidad de recetas emitidas por cada médico.

```sql
SELECT  medicos.nombre,COUNT(recetas.id_medico) AS cantidad
FROM recetas
LEFT JOIN medicos ON medicos.id_medico = recetas.id_medico
GROUP BY medicos.nombre
ORDER BY medicos.nombre;
```

![Output 9](imagenes/09.png)

**10.** Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en agosto del 2024.

```sql
SELECT pacientes.nombre, consultas.fecha, consultas.diagnostico
FROM consultas
INNER JOIN pacientes ON consultas.id_paciente = pacientes.id_paciente
WHERE consultas.fecha >= '2024-08-01' AND consultas.fecha <= '2024-08-31'
ORDER BY consultas.id_paciente;
```

![Output 10](imagenes/10.png)

**11.** Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2.

```sql
SELECT medicos.nombre, medicamentos.nombre, COUNT(recetas.id_medicamento) AS CantidadMedicamentos
FROM recetas
LEFT JOIN medicos ON recetas.id_medico = medicos.id_medico
LEFT JOIN medicamentos ON recetas.id_medicamento = medicamentos.id_medicamento
WHERE recetas.id_medico = 2
GROUP BY medicos.nombre, medicamentos.nombre
HAVING COUNT(recetas.id_medicamento) > 1;
```

![Output 11](imagenes/11.png)

**12.** Obtener el nombre de cada paciente junto con la cantidad total de recetas que ha recibido.

```sql
SELECT pacientes.nombre, COUNT(recetas.id_paciente) AS CantidadRecetas
FROM recetas
RIGHT JOIN pacientes ON recetas.id_paciente = pacientes.id_paciente
GROUP BY pacientes.id_paciente
ORDER BY CantidadRecetas;
```

![Output 12](imagenes/12.png)

**13.** Obtener el nombre de cada especialidad y la cantidad de médicos que pertenecen a ella, mostrando únicamente aquellas especialidades que tienen más de 2 médicos.

```sql
SELECT especialidades.nombre, COUNT(medicos.id_medico)
FROM especialidades
LEFT JOIN medicos ON especialidades.id_especialidad = medicos.especialidad_id
GROUP BY especialidades.nombre
HAVING COUNT(medicos.id_medico) > 2;
```

![Output 13](imagenes/13.png)

**14.** Obtener el nombre y la edad de los pacientes cuya edad sea mayor al promedio de edad de todos los pacientes, ordenados de mayor a menor edad.

```sql
SELECT nombre, EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))::int AS edad
FROM pacientes
where EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento)) >
      (SELECT AVG (EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))) FROM pacientes)
ORDER BY edad DESC;
```

![Output 14](imagenes/14.png)

**15.** Obtener los medicamentos que ocupan las dos primeras posiciones en cantidad de recetas emitidas, indicando para cada uno la cantidad de recetas.

```sql
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
```

![Output 15](imagenes/15.png)

**16.** Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado.

```sql
SELECT pacientes.nombre, consultas.diagnostico, consultas.fecha AS UltimaConsulta
FROM consultas
LEFT JOIN pacientes ON pacientes.id_paciente = consultas.id_paciente
WHERE consultas.fecha = (SELECT MAX (c.fecha) FROM consultas c WHERE consultas.id_paciente = c.id_paciente)
ORDER BY UltimaConsulta ASC;
```

![Output 16](imagenes/16.png)

**17.** Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente.

```sql
SELECT medicos.nombre, pacientes.nombre, COUNT(consultas.id_medico) AS ConsultasRealizadasXMedico
FROM consultas
LEFT JOIN medicos ON consultas.id_medico = medicos.id_medico
LEFT JOIN pacientes ON consultas.id_paciente = pacientes.id_paciente
GROUP BY medicos.id_medico, pacientes.id_paciente
ORDER BY medicos.nombre, pacientes.nombre;
```

![Output 17](imagenes/17.png)

**18.** Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente.

```sql
SELECT medicamentos.nombre, medicos.nombre, pacientes.nombre, COUNT (recetas.id_medicamento) AS RecetaPrescriptaMedicamento
FROM recetas
LEFT JOIN medicamentos ON medicamentos.id_medicamento = recetas.id_medicamento
LEFT JOIN medicos ON medicos.id_medico = recetas.id_medico
LEFT JOIN pacientes ON pacientes.id_paciente = recetas.id_paciente
GROUP BY medicamentos.id_medicamento, medicos.id_medico, pacientes.id_paciente
ORDER BY RecetaPrescriptaMedicamento DESC;
```

![Output 18](imagenes/18.png)

**19.** Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente.

```sql
SELECT medicos.nombre, COUNT (consultas.id_paciente) AS ConsultasXPaciente
FROM consultas
RIGHT JOIN medicos ON medicos.id_medico = consultas.id_medico
GROUP BY medicos.nombre
ORDER BY ConsultasXPaciente;
```

![Output 19](imagenes/19.png)

**20.** Obtener el nombre de cada médico junto con el número total de consultas realizadas por cada uno a pacientes menores de edad y una tercera columna que indique si el médico es pediatra (TRUE/FALSE).

```sql
SELECT medicos.nombre, COUNT(pacientes.id_paciente) AS ConsultasRealizadas,COALESCE(especialidades.nombre = 'Pediatría', FALSE) AS EsPediatra
FROM consultas
RIGHT JOIN medicos ON consultas.id_medico = medicos.id_medico
LEFT JOIN pacientes ON consultas.id_paciente = pacientes.id_paciente AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, pacientes.fecha_nacimiento)) < 18
LEFT JOIN especialidades ON medicos.especialidad_id = especialidades.id_especialidad
GROUP BY medicos.id_medico, especialidades.nombre
ORDER BY ConsultasRealizadas DESC;
```

![Output 20](imagenes/20.png)

Las queries están hechas en PostgreSQL y copiadas en un Google Colab para mejor visualización:

https://colab.research.google.com/drive/10tJWQa5JIjjaUlH8yiEecoRJ6Mn9q0Bt#scrollTo=MgB_7Il3ATJr
