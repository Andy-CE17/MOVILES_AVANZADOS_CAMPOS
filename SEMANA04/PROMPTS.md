# Prompts utilizados - Laboratorio 04

## Herramienta de IA utilizada

ChatGPT


## Caso 2B - Biblioteca


### Prompt 1

Soy estudiante de Diseño y Desarrollo de Software y necesito desarrollar en Swift una biblioteca con enum EstadoLibro, struct Libro y class Biblioteca, con métodos para agregar, prestar, devolver y mostrar el inventario; la búsqueda debe hacerse con for i in 0..<libros.count y solo quiero usar arrays, bucles, if/else, switch y funciones, sin guard let, optionals, firstIndex(where:), didSet, propiedades calculadas ni genéricos, con comentarios claros para poder entender el código.

### Respuesta de la IA

Creé un enum EstadoLibro con los estados disponible y prestado, un struct Libro para guardar el título, autor y estado, y una class Biblioteca con un arreglo de libros. Agregué los métodos agregar(libro:), prestar(titulo:), devolver(titulo:) e inventario(). Para las búsquedas utilicé for i in 0..<libros.count y modifiqué directamente libros[i].estado según correspondía. También utilicé if/else para las validaciones y switch para mostrar el estado de cada libro.


### Prompt 2 - Simulación

Realiza la prueba con los libros Cien años de soledad, La ciudad y los perros y El Quijote. Presta La ciudad y los perros, intenta prestarlo nuevamente, devuélvelo, presta El Quijote, intenta prestar El Principito que no existe y al final muestra el inventario.

### Respuesta de la IA

Agregué los tres libros indicados y realicé las operaciones en el orden solicitado. Primero presté La ciudad y los perros, luego mostré el error al intentar prestarlo nuevamente, registré su devolución, presté El Quijote e intenté prestar El Principito. Finalmente mostré el inventario con los estados actualizados.


### Prompt 3 - Comentarios

Agrega comentarios claros en el código para entender qué realiza cada parte y mantén la salida igual a la Parte A del laboratorio.

### Respuesta de la IA

Agregué comentarios explicando las estructuras, propiedades, métodos, recorridos y condiciones. También mantuve los mismos mensajes de préstamo, devolución, errores e inventario para que la salida coincida con la Parte A.


## ¿Funcionó a la primera?

La estructura principal funcionó correctamente. Después realicé ajustes para completar la simulación y agregar comentarios más claros al código.


## ¿Usó algo que no hemos visto en clase?

No. La versión final no utiliza guard let, optionals, firstIndex(where:), didSet, propiedades calculadas ni genéricos. El código utiliza enum, struct, class, arrays, bucles, if/else, switch y funciones.


## Mi versión (Parte A) vs. la versión de la IA (Parte B)


### ¿Qué hizo distinto la IA respecto a mi solución?

La estructura fue similar porque ambas versiones debían cumplir los mismos requisitos. La versión generada con IA tenía más comentarios para explicar cada parte del código.


### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?

No. El código final utiliza estructuras y sentencias que puedo identificar y explicar.


### ¿Qué me pareció mejor de MI versión?

Mi versión la desarrollé paso a paso y eso me ayudó a comprender mejor cómo funcionan los préstamos, las devoluciones y los cambios de estado de los libros.


### ¿Qué me pareció mejor de la versión de la IA?

Los comentarios permiten identificar con mayor rapidez qué realiza cada parte del código y facilitan su lectura.
