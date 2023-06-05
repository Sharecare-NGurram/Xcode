//
//  ListOfAddMedicationTableViewCell.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 30/01/23.
//

import UIKit

class ListOfAddMedicationTableViewCell: UITableViewCell {
  @IBOutlet weak var addMedsDescrptionLabel: UILabel!
  
  @IBOutlet weak var addMedsBGView: UIView!
  @IBOutlet weak var addMedsHeaderTitle: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
