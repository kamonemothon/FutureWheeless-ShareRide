import Foundation

// 카카오 모빌리티
// 37.3942237, 127.1103225

// 넥슨
// 37.4020016, 127.1035125

// 스마일 게이트
// 37.4024887, 127.1122009

// 만도
// 37.4042266, 127.1008524

// SK
// 37.405725, 127.0983423

let mockSameStartInitUsers: [User] = [
    User(id: 1, isHost: true, userName: "박지은", userImage: "UserImage1", destination: "도착지 입력 전", x: "", y: "", distance: 0),
    User(id: 2, isHost: false, userName: "조예린", userImage: "UserImage2", destination: "스마일게이트", x: "37.4024887", y: "127.1122009", distance: 0),
    User(id: 3, isHost: false, userName: "이지은", userImage: "UserImage3", destination: "만도", x: "37.4042266", y: "127.1008524", distance: 0),
    User(id: 4, isHost: false, userName: "김예림", userImage: "UserImage4", destination: "넥슨", x: "37.4020016", y: "127.1035125", distance: 0)
]

let mockSameDestinationInitUsers: [User] = [
    User(id: 1, isHost: true, userName: "박지은", userImage: "UserImage1", destination: "출발지 입력 전", x: "", y: "", distance: 0),
    User(id: 2, isHost: false, userName: "조예린", userImage: "UserImage2", destination: "스마일게이트", x: "37.4024887", y: "127.1122009", distance: 0),
    User(id: 3, isHost: false, userName: "이지은", userImage: "UserImage3", destination: "만도", x: "37.4042266", y: "127.1008524", distance: 0),
    User(id: 4, isHost: false, userName: "김예림", userImage: "UserImage4", destination: "SK", x: "37.405725", y: "127.0983423", distance: 0)
]

let mockStartPointAndDestination: DestinationModel = DestinationModel(id: 0, userName: "", userImage: "", destination: "카카오 모빌리티", x: "37.3942237", y: "127.1103225")

let mockSameStartFetchUsers: [User] = [
    User(id: 1, isHost: true, userName: "박지은", userImage: "UserImage1", destination: "넥슨", x: "37.4020016", y: "127.1035125", distance: 0),
    User(id: 2, isHost: false, userName: "조예린", userImage: "UserImage2", destination: "스마일게이트", x: "37.4024887", y: "127.1122009", distance: 0),
    User(id: 3, isHost: false, userName: "이지은", userImage: "UserImage3", destination: "만도", x: "37.4042266", y: "127.1008524", distance: 0),
    User(id: 4, isHost: false, userName: "김예림", userImage: "UserImage4", destination: "넥슨", x: "37.4020016", y: "127.1035125", distance: 0)
]

let mockSameDestinationFetchUsers: [User] = [
    User(id: 1, isHost: true, userName: "박지은", userImage: "UserImage1", destination: "넥슨", x: "37.4020016", y: "127.1035125", distance: 0),
    User(id: 2, isHost: false, userName: "조예린", userImage: "UserImage2", destination: "스마일게이트", x: "37.4024887", y: "127.1122009", distance: 0),
    User(id: 3, isHost: false, userName: "이지은", userImage: "UserImage3", destination: "만도", x: "37.4042266", y: "127.1008524", distance: 0),
    User(id: 4, isHost: false, userName: "김예림", userImage: "UserImage4", destination: "SK", x: "37.405725", y: "127.0983423", distance: 0)
]

let mockDestinationList: [DestinationModel] = [
    DestinationModel(id: 1, userName: "조예린", userImage: "UserImage2", destination: "넥슨", x: "", y: ""),
    DestinationModel(id: 2, userName: "이지은", userImage: "UserImage3", destination: "스마일게이트", x: "", y:""),
    DestinationModel(id: 3, userName: "김예림", userImage: "UserImage4", destination: "만도", x: "", y: "")
]

