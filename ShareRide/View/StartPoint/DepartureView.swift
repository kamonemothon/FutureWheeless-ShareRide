import SwiftUI
import CoreLocation

struct DepartureView: View {
	@State private var kakaoAddressState = false
	@State private var text = ""
	@State private var showModal = false
	
	@State private var afterKakaoNavigation = false
	
	@SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

	var isSelected: Bool
	
	var body: some View {
		VStack {
			
			SearchView()
			
			HomeAndMapIcons()
			
			Rectangle()
				.fill(.gray.opacity(0.05))
				.frame(height: 10)
			
			Bookmark()
			
			RecentDetails()
			
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		
		NavigationLink(destination: ShareView(startDestinationState: isSelected)
			.navigationBarBackButtonHidden(),
					   isActive: $afterKakaoNavigation) {
			
		}
	}
}

private extension DepartureView {
	@ViewBuilder
	func SearchView() -> some View {
		HStack {
			Circle()
				.frame(width: 8, height: 8)
				.foregroundColor(isSelected ? .red : .blue)
				.padding(.leading, 20)
			
			TextField(isSelected ? "출발지 검색" : "도착지 검색", text: $text)
			Spacer()
		}
		.frame(width: 372, height: 48)
		.background(Color.gray.opacity(0.05))
		.cornerRadius(100)
		.padding(.vertical, 20)
		.onTapGesture {
			kakaoAddressState = true
		}
		.sheet(isPresented: self.$kakaoAddressState) {
			KakaoAddressViewControllerRepresentable(delegate: self)
		}
	}
	
	@ViewBuilder
	func HomeAndMapIcons() -> some View {
		HStack {
			Image(systemName: "house")
				.frame(width: 20)
			Text("집")
				.font(.system(size: 16))
			Spacer()
			Divider()
				.frame(height: 20)
			Image(systemName: "map")
				.frame(width: 20)
		}
		.padding(.horizontal, 20)
	}
	
	@ViewBuilder
	func Bookmark() -> some View {
		HStack {
			Text("즐겨찾기")
				.font(.system(size: 12))
				.padding(.leading, 20)
				.foregroundColor(.black.opacity(0.1))
			Spacer()
		}
		
		Divider()
		
		HistoryModel(destination: "자금성", address: "충북 충주시 예성로 323", buttonName: "도착")
	}
	
	@ViewBuilder
	func RecentDetails() -> some View {
		HStack {
			Text("최근 내역")
				.font(.system(size: 12))
				.padding(.leading, 20)
				.foregroundColor(.black.opacity(0.1))
			Spacer()
		}
		
		Divider()
		
		HistoryModel(destination: "더좋은세상", address: "서울특별시 송파구 올림픽로35가길 10", buttonName: "도착")
	}
}

extension DepartureView: KakaoAddressViewDelegate {
	func dismissKakaoAddressWebView(address: String, coordinates: CLLocationCoordinate2D) {
		afterKakaoNavigation = true
	}
}
