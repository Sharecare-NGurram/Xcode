//
//  AnthemColor.swift
//  WHE
//
//  Created by Pratima Pundalik on 19/01/23.
//

import UIKit
class AnthemColor: UIColor{
  static func colorFromHex(_ hexCode: String) -> UIColor {
    UIColor(hexString: hexCode)
  }
}
extension AnthemColor {
  public static let DayTextColor = colorFromHex("#6E6B79")
  public static let enabledDateTextColor = colorFromHex("#231E33")
  public static let highLightedDateTextColor = colorFromHex("#5009B5")
  public static let circleBorderColor = UIColor(red: 0.14, green: 0.12, blue: 0.20, alpha: 0.10)
  public static let HighlightedCircleBorderColor = colorFromHex("#F7F4FF")
  public static let medicationViewBGColor = UIColor.init(red: 0.976, green: 0.98, blue: 0.984, alpha: 1)
  public static let medsListTitleColor = UIColor.init(red: 121.0/255.0, green: 76.0/255.0, blue: 255.0/255.0, alpha: 1)
  public static let medicationViewBoaderColor = UIColor.init(red: 235.0/255, green: 228.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor
  public static let medsListSelectedTitleColor =  UIColor.init(red: 80.0/255.0, green: 9.0/255.0, blue: 181.0/255.0, alpha: 1)
  public static let medicationSelectedViewBGColor = UIColor.init(red: 0.922, green: 0.894, blue: 1, alpha: 1)
  public static let medicationSelectedViewBoaderColor = UIColor.init(red: 114/255, green: 78/255, blue: 246/255, alpha: 1).cgColor
  public static let addMedicationShadowColour = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
  public static let errorBackGroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)    
  public static let tryAgainBackGroundColor = UIColor(red: 0.47, green: 0.30, blue: 1.00, alpha: 0.06)
    public static let semiAlphaBlackColor = UIColor(red: 35, green: 30, blue: 51, alpha: 0.04)
    public static let semiAlphaBlackBorderColor = UIColor(red: 35, green: 30, blue: 51, alpha: 1.0)
    public static let grayTxt = UIColor(red: 110, green: 107, blue: 121, alpha: 1.0)
    public static let configTxtColor = UIColor.init(red: 110/255, green: 107/255, blue: 121/255, alpha: 1)
    public static let buttonTextColor = UIColor.init(red: 0.475, green: 0.298, blue: 1, alpha: 1.0)
    public static let collectionViewBackgroundColor = UIColor.init(red: 0.475, green: 0.298, blue: 1, alpha: 0.06)
    public static let focusAreaBgView = UIColor(red: 0.008, green: 0.51, blue: 0.514, alpha: 1)
    public static let textBorderColor = colorFromHex("#794CFF")
    public static let dateShadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
    public static let completedStatusColor = colorFromHex("#028283")
    public static let unlockViewBoaderColour = colorFromHex("#F9FAFB")
    public static let tabBarPalePurple = colorFromHex("#EBE4FF")
    public static let tabBarDarkGrayColour = colorFromHex("#231E33")
    public static let timelabelcolor = colorFromHex("#A3A2AB")
    public static let colonLabelColor = colorFromHex("#794CFF")
    public static let submitBtnBGGrayColor = colorFromHex("#D7D7DB")
    public static let submitBtnWhiteColor = colorFromHex("#FFFFFF")
    public static let submitBtnGrayColor = colorFromHex("#6E6B79")
    public static let resendGrayColor = colorFromHex("#A3A2AB")
    public static let focusAreaColor = colorFromHex("#F9FAFB")
    public static let rewardsTextColor = colorFromHex("#E54D4D")
    public static let buttonDisableColor = colorFromHex("#D7D7DB")
    public static let TurquoiseColor = colorFromHex("#028283")
    public static let MediumGrayColor = colorFromHex("#6E6B79")
}
