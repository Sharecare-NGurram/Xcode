//
//  TrackMedsCell.swift
//  WHE
//
//  Created by Nagarjunareddy Yeruvu on 18/04/23.
//

import UIKit

class TrackMedsCell: UITableViewCell {
    @IBOutlet weak var btn_taken: UIButton!
    @IBOutlet weak var trackLbl: UILabel!
    @IBOutlet weak var lbl_earn: UILabel!
    @IBOutlet weak var manullayImageView: UIImageView!
    let trackedmanually =  "Tracked manually"
    let touchIcon =  "touch_app"
    let starGrayIcon =  "starGray"
    let takenBtnTitle =  "Taken?"
    let takenDoneBtnTitle =  "Taken"
    let earnToday =  "Earn today's reward"
    let earnReward =  "Earned reward"
    let completedIcon =  "completed"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configueCellWithTrackMeds(){
        
        if !LocalStorageManager.fetchTrackYourMedsTaken() && !LocalStorageManager.fetchTrackYourStepsDone()
        {
            lbl_earn.text = earnToday
            manullayImageView.image = UIImage.init(named: starGrayIcon)
            btn_taken.setTitle(takenBtnTitle, for: .normal)
            btn_taken.backgroundColor  = AnthemColor.buttonTextColor
            btn_taken.titleLabel?.textColor = AnthemColor.white
            btn_taken.isUserInteractionEnabled =  true


        }else   if !LocalStorageManager.fetchTrackYourMedsTaken() && LocalStorageManager.fetchTrackYourStepsDone()
        {
            lbl_earn.text = trackedmanually
            manullayImageView.image = UIImage.init(named: touchIcon)
            btn_taken.setTitle(takenBtnTitle, for: .normal)
            btn_taken.backgroundColor  = AnthemColor.buttonTextColor
            btn_taken.titleLabel?.textColor = AnthemColor.white
            btn_taken.isUserInteractionEnabled =  true

        }else   if LocalStorageManager.fetchTrackYourMedsTaken()
        {
            lbl_earn.text = earnReward
            lbl_earn.textColor = AnthemColor.TurquoiseColor
            manullayImageView.image = UIImage.init(named: completedIcon)
            btn_taken.setTitle(takenDoneBtnTitle, for: .normal)
            btn_taken.backgroundColor  = AnthemColor.buttonTextColor.withAlphaComponent(0.6)
            btn_taken.titleLabel?.textColor = AnthemColor.buttonTextColor
            btn_taken.isUserInteractionEnabled =  false

        }
        
       
         
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
}
