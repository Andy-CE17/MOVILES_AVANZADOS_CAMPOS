# SEMANA 02 - Programación Móvil Avanzado

En esta semana se realizaron ejercicios prácticos utilizando Swift, aplicando entrada de datos, operaciones matemáticas, condicionales y validaciones.

## 1. Laboratorio 02 - Suma de dos números

En este ejercicio desarrollé un programa que permite ingresar dos números y realizar la suma de ambos, mostrando el resultado final en consola.

### Evidencia

![Suma de dos números](evidencias/laboratorio02.png)

---

## 2. Promedio de Notas

En este ejercicio desarrollé un programa para calcular el promedio ponderado de un estudiante. Se consideran las notas del examen parcial, trabajo y examen final con sus respectivos porcentajes.

Los porcentajes utilizados son:

- Examen parcial: 30%
- Trabajo: 30%
- Examen final: 40%

El programa solicita las notas, realiza el cálculo y muestra el promedio final obtenido.

### Evidencia

![Promedio de notas](evidencias/promedio_notas.png)

---

## 3. Sistema de Préstamo de Libros

En este ejercicio desarrollé un sistema de préstamo de libros en Swift. El programa permite registrar información del préstamo, identificar el tipo de usuario y trabajar con las fechas para determinar el estado final del préstamo.

También se aplicaron diferentes reglas y validaciones para controlar los días permitidos, atrasos, multas y la situación del usuario.

### Evidencia 1 - Préstamo permitido

En esta prueba se muestra un caso donde el usuario cumple con las condiciones establecidas y puede realizar el préstamo.

![Préstamo permitido](evidencias/prestamo_permitido.png)

### Evidencia 2 - Devolución con atraso

En esta prueba se muestra un préstamo devuelto después de la fecha prometida. El programa calcula los días de atraso y la multa correspondiente.

![Devolución con atraso](evidencias/prestamo_atraso.png)

### Evidencia 3 - Usuario suspendido

En esta prueba se muestra el caso en el que el usuario alcanza la condición establecida para quedar suspendido.

![Usuario suspendido](evidencias/usuario_suspendido.png)

### Evidencia 4 - Préstamo no permitido

En esta prueba se comprueba que el sistema no permite continuar con el préstamo cuando se supera el límite establecido.

![Préstamo no permitido](evidencias/prestamo_no_permitido.png)

### Evidencia 5 - Validación de datos

En esta prueba se muestra una de las validaciones implementadas para evitar el ingreso de datos que no cumplen con las condiciones del sistema.

![Validación de datos](evidencias/validacion_prestamo.png)

---

## Archivos desarrollados

- `Laboratorio02.swift`
- `PromedioNotas.swift`
- `Prestamos.swift`

## Autor

**Andy Luis Campos Escandón**  
Diseño y Desarrollo de Software  
TECSUP
