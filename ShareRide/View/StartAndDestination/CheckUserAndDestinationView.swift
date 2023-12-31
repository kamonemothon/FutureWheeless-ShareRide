import SwiftUI

// 출발지 동일
struct CheckUserAndDestinationView: View {
    
    @ObservedObject private var viewModel = DestinationViewModel()
    
    @State private var users: [User] = []
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            StartPointView()
            
            Spacer()
                .frame(height: 100)
            
            ForEach(viewModel.userDatas.indices, id: \.self) { index in
                UserListView(users: viewModel.userDatas[index])
                    .padding(.bottom, 8)
            }
        }
        .onAppear {
            if !viewModel.setDestinationState {
                Task {
                    try await viewModel.initSameStartDestination()
                }
            }
        }
        .padding(.horizontal, 20)
        
        Spacer()
        
        NavigationButton()
            .navigationTitle("참여자 및 도착지")
    }
}

private extension CheckUserAndDestinationView {
    
    @ViewBuilder
    
    func StartPointView() -> some View {
        
        Rectangle()
            .fill(.blue.opacity(0.1))
            .cornerRadius(100)
            .frame(height: 48)
            .overlay {
                HStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 4, height: 4)
                    Text("출발지: 경기도 성남시 판교역로 152")
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
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .frame(height: 68)
            .border(users.first!.destination == "도착지 입력 전" ? .clear : .blue, width: 1)
            .overlay {
                HStack(alignment: .center, spacing: 0) {
                    UserImageView(users: users)
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
    func UserImageView(users: [User]) -> some View {
        ZStack(alignment: .leading) {
            ForEach(users.indices.reversed(), id: \.self) { index in
                Image(users[index].userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 48, height: 48)
                    .overlay {
                        Circle()
                            .fill(users[index].destination == "도착지 입력 전" ? .clear : .black.opacity(0.5))
                            .overlay {
                                Text(users[index].destination == "도착지 입력 전" ? "" : "완료")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                    }
                    .padding(.leading, index == 1 ? 20 : 0)
            }
        }
    }
    
    @ViewBuilder
    func UserNameView(users: [User]) -> some View {
        ForEach(users.indices, id: \.self) { index in
            if users[index].isHost {
                Text(users[index].userName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(users[index].destination == "도착지 입력 전" ? .gray.opacity(0.5) : .black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
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
                    .foregroundColor(users[index].destination == "도착지 입력 전" ? .gray.opacity(0.5) : .black)
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
                destination: SameStartPathView(users: $users)
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
                                                              inputState: .sameStart)
            ) {
                Rectangle()
                    .cornerRadius(4)
                    .frame(height: 48)
                    .padding(.horizontal, 20)
                    .overlay {
                        Text("나의 도착지 입력하기")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
            }
        }
        
    }
}

