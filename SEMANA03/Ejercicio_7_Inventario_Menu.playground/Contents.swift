// Desarrollado por: Andy Luis Campos Escandón
// Ejercicio 7: Inventario con Menú - realizado con IA

// Importo Foundation para utilizar funciones básicas de Swift
import Foundation

// Creo un diccionario para guardar los precios de los productos
var precios: [String: Double] = [:]

// Creo un diccionario para guardar el stock de los productos
var stocks: [String: Int] = [:]

// Muestro el título del programa
print("========== INVENTARIO ==========")

// Pido la cantidad de productos
print("Ingrese la cantidad de productos:")

// Leo la cantidad ingresada y la convierto a entero
let cantidadProductos = Int(readLine() ?? "") ?? 0

// Verifico que la cantidad de productos sea mayor a cero
if cantidadProductos > 0 {

    // Repito el registro según la cantidad de productos
    for i in 1...cantidadProductos {

        // Muestro el número del producto
        print("\n========== PRODUCTO \(i) ==========")

        // Pido el nombre del producto
        print("Nombre:")

        // Leo y guardo el nombre
        let nombre = readLine() ?? ""

        // Pido el precio del producto
        print("Precio:")

        // Leo el precio y lo convierto a Double
        let precio = Double(readLine() ?? "") ?? 0

        // Pido el stock del producto
        print("Stock:")

        // Leo el stock y lo convierto a entero
        let stock = Int(readLine() ?? "") ?? 0

        // Guardo el precio usando el nombre como clave
        precios[nombre] = precio

        // Guardo el stock usando el mismo nombre como clave
        stocks[nombre] = stock
    }

    // Creo una variable para controlar el menú
    var continuar = true

    // Mantengo el menú activo mientras continuar sea verdadero
    while continuar {

        // Muestro el título del menú
        print("\n========== MENÚ ==========")

        // Muestro la opción 1
        print("1. Ver inventario")

        // Muestro la opción 2
        print("2. Buscar producto")

        // Muestro la opción 3
        print("3. Productos con stock bajo")

        // Muestro la opción 4
        print("4. Valor total del inventario")

        // Muestro la opción 5
        print("5. Salir")

        // Pido al usuario una opción
        print("Seleccione una opción:")

        // Leo la opción y la convierto a entero
        let opcion = Int(readLine() ?? "") ?? 0

        // Evalúo la opción seleccionada
        switch opcion {

        // Opción para mostrar el inventario completo
        case 1:

            // Muestro el título
            print("\n========== INVENTARIO COMPLETO ==========")

            // Recorro todos los productos registrados
            for (nombre, precio) in precios {

                // Obtengo el stock del producto
                let stock = stocks[nombre] ?? 0

                // Muestro el nombre, precio y stock
                print("\(nombre) | Precio: S/. \(String(format: "%.2f", precio)) | Stock: \(stock)")
            }

        // Opción para buscar un producto
        case 2:

            // Muestro el título de búsqueda
            print("\n========== BUSCAR PRODUCTO ==========")

            // Pido el nombre del producto
            print("Ingrese el nombre del producto:")

            // Leo el nombre ingresado
            let buscar = readLine() ?? ""

            // Verifico si el producto existe
            if let precio = precios[buscar] {

                // Obtengo el stock del producto encontrado
                let stock = stocks[buscar] ?? 0

                // Muestro los datos del producto
                print("\(buscar) | Precio: S/. \(String(format: "%.2f", precio)) | Stock: \(stock)")

            // Si el producto no existe
            } else {

                // Muestro un mensaje de error
                print("Producto no encontrado.")
            }

        // Opción para mostrar productos con stock bajo
        case 3:

            // Muestro el título
            print("\n========== STOCK BAJO ==========")

            // Creo una variable para saber si encontré algún producto
            var hayStockBajo = false

            // Recorro los productos y sus stocks
            for (nombre, stock) in stocks {

                // Verifico si el stock es menor a cinco
                if stock < 5 {

                    // Muestro el producto con stock bajo
                    print("\(nombre): \(stock) unidades")

                    // Indico que sí encontré stock bajo
                    hayStockBajo = true
                }
            }

            // Verifico si no encontré ningún producto
            if !hayStockBajo {

                // Muestro un mensaje
                print("No hay productos con stock bajo.")
            }

        // Opción para calcular el valor total del inventario
        case 4:

            // Creo una variable para acumular el valor total
            var valorTotal = 0.0

            // Recorro todos los productos y precios
            for (nombre, precio) in precios {

                // Obtengo el stock del producto
                let stock = stocks[nombre] ?? 0

                // Multiplico precio por stock y lo acumulo
                valorTotal += precio * Double(stock)
            }

            // Muestro el título
            print("\n========== VALOR DEL INVENTARIO ==========")

            // Muestro el valor total
            print("Valor total: S/. \(String(format: "%.2f", valorTotal))")

        // Opción para salir
        case 5:

            // Cambio continuar a falso
            continuar = false

            // Muestro el mensaje de salida
            print("\nPrograma finalizado.")

        // Opción no válida
        default:

            // Muestro un mensaje de error
            print("\nOpción no válida.")
        }
    }

// Si la cantidad ingresada no es válida
} else {

    // Muestro un mensaje de validación
    print("La cantidad de productos debe ser mayor a 0.")
}
