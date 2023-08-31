//
//  SearchViewModel.swift
//  ShareRide
//
//  Created by 김예림 on 2023/09/01.
//

import Foundation
import Alamofire

final class SearchViewModel: ObservableObject {
    @Published var places: [Place] = []
    
    func fetchData() {
        let apiKey = "9d7fa0a4b8f541e26d891309ea4e77bf"
        let url = "https://dapi.kakao.com/v2/local/search/keyword.json"
        let parameters: [String: Any] = [
            "radius": 20000,
            "query": "카카오"
        ]
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(apiKey)"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        self.parseData(data)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func parseData(_ data: Data) {
        do {
            let response = try JSONDecoder().decode(SearchResponse.self, from: data)
            places = response.documents
        } catch {
            print("Error decoding: \(error)")
        }
    }
}
