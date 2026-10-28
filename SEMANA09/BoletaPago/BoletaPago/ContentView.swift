import SwiftUI

struct ContentView: View {
    @State private var casoSeleccionado = 0
    @State private var sueldo = "2500"
    @State private var dias = "30"
    @State private var hijos = false
    @State private var sistema = SistemaPension.onp
    @State private var afp = "AFP Guía"
    @State private var horas25 = "0"
    @State private var horas35 = "0"
    @State private var adelanto = "0"
    @State private var resultado: ResultadoBoleta?
    @State private var mensajeError = ""

    private let verde = Color(red: 0.04, green: 0.38, blue: 0.16)
    private let naranja = Color(red: 0.95, green: 0.34, blue: 0.02)
    private let fondo = Color(red: 0.96, green: 0.97, blue: 0.95)

    private var entradas: [String] {
        [sueldo, dias, String(hijos), sistema.rawValue, afp, horas25, horas35, adelanto]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                encabezado
                formulario

                if let resultado {
                    resumen(resultado)
                    bloque(titulo: "Remuneraciones", conceptos: resultado.remuneraciones, total: resultado.totalRemuneraciones)
                    bloque(titulo: "Retenciones y descuentos", conceptos: resultado.descuentos, total: resultado.totalDescuentos)
                    bloque(titulo: "Aportación del empleador", conceptos: resultado.aportaciones, total: nil)
                    fila(titulo: "Costo total para la empresa", monto: resultado.costoEmpresa)
                        .font(.headline)
                        .padding(.horizontal, 4)
                    Text("EsSalud lo paga la empresa y no se descuenta del trabajador. Los conceptos que no aplican se muestran en S/ 0.00.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Text("Complete los datos y pulse Calcular boleta para mostrar el resultado.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text("Parámetros y fuentes documentados en el Excel. Fecha de consulta: \(Parametros.fechaConsulta).")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(18)
            .frame(maxWidth: 680)
            .frame(maxWidth: .infinity)
        }
        .background(fondo)
        .onChange(of: casoSeleccionado) { cargarCaso($0) }
        .onChange(of: entradas) { _ in
            resultado = nil
            mensajeError = ""
        }
        .onAppear(perform: prepararEvidencia)
    }

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Boleta de ejemplo")
                .font(.largeTitle.bold())
                .foregroundStyle(verde)
            Text("Del sueldo bruto al neto")
                .font(.title3)
            Text("Simulación académica · Octubre 2026")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var formulario: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Datos de entrada")
                .font(.title2.bold())
                .foregroundStyle(verde)

            Picker("Caso", selection: $casoSeleccionado) {
                ForEach(Casos.todos.indices, id: \.self) { indice in
                    Text(Casos.todos[indice].nombre).tag(indice)
                }
            }
            .pickerStyle(.menu)
            .tint(verde)

            campo(titulo: "Sueldo básico (S/)", texto: $sueldo, teclado: .decimalPad)
            campo(titulo: "Días laborados (1–30)", texto: $dias, teclado: .numberPad)

            Text("¿Tiene hijos?").font(.subheadline.bold())
            Picker("¿Tiene hijos?", selection: $hijos) {
                Text("No").tag(false)
                Text("Sí").tag(true)
            }
            .pickerStyle(.segmented)

            Text("Sistema de pensiones").font(.subheadline.bold())
            Picker("Sistema de pensiones", selection: $sistema) {
                Text("ONP").tag(SistemaPension.onp)
                Text("AFP").tag(SistemaPension.afp)
            }
            .pickerStyle(.segmented)

            if sistema == .afp {
                Picker("AFP", selection: $afp) {
                    ForEach(Parametros.ordenAFP, id: \.self) { nombre in
                        Text(nombre).tag(nombre)
                    }
                }
                .pickerStyle(.menu)
                .tint(verde)
            }

            HStack(alignment: .top, spacing: 12) {
                campo(titulo: "Horas al 25%", texto: $horas25, teclado: .decimalPad)
                campo(titulo: "Horas al 35%", texto: $horas35, teclado: .decimalPad)
            }
            campo(titulo: "Adelanto (S/)", texto: $adelanto, teclado: .decimalPad)

            Button(action: calcular) {
                Text("Calcular boleta")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            .tint(naranja)

            if !mensajeError.isEmpty {
                Text(mensajeError)
                    .font(.subheadline)
                    .foregroundStyle(.red)
            }
        }
        .padding(18)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(verde.opacity(0.18)))
    }

    private func campo(titulo: String, texto: Binding<String>, teclado: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titulo).font(.subheadline.bold())
            TextField(titulo, text: texto)
                .keyboardType(teclado)
                .textFieldStyle(.roundedBorder)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func resumen(_ resultado: ResultadoBoleta) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("NETO A PAGAR").font(.caption.bold())
            Text(soles(resultado.neto)).font(.largeTitle.bold())
            Text("Profesional ficticio · Empresa de ejemplo")
                .font(.caption)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .foregroundStyle(.white)
        .background(verde)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private func bloque(titulo: String, conceptos: [Concepto], total: Decimal?) -> some View {
        VStack(alignment: .leading, spacing: 11) {
            Text(titulo).font(.title3.bold()).foregroundStyle(verde)
            ForEach(conceptos) { concepto in
                fila(titulo: concepto.nombre, monto: concepto.monto)
            }
            if let total {
                Divider()
                fila(titulo: "Total", monto: total).font(.headline)
            }
        }
        .padding(18)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(verde.opacity(0.18)))
    }

    private func fila(titulo: String, monto: Decimal) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(titulo).frame(maxWidth: .infinity, alignment: .leading)
            Text(soles(monto)).monospacedDigit()
        }
    }

    private func calcular() {
        resultado = nil
        mensajeError = ""
        do {
            guard let diasEnteros = Int(dias.trimmingCharacters(in: .whitespacesAndNewlines)) else {
                throw ErrorBoleta.dato("Días laborados: escriba un número entero entre 1 y 30.")
            }
            let datos = DatosBoleta(
                sueldo: try Entrada.decimal(sueldo, nombre: "Sueldo básico"),
                dias: diasEnteros,
                hijos: hijos,
                sistema: sistema,
                afp: afp,
                horas25: try Entrada.decimal(horas25, nombre: "Horas al 25%"),
                horas35: try Entrada.decimal(horas35, nombre: "Horas al 35%"),
                adelanto: try Entrada.decimal(adelanto, nombre: "Adelanto")
            )
            resultado = try Boleta().calcular(datos)
        } catch {
            mensajeError = error.localizedDescription
        }
    }

    private func cargarCaso(_ indice: Int) {
        guard Casos.todos.indices.contains(indice) else { return }
        cargar(Casos.todos[indice].datos)
        resultado = nil
        mensajeError = ""
    }

    private func cargar(_ datos: DatosBoleta) {
        sueldo = texto(datos.sueldo)
        dias = String(datos.dias)
        hijos = datos.hijos
        sistema = datos.sistema
        afp = datos.afp
        horas25 = texto(datos.horas25)
        horas35 = texto(datos.horas35)
        adelanto = texto(datos.adelanto)
    }

    private func prepararEvidencia() {
        let argumentos = ProcessInfo.processInfo.arguments
        guard let posicion = argumentos.firstIndex(of: "--evidence-case"), argumentos.indices.contains(posicion + 1),
              let indice = Int(argumentos[posicion + 1]), Casos.todos.indices.contains(indice) else { return }
        casoSeleccionado = indice
        cargar(Casos.todos[indice].datos)
        calcular()
    }

    private func soles(_ monto: Decimal) -> String {
        let formato = NumberFormatter()
        formato.numberStyle = .currency
        formato.currencySymbol = "S/ "
        formato.currencyDecimalSeparator = "."
        formato.currencyGroupingSeparator = ","
        formato.minimumFractionDigits = 2
        formato.maximumFractionDigits = 2
        return formato.string(from: NSDecimalNumber(decimal: monto)) ?? "S/ 0.00"
    }

    private func texto(_ valor: Decimal) -> String {
        NSDecimalNumber(decimal: valor).stringValue
    }
}

#Preview {
    ContentView()
}
