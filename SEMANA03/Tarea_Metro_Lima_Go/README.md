# Requerimientos Funcionales - Metro Lima Go

## RF01 - Listar estaciones por sistema

El sistema debe permitir visualizar las estaciones de Línea 1, Línea 2,
Metropolitano y Ramal Línea 4 mediante una tabla con código, nombre,
distrito y estado.

## RF02 - Buscar estaciones

El sistema debe permitir buscar una estación por nombre, código o distrito,
ignorando diferencias entre mayúsculas, minúsculas y tildes.

## RF03 - Mostrar información de una estación

El sistema debe mostrar nombre, código, distrito, sistema, estado,
accesibilidad, ascensor, disponibilidad de transporte complementario y
lugares cercanos registrados.

## RF04 - Mostrar puntos de conexión

El sistema debe identificar los puntos de conexión o transbordo entre las
diferentes líneas y sistemas de transporte, indicando su estado actual.

## RF05 - Consultar transporte complementario

El sistema debe mostrar rutas de transporte complementario desde estaciones
operativas hacia otra línea o sistema.

## RF06 - Calcular y planificar rutas

El sistema debe calcular rutas directas y multimodales entre estaciones o
destinos registrados, indicando las líneas, conexiones o transportes
necesarios para llegar al destino.

## RF07 - Mostrar detalle y seguimiento de la ruta

El sistema debe mostrar cada tramo del recorrido, cantidad de estaciones,
transbordos, tiempo referencial y permitir simular el avance del usuario
indicando cuánto falta para llegar al destino.

## RF08 - Diferenciar rutas actuales y futuras

El sistema debe advertir cuando una ruta utilice estaciones o conexiones
que todavía se encuentren en construcción o proyectadas.

## RF09 - Validar entradas y mantener el menú

El sistema debe validar opciones, montos, estaciones y búsquedas incorrectas,
regresar al menú correspondiente y mantenerse activo hasta que el usuario
seleccione Salir.

## RF10 - Gestionar tarjeta de transporte

El sistema debe permitir consultar el saldo actual de una tarjeta de
transporte y mantener actualizado dicho saldo durante la ejecución del
programa.

## RF11 - Recargar tarjeta de transporte

El sistema debe permitir ingresar un monto válido para recargar la tarjeta,
rechazando valores negativos, cero o entradas no numéricas.

## RF12 - Simular el cobro del viaje

El sistema debe simular el cobro de una tarifa al iniciar un viaje,
verificar que exista saldo suficiente, descontar el importe correspondiente
y mostrar el saldo restante.

## RF13 - Acceder al modo administrador

El sistema debe contar con un modo administrador protegido mediante una
clave académica que permita gestionar la información de la red de transporte.

## RF14 - Gestionar estaciones

El administrador debe poder agregar nuevas estaciones al final de una línea
o insertar una nueva estación entre dos estaciones existentes, validando
que el ID y código no estén repetidos.

## RF15 - Crear nuevas líneas de transporte

El administrador debe poder crear una nueva línea completa, definiendo su
nombre, código o prefijo y las estaciones que la conforman.

## RF16 - Crear conexiones entre líneas

El administrador debe poder conectar estaciones pertenecientes a diferentes
líneas o sistemas para que estas conexiones puedan ser utilizadas durante
el cálculo de rutas.

## RF17 - Consultar y gestionar lugares cercanos

El sistema debe permitir consultar lugares cercanos a una estación, como
centros comerciales, hospitales, universidades, parques, mercados u otros
puntos de interés. El administrador debe poder registrar nuevos lugares
indicando su nombre, categoría y distancia aproximada.

## Ejecución

Desde la raíz del repositorio, con Swift instalado:

```bash
swift SEMANA03/Tarea_Metro_Lima_Go/MetroLimaGo.playground/Contents.swift
```

## Menú principal

```text
1. Ver estaciones y líneas.
2. Buscar estación.
3. Ver conexiones entre líneas.
4. Consultar buses de conexión.
5. Planificar un viaje y seguir el recorrido con Enter.
6. Mi tarjeta: consultar saldo, recargar y pagar un viaje.
7. Consultar lugares cercanos a una estación.
8. Administrar líneas y estaciones (clave académica: `1234`).
0. Salir.
```

En Administración, las opciones 6 y 7 permiten registrar y listar lugares
cercanos; la opción 8 muestra los datos agregados durante la sesión.
Las altas de estaciones y líneas se reflejan inmediatamente en los listados
y búsquedas. Para viajar entre una línea nueva y otra existente, crea una
conexión desde Administración.

## Alcance y datos de la sesión

- Saldo inicial de la tarjeta: S/ 10.00. Tarifa plana inicial: S/ 1.50 por viaje.
- La tarifa y los cobros son simulados para fines académicos; no representan
  necesariamente las tarifas oficiales. El administrador puede cambiar la tarifa.
- El pago con tarjeta es opcional al iniciar el seguimiento. Si se elige y el
  saldo no alcanza, se impide el inicio. Detener el seguimiento no devuelve
  automáticamente un cobro aprobado.
- Los datos nuevos, el saldo y la tarifa se conservan solo en memoria y se
  restablecen al cerrar y abrir el programa. No se utiliza base de datos.
- Las rutas utilizan el mismo grafo y algoritmo de búsqueda. Los tiempos son
  referenciales; las líneas nuevas usan tres minutos entre estaciones.
- Las conexiones entre líneas se crean en ambos sentidos y permiten indicar
  un tiempo entre 1 y 1440 minutos. Las estaciones no operativas y sus conexiones
  se mantienen diferenciadas en los recorridos futuros.
- Las recargas aceptan punto o coma decimal, como máximo dos decimales y montos
  positivos hasta S/ 1000000.00; el saldo tiene el mismo límite máximo.
- Cada línea nueva admite de 1 a 200 estaciones. Los IDs y códigos deben ser
  únicos, no vacíos y distintos de `0`, reservado para volver al menú.
- Los lugares cercanos tienen una categoría seleccionada del catálogo y una
  distancia entera no negativa. El registro inicial de Gamarra usa la distancia
  aproximada propuesta en el ejercicio.
