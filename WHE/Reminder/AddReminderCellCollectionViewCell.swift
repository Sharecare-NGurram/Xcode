//
//  AddReminderCellCollectionViewCell.swift
//  WHE
//
//  Created by Pratima Pundalik on 24/04/23.
//

import UIKit

class AddReminderCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reminderTimeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.reminderTimeButton.titleLabel?.font = UIFont.semiBold(ofSize: 16)
        self.reminderTimeButton.backgroundColor = AnthemColor.collectionViewBackgroundColor
        self.reminderTimeButton.setTitleColor(AnthemColor.textBorderColor, for: .normal)
        self.reminderTimeButton.titleLabel?.textAlignment = .center
        self.reminderTimeButton.isUserInteractionEnabled = false
        self.reminderTimeButton.layer.cornerRadius = 10
    }
}
