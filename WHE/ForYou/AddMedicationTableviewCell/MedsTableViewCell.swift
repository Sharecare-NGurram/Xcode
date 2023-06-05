//
//  MedsTableViewCell.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 20/01/23.
//

import UIKit

class MedsTableViewCell: UITableViewCell {

  @IBOutlet weak var medsBoaderLayerView: UIView!
  @IBOutlet weak var medsImageView: UIImageView!
  @IBOutlet weak var medsBGView: UIView!
  @IBOutlet weak var medsListTitle: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    var isItemSelected: Bool = false {
        didSet {
            medsImageView.image = isItemSelected ?  UIImage(named: "pill_capsule") :  UIImage(named: "no_pill_capsule")
            medsListTitle.textColor = isItemSelected ? AnthemColor.medsListSelectedTitleColor : AnthemColor.medsListTitleColor
            medsBGView.backgroundColor = isItemSelected ? AnthemColor.medicationSelectedViewBGColor : AnthemColor.medicationViewBGColor
            medsBoaderLayerView.layer.borderWidth  = isItemSelected ? 2 : 1
            medsBoaderLayerView.layer.cornerRadius = isItemSelected ? 10 : 0
            medsBoaderLayerView.layer.borderColor = isItemSelected ? AnthemColor.medicationSelectedViewBoaderColor : UIColor.white.cgColor
            medsListTitle.font = isItemSelected ? UIFont.semiBold(ofSize: 17) :  UIFont.mediumBold(ofSize: 17)
          medsListTitle.textColor = AnthemColor.highLightedDateTextColor
        }
    }
}
