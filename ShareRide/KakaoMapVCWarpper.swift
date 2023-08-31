import Foundation
import SwiftUI

// 아무것도 없는 카카오 맵
struct KakaoMapVCWrapper: UIViewControllerRepresentable {
	
	func makeUIViewController(context: Context) -> some UIViewController {
		return KakaoMapVC()
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
}

class KakaoMapVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let mapView = MTMapView(frame: self.view.frame)
		mapView.baseMapType = .standard
		
		self.view.addSubview(mapView)
	}
}
