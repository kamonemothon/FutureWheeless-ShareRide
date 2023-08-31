import SwiftUI

struct ButtonModel: View {
	
	var buttonSystemImage: Image
	var buttonName: String
	
	var body: some View {
		Rectangle()
			.foregroundColor(.clear)
			.frame(width: 80, height: 36)
			.background(.white)
			.cornerRadius(32)
			.shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
			.overlay(
				HStack{
					Text(buttonSystemImage)
						.font(Font.system(size: 12, weight: .bold))
						.foregroundColor(.black)
					Spacer()
						.frame(width: 5)
					Text(buttonName)
						.font(.system(size: 12))
						.fontWeight(.medium)
						.foregroundColor(.black)
				})
	}
}
