import SwiftUI

struct TogetherOptionView: View {
	@State private var startCheckValue = true
	@State private var destinationCheckValue = false
	@State private var buttonText = "출발지 지정하기"
	@State private var startOrDestinationState = true
	
	@Environment(\.presentationMode) private var presentationMode
	
	var body: some View {
		NavigationView {
			ZStack {
				KakaoMapVCWrapper()
					.edgesIgnoringSafeArea(.all)
				VStack(alignment: .leading) {
					Spacer()
						.frame(height: 40)
					
					TopIntroductionView()
					
					Spacer()
						.frame(height: 40)
					
					Spacer()
					
					VStack {
						selectedStartOrDestinationView()
						
						Spacer()
						
						NavigationButton()
					}
					.frame(maxWidth: .infinity)
					.frame(height: 600)
				}
				.background(Color.white)
			}
		}
	}
}

private extension TogetherOptionView {
	@ViewBuilder
	func TopIntroductionView() -> some View {
		VStack(alignment: .leading) {
			HStack(spacing: 0) {
				Text("친구, 지인과 ")
					.font(.system(size: 30, weight: .medium))
				Text("함께 타기")
					.foregroundColor(.blue)
					.font(.system(size: 30, weight: .medium))
				Text("로")
					.font(.system(size: 30, weight: .medium))
			}
			Text("더욱 저렴하게 택시타기")
				.font(.system(size: 30, weight: .medium))
			HStack(spacing: 0) {
				Text("함께타기 서비스 ")
					.font(.system(size: 10, weight: .medium))
				Text("알아보기 >")
					.font(.system(size: 10))
			}
		}
		.padding(.leading, 20)
	}
	
	@ViewBuilder
	func selectedStartOrDestinationView() -> some View {
		HStack(spacing: 16) {
			DepartOrArriveView(title: "출발지 동일",
							   description: "출발지가 동일한 경우\n경유지를 통해 하차 하세요",
							   isSelected: startCheckValue,
							   TogetherImage: "departure")
			.onTapGesture {
				startOrDestinationState = true
				startCheckValue = true
				destinationCheckValue = false
				buttonText = "출발지 지정하기"
			}
			DepartOrArriveView(title: "도착지 동일",
							   description: "도착지가 동일한 경우\n경유지를 통해 픽업 하세요",
							   isSelected: destinationCheckValue,
							   TogetherImage: "arrival")
			.onTapGesture {
				startOrDestinationState = false
				destinationCheckValue = true
				startCheckValue = false
				buttonText = "도착지 지정하기"
			}
		}
	}
	
	@ViewBuilder
	func NavigationButton() -> some View {
		NavigationLink {
			DepartureView(isSelected: startOrDestinationState)
				.navigationTitle(startOrDestinationState ? "출발지 지정" : "도착지 지정")
		} label: {
			Text(buttonText)
				.foregroundColor(.white)
				.font(.system(size: 16))
				.frame(width: 344, height: 52)
				.background(Color.blue)
				.cornerRadius(4)
				.padding(.bottom, 36)

		}
	}
}
