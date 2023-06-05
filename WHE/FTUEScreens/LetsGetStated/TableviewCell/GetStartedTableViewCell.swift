//
//  GetStartedTableViewswift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 23/02/23.
//

import UIKit

class GetStartedTableViewCell: UITableViewCell {

  @IBOutlet weak var containerMainBG: UIView!
  @IBOutlet weak var imagviewHeight: NSLayoutConstraint!
  @IBOutlet weak var headerTitleLabel: UILabel!
  @IBOutlet weak var indexLabel: UILabel!
  @IBOutlet weak var indexMainView: UIView!
  @IBOutlet weak var indexImage: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  var loadCell: Bool = false {
      didSet {
        indexMainView.layer.cornerRadius = 15
        containerMainBG.layer.borderWidth = 1
        containerMainBG.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        contentView.backgroundColor = AnthemColor.colorFromHex("231E33")
      }
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
