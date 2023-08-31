import SwiftUI

// 도착지 동일
struct CheckUserAndStartPointView: View {
    
    @ObservedObject private var viewModel = DestinationViewModel()
    
    @State private var users: [User] = []
    
    var body: some View {
        
        VStack {
            Spacer()
                .frame(height: 20)
            ForEach(viewModel.userDatas.indices, id: \.self) { index in
                UserListView(users: viewModel.userDatas[index])
                    .padding(.bottom, 8)
            }
            
            Spacer()
                .frame(height: 100)
            
            DestinaionPointView()
        }
        .onAppear {
            if !viewModel.setDestinationState {
                Task {
                    try await viewModel.initSameDestinationDestination()
                }
            }
        }
        .padding(.horizontal, 20)
        
        Spacer()
        
        NavigationButton()
    }
    
    @ViewBuilder
    func DestinaionPointView() -> some View {
        Rectangle()
            .fill(.blue.opacity(0.1))
            .cornerRadius(100)
            .frame(height: 48)
            .overlay {
                HStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: 4, height: 4)
                    Text("도착지: 경기도 성남시 판교역로 152")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.blue)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding(.leading, 24)
            }
    }
    
    @ViewBuilder
    func UserListView(users: [User]) -> some View {
        Rectangle()
            .fill(.white)
            .shadow(color: .gray.opacity(0.2), radius: 8)
            .frame(height: 68)
            .border(users.first!.destination == "출발지 입력 전" ? .clear : .blue, width: 1)
            .overlay {
                HStack(alignment: .center, spacing: 0) {
                    userImageView(users: users)
                        .frame(width: 60)
                    
                    Spacer()
                        .frame(width: 20)
                    
                    UserNameView(users: users)
                    
                    Spacer()
                    
                    Text(users[0].destination)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.trailing, 8)
                }
                .padding()
            }
    }
    
    @ViewBuilder
    func userImageView(users: [User]) -> some View {
        ZStack(alignment: .leading) {
            Image(users[0].userImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 48, height: 48)
                .overlay {
                    Circle()
                        .fill(users[0].destination == "출발지 입력 전" ? .clear : .black.opacity(0.5))
                        .overlay {
                            Text(users[0].destination == "출발지 입력 전" ? "" : "완료")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                }
        }
    }
    
    @ViewBuilder
    func UserNameView(users: [User]) -> some View {
        ForEach(users.indices, id: \.self) { index in
            if users[index].isHost {
                Text(users[index].userName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(users[index].destination == "출발지 입력 전" ? .gray.opacity(0.5) : .black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue.opacity(0.5))
                            .frame(width: 40, height: 16)
                            .overlay {
                                Text("결제담당")
                                    .font(.system(size: 8))
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 36)
                    }
                if index != users.count-1 {
                    Text(", ")
                }
            } else {
                Text(users[index].userName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(users[index].destination == "출발지 입력 전" ? .gray.opacity(0.5) : .black)
                if index != users.count-1 {
                    Text(", ")
                }
            }
        }
    }
    
    @ViewBuilder
    func NavigationButton() -> some View {
        if viewModel.setDestinationState {
            NavigationLink(
                destination: SameDestinationPathView(users: $users)
                    .navigationBarBackButtonHidden(true)
            ) {
                Rectangle()
                    .cornerRadius(4)
                    .frame(height: 48)
                    .padding(.horizontal, 20)
                    .overlay {
                        Text("최적 경로 확인하기")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
            }
        } else {
            NavigationLink(
                destination: InputStartPointOrDestinationView(viewModel: viewModel,
                                                              users: $users,
                                                              inputState: .sameDestination)
            ) {
                Rectangle()
                    .cornerRadius(4)
                    .frame(height: 48)
                    .padding(.horizontal, 20)
                    .overlay {
                        Text("나의 출발지 입력하기")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
            }
        }
    }
}

