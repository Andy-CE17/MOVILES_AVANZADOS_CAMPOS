import UIKit

class OpcionTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenOpcion: UIImageView!
    @IBOutlet weak var tituloOpcion: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imagenOpcion.layer.cornerRadius = 10
        imagenOpcion.clipsToBounds = true
    }
}
