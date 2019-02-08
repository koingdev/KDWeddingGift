//
//  MainTabBar.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/7/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
	
	lazy var weddingGiftVC = WeddingGiftVC.instantiate()
	lazy var reportVC = ReportVC.instantiate()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .selected)
		
		let weddingGiftNav = UINavigationController(rootViewController: weddingGiftVC)
		let reportNav = UINavigationController(rootViewController: reportVC)
		
		viewControllers = [weddingGiftNav, reportNav]
	}
	
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		if let view = item.value(forKey: "view") as? UIView {
			view.bounce()
		}
	}

}
