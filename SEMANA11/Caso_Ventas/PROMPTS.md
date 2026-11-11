# Registro de consultas a la IA

## Consulta 1 Identificación del alcance

**Contexto:** Se debe desarrollar el trabajo semanal del Laboratorio 11 correspondiente al Grupo A, Caso Ventas con UIKit y Core Data.

**Tarea:** Identificar en la guía dónde comienza y termina el Caso Ventas y resumir sus componentes obligatorios.

**Restricciones:** No crear proyectos ni escribir código. Revisar únicamente la guía entregada por el docente.

**Formato esperado:** Indicar páginas de inicio y fin, entidades, roles, pantallas, reglas y casos de prueba.

**Uso de la respuesta:** Se aceptó el alcance identificado. Se confirmó que el bloque específico comienza en la página 20 y termina en la página 24, antes del Caso Compras.

## Consulta 2 Organización del trabajo

**Contexto:** El repositorio ya contiene las actividades 1 y 2 de la Semana 11 en la rama manual. El Caso Ventas debe trabajarse con asistencia de IA y commits progresivos.

**Tarea:** Preparar la rama de trabajo, proteger cambios locales anteriores y elaborar el expediente previo con el plan exigido por la guía.

**Restricciones:** Trabajar dentro de `SEMANA11`, no subir el informe APA, no mezclar cambios locales de las actividades anteriores y no iniciar la aplicación antes del visto bueno docente.

**Formato esperado:** Rama `ia-asistida`, carpeta independiente para el Caso Ventas, expediente completo y registro de prompts.

**Uso de la respuesta:** Se creó la rama `ia-asistida` desde el último estado de `manual`. Los cambios locales anteriores se guardaron de forma reversible y el informe APA se excluyó de Git. Se prepararon el expediente y este registro; la construcción queda pendiente del visto bueno.

## Consulta 3 Proyecto base y autenticación

**Contexto:** El docente autorizó continuar el Caso Ventas dentro de `SEMANA11` y en la rama existente `ai-assisted`.

**Tarea:** Crear el proyecto UIKit con Core Data e implementar registro, inicio de sesión y sesión activa para los roles Vendedor y Supervisor.

**Restricciones:** Mantener las entidades y reglas indicadas por la guía, validar usuario único sin distinguir mayúsculas, exigir una contraseña mínima de seis caracteres y mostrar un error genérico al iniciar sesión.

**Formato esperado:** Proyecto compilable con pantallas UIKit creadas por código y persistencia local mediante Core Data.

**Uso de la respuesta:** Se implementó el registro de usuarios, la validación de credenciales, la selección de rol y el acceso inicial a la aplicación.

## Consulta 4 Navegación por roles

**Contexto:** Después de autenticarse, cada rol debe acceder únicamente a las funciones que le corresponden.

**Tarea:** Configurar las pestañas de Vendedor y Supervisor y agregar una pantalla de cuenta que permita cerrar la sesión.

**Restricciones:** El Vendedor no debe tener acceso a los indicadores de supervisión ni a la administración del equipo. El Supervisor debe acceder al resumen y a todas las ventas.

**Formato esperado:** Navegación UIKit mediante barra de pestañas, con títulos e iconos claros.

**Uso de la respuesta:** Se configuraron cinco pestañas para cada rol y se agregó el cierre de sesión con confirmación.

## Consulta 5 Gestión de productos y clientes

**Contexto:** La aplicación requiere catálogos persistentes que luego serán utilizados al registrar ventas.

**Tarea:** Implementar listas, búsqueda, formularios y operaciones de mantenimiento para Producto y Cliente.

**Restricciones:** Solo el Supervisor puede modificar productos. El Vendedor únicamente consulta el catálogo. No se puede eliminar un producto o cliente que tenga ventas relacionadas y el documento del cliente no se repite.

**Formato esperado:** Pantallas UIKit con tablas, buscador, validaciones y persistencia Core Data.

**Uso de la respuesta:** Se implementaron ambos catálogos, el control de permisos, el cálculo de categoría del cliente y las restricciones de eliminación.

## Consulta 6 Registro de ventas

**Contexto:** El Vendedor necesita registrar operaciones utilizando los productos y clientes persistidos.

**Tarea:** Implementar la selección de producto y cliente, cantidad, cálculo monetario, validación de stock y listado de ventas propias.

**Restricciones:** Aplicar 10 % de descuento a clientes VIP, calcular IGV de 18 % después del descuento, impedir cantidades inválidas o mayores al stock y descontar existencias al guardar.

**Formato esperado:** Flujo UIKit con resumen previo, confirmación y persistencia de relaciones en Core Data.

**Uso de la respuesta:** Se implementó el registro de ventas, los cálculos de subtotal, descuento, IGV y total, la actualización de stock y la consulta de ventas del vendedor.

## Consulta 7 Supervisión y resumen

**Contexto:** El Supervisor debe controlar las operaciones de todo el equipo y revisar indicadores sin alterar las ventas directamente.

**Tarea:** Agregar filtros, detalle de venta, anulación con motivo, reposición del stock y un resumen gerencial.

**Restricciones:** Solo el Supervisor anula. El motivo es obligatorio, una venta no se anula dos veces y las ventas anuladas no participan en ingresos, ranking ni totales válidos.

**Formato esperado:** Lista filtrable, detalle completo y tablero con ingresos, estados, ranking y alertas de stock.

**Uso de la respuesta:** Se implementaron las funciones de supervisión, la anulación trazable y el resumen actualizado desde Core Data.
