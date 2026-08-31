import Foundation

// Docente: Juan León S.

// ==========================================
// EJERCICIO 3: FOR-IN
// ==========================================


// --- Ejemplo (ya resuelto): ---
// Imprime los números del 1 al 5:

for i in 1...5 {
    print("Número: \(i)")
}


// --- TODO 7: Tabla de multiplicar del 7 ---
// Imprime: 7 x 1 = 7, 7 x 2 = 14, ... 7 x 12 = 84
//==================================================

for  i in 1...12{
    print("7 x \(i) = \(7*i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
// Suma todos los números del 1 al 100
//========================================

var suma = 0 

for i in 1...100{
    suma = suma + i 
    
}
print("La suma del 1 al 100 es: \(suma)") // debe dar 5050


// --- TODO 9: Calcular el factorial de 8 ---
// Factorial: 8! = 8 × 7 × 6 × 5 × 4 × 3 × 2 × 1 = 40320
//=======================================================

var factorial = 1
for i in 1...8{
    factorial = factorial * i
    
}
print("8! = \(factorial)")


// --- TODO 10: Patrón de asteriscos ---
// Imprime este patrón usando for anidados:
// *
// **
// ***
// ****
// *****
//==============================================

for i in 1...5{
    print(String(repeating: "*", count: i))
}


// ==========================================
// FIX: ENCUENTRA LOS 2 ERRORES

// Se quiere imprimir los números pares del 2 al 20:
// ==================================================

for i in 1...20{
    if i % 2 == 0{ // FIX 4:  se cambio a 0 para identificar los nueros pares
        print(i)
    }
}


// Se quiere contar del 10 al 1 (cuenta regresiva):
//===================================================

for i in stride(from:10, through: 1, by: -1){
    print(i)
}


// ==========================================
// 3.3 — PREDICCIONES
// ==========================================

// PREDICT: ¿Cuántas veces se ejecuta y qué imprime al final?
//=============================================================

var total = 0 
for i in 1...5{
    total = total +  i
}
print(total)  // //PREDICT 6: valor = 15 | iteraciones = 5


// PREDICT 7: Repetición de texto
//================================

var texto = ""

for _ in 1...3 {
    texto += "Hola "
}

print(texto)  // PREDICT 7: Hola , Hola , Hola
// el _ se usa por que no necesitamos utilizar el valor de cada iteracion
