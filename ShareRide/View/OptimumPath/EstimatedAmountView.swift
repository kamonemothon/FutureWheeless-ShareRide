import SwiftUI

struct EstimatedAmountView: View {
    
    @State var uniqueDestinations: [String] = []
    @State var totalAmount = 0
    
    @Binding var users: [User]
    
    var inputState: InputState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
                .frame(height: 12)
            
            StartAndDestinationView()
            
            Spacer()
                .frame(height: 12)
            
            AddOptimumPathView()
            
            if inputState == .sameDestination {
                EstimatedPaymentAmountView()
            }
            
            Spacer()
            
            TotalExpectedAmount()
            
            CallTaxiButton()
        }
        .onAppear {
            for user in users {
                if !uniqueDestinations.contains(user.destination) {
                    uniqueDestinations.append(user.destination)
                }
            }
            totalAmount = users.reduce(0) { $0 + $1.distance }
        }
        .padding(.horizontal, 28)
    }
}

private extension EstimatedAmountView {
    @ViewBuilder
    func StartAndDestinationView() -> some View {
        Text("출발/도착")
            .font(.system(size: 16, weight: .medium))
        
        Rectangle()
            .fill(.gray.opacity(0.05))
            .cornerRadius(8)
            .frame(height: 148)
            .overlay {
                if inputState == .sameStart {
                    VStack {
                        HStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 4, height: 4)
                            Text("카카오 모빌리티")
                                .foregroundColor(.blue)
                                .font(.system(size: 12))
                            Spacer()
                        }
                        ForEach(uniqueDestinations.indices, id: \.self) { index in
                            HStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                                    .frame(width: 4, height: 4)
                                Text("\(uniqueDestinations[index])")
                                    .font(.system(size: 12))
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                } else {
                    VStack {
                        ForEach(uniqueDestinations.indices, id: \.self) { index in
                            HStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                                    .frame(width: 4, height: 4)
                                Text("\(uniqueDestinations[index])")
                                    .font(.system(size: 12))
                                Spacer()
                            }
                        }
                        HStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 4, height: 4)
                            Text("카카오 모빌리티")
                                .foregroundColor(.blue)
                                .font(.system(size: 12))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    
                }
            }
    }
    
    @ViewBuilder
    func AddOptimumPathView() -> some View {
        Text("경유지 추가")
            .font(.system(size: 16, weight: .medium))
        
        Text("- 출발/도착지가 추가될 때 금액 1000원이 들어가요.")
            .foregroundColor(.gray)
            .font(.system(size: 8))
        Text("- 기사님이 경유지마다 고객님의 하차와 탑승을 확인합니다.")
            .foregroundColor(.gray)
            .font(.system(size: 8))
        
        Rectangle()
            .fill(.gray.opacity(0.05))
            .cornerRadius(10)
            .frame(height: 48)
            .overlay {
                HStack {
                    Text(inputState == .sameStart ? "추가 경유지 x3" : "추가 경유지 x4")
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .bold))
                    Spacer()
                    Text(inputState == .sameStart ? "3000원" : "4000원")
                        .foregroundColor(.blue)
                        .font(.system(size: 12))
                }
                .padding(.horizontal, 16)
            }
    }
    
    @ViewBuilder
    func EstimatedPaymentAmountView() -> some View {
        VStack(alignment: .trailing) {
            ForEach(users) { user in
                UserListView(users: user)
                Text("예상금액 \(user.distance)원~")
                    .foregroundColor(.blue)
                    .font(.system(size: 12))
            }
        }
    }
    
    @ViewBuilder
    func UserListView(users: User) -> some View {
        Rectangle()
            .fill(.white)
            .frame(height: 40)
            .border(.blue, width: 1)
            .overlay {
                HStack(alignment: .center, spacing: 0) {
                    UserImageView(users: users)
                        .frame(width: 60)
                    
                    Spacer()
                        .frame(width: 20)
                    
                    UserNameView(users: users)
                    
                    Spacer()
                    
                    Text(users.destination)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.trailing, 8)
                }
                .padding()
            }
    }
    
    @ViewBuilder
    func UserImageView(users: User) -> some View {
        Image(users.userImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .frame(width: 28, height: 30)
            .padding(.leading, 10)
    }
    
    @ViewBuilder
    func UserNameView(users: User) -> some View {
        Text(users.userName)
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.black)
    }
    
    @ViewBuilder
    func TotalExpectedAmount() -> some View {
        HStack(alignment: .center) {
            Spacer()
            Text("총 예상 금액")
                .foregroundColor(.blue)
                .font(.system(size: 10))
            Text("\(String(describing: totalAmount))원")
                .foregroundColor(.blue)
                .font(.system(size: 20, weight: .medium))
            Spacer()
        }
        .padding(.bottom, 8)
    }
    
    @ViewBuilder
    func CallTaxiButton() -> some View {
        NavigationLink {
            PaymentOneView()
                .navigationBarBackButtonHidden()
        } label: {
            Rectangle()
                .fill(.blue)
                .cornerRadius(4)
                .frame(height: 48)
                .padding(.horizontal, -10)
                .overlay {
                    Text("택시 호출하기")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
        }
        
    }
}

