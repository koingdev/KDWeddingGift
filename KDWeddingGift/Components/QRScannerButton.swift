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
		
		// Animation
		popIn()
	}
	
	private func setUp() {
		bounceable = true
		cornerRadius = bounds.size.width / 2
		isExclusiveTouch = true
		adjustsImageWhenHighlighted = false
		backgroundColor = UIColor.magenta
		setImage(#imageLiteral(resourceName: "qr"), for: .normal)
	}
	
}
