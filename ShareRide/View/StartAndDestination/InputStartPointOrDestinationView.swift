import SwiftUI

struct InputStartPointOrDestinationView: View {
	@Environment(\.presentationMode) private var presentationMode
	
	@StateObject var viewModel: DestinationViewModel
	
	@Binding var users: [User]
	
	var inputState: InputState
	
	var body: some View {
		VStack {
			OptimumPathSearchView()
			
			MiddleIconsView()
			
			Rectangle()
				.fill(.gray.opacity(0.05))
				.frame(height: 10)
			
			StopoverListTitleView(inputState: self.inputState)
			
			ForEach(mockDestinationList) { destination in
				StopoverListView(userName: destination.userName,
								 userImage: destination.userImage,
								 destination: destination.destination)
				.padding(.horizontal, 20)
			}
			
			Spacer()
		}
	}
}

private extension InputStartPointOrDestinationView {
	@ViewBuilder
	func OptimumPathSearchView() -> some View {
		Rectangle()
			.fill(.gray.opacity(0.05))
			.cornerRadius(100)
			.frame(height: 40)
			.overlay {
				HStack {
					Text("경유지 검색")
						.foregroundColor(.gray.opacity(0.5))
						.font(.system(size: 18))
					Spacer()
				}
				.padding(.leading, 30)
			}
			.padding(.horizontal, 10)
	}
	
	@ViewBuilder
	func MiddleIconsView() -> some View {
		HStack(spacing: 20) {
			HStack(spacing: 5) {
				Image(systemName: "house")
				Text("집")
					.font(.system(size: 12))
			}
			
			HStack(spacing: 5) {
				Image(systemName: "building")
				Text("회사")
					.font(.system(size: 12))
			}
			
			Spacer()
			
			HStack(spacing: 20) {
				Image(systemName: "viewfinder")
				Divider()
					.frame(height: 20)
				Image(systemName: "map")
			}
		}
		.padding(.horizontal, 20)
		.padding(.vertical, 10)
	}
	
	@ViewBuilder
	func StopoverListTitleView(inputState: InputState) -> some View {
		HStack {
			Text(inputState == .sameStart ? "경유지 목록" : "출발지 목록")
				.bold()
			Spacer()
			Text("편집")
				.foregroundColor(.gray)
		}
		.padding(.horizontal, 20)
		.padding(.vertical, 10)
	}
	
	@ViewBuilder
	func StopoverListView(userName: String,
						  userImage: String,
						  destination: String) -> some View {
		Rectangle()
			.fill(.white)
			.frame(height: 80)
			.overlay {
				HStack {
					Image(userImage)
						.resizable()
						.aspectRatio(contentMode: .fill)
						.clipShape(Circle())
						.frame(width: 50, height: 50)
					
					Text(destination)
						.font(.system(size: 14))
						.padding(.leading, 10)
					
					Spacer()
					
					Rectangle()
						.fill(.white)
						.border(.gray.opacity(0.5), width: 1)
						.frame(width: 50, height: 30)
						.overlay {
							Text("참여")
								.font(.system(size: 14))
								.onTapGesture {
									Task {
										users = try await viewModel.afterParticipationFetch(
											inputState: inputState
										)
										self.presentationMode.wrappedValue.dismiss()
									}
								}
						}
				}
			}
	}
}
