import SwiftUI

struct HistoryModel: View {
	
	var destination: String
	var address: String
	var buttonName: String
	
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 8) {
				Text(destination)
					.font(.system(size: 16))
				Text(address)
					.font(.system(size: 12))
			}
			Spacer()
			Button {
				
			} label: {
				Rectangle()
					.stroke(Color.black)
					.frame(width: 52, height: 40)
					.cornerRadius(8)
					.background(Color.clear)
					.overlay(
						Text(buttonName)
							.foregroundColor(Color.black)
					)
			}
		}
		.padding(.all, 20)
		Divider()
	}
}
