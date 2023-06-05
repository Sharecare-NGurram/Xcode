//
//  FirstTimeSetupViewController.swift
//  WHE
//
//  Created by Pratima Pundalik on 11/04/23.
//

import UIKit

class FirstTimeSetupViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var moneyReward: UILabel!
    
    @IBOutlet weak var completingTask: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var completeStepText: UILabel!
    
    @IBOutlet weak var FirstTimeSetupView: UIView!
    
    @IBOutlet weak var setupFirstWeek: UIButton!
    
    private var firstTimeViewModel = FirstTimeSetupViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        applyBGColorCornerRadius()
        applyCornerRadius()
        updateFirstTimeSetupLabels()
    }
    
    @IBAction func setupFirstWeekAction(_ sender: Any) {
      yourWeelyPlanVC()
    }

    func yourWeelyPlanVC() {
       if let weeklyPlanVC = WeeklyPlantSB.instantiateViewController(withIdentifier: "YourWeeklyPlanViewController") as? YourWeeklyPlanViewController {
          LocalStorageManager.setDailyCheckIn(status: true)
          self.navigationController?.pushViewController(weeklyPlanVC, animated: true)
        }
    }
    
    func applyCornerRadius(){
        setupFirstWeek.layer.cornerRadius = 10
        FirstTimeSetupView.layer.cornerRadius = 10
    }
    
    func updateFirstTimeSetupLabels(){
        moneyReward.text = firstTimeViewModel.moneyRewardTitle
        moneyReward.font = UIFont.semiBold(ofSize: 24)
        moneyReward.textColor = AnthemColor.enabledDateTextColor
        completingTask.text = firstTimeViewModel.completingTaskTitle
        completingTask.font = UIFont.mediumBold(ofSize: 16)
        completingTask.textColor = AnthemColor.enabledDateTextColor
        completingTask.attributedText = completingTask.updateLineHeightMultipleLabel(with: completingTask.text ?? "", lineHeight: 1.32)
        completeStepText.font = UIFont.mediumBold(ofSize: 16)
        completeStepText.textColor = AnthemColor.DayTextColor
        completeStepText.text = firstTimeViewModel.completingStepTitle
        setupFirstWeek.titleLabel?.font = UIFont.semiBold(ofSize: 17)
        completingTask.textAlignment = .center
        completeStepText.textAlignment = .center
    }
    
    func applyBGColorCornerRadius() {
        //mainView.layer.cornerRadius = 45
    }

    func setGradientBackground() {
        self.mainView.layer.cornerRadius = 20.0
        self.mainView.clipsToBounds = true
        let colorTop =  UIColor(red: 35.0/255.0, green: 30.0/255.0, blue: 51.0/255.0, alpha: 0.6).cgColor
        let colorBottom = UIColor(red: 35.0/255.0, green: 30.0/255.0, blue: 51.0/255.0, alpha: 0.9).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.view.bounds
        self.gradientView.layer.insertSublayer(gradientLayer, at:0)
    }
}
