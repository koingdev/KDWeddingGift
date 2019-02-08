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
		
		delegate = self
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .selected)
		
		viewControllers = [weddingGiftVC, reportVC]
	}

}

// MARK: Delegate

extension MainTabBar: UITabBarControllerDelegate {
	
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		if let view = item.value(forKey: "view") as? UIView {
			view.bounce()
		}
	}
	
//	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//		if viewController is MiddleTabActionVC {
//			let vc = QRScannerVC.instantiate()
//			vc.modalPresentationStyle = .overFullScreen
//			present(vc, animated: true)
//			return false
//		}
//		return true
//	}
	
}
