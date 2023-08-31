import Foundation

struct MOAPIResponse: Codable {
	let trans_id: String
	let routes: [MORoute]
}

struct MORoute: Codable {
	let result_code: Int
	let result_msg: String
	let key: String
	let summary: MORouteSummary
}

struct MORouteSummary: Codable {
	let distance: Int
	let duration: Int
}

struct MOAPIRequest {
	let origins: [MOOrigin]
	let destination: MODestination
	let radius: Int
}

struct MOOrigin {
	let x: String
	let y: String
	let key: String
}

struct MODestination {
	let x: String
	let y: String
}
