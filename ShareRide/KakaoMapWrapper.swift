import Foundation
import SwiftUI

enum MapState {
    case none
    case sameStart
    case sameDestination
}

// 최적 경로가 그려진 카카오 맵
struct KakaoMapWrapper: UIViewRepresentable {

    @State var mapState: MapState

    @Binding var userDatas: [[User]]
    @Binding var lineDatas: [Double]

    let mapView = KakaoMapView()

    func makeUIView(context: Context) -> some UIView {
        mapView.baseMapType = .standard
        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

        if mapState != .none {
            var pointArr: [MTMapPOIItem] = []

            var cnt = 1

            let p1 = MTMapPOIItem()
            p1.markerType = .customImage
            p1.showDisclosureButtonOnCalloutBalloon = false
            p1.customImage = UIImage(named: mapState == .sameStart ? "start" : "arrive")
            p1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double( mockStartPointAndDestination.x)!, longitude: Double( mockStartPointAndDestination.y)!))
            pointArr.append(p1)

            userDatas.forEach { users in
                let p1 = MTMapPOIItem()
                p1.showDisclosureButtonOnCalloutBalloon = false
                p1.markerType = .customImage

                if mapState == .sameStart {
                    switch cnt {
                    case 1:
                        p1.customImage = UIImage(named: "first")
                        break
                    case 2:
                        p1.customImage = UIImage(named: "second")
                        break
                    case 3:
                        p1.customImage = UIImage(named: "third")
                        break
                    default:
                        break
                    }
                } else {
                    switch cnt {
                    case 1:
                        p1.customImage = UIImage(named: "first")
                        break
                    case 2:
                        p1.customImage = UIImage(named: "second")
                        break
                    case 3:
                        p1.customImage = UIImage(named: "third")
                        break
                    case 4:
                        p1.customImage = UIImage(named: "four")
                        break
                    default:
                        break
                    }
                }

                p1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(users.first!.x)!, longitude: Double(users.first!.y)!))
                pointArr.append(p1)
                cnt += 1
            }

            if !pointArr.isEmpty {
                mapView.addPOIItems(pointArr)
            }

            let polyline = MTMapPolyline.polyLine()

            polyline?.polylineColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.8)

            var points: [MTMapPoint] = []

            for i in stride(from: 0, to: lineDatas.count, by: 2) {
                let longitude = lineDatas[i]
                let latitude = lineDatas[i + 1]
                let geoCoord = MTMapPointGeo(latitude: latitude, longitude: longitude)
                if let mapPoint = MTMapPoint(geoCoord: geoCoord) {
                    points.append(mapPoint)
                }
            }

            polyline?.addPoints(points)

            mapView.addPolyline(polyline)

//            mapView.fitAreaToShowAllPOIItems()
            mapView.fitAreaToShowAllPolylines()

//            mapView.setMapCenter(pointArr.first?.mapPoint, animated: false)
            mapView.setZoomLevel(4, animated: false)

            mapView.needsUpdateConstraints()

        }
    }
}

class KakaoMapView: MTMapView {
    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}

