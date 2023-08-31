import Foundation

struct Place: Identifiable, Codable {
    let placeName: String?
    let distance: String?
    let placeURL: String?
    let categoryName: String?
    let addressName: String?
    let roadAddressName: String?
    let id: String?
    let phone: String?
    let categoryGroupCode: String?
    let categoryGroupName: String?
    let x: String?
    let y: String?
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case distance
        case placeURL = "place_url"
        case categoryName = "category_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case id
        case phone
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case x
        case y
    }
}

struct SearchResponse: Codable {
    let documents: [Place]
    let meta: Meta
}

struct Meta: Codable {
    let pageableCount: Int
    let totalCount: Int
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
        case isEnd = "is_end"
    }
}
