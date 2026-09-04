# Prompts - Laboratorio 03

**Docente:** Juan Leon - Tecsup  
**Herramienta:** ChatGPT  
**Rama:** `ai-assisted`  
**Desarrollado por:** Andy Luis Campos Escandón  

En este documento se registran los prompts utilizados durante el desarrollo de los ejercicios 6 y 7. Los prompts se realizaron por etapas utilizando la estructura **CTRFE: Contexto, Tarea, Restricciones, Formato y Ejemplo**.

---

# Ejercicio 6 - Gestión de Notas

## Prompt 1 - Registro de estudiantes y notas

**CONTEXTO:**  
Se necesita desarrollar la primera parte de un sistema de gestión de notas en Swift Playground. El ejercicio debe trabajar con colecciones, principalmente Arrays y Diccionarios, además de ciclos y entrada de información mediante `readLine()`.

**TAREA:**  
Crear el registro inicial del programa. Primero debe solicitar la cantidad de estudiantes que se van a ingresar. Después, por cada estudiante, pedir su nombre y exactamente tres notas. Las notas deben almacenarse en un Array de tipo `Double` y posteriormente relacionarse con el nombre del estudiante mediante un diccionario `[String: [Double]]`.

**RESTRICCIONES:**  
Utilizar solamente conceptos trabajados hasta la semana 3. No utilizar `struct`, `class` ni funciones personalizadas. Los datos deben ingresarse utilizando `readLine()` y convertirse al tipo correspondiente. Mantener el código sencillo y entendible.

**FORMATO:**  
Entregar código Swift compatible con Playground. Colocar el encabezado con el nombre del desarrollador y agregar un comentario específico en cada línea explicando qué acción realiza.

**EJEMPLO:**  
Si se registra un estudiante llamado Andy con las notas `18`, `16` y `17`, el diccionario debe relacionar el nombre Andy con las tres notas ingresadas.

---

## Prompt 2 - Promedios y clasificación

**CONTEXTO:**  
La primera parte del programa ya permite registrar estudiantes y almacenar sus tres notas dentro de un diccionario `[String: [Double]]`.

**TAREA:**  
Continuar el programa recorriendo los estudiantes registrados. Calcular la suma de sus notas y obtener el promedio individual. Guardar cada promedio en un segundo diccionario `[String: Double]`. Después, utilizar `switch` para determinar la clasificación correspondiente de cada estudiante.

**RESTRICCIONES:**  
La clasificación debe realizarse obligatoriamente utilizando `switch` y rangos. Considerar `Excelente` de 18 a 20, `Bueno` de 15 a menos de 18, `Aprobado` de 13 a menos de 15 y `Desaprobado` para valores menores a 13. No utilizar estructuras o clases.

**FORMATO:**  
Integrar esta parte con el código anterior. Mostrar el nombre, las notas, el promedio con dos decimales y la clasificación obtenida. Mantener un comentario específico en cada línea.

**EJEMPLO:**  
Si un estudiante obtiene las notas `18`, `16` y `17`, su promedio debe ser `17.00` y su clasificación debe mostrarse como `Bueno`.

---

## Prompt 3 - Estadísticas y ranking

**CONTEXTO:**  
El programa ya registra estudiantes, calcula sus promedios y determina la clasificación individual mediante `switch`.

**TAREA:**  
Agregar las estadísticas generales del grupo. Calcular el promedio general, identificar la nota más alta y la nota más baja de todas las notas registradas, contar los estudiantes aprobados y obtener su porcentaje. Finalmente, ordenar a los estudiantes desde el promedio más alto hasta el más bajo.

**RESTRICCIONES:**  
Considerar aprobado a todo estudiante cuyo promedio sea mayor o igual a 13. Utilizar los diccionarios y ciclos ya existentes. No agregar `struct`, `class` ni funciones personalizadas. Mantener únicamente conceptos correspondientes a las primeras tres semanas.

**FORMATO:**  
Mostrar una sección denominada `ESTADÍSTICAS` con los resultados generales y una sección `RANKING` con los estudiantes ordenados. Los promedios y porcentajes deben mostrarse con dos decimales. Comentar cada línea.

**EJEMPLO:**  
Si se tienen tres estudiantes con promedios `17`, `14` y `11`, el ranking debe comenzar con el promedio `17` y el porcentaje de aprobados debe considerar a los dos estudiantes que tienen promedio mayor o igual a 13.

---

## Prompt 4 - Revisión y prueba del ejercicio 6

**CONTEXTO:**  
El ejercicio de gestión de notas ya cuenta con registro de estudiantes, cálculo de promedios, clasificación, estadísticas generales y ranking.

**TAREA:**  
Revisar el programa completo para comprobar que todas las partes funcionen correctamente. Preparar una prueba con tres estudiantes y diferentes notas para verificar los cálculos, las clasificaciones y el orden del ranking.

**RESTRICCIONES:**  
No modificar la estructura principal del ejercicio ni agregar conceptos avanzados. Mantener `readLine()`, Arrays, Diccionarios, ciclos y `switch`. Cada línea del código debe continuar documentada mediante comentarios.

**FORMATO:**  
Entregar el código final revisado y proporcionar datos de prueba que puedan ingresarse desde Terminal para comprobar el funcionamiento.

**EJEMPLO:**  
Realizar una prueba con Andy, Luis y Carlos utilizando diferentes notas para obtener estudiantes aprobados y desaprobados y comprobar las estadísticas generales.

---

# Ejercicio 7 - Inventario con Menú

## Prompt 1 - Registro de productos

**CONTEXTO:**  
Se necesita desarrollar un sistema de inventario en Swift Playground utilizando Diccionarios, ciclos y entrada de datos mediante `readLine()`.

**TAREA:**  
Crear la primera parte del inventario solicitando la cantidad de productos. Para cada producto se debe ingresar nombre, precio y stock. Utilizar un diccionario `[String: Double]` para almacenar los precios y otro `[String: Int]` para almacenar el stock, utilizando el nombre del producto como clave en ambos.

**RESTRICCIONES:**  
Utilizar únicamente conceptos vistos hasta la semana 3. No utilizar `struct`, `class` ni funciones personalizadas. La cantidad de productos debe validarse antes de ejecutar el ciclo para evitar problemas cuando se ingrese un valor igual o menor a cero.

**FORMATO:**  
Entregar código Swift ejecutable en Playground. El registro debe mostrarse de manera ordenada y cada línea debe contener un comentario específico.

**EJEMPLO:**  
Registrar `Laptop` con precio `2500` y stock `3`. El precio y el stock deben quedar relacionados mediante la misma clave `Laptop`.

---

## Prompt 2 - Creación del menú interactivo

**CONTEXTO:**  
El programa ya registra los productos correctamente dentro de los diccionarios de precios y stock.

**TAREA:**  
Agregar un menú que permanezca activo después del registro de productos. El menú debe permitir seleccionar las siguientes opciones: ver inventario, buscar producto, mostrar productos con stock bajo, calcular el valor total del inventario y salir.

**RESTRICCIONES:**  
Utilizar un ciclo `while` para mantener activo el menú y utilizar `switch` para controlar cada opción. La opción `5` debe finalizar el ciclo. También se debe considerar un `default` para valores que no correspondan a ninguna opción disponible.

**FORMATO:**  
Mostrar un menú numerado del 1 al 5. Después de ejecutar una opción, el programa debe regresar automáticamente al menú mientras no se seleccione Salir. Mantener comentarios en cada línea.

**EJEMPLO:**  
Si el usuario selecciona la opción `1`, debe mostrarse el inventario completo y posteriormente debe volver a aparecer el menú.

---

## Prompt 3 - Funcionalidades de búsqueda y stock

**CONTEXTO:**  
El inventario ya registra productos y dispone de un menú controlado mediante `while` y `switch`.

**TAREA:**  
Completar las opciones relacionadas con la consulta del inventario. La opción de búsqueda debe solicitar el nombre de un producto y mostrar su precio y stock. La opción de stock bajo debe recorrer los productos y mostrar aquellos que tengan menos de cinco unidades disponibles.

**RESTRICCIONES:**  
Consultar los diccionarios de manera segura. Si el producto buscado no existe, mostrar un mensaje indicando que no fue encontrado. Considerar como stock bajo únicamente cantidades menores a 5. Si no existen productos con stock bajo, mostrar un mensaje informativo.

**FORMATO:**  
Separar los resultados utilizando títulos como `BUSCAR PRODUCTO` y `STOCK BAJO`. Mostrar precios con dos decimales y conservar los comentarios específicos en cada línea.

**EJEMPLO:**  
Si `Laptop` tiene stock `3`, debe aparecer dentro de stock bajo. Si `Mouse` tiene stock `10`, no debe aparecer en esa sección.

---

## Prompt 4 - Valor total y finalización

**CONTEXTO:**  
El menú ya permite visualizar el inventario, buscar productos y comprobar cuáles tienen stock bajo.

**TAREA:**  
Implementar el cálculo del valor total del inventario recorriendo los productos y multiplicando el precio de cada uno por su stock. También completar la opción para salir correctamente del programa.

**RESTRICCIONES:**  
Utilizar los diccionarios existentes. El cálculo debe realizarse mediante `precio * stock` para cada producto. La opción `5` debe cambiar la variable de control del `while` para finalizar el programa de manera normal.

**FORMATO:**  
Mostrar el valor total con dos decimales y un mensaje de finalización cuando se seleccione la opción de salida. Mantener cada línea comentada.

**EJEMPLO:**  
Para Laptop `2500 x 3`, Mouse `80 x 10` y Teclado `150 x 4`, el valor total esperado del inventario es `S/. 8900.00`.

---

## Prompt 5 - Corrección y pruebas del menú

**CONTEXTO:**  
El ejercicio 7 ya contiene el registro de productos y las cinco funcionalidades del menú, pero se necesita comprobar su funcionamiento completo desde Terminal.

**TAREA:**  
Revisar el código para evitar errores cuando la cantidad de productos sea inválida y preparar una prueba completa que permita comprobar todas las opciones del menú durante una misma ejecución.

**RESTRICCIONES:**  
Validar que la cantidad de productos sea mayor a cero antes de utilizar el rango del ciclo. Mantener los dos diccionarios, `readLine()`, `while` y `switch`. No utilizar conceptos adicionales a los trabajados durante el laboratorio.

**FORMATO:**  
Entregar el código corregido y una secuencia de prueba que permita registrar productos y posteriormente utilizar las opciones `1`, `2`, `3`, `4` y `5`.

**EJEMPLO:**  
Registrar Laptop, Mouse y Teclado. Visualizar el inventario, buscar `Mouse`, comprobar el stock bajo, calcular el valor total y finalmente seleccionar la opción `5` para terminar el programa.

---

## Herramienta utilizada

Para apoyar el desarrollo, revisión, corrección y pruebas de los ejercicios 6 y 7 se utilizó **ChatGPT**.
