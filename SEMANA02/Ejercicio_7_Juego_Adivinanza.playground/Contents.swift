import Foundation

// Docente: Juan León S.

// ==========================================
// EJERCICIO 7: JUEGO DE ADIVINANZA
// ==========================================

// Guarda el número que el jugador debe adivinar.
let numeroSecreto = 42

// Guarda el primer intento del jugador.
let intento1 = 20

// Guarda el segundo intento del jugador.
let intento2 = 50

// Guarda el tercer intento del jugador.
let intento3 = 35

// Guarda el cuarto intento del jugador.
let intento4 = 42

// Guarda el quinto intento del jugador.
let intento5 = 60


// ==========================================
// VARIABLES DE CONTROL Y BUCLE
// ==========================================

// Guarda el intento que se está evaluando actualmente.
var intentoActual = intento1

// Lleva la cuenta del número de intento realizado.
var numeroIntento = 1

// Indica si el jugador ya logró adivinar el número secreto.
var adivino = false

// Repite el juego mientras no haya acertado y tenga intentos disponibles.
while !adivino && numeroIntento <= 5 {

    // Muestra el número de intento y el valor que se está probando.
    print("Intento \(numeroIntento): \(intentoActual)")

    // ==========================================
    // COMPARACIÓN DEL INTENTO
    // ==========================================

    // Compara el intento actual con el número secreto.
    if intentoActual > numeroSecreto {

        // Indica que el número ingresado es mayor que el número secreto.
        print("Muy alto")

    } else if intentoActual < numeroSecreto {

        // Indica que el número ingresado es menor que el número secreto.
        print("Muy bajo")

    } else {

        // Indica que el jugador encontró el número secreto.
        print("¡Correcto!")

        // Cambia el estado para indicar que el jugador ya adivinó.
        adivino = true
    }

    // ==========================================
    // PASAR AL SIGUIENTE INTENTO
    // ==========================================

    // Verifica que el jugador todavía no haya adivinado.
    if !adivino {

        // Cambia al segundo intento.
        if numeroIntento == 1 {
            intentoActual = intento2

        // Cambia al tercer intento.
        } else if numeroIntento == 2 {
            intentoActual = intento3

        // Cambia al cuarto intento.
        } else if numeroIntento == 3 {
            intentoActual = intento4

        // Cambia al quinto intento.
        } else if numeroIntento == 4 {
            intentoActual = intento5
        }

        // Aumenta el contador para pasar al siguiente intento.
        numeroIntento += 1
    }
}


// ==========================================
// MENSAJE FINAL
// ==========================================

// Verifica si el jugador logró adivinar el número.
if adivino {

    // Muestra en qué intento encontró el número secreto.
    print("Adivinaste el número en \(numeroIntento) intentos.")

} else {

    // Muestra el mensaje de pérdida después de usar los 5 intentos.
    print("Perdiste. El número era: \(numeroSecreto)")
}
