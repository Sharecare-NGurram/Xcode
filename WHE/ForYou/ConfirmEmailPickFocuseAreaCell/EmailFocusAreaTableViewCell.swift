//
//  EmailFocusAreaTableViewCell.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 01/03/23.
//

import UIKit

class EmailFocusAreaTableViewCell: UITableViewCell {

  @IBOutlet weak var buttonOutlet: UIButton!
  @IBOutlet weak var rewardsImageview: UIImageView!
  @IBOutlet weak var rewardsTitleLabel: UILabel!
  @IBOutlet weak var descriptionTitleLabel: UILabel!
  @IBOutlet weak var headerTitleLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      self.buttonOutlet.layer.cornerRadius = 10
      buttonOutlet.backgroundColor = AnthemColor.colorFromHex("794CFF")
    }
    
    var emailVerified: Bool = true {
        didSet {
            if emailVerified {
                rewardsTitleLabel.text = "Completed"
                rewardsTitleLabel.font = UIFont.mediumBold(ofSize: 17)
                rewardsTitleLabel.textColor = AnthemColor.colorFromHex("#028283")
                rewardsImageview.image = UIImage(named: "check_circle")?.withTintColor(AnthemColor.completedStatusColor)
                buttonOutlet.isHidden = true
            } else {
                rewardsImageview.image = UIImage(named: "starGray")
                buttonOutlet.isHidden = false
            }
        }
    }
}
