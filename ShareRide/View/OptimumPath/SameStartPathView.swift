import SwiftUI

struct SameStartPathView: View {
	
	@ObservedObject private var viewModel = DestinationViewModel()
	
	@State private var isLoading = true
	
	@Binding var users: [User]
	
	var body: some View {
		ZStack(alignment: .bottom) {
			KakaoMapWrapper(mapState: .sameStart,
							userDatas: $viewModel.userDatas,
							lineDatas: $viewModel.lineDatas)
				.edgesIgnoringSafeArea(.vertical)
			
			BottomSheetView()
			
			if isLoading {
				Image("loading")
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
							isLoading = false
						}
					}
			}
		}
		.edgesIgnoringSafeArea(.bottom)
		.onAppear {
			Task {
				try await viewModel.fetchOptimumPath(inputState: .sameStart, users: users)
			}
		}
	}
}

private extension SameStartPathView {
	@ViewBuilder
	func BottomSheetView() -> some View {
		Rectangle()
			.fill(.white)
			.frame(height: 400)
			.overlay {
				VStack {
					Spacer()
					StartPointView()
						.padding(.horizontal, 20)
					Spacer()
					ForEach(viewModel.userDatas.indices, id: \.self) { index in
						HStack(spacing: 0) {
							Image(index == 0 ? "first" : index == 1 ? "second" : "third")
								.padding(.trailing, 5)
							UserListView(users: viewModel.userDatas[index])
								.padding(.leading, 5)
						}
						.padding(.horizontal, 10)
					}
					
					Spacer()
					
					Rectangle()
						.cornerRadius(5)
						.frame(height: 50)
						.padding(.horizontal, 20)
						.overlay {
							Text("택시 호출하기")
								.font(.system(size: 15, weight: .medium))
								.foregroundColor(.white)
						}
					Spacer()
				}
			}
	}
	
	@ViewBuilder
	func StartPointView() -> some View {
		Rectangle()
			.fill(.blue.opacity(0.1))
			.cornerRadius(100)
			.frame(height: 50)
			.overlay {
				HStack {
					Circle()
						.fill(.red)
						.frame(width: 10, height: 10)
					Text("출발지: 경기도 성남시 판교역로 152")
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
			.frame(height: 50)
			.border(.blue, width: 1)
			.overlay {
				HStack(alignment: .center, spacing: 0) {
					UserImageView(users: users)
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
	func UserImageView(users: [User]) -> some View {
		ZStack(alignment: .leading) {
			ForEach(users.indices.reversed(), id: \.self) { index in
				Image(users[index].userImage)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.clipShape(Circle())
					.frame(width: 40, height: 40)
					.padding(.leading, index == 1 ? 20 : 0)
			}
		}
	}
	
	@ViewBuilder
	func UserNameView(users: [User]) -> some View {
		ForEach(users.indices, id: \.self) { index in
			if users[index].isHost {
				Text(users[index].userName)
					.font(.system(size: 15, weight: .bold))
					.foregroundColor(.black)
				if index != users.count-1 {
					Text(", ")
				}
			} else {
				Text(users[index].userName)
					.font(.system(size: 15, weight: .bold))
					.foregroundColor(.black)
				if index != users.count-1 {
					Text(", ")
				}
			}
		}
	}
}
