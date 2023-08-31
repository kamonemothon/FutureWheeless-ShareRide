import Foundation

struct User: Identifiable {
	var id: Int
	var isHost: Bool
	var userName: String
	var userImage: String
	var destination: String
	var x: String
	var y: String
	var distance: Int
}
