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
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func setRielAmount(_ amount: Double) {
		lbRielAmount.text = "\(amount) រៀល"
	}
	
	func setDollarAmount(_ amount: Double) {
		lbDollarAmount.text = "\(amount) ដុល្លា"
	}
	
}
