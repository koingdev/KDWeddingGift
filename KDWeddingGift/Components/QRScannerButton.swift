//
//  QRScannerButton.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

final class QRScannerButton: UIButton {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUp()
	}
	
	private func setUp() {
		bounceable = true
		cornerRadius = bounds.size.width / 2
		adjustsImageWhenHighlighted = false
		backgroundColor = UIColor.magenta
		setImage(#imageLiteral(resourceName: "qr"), for: .normal)
		addTarget(self, action: #selector(didTap), for: .touchUpInside)
	}
	
	@objc func didTap() {
		let vc = QRScannerVC.instantiate()
		UIViewController.topMostViewController.present(vc, animated: true)
	}
	
}
