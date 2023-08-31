import SwiftUI

struct HistoryModel: View {
    
    @Binding var afterKakaoNavigation: Bool
    
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
                afterKakaoNavigation = true
            } label: {
                Rectangle()
                    .stroke(Color.black.opacity(0.2))
                    .frame(width: 42, height: 30)
                    .background(Color.clear)
                    .overlay(
                        Text(buttonName)
                            .font(.system(size: 14))
                            .foregroundColor(Color.black)
                    )
            }
        }
        .padding(.all, 20)
        Divider()
    }
}

