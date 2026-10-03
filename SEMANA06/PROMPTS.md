# Prompts utilizados - Laboratorio 06

## Herramienta de IA utilizada

ChatGPT

## Ejercicio 4 - Calculadora de venta a plazos

### Prompt con estructura CTRFE

#### Contexto

Soy estudiante de Diseño y Desarrollo de Software. En la semana 6 estoy trabajando con UIKit, Storyboard, `UINavigationController`, segues, `IBOutlet`, `IBAction`, clases y el método `prepare(for:sender:)`. Debo crear una calculadora de venta a plazos de electrodomésticos en la rama `ai-assisted`.

#### Tarea

Crea una aplicación UIKit con dos pantallas. La pantalla **Nueva Venta** debe solicitar el nombre del electrodoméstico, precio unitario, cantidad, número de meses y tasa de interés mensual. Al presionar **Calcular**, debe obtener subtotal, IGV, monto base, intereses totales, total a pagar y cuota mensual. Los resultados deben guardarse en una clase `VentaModel` y enviarse a la pantalla **Resultado** mediante un segue `Show` con identificador `showResultado` y `prepare(for:sender:)`.

Usa estas fórmulas:

```text
subtotal = precioUnitario × cantidad
igv = subtotal × 0.18
base = subtotal + igv
intereses = base × (tasaInteresMensual / 100) × meses
total = base + intereses
cuota = total / meses
```

#### Restricciones

- Utiliza solamente temas revisados hasta la semana 6.
- Usa UIKit y Storyboard.
- `VentaModel` debe ser una clase que herede de `NSObject`.
- No uses SwiftUI, Combine, Codable ni persistencia.
- Utiliza `IBOutlet`, segue `Show` y `prepare(for:sender:)`.
- Muestra los importes con `String(format: "S/. %.2f", valor)`.
- Evita dividir entre cero y no permitas continuar con datos vacíos o valores inválidos.
- Explica por qué se utiliza `class` en lugar de `struct` para `VentaModel`.

#### Formato

Entrega el código de:

1. `VentaModel.swift`.
2. `NuevaVentaViewController.swift`.
3. `ResultadoViewController.swift`.
4. Las conexiones necesarias en Storyboard.
5. Una explicación breve del cálculo y del paso de datos.

#### Ejemplo

Para un electrodoméstico de S/. 3500.00, cantidad 1, plazo de 12 meses e interés mensual de 1%, el resultado esperado es:

```text
Subtotal: S/. 3500.00
IGV: S/. 630.00
Base: S/. 4130.00
Intereses: S/. 495.60
Total: S/. 4625.60
Cuota mensual: S/. 385.47
```

### Respuesta de la IA

La IA propuso una aplicación con dos controladores conectados mediante el segue `showResultado`. Creó `VentaModel` como subclase de `NSObject` con seis propiedades `Double`, implementó las fórmulas solicitadas y utilizó `prepare(for:sender:)` para entregar el modelo a la pantalla de resultados. Los importes se presentan con dos decimales y el prefijo `S/.`.

También agregó validaciones con `guard` para comprobar que el nombre no esté vacío, que los valores sean numéricos, que precio, cantidad y meses sean mayores que cero y que la tasa de interés no sea negativa. La navegación se cancela y se muestra una alerta cuando los datos no son válidos. Además, permite escribir decimales con punto o coma.

### ¿Por qué se utilizó `class` y no `struct` para `VentaModel`?

Se utilizó `class` porque el laboratorio sigue el mismo patrón de `ClienteModel`, donde se crea un objeto y se comparte su referencia entre controladores. Una clase permite que ambos controladores trabajen con la misma instancia.

Una `struct` también podría enviarse a la siguiente pantalla y la aplicación no se rompería. La diferencia es que se enviaría una copia del valor. Para este ejercicio se conserva `class` porque es el patrón solicitado y permite reforzar el comportamiento por referencia visto en clase.

## Reflexión sobre el uso de IA

### ¿Funcionó a la primera?

La estructura y las fórmulas funcionaron. Durante la verificación visual fue necesario ajustar el botón para que utilizara el estilo de sistema y se mostrara correctamente en el simulador. También se revisaron las conexiones del Storyboard y el Bundle ID antes de la compilación final.

### ¿Qué hizo distinto la IA?

La guía pedía realizar el cálculo y pasar el modelo. La IA también agregó validaciones con `guard`, mensajes de alerta y aceptación de punto o coma en valores decimales. Esto evita navegar a la pantalla de resultados con campos vacíos o con meses iguales a cero.

### Diferencia entre el ejercicio manual y el asistido

En el ejercicio manual fue necesario seguir cada conexión y cada paso de envío de datos de forma progresiva. En el ejercicio asistido se pudo construir más rápido una solución completa, pero fue necesario revisar el Storyboard, las fórmulas, los identificadores y la ejecución en el simulador para comprobar que el código generado correspondiera con la guía.

## Conclusiones

### 1. ¿Cuándo conviene usar Show y cuándo Present Modally?

`Show` conviene cuando la nueva pantalla forma parte de un recorrido jerárquico dentro de un `UINavigationController`. Por ejemplo, al seleccionar un producto en una tienda se puede usar `Show` para abrir su detalle y regresar con el botón de navegación.

`Present Modally` conviene cuando la pantalla representa una tarea temporal que debe completarse o cerrarse antes de continuar. Por ejemplo, un formulario para registrar un cliente o confirmar un pago.

### 2. ¿Para qué sirven Show Detail y Present As Popover?

`Show Detail` permite mostrar contenido en la zona de detalle de una interfaz dividida. Tiene más sentido en iPad, donde una aplicación puede mostrar una lista a la izquierda y el detalle seleccionado a la derecha.

`Present As Popover` muestra una vista flotante relacionada con un control o una zona de la interfaz. Se utiliza principalmente en iPad para opciones, filtros o acciones breves sin ocupar toda la pantalla.

### 3. ¿Qué pasaría si `ClienteModel` o `VentaModel` fueran `struct`?

El paso de datos hacia adelante seguiría funcionando. La diferencia es que una `struct` se copia al asignarla, mientras que una `class` comparte una referencia a la misma instancia. Si un controlador modifica una `struct`, el otro controlador no observa ese cambio automáticamente porque conserva su propia copia.

### 4. Diferencia de tiempo y comprensión entre el ejercicio manual y el ejercicio con IA

La IA redujo el tiempo necesario para crear el modelo, aplicar las fórmulas y conectar el paso de datos. El ejercicio manual ayudó más a comprender cada conexión individual. El ejercicio asistido exigió revisar y explicar las decisiones generadas, por lo que permitió practicar la validación del código y no solo su escritura.
