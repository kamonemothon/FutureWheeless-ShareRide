import SwiftUI

struct ShareView: View {
	@State var isModalPresented = false
	@State public var showModal = false
	
	var startDestinationState: Bool
	
	var body: some View {
		ZStack {
			KakaoMapVCWrapper()
				.edgesIgnoringSafeArea(.all)
			VStack(spacing: 0){
				BackbuttonView()
				Spacer()
				Sharebuttons()
				SharebottomView()
			}
		}
		
		if startDestinationState {
			NavigationLink(destination: CheckUserAndDestinationView(), isActive: $isModalPresented) { }
		} else {
			NavigationLink(destination: CheckUserAndStartPointView(), isActive: $isModalPresented) { }
		}
	}
}

private extension ShareView {
	@ViewBuilder
	func BackbuttonView()  -> some View {
		HStack{
			Button {
				
			} label: {
				Circle()
					.foregroundColor(.white)
					.frame(width: 37, height: 37)
					.shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
					.overlay(Image(systemName: "arrow.left")
						.font(Font.system(size: 18))
						.foregroundColor(.black)
					)
			}
			Spacer()
		}
		.padding()
	}
	
	@ViewBuilder
	func Sharebuttons() -> some View {
		HStack{
			Button {
				
			} label: {
				Rectangle()
					.foregroundColor(.clear)
					.frame(width: 80, height: 37)
					.background(.white)
					.cornerRadius(30)
					.shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
					.overlay(
						HStack{
							Image(systemName: "person.2")
								.font(Font.system(size: 14, weight: .bold))
								.foregroundColor(.black)
							Spacer()
								.frame(width: 5)
							Text("함께")
								.font(
									Font.custom("Apple SD Gothic Neo", size: 14)
										.weight(.medium)
								)
								.foregroundColor(.black)
						})
			}
			
			Button {
				
			} label: {
				Rectangle()
					.foregroundColor(.clear)
					.frame(width: 80, height: 37)
					.background(.white)
					.cornerRadius(30)
					.shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
					.overlay(
						HStack{
							Image(systemName: "calendar.badge.clock")
								.font(Font.system(size: 14, weight: .bold))
								.foregroundColor(.black)
							Spacer()
								.frame(width: 5)
							Text("예약")
								.font(
									Font.custom("Apple SD Gothic Neo", size: 14)
										.weight(.medium)
								)
								.foregroundColor(.black)
						})
			}
			
			Spacer()
			
			Circle()
				.foregroundColor(.white)
				.frame(width: 30, height: 30)
				.shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
				.overlay(Image(systemName: "location.circle")
					.font(Font.system(size: 18))
					.opacity(0.8))
			
		}
		.padding(10)
	}
	
	@ViewBuilder
	func SharebottomView() -> some View {
		Rectangle()
			.foregroundColor(.clear)
			.frame(width: 390, height: 180)
			.background(.white)
			.overlay(
				VStack(alignment: .leading) {
					if startDestinationState {
						HStack {
							Circle()
								.fill(.red)
								.frame(width: 5, height: 5)
							Text("출발지 : 카카오 모빌리티")
								.font(.system(size: 16, weight: .medium))
						}
					} else {
						HStack {
							Circle()
								.fill(.red)
								.frame(width: 5, height: 5)
							Text("도착지 : 카카오 모빌리티")
								.font(.system(size: 16, weight: .medium))
						}
					}
					
					Spacer()
						.frame(height: 60)
					
					Button {
						self.showModal = true
					} label: {
						Text("초대하고 함께 타기")
							.font(.system(size: 16))
							.frame(width: 347,height: 52)
							.foregroundColor(.white)
							.background(Color.blue)
							.cornerRadius(4)
							.sheet(isPresented: self.$showModal) {
								InviteView(showModal: $showModal, isModalPresented: $isModalPresented)
							}
					}
				}
					.padding(.top,35)
			)
	}
}
