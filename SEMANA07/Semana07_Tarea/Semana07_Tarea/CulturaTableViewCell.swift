import UIKit

class CulturaTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenCultura: UIImageView!
    @IBOutlet weak var nombreCultura: UILabel!
    @IBOutlet weak var regionCultura: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imagenCultura.layer.cornerRadius = 10
        imagenCultura.clipsToBounds = true
    }
}
