import UIKit

class ResultadoViewController: UIViewController {

    var venta: VentaModel?

    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblIgv: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblIntereses: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCuota: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Resultado"

        guard let venta else { return }

        lblSubtotal.text = formatearSoles(venta.subtotal)
        lblIgv.text = formatearSoles(venta.igv)
        lblBase.text = formatearSoles(venta.base)
        lblIntereses.text = formatearSoles(venta.intereses)
        lblTotal.text = formatearSoles(venta.total)
        lblCuota.text = formatearSoles(venta.cuota)
    }

    private func formatearSoles(_ valor: Double) -> String {
        String(format: "S/. %.2f", valor)
    }
}
