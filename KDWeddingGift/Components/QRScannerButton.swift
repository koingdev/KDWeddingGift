//
//  QRScannerButton.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

final class QRScannerButton: DesignableButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUp()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setUp()
	}
	
	private func setUp() {
		animateOnTouch = true
		cornerRadius = bounds.size.width / 2
		isExclusiveTouch = true
		adjustsImageWhenHighlighted = false
		backgroundColor = UIColor.main
		setImage(#imageLiteral(resourceName: "qr"), for: .normal)
		
		// Animation
		popIn()
	}
	
}
