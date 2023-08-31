import Foundation

import SwiftUI
import CoreLocation
import WebKit
import UIKit
import CoreLocation

final class KakaoAddressViewController: BaseWebViewController {
	
	// MARK: - Properties
	
	var delegate: KakaoAddressViewDelegate?
	
	private var coordinates: CLLocationCoordinate2D?
	
	private var addressEnglish = "" /// 기본 영문 주소
	private var roadAddress = "" /// 도로명 주소
	private var roadAddressEnglish = "" /// 영문 도로명 주소
	private var jibunAddressEnglish = "" /// 영문 지번 주소
	private var autoRoadAddressEnglish = "" /// autoRoadAddress의 영문 도로명 주소
	private var autoJibunAddressEnglish = "" /// autoJibunAddress의 영문 지번 주소
	private var sidoEnglish = "" /// 도/시 이름의 영문
	private var sigunguEnglish = "" /// 시/군/구 이름의 영문
	private var roadnameEnglish = "" /// 도로명 값, 검색 결과 중 선택한 도로명주소의 "도로명의 영문" 값이 들어갑니다.(
	private var bname = "" /// 법정동/법정리 이름
	private var bname2 = "" /// 법정동/법정리 이름
	private var sido = "" /// 도/시 이름
	private var sigungu = "" /// 시/군/구 이름
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension KakaoAddressViewController {
	override func userContentController(_ userContentController: WKUserContentController,
										didReceive message: WKScriptMessage) {
		if let data = message.body as? [String: Any] {
			addressEnglish = data["addressEnglish"] as? String ?? ""
			roadAddress = data["roadAddress"] as? String ?? ""
			sidoEnglish = data["sidoEnglish"] as? String ?? ""
			sigunguEnglish = data["sigunguEnglish"] as? String ?? ""
			roadnameEnglish = data["roadnameEnglish"] as? String ?? ""
			roadAddressEnglish = data["roadAddressEnglish"] as? String ?? ""
			jibunAddressEnglish = data["jibunAddressEnglish"] as? String ?? ""
			autoRoadAddressEnglish = data["autoRoadAddressEnglish"] as? String ?? ""
			autoJibunAddressEnglish = data["autoJibunAddressEnglish"] as? String ?? ""
			bname = data["bname"] as? String ?? ""
			bname2 = data["bname2"] as? String ?? ""
			sido = data["sido"] as? String ?? ""
			sigungu = data["sigungu"] as? String ?? ""
		}
		
		let geocoder = CLGeocoder()
		let address1 = "\(sidoEnglish) \(sigunguEnglish) \(roadnameEnglish)"
		let address2 = roadnameEnglish
		
		geocoder.geocodeAddressString(address1, completionHandler: {(placemarks, error) -> Void in
			if error != nil {
				geocoder.geocodeAddressString(address2, completionHandler: {(placemarks, error) -> Void in
					if error != nil {
						return
					}
					if let placemark = placemarks?.first {
						let coordinates = placemark.location?.coordinate
						self.delegate?.dismissKakaoAddressWebView(address: self.roadAddress,
																  coordinates: coordinates
																  ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
						self.dismiss(animated: true, completion: nil)
					}
				})
			} else {
				if let placemark = placemarks?.first {
					let coordinates = placemark.location?.coordinate
					self.delegate?.dismissKakaoAddressWebView(address: self.roadAddress,
															  coordinates: coordinates
															  ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
					self.dismiss(animated: true, completion: nil)
				}
			}
		})
	}
}


struct KakaoAddressViewControllerRepresentable: UIViewControllerRepresentable {
	typealias UIViewControllerType = KakaoAddressViewController

	let delegate: KakaoAddressViewDelegate
	
	func makeUIViewController(context: Context) -> KakaoAddressViewController {
		
		let viewController = KakaoAddressViewController(webViewTitle: "카카오",
														url: "https://ungchun.github.io/Kakao-Postcode/",
													 callBackKey: "callBackHandler")
		viewController.delegate = delegate
		return viewController
	}
	
	func updateUIViewController(_ uiViewController: KakaoAddressViewController, context: Context) {
		// Update the view controller if needed
	}
}

protocol KakaoAddressViewDelegate {
	func dismissKakaoAddressWebView(address: String, coordinates: CLLocationCoordinate2D)
}


class BaseWebViewController: UIViewController {
	
	private var webViewTitle: String?
	private var url: String?
	private var callBackKey: String?
	
	private lazy var webView: WKWebView = {
		let preferences = WKPreferences()
		preferences.javaScriptCanOpenWindowsAutomatically = true
		
		let contentController = WKUserContentController()
		contentController.add(self, name: self.callBackKey ?? "")
		
		let configuration = WKWebViewConfiguration()
		configuration.userContentController = contentController
		
		let webView = WKWebView(frame: self.view.bounds, configuration: configuration)
		webView.scrollView.contentInsetAdjustmentBehavior = .never
		return webView
	}()
	
	public let indicator = UIActivityIndicatorView(style: .medium)
	
	public init(webViewTitle: String?, url: String?, callBackKey: String = "") {
		self.webViewTitle = webViewTitle
		self.url = url
		self.callBackKey = callBackKey
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		addView()
		setLayout()
		setupView()
	}
	
	private func addView() {
		view.addSubview(webView)
		webView.addSubview(indicator)
	}
	
	private func setLayout() {
		webView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
		
		indicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
			indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
		])
	}
	
	private func setupView() {
		indicator.startAnimating()
		
		self.navigationItem.title = webViewTitle
		
		guard let url = URL(string: url ?? "https://www.naver.com/") else { return }
		let request = URLRequest(url: url)
		webView.scrollView.delegate = self
		webView.navigationDelegate = self
		webView.load(request)
	}
}

extension BaseWebViewController: UIScrollViewDelegate {
	
	public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
		scrollView.pinchGestureRecognizer?.isEnabled = false
	}
}

extension BaseWebViewController: WKNavigationDelegate {
	
	public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		indicator.startAnimating()
	}
	
	public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		indicator.stopAnimating()
	}
}

extension BaseWebViewController: WKScriptMessageHandler {
	
	open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
	}
}
