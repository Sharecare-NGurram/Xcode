//
//  TrackMedsCell.swift
//  WHE
//
//  Created by Nagarjunareddy Yeruvu on 18/04/23.
//

import UIKit

class TrackYourStepCell: UITableViewCell {
    @IBOutlet weak var per_imageView: UIImageView!
    @IBOutlet weak var trackLbl: UILabel!
    @IBOutlet weak var lbl_earn: UILabel!
    @IBOutlet weak var manullayImageView: UIImageView!
    @IBOutlet weak var auto_label: UILabel!
    let trackedauto =  "Tracked automatically"
    let starGray =  "starGray"
    let earnToday =  "Earn today's reward"
    let actumatically =  "Automatic"
    let trackedmanually =  "Tracked manually"
    let touchIcon =  "touch_app"
    let starGrayIcon =  "starGray"
    let takenBtnTitle =  "Taken?"
    let takenDoneBtnTitle =  "Taken"
    let earnReward =  "Earned reward"
    let completedIcon =  "completed"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configueCellWithTrackYourSteps(stepsCount:Double?){
        
        var percatageofStepsCount:Float = Float((stepsCount ?? 0)/5000)
        percatageofStepsCount = percatageofStepsCount * 100
        print(percatageofStepsCount)
          let percatageofStepsCoutInt:Int = Int(percatageofStepsCount)
        let imagePercentage:String = "percentage_" + String(roundToTens(x: Double(percatageofStepsCoutInt)))
        per_imageView.image = UIImage.init(named: imagePercentage)

        if !LocalStorageManager.fetchTrackYourMedsTaken() && !LocalStorageManager.fetchTrackYourStepsDone()
        {
            self.lbl_earn.text = self.earnToday
            self.lbl_earn.textColor = AnthemColor.MediumGrayColor
            self.manullayImageView.image = UIImage.init(named: self.starGrayIcon)
            self.per_imageView.isHidden = false
            self.auto_label.isHidden = false

        }else if !LocalStorageManager.fetchTrackYourStepsDone()  && LocalStorageManager.fetchTrackYourMedsTaken()
        {
            self.lbl_earn.text = self.trackedauto
            self.lbl_earn.textColor = AnthemColor.MediumGrayColor
            self.manullayImageView.image = UIImage.init(named:self.actumatically )
            self.per_imageView.isHidden = false
            self.auto_label.isHidden = false


        }else if LocalStorageManager.fetchTrackYourStepsDone()
        {
            self.lbl_earn.text = self.earnReward
            self.manullayImageView.image = UIImage.init(named: self.completedIcon)
            self.per_imageView.isHidden = true
            self.auto_label.isHidden = true


        }

  
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func roundToTens(x : Double) -> Int {
    return 10 * Int(round(x / 10.0))
    }
}
