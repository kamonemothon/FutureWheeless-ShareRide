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
					.padding(.bottom, 10)
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
			.frame(height: 50)
			.overlay {
				HStack {
					Circle()
						.fill(.blue)
						.frame(width: 5, height: 5)
					Text("도착지: 경기도 성남시 판교역로 152")
						.font(.system(size: 16, weight: .medium))
						.foregroundColor(.blue)
						.padding(.leading, 10)
					Spacer()
				}
				.padding(.leading, 25)
			}
	}
	
	@ViewBuilder
	func UserListView(users: [User]) -> some View {
		Rectangle()
			.fill(.white)
			.shadow(color: .gray.opacity(0.2), radius: 10)
			.frame(height: 70)
			.border(users.first!.destination == "출발지 미지정" ? .clear : .blue, width: 1)
			.overlay {
				HStack(alignment: .center, spacing: 0) {
					userImageView(users: users)
						.frame(width: 60)
					
					Spacer()
						.frame(width: 20)
					
					UserNameView(users: users)
					
					Spacer()
					
					Text(users[0].destination)
						.font(.system(size: 15, weight: .bold))
						.foregroundColor(.blue)
						.padding(.trailing, 10)
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
				.frame(width: 50, height: 50)
				.overlay {
					Circle()
						.fill(users[0].destination == "출발지 미지정" ? .clear : .black.opacity(0.5))
						.overlay {
							Text(users[0].destination == "출발지 미지정" ? "" : "완료")
								.font(.system(size: 15, weight: .bold))
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
					.font(.system(size: 15, weight: .bold))
					.foregroundColor(users[index].destination == "출발지 미지정" ? .gray.opacity(0.5) : .black)
					.overlay {
						RoundedRectangle(cornerRadius: 10)
							.fill(.blue.opacity(0.5))
							.frame(width: 40, height: 15)
							.overlay {
								Text("결제담당")
									.font(.system(size: 8))
									.foregroundColor(.white)
							}
							.padding(.bottom, 35)
					}
				if index != users.count-1 {
					Text(", ")
				}
			} else {
				Text(users[index].userName)
					.font(.system(size: 15, weight: .bold))
					.foregroundColor(users[index].destination == "출발지 미지정" ? .gray.opacity(0.5) : .black)
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
					.cornerRadius(5)
					.frame(height: 50)
					.padding(.horizontal, 20)
					.overlay {
						Text("최적 경로 확인하기")
							.font(.system(size: 15, weight: .medium))
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
					.cornerRadius(5)
					.frame(height: 50)
					.padding(.horizontal, 20)
					.overlay {
						Text("나의 경유지 입력하기")
							.font(.system(size: 15, weight: .medium))
							.foregroundColor(.white)
					}
			}
		}
	}
}
