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
