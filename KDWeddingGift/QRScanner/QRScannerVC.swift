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
	
	var didFinishAddNewData: (() -> Void)?
	private var qrCodeReader = AVQRCodeReader()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Scanner
		videoLayer = qrCodeReader.videoPreview
		videoPreview.layer.addSublayer(videoLayer)
		
		// Event
		_ = btnGoToAddForm.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			let vc = AddFormVC.instantiate()
			vc.didFinishAddNewData = self?.didFinishAddNewData
			self?.present(vc, animated: false)
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		// Scanner frame
		videoLayer.frame = videoPreview.bounds
		let heartSize = CGSize(width: videoPreview.width * 0.85, height: videoPreview.width * 0.85)
		videoPreview.addHeartShapeTransparentHole(size: heartSize, fillColor: .main, opacity: 0.4)
		
		// Animation
		btnGoToAddForm.popIn()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		qrCodeReader.startReading { [weak self] name in
			// Read success -> Open and pass `name` to Add Form
			let vc = AddFormVC.instantiate()
			vc.didFinishAddNewData = self?.didFinishAddNewData
			self?.present(vc, animated: false) {
				vc.viewModel.name.value = name
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		qrCodeReader.stopReading()
	}
	
}
