import SwiftUI

struct DepartOrArriveView: View {
	
	var title: String
	var description: String
	var isSelected: Bool
	var TogetherImage: String
	
	var body: some View {
		ZStack {
			Rectangle()
				.stroke(isSelected ? Color.blue : Color.white, lineWidth: 2)
				.background(Color.blue.opacity(isSelected ? 0.08 : 0))
				.shadow(color: .black.opacity(0.4), radius: 4, x: -2, y: -2)
				.frame(width: 180, height: 252)
				.overlay(
					VStack {
						Image(TogetherImage)
							.frame(width: 120, height: 100)
							.padding(.top, 28)
						Spacer()
						Text(title)
							.foregroundColor(.black)
							.bold()
							.font(.system(size: 16))
							.padding(.bottom, 8)
						Text(description)
							.foregroundColor(.black)
							.font(.system(size: 12))
							.multilineTextAlignment(.center)
							.padding(.bottom, 16)
						Spacer()
					}
				)
			Rectangle()
				.stroke(isSelected ? Color.blue : Color.black.opacity(0.4), lineWidth: 2)
				.frame(width: 28, height: 28)
				.background(isSelected ? .blue : .clear)
				.offset(x: -68, y: -104)
				.overlay(
					Image(systemName: "checkmark")
						.frame(width: 11)
						.foregroundColor(isSelected ? .white : .clear)
						.offset(x: -68, y: -104)
				)
		}
	}
}
