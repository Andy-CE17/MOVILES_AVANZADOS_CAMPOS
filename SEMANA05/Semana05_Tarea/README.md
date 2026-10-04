# Semana 05 - Tarea: Calculadora de préstamos

## Descripción

Aplicación iOS desarrollada con UIKit y Storyboard para calcular la cuota mensual y el monto total de un préstamo.

## Requisitos de la guía

El cálculo utiliza los siguientes datos:

- Capital inicial.
- Tasa de interés anual.
- Plazo del préstamo en años.

La cuota mensual se obtiene mediante la fórmula de amortización indicada en la guía:

```text
M = P × [r(1 + r)ⁿ / ((1 + r)ⁿ - 1)]
```

Donde:

- `M` es la cuota mensual.
- `P` es el capital inicial.
- `r` es la tasa de interés mensual.
- `n` es el número total de cuotas.

El monto total corresponde a la cuota mensual multiplicada por el número total de cuotas.

## Funcionalidad

La aplicación solicita los datos del préstamo y muestra:

- Número de cuotas mensuales.
- Cuota mensual expresada en soles.
- Monto total que se pagará.

## Validaciones

- El capital debe ser mayor que cero.
- La tasa anual debe ser mayor o igual que cero.
- El plazo debe ser mayor que cero.
- Se aceptan decimales escritos con punto o coma.
- Una tasa de `0 %` se calcula dividiendo el capital entre el número de cuotas.
- Se rechazan resultados no representables producidos por valores demasiado grandes.

## Tecnologías utilizadas

- Swift
- UIKit
- Storyboard
- Auto Layout
- Xcode

## Estructura del proyecto

```text
Semana05_Tarea/
├── Semana05_Tarea.xcodeproj
├── Semana05_Tarea/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── ViewController.swift
│   ├── LoanCalculator.swift
│   ├── Main.storyboard
│   ├── LaunchScreen.storyboard
│   ├── Info.plist
│   └── Assets.xcassets
├── Evidencias/
└── README.md
```

## Ejecución

Desde la raíz del repositorio, abrir el proyecto con:

```bash
open SEMANA05/Semana05_Tarea/Semana05_Tarea.xcodeproj
```

Luego seleccionar un simulador de iPhone y presionar `Command + R`.

## Evidencias

Las capturas del formulario y del resultado se guardarán en la carpeta `Evidencias` después de ejecutar la aplicación en el simulador.

## Rama de desarrollo

```text
ai-assisted
```

## Autor

**Andy Luis Campos Escandón**
