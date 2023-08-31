import Foundation

struct MSWaypoint: Codable {
	let name: String
	let x: Double
	let y: Double
}

struct MSLocation: Codable {
	let name: String
	let x: Double
	let y: Double
}

struct MSRouteSummary: Codable {
	let origin: MSLocation
	let destination: MSLocation
	let waypoints: [MSWaypoint]
}

struct MSRouteSection: Codable {
	let distance: Int
	let duration: Int
	let roads: [MSRoad]
}

struct MSRoad: Codable {
	let name: String
	let distance: Int
	let duration: Int
	let traffic_speed: Int
	let traffic_state: Int
	let vertexes: [Double]
}

struct MSRoute: Codable {
	let result_code: Int
	let result_msg: String
	let summary: MSRouteSummary
	let sections: [MSRouteSection]
}

struct MSAPIResponse: Codable {
	let trans_id: String
	let routes: [MSRoute]
}
