//
//  PickCheckinTimeTableViewCell.swift
//  WHE
//
//  Created by Rajesh Gaddam on 11/04/23.
//

import UIKit

class PickCheckinTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var pickLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var pickBtn: UIButton!
    @IBOutlet weak var rewardsImg: NSLayoutConstraint!
    @IBOutlet weak var rewardsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.pickBtn.layer.cornerRadius = 10
        pickBtn.backgroundColor = AnthemColor.colorFromHex("794CFF")
        // Configure the view for the selected state
    }
    
}
