//
//  FocusAreaTableViewCell.swift
//  WHE
//
//  Created by Rajesh Gaddam on 24/03/23.
//

import UIKit

class FocusAreaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rewardHeight: NSLayoutConstraint!
    @IBOutlet weak var rewardWidth: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var activeImg: UIImageView!
    @IBOutlet weak var rewards: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var viewModel = FocusAreaViewModel()
    @IBOutlet weak var rewardsImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  var setSharingDeniedCell: Bool = true {
    didSet {
      bgView.backgroundColor =  AnthemColor.focusAreaColor
      rewards.text = viewModel.sharingDeniedText
      rewards.font = UIFont.semiBold(ofSize: 17)
      rewards.textColor = AnthemColor.rewardsTextColor
      descriptionLbl.textColor = AnthemColor.submitBtnGrayColor
      title.textColor = AnthemColor.submitBtnGrayColor
      rewardsImg.image = UIImage(named: viewModel.imagesHKit)
      activeImg.image = UIImage(named: viewModel.walkHKitImg)
      rewardWidth.constant = 20
      rewardHeight.constant = 20
    }
  }
  
  var setnotDeterminedCell: Bool = true {
    didSet {
      title.textColor = AnthemColor.colonLabelColor
      descriptionLbl.textColor = AnthemColor.submitBtnGrayColor
      bgView.backgroundColor =  AnthemColor.unlockViewBoaderColour
      rewards.text = viewModel.sharingNotDeterminedText
      rewards.font = UIFont.mediumBold(ofSize: 17)
      rewards.textColor = AnthemColor.completedStatusColor
      rewardsImg.image = UIImage(named: viewModel.rewardsImg)
      activeImg.image = UIImage(named: viewModel.listImages[1])
      rewardWidth.constant = 22
      rewardHeight.constant = 22
    }
  }
  
  var setSharingAuthorizationCell: Bool = true {
    didSet {
      bgView.backgroundColor =  AnthemColor.focusAreaBgView
      rewards.text = viewModel.sharingAuthorizedText
      rewards.font = UIFont.semiBold(ofSize: 17)
      rewards.textColor = AnthemColor.submitBtnWhiteColor
      descriptionLbl.textColor = AnthemColor.submitBtnWhiteColor
      title.textColor = AnthemColor.submitBtnWhiteColor
      rewardsImg.image = UIImage(named: viewModel.checkMarkImg)?.withTintColor(.white)
      activeImg.image = UIImage(named: viewModel.walkHKitImg)?.withTintColor(.white)
      rewardWidth.constant = 20
      rewardHeight.constant = 20
    }
  }
    
   var setSharingTrackMeds: Bool = true {
      didSet {
        bgView.backgroundColor =  AnthemColor.focusAreaBgView
        rewards.text = viewModel.sharingAuthorizedText
        rewards.font = UIFont.semiBold(ofSize: 17)
        rewards.textColor = AnthemColor.submitBtnWhiteColor
        descriptionLbl.textColor = AnthemColor.submitBtnWhiteColor
        title.textColor = AnthemColor.submitBtnWhiteColor
        rewardsImg.image = UIImage(named: viewModel.checkMarkImg)?.withTintColor(.white)
        activeImg.image = UIImage(named: viewModel.listImages[0])?.withTintColor(.white)
        rewardWidth.constant = 20
        rewardHeight.constant = 20
      }
    }
}
