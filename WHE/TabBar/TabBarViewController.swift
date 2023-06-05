//
//  TabBarViewController.swift
//  ShareCareTabBar
//
//  Created by Venkateswarlu Samudrala on 09/01/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
    super.viewDidLoad()
        tabBarSetup()
    }
    func tabBarSetup(){
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "ElevanceSans-Bold", size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        let attributes1 = [NSAttributedString.Key.font:UIFont(name: "ElevanceSans-Medium", size: 14)]
        appearance.setTitleTextAttributes(attributes1 as [NSAttributedString.Key : Any], for: .selected)
        self.tabBar.isTranslucent = false
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -18)
        navigationController?.isNavigationBarHidden = true
        self.tabBar.tintColor = UIColor.white
        self.tabBar.backgroundColor = AnthemColor.tabBarDarkGrayColour
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = AnthemColor.tabBarDarkGrayColour
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "ElevanceSans-Semibold", size: 14)!]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(hexString: "#EBE4FF"), .font: UIFont(name: "ElevanceSans-Medium", size: 14)!]
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = AnthemColor.tabBarPalePurple
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
}
