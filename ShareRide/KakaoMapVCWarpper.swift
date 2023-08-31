import Foundation
import SwiftUI

// 아무것도 없는 카카오 맵
struct KakaoMapVCWrapper: UIViewControllerRepresentable {
    
    var x: Double?
    var y: Double?
    var inputState: InputState?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return KakaoMapVC(x: x ?? 36.0141447,
                          y: y ?? 129.3257511,
                          inputState: (inputState ?? .none))
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class KakaoMapVC: UIViewController {
    
    init(x: Double, y: Double, inputState: InputState) {
        super.init(nibName: nil, bundle: nil)
        self.x = x
        self.y = y
        self.inputState = inputState
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var x: Double?
    var y: Double?
    var inputState: InputState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MTMapView(frame: self.view.frame)
        mapView.baseMapType = .standard

        if inputState != InputState.none {
            var pointArr: [MTMapPOIItem] = []
            let p1 = MTMapPOIItem()
            p1.markerType = .customImage
            p1.showDisclosureButtonOnCalloutBalloon = false
            p1.customImage = UIImage(named: inputState == .sameStart ? "start" : "arrive")
            p1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: x!, longitude: y!))
            pointArr.append(p1)
            mapView.addPOIItems(pointArr)
        }
        
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: x!, longitude: y!)), animated: false)
        
        self.view.addSubview(mapView)
    }
}

