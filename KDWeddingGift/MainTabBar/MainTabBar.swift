//
//  MainTabBar.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/7/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

extension UIColor {
	
	static let main = UIColor(rgb: 0xfc5185)
	
}

class MainTabBar: UITabBarController {
	
	lazy var weddingGiftVC = WeddingGiftVC.instantiate()
	lazy var reportVC = TotalRecordVC.instantiate()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// UI
		let qrScannerButton = QRScannerButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
		setMiddleButton(qrScannerButton)
		changeTabBarFontSize()
		
		// VCs
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

}
