//
//  NewPrescriptionTableViewCell.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 09/02/23.
//

import UIKit

class NewPrescriptionTableViewCell: UITableViewCell {

  @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var newPrescriptionBoaderLine: UIView!
  @IBOutlet weak var newPrescriptionImageview: UIImageView!
  @IBOutlet weak var newPrescriptionTitleLabel: UILabel!
  @IBOutlet weak var newPrescriptionSelectionButton: UIButton!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
