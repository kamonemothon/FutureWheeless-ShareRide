import Foundation
import Alamofire

enum InputState {
    case none
    case sameStart
    case sameDestination
}

final class DestinationViewModel: ObservableObject {
    @Published var setDestinationState: Bool = false
    @Published var userDatas: [[User]] = []
    @Published var lineDatas: [Double] = []
    
    @MainActor
    func initSameStartDestination() async throws {
        var modifiedUserDatas: [[User]] = []
        
        for user in mockSameStartInitUsers {
            modifiedUserDatas.append([user])
        }
        userDatas = modifiedUserDatas
    }
    
    @MainActor
    func initSameDestinationDestination() async throws {
        var modifiedUserDatas: [[User]] = []
        
        for user in mockSameDestinationInitUsers {
            modifiedUserDatas.append([user])
        }
        userDatas = modifiedUserDatas
    }
    
    @MainActor
    func afterParticipationFetch(inputState: InputState) async throws -> [User] {
        var userDict: [String: [User]] = [:]
        var users: [User] = []
        
        if inputState == .sameStart {
            users = try await multipleDestinationAPIRequest(users: mockSameStartFetchUsers)
            for user in users {
                if var existingUsers = userDict[user.destination] {
                    existingUsers.append(user)
                    userDict[user.destination] = existingUsers
                } else {
                    userDict[user.destination] = [user]
                }
            }
            
            var modifiedUserDatas: [[User]] = []
            
            for (_, users) in userDict {
                modifiedUserDatas.append(users)
            }
            
            let sortedUserDatas = modifiedUserDatas.sorted { $0.count > $1.count }
            userDatas = sortedUserDatas
        } else {
            users = try await multipleOriginAPIRequest(users: mockSameDestinationFetchUsers)
            
            let sortedUsers = users.sorted { $0.isHost && !$1.isHost }
            let usersAsArray: [[ShareRide.User]] = sortedUsers.map { [$0] }
            
            userDatas = usersAsArray
        }
        self.setDestinationState = true
        
        print("users \(users)")
        
        return users
    }
    
    @MainActor
    func fetchOptimumPath(inputState: InputState, users: [User]) async throws {
        var userDict: [String: [User]] = [:]
        
        for user in users {
            if var existingUsers = userDict[user.destination] {
                existingUsers.append(user)
                userDict[user.destination] = existingUsers
            } else {
                userDict[user.destination] = [user]
            }
        }
        
        var modifiedUserDatas: [[User]] = []
        for (_, users) in userDict {
            modifiedUserDatas.append(users)
        }
        
        if inputState == .sameStart {
            userDatas = modifiedUserDatas.sorted { $0.first!.distance < $1.first!.distance }
            var uniqueDestinations: [String: ShareRide.User] = [:]
            for users in userDatas {
                if let user = users.first, uniqueDestinations[user.destination] == nil {
                    uniqueDestinations[user.destination] = user
                }
            }
            let resultArray = Array(uniqueDestinations.values)
            
            let sortData = resultArray.sorted { $0.distance < $1.distance }
            
            lineDatas = try await multipleStopsAPIRequest(inputState: .sameStart,
                                                          userDatas: sortData)
        } else {
            userDatas = modifiedUserDatas.sorted { $0.first!.distance > $1.first!.distance }
            let sortData = userDatas.flatMap { $0 }.sorted { $0.distance > $1.distance }
            lineDatas = try await multipleStopsAPIRequest(inputState: .sameStart,
                                                          userDatas: sortData)
        }
        self.setDestinationState = true
    }
}

