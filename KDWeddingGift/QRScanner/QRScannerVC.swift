//
//  QRScannerVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/7/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit
import Bond

final class QRScannerVC: UIViewController {
	
	@IBOutlet weak var videoPreview: UIView!
	@IBOutlet weak var btnGoToAddForm: UIButton!
	private var videoLayer: CALayer!
	
	private var qrCodeReader = AVQRCodeReader()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		videoLayer = qrCodeReader.videoPreview
		videoPreview.layer.addSublayer(videoLayer)
		
		// Event
		_ = btnGoToAddForm.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			let vc = AddFormVC.instantiate()
			self?.present(vc, animated: true)
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		videoLayer.frame = videoPreview.bounds
		
		// Animation
		btnGoToAddForm.popIn()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		qrCodeReader.startReading { [weak self] name in
			let vc = AddFormVC.instantiate()
			self?.present(vc, animated: true) {
				vc.viewModel.name.value = name
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		qrCodeReader.stopReading()
	}
	
}
