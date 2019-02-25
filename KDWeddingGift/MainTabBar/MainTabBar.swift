//
//  MainTabBar.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/7/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

extension UIColor {
	
	convenience init(rgb: UInt) {
		self.init(
			red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgb & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
	
	static let main = UIColor(rgb: 0xfc5185)
	
}

class MainTabBar: UITabBarController {
	
	lazy var weddingGiftVC = WeddingGiftVC.instantiate()
	lazy var reportVC = TotalRecordVC.instantiate()
	let qrScannerButton = QRScannerButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .selected)
		
		setMiddleButton(qrScannerButton)
		
		let weddingGiftNav = UINavigationController(rootViewController: weddingGiftVC)
		let reportNav = UINavigationController(rootViewController: reportVC)
		
		viewControllers = [weddingGiftNav, reportNav]
		
		// Event
		_ = qrScannerButton.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			guard let self = self else { return }
			
			let vc = QRScannerVC.instantiate()
			// Finish add new data ?
			vc.didFinishAddNewData = {
				let firstRow = IndexPath(item: 0, section: 0)
				self.weddingGiftVC.tableView.performAction(.insert, at: firstRow)
			}
			UIViewController.topMostViewController.present(vc, animated: true)
		}
	}
	
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		if let view = item.value(forKey: "view") as? UIView {
			view.bounce(duration: 0.5)
		}
	}
	
	func setMiddleButton(_ button: UIButton) {
		let heightDifference: CGFloat = 60 - tabBar.frame.size.height
		if heightDifference < 0 {
			button.center = tabBar.center
		} else {
			var center: CGPoint = tabBar.center
			center.y = center.y - heightDifference / 2.0
			button.center = center
		}
		
		view.addSubview(button)
	}

}
