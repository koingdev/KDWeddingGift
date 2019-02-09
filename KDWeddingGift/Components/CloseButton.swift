//
//  CloseButton.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

final class CloseButton: UIButton {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		bounceable = true
		isExclusiveTouch = true
		setImage(#imageLiteral(resourceName: "close"), for: .normal)
		addTarget(self, action: #selector(didTap), for: .touchUpInside)
	}
	
	@objc func didTap() {
		UIViewController.topMostViewController.dismiss(animated: true)
	}
	
}
