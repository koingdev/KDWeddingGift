//
//  WeddingGiftTableViewCell.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

final class WeddingGiftTableViewCell: UITableViewCell {
	
	@IBOutlet weak var lbName: UILabel!
	@IBOutlet weak var lbRielAmount: UILabel!
	@IBOutlet weak var lbDollarAmount: UILabel!
	@IBOutlet weak var mainView: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(data: WeddingGiftRealmModel?, action: (() -> Void)?) {
		if let data = data {
			lbName.text = data.name
			setRielAmount(data.rielAmount)
			setDollarAmount(data.dollarAmount)
			
			// Action
			mainView.setAction(delayHighlight: 1, action: action)
		}
	}
	
	private func setRielAmount(_ amount: Double) {
		lbRielAmount.text = "\(amount) រៀល"
	}
	
	private func setDollarAmount(_ amount: Double) {
		lbDollarAmount.text = "\(amount) ដុល្លា"
	}
	
}
