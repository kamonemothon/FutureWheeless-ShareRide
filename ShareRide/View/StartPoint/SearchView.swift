import SwiftUI
import CoreLocation

struct SearchView: View {
    @State private var text = ""
    @State private var showModal = false
    
    @State private var afterKakaoNavigation = false
    
    @SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @StateObject var viewModel = SearchViewModel()
    
    var isSelected: Bool
    
    var body: some View {
        VStack {
            
            SearchView()
            
            HomeAndMapIcons()
            
            Rectangle()
                .fill(.gray.opacity(0.05))
                .frame(height: 10)
            
            ScrollView {
                Bookmark()
                
                RecentDetails()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        NavigationLink(destination: ShareView(startDestinationState: isSelected)
            .navigationBarBackButtonHidden(),
                       isActive: $afterKakaoNavigation) {
            
        }
    }
}

private extension SearchView {
    @ViewBuilder
    func SearchView() -> some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(isSelected ? .red : .blue)
                .padding(.leading, 20)
            
            TextField(isSelected ? "출발지 검색" : "도착지 검색", text: $text) {
                viewModel.fetchData()
            }
            Spacer()
        }
        .frame(width: 372, height: 48)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(100)
        .padding(.vertical, 20)
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
        
        HistoryModel(afterKakaoNavigation: $afterKakaoNavigation,
                     destination: "카카오 모빌리티",
                     address: "경기도 성남시 분당구 판교역로 152",
                     buttonName: "도착")
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
        
        if viewModel.places.isEmpty {
            HistoryModel(afterKakaoNavigation: $afterKakaoNavigation,
                         destination: "애플 디벨로퍼 아카데미",
                         address: "경상북도 포항시 남구 청암로 77",
                         buttonName: "도착")
        } else {
            ForEach(viewModel.places) { place in
                HistoryModel(afterKakaoNavigation: $afterKakaoNavigation,
                             destination: place.placeName!,
                             address: place.addressName ?? "",
                             buttonName: "도착")
            }
        }
    }
}
