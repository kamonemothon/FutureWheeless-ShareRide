import SwiftUI

struct DepartOrArriveView: View {
    
    @Binding var startCheckValue: Bool
    @Binding var destinationCheckValue: Bool
    
    @Binding var buttonText: String
    @Binding var startOrDestinationState: Bool
    
    var body: some View {
        
        HStack {
            
            Image(startCheckValue ? "departOn" : "departOff")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 176, height: 268)
                .onTapGesture {
                    startOrDestinationState = true
                    startCheckValue = true
                    destinationCheckValue = false
                    buttonText = "출발/도착지 지정하기"
                }
            
            Image(destinationCheckValue ? "arriveOn" : "arriveOff")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 176, height: 268)
                .onTapGesture {
                    startOrDestinationState = false
                    destinationCheckValue = true
                    startCheckValue = false
                    buttonText = "출발/도착지 지정하기"
                }
        }
    }
}

