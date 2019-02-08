//
//  WeddingGiftFormVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

final class WeddingGiftFormVC: UIViewController {
	
	@IBOutlet weak var tfName: UITextField!
	@IBOutlet weak var tfAmountDollar: UITextField!
	@IBOutlet weak var tfAmountRiel: UITextField!
	
	var didFinishScanning: ((String) -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		didFinishScanning = { [weak self] name in
			self?.tfName.text = name
		}
	}
	
	@IBAction func addWeddingGift(_ sender: Any) {
		
	}
	
}
