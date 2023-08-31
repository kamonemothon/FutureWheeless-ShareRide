import SwiftUI

struct TogetherOptionView: View {
    @State private var startCheckValue = true
    @State private var destinationCheckValue = false
    @State private var buttonText = "출발지 지정하기"
    @State private var startOrDestinationState = true
    
    @Environment(\.presentationMode) private var presentationMode
    
    @Environment(\.dismiss) private var dismiss
    
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
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                }
            }
        }
        
//        @Environment(\.dismiss) private var dismiss

    }
}

private extension TogetherOptionView {
    @ViewBuilder
    func TopIntroductionView() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text("친구, 지인과 ")
                    .font(.system(size: 28, weight: .medium))
                Text("함께 타기")
                    .foregroundColor(.blue)
                    .font(.system(size: 28, weight: .medium))
                Text("로")
                    .font(.system(size: 28, weight: .medium))
            }
            Text("더욱 저렴하게 택시타기")
                .font(.system(size: 28, weight: .medium))
            HStack(spacing: 0) {
                Text("함께타기 서비스 ")
                    .font(.system(size: 12, weight: .medium))
                Text("알아보기 >")
                    .font(.system(size: 12))
            }
            .padding(.top, 4)
        }
        .padding(.leading, 28)
        .padding(.top, 12)
    }
    
    @ViewBuilder
    func selectedStartOrDestinationView() -> some View {
        
        DepartOrArriveView(startCheckValue: $startCheckValue, destinationCheckValue: $destinationCheckValue, buttonText: $buttonText, startOrDestinationState: $startOrDestinationState)
    }
    
    @ViewBuilder
    func NavigationButton() -> some View {
        NavigationLink {
            SearchView(isSelected: startOrDestinationState)
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

