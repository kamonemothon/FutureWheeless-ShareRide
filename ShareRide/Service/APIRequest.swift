import Foundation
import Alamofire

// 다중 출발지 길찾기
// 한 개 이상의 다중 출발지에서 하나의 목적지까지의 경로 안내 정보를 제공합니다. 최대 30개의 출발지를 추가할 수 있습니다.

func multipleOriginAPIRequest(users: [User]) async throws -> [User] {
    return try await withUnsafeThrowingContinuation { configuration in
        let restAPIKey = "9d7fa0a4b8f541e26d891309ea4e77bf"
        let baseURL = "https://apis-navi.kakaomobility.com/v1/origins/directions"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "KakaoAK \(restAPIKey)"
        ]
        
        var origins: [[String: Any]] = []
        users.forEach { user in
            let x = user.x
            let y = user.y
            let key = user.id-1
            origins.append([
                "x": y,
                "y": x,
                "key": String(describing: key)
            ])
        }
        
        let target = mockStartPointAndDestination
        
        let parameters: [String: Any] = [
            "origins": origins,
            "destination": [ // 카카오 모빌리티
                "x": target.y,
                "y": target.x
                           ],
            "radius": 5000
        ]
        
        AF.request(baseURL, method: .post, parameters: parameters,
                   encoding: JSONEncoding.default, headers: headers)
        .responseData { response in
            switch response.result {
            case .success(_):
                if let jsonData = response.data {
                    var sortedMockAfterUsers: [User] = []
                    do {
                        let decoder = JSONDecoder()
                        let apiResponse = try decoder.decode(MOAPIResponse.self, from: jsonData)
                        
                        let sortedRoutes = apiResponse.routes.sorted {
                            $0.summary.distance > $1.summary.distance
                        }
                        let sortedKeyOrder = sortedRoutes.map { $0.key }
                        let targetMockData = mockSameDestinationFetchUsers
                        sortedMockAfterUsers = targetMockData.sorted { user1, user2 in
                            guard let index1 = sortedKeyOrder.firstIndex(of: "\(user1.id-1)") else { return false }
                            guard let index2 = sortedKeyOrder.firstIndex(of: "\(user2.id-1)") else { return true }
                            return index1 < index2
                        }
                        for i in 0..<sortedRoutes.count {
                            sortedMockAfterUsers[i].distance = sortedRoutes[i].summary.distance
                        }
                        configuration.resume(returning: sortedMockAfterUsers)
                    } catch {
                        print("Decoding Error: \(error)")
                    }
                }
            case .failure(let error):
                print("API Failure: \(error)")
            }
        }
    }
}

// 다중 목적지 길찾기
// 하나의 출발지에서 한 개 이상의 다중 목적지까지의 경로 요약 정보를 제공합니다. 최대 30개의 목적지를 추가할 수 있습니다.

func multipleDestinationAPIRequest(users: [User]) async throws -> [User] {
    return try await withUnsafeThrowingContinuation { configuration in
        let restAPIKey = "9d7fa0a4b8f541e26d891309ea4e77bf"
        let baseURL = "https://apis-navi.kakaomobility.com/v1/destinations/directions"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "KakaoAK \(restAPIKey)"
        ]
        
        var destinations: [[String: Any]] = []
        users.forEach { user in
            let x = user.x
            let y = user.y
            let key = user.id-1
            destinations.append([
                "x": y,
                "y": x,
                "key": String(describing: key)
            ])
        }
        
        let target = mockStartPointAndDestination

        let parameters: [String: Any] = [
            "origin": [ // 카카오 모빌리티
                "x": target.y,
                "y": target.x
                      ],
            "destinations": destinations,
            "radius": 5000
        ]
        
        AF.request(baseURL, method: .post, parameters: parameters,
                   encoding: JSONEncoding.default, headers: headers)
        .responseData { response in
            switch response.result {
            case .success(_):
                if let jsonData = response.data {
                    var sortedMockAfterUsers: [User] = []
                    do {
                        let decoder = JSONDecoder()
                        let apiResponse = try decoder.decode(MOAPIResponse.self, from: jsonData)
                        
                        print("apiResponse \(apiResponse)")
                        print()
                        
                        let sortedRoutes = apiResponse.routes.sorted {
                            $0.summary.distance < $1.summary.distance
                        }
                        let sortedKeyOrder = sortedRoutes.map { $0.key }
                        let targetMockData = mockSameStartFetchUsers
                        sortedMockAfterUsers = targetMockData.sorted { user1, user2 in
                            guard let index1 = sortedKeyOrder.firstIndex(of: "\(user1.id-1)") else { return false }
                            guard let index2 = sortedKeyOrder.firstIndex(of: "\(user2.id-1)") else { return true }
                            return index1 < index2
                        }
                        for i in 0..<sortedRoutes.count {
                            sortedMockAfterUsers[i].distance = sortedRoutes[i].summary.distance
                        }
                        configuration.resume(returning: sortedMockAfterUsers)
                    } catch {
                        print("Decoding Error: \(error)")
                    }
                }
            case .failure(let error):
                print("API Failure: \(error)")
            }
        }
    }
}

// 다중 경유지 길찾기
// 하나의 출발지에서 하나의 목적지까지의 경로 안내 정보를 제공합니다. 최대 30개의 경유지를 추가할 수 있습니다.

func multipleStopsAPIRequest(inputState: InputState, userDatas: [User]) async throws -> [Double]  {
    return try await withUnsafeThrowingContinuation { configuration in
        var copyUserDatas = userDatas
        
        let restAPIKey = "9d7fa0a4b8f541e26d891309ea4e77bf"
        let url = "https://apis-navi.kakaomobility.com/v1/waypoints/directions"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "KakaoAK \(restAPIKey)"
        ]
        
        var waypoints: [[String: Any]] = []
        for (index, coordinate) in copyUserDatas.enumerated() {
            let waypoint: [String: Any] = [
                "name": "waypoint\(index)",
                "x": coordinate.y,
                "y": coordinate.x
            ]
            waypoints.append(waypoint)
        }
        
        let target = mockStartPointAndDestination
        
        var parameters: [String: Any] = [:]
        if inputState == .sameStart {
            let destination = copyUserDatas.removeLast()
            parameters = [
                "origin": [ // 카카오 모빌리티
                    "x": target.y,
                    "y": target.x
                          ],
                "destination": [
                    "x": destination.y,
                    "y": destination.x
                ],
                "waypoints": waypoints,
                "priority": "RECOMMEND",
                "car_fuel": "GASOLINE",
                "car_hipass": false,
                "alternatives": false,
                "road_details": false
            ]
        } else {
            let origin = copyUserDatas.removeFirst()
            parameters = [
                "origin": [
                    "x": origin.y,
                    "y": origin.x
                ],
                "destination": [ // 카카오 모빌리티
                    "x": target.y,
                    "y": target.x
                               ],
                "waypoints": waypoints,
                "priority": "RECOMMEND",
                "car_fuel": "GASOLINE",
                "car_hipass": false,
                "alternatives": false,
                "road_details": false
            ]
        }
        
        AF.request(url, method: .post, parameters: parameters,
                   encoding: JSONEncoding.default, headers: headers)
        .responseData { response in
            switch response.result {
            case .success(_):
                if let jsonData = response.data {
                    var allVertexes: [Double] = []
                    do {
                        let decoder = JSONDecoder()
                        let apiResponse = try decoder.decode(MSAPIResponse.self, from: jsonData)
                        apiResponse.routes.first?.sections.forEach({ sec in
                            let vertexes = sec.roads.flatMap { $0.vertexes }
                            allVertexes.append(contentsOf: vertexes)
                        })
                        configuration.resume(returning: allVertexes)
                    } catch {
                        print("Decoding Error: \(error)")
                    }
                }
            case .failure(let error):
                print("API Failure: \(error)")
            }
        }
    }
}


// 도착지가 같을 때 - 요금 정산
//do {
//    // JSON 데이터를 파싱하여 Swift 객체로 변환
//    let data = jsonResponse.data(using: .utf8)!
//    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//
//    // sections 배열의 마지막 값부터 반복하여 작업 수행
//    let sections = apiResponse.apiResponse.sections
//    var totalFare = 0.0
//    var dividingValue = Double(sections.count)
//
//    for (index, section) in sections.enumerated().reversed() {
//        let distance = Double(section.distance) / 1000.0  // m를 km로 변환
//
//        let distanceFare = distance * 763.4
//        let additionalFare = dividingValue * 200.0
//        let baseFare = (index == sections.count - 1) ? (4800 + (max(distance - 1.6, 0)) * 763.4) / dividingValue + additionalFare + 1000.0 : (distanceFare / dividingValue) + additionalFare + 1000.0
//
//        totalFare += baseFare
//
//        dividingValue -= 1.0
//
//        print("Distance:", distance, "Fare:", baseFare)
//    }
//
//    print("Total Fare:", totalFare)
//} catch {
//    print("Error:", error)
//}
