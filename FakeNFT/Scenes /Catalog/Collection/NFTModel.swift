import Foundation

struct NftShort {
    let id: String
    let title: String
    let image: URL?
    let rating: Double
    let priceEth: Double
}

struct NftCollection {
    let id: String
    let title: String
    let cover: URL?
    let description: String
    let author: String
    let authorSite: URL?
    let items: [NftShort]
}

struct NftCollectionDTO: Decodable {
    let id: String
    let name: String
    let cover: String
    let description: String
    let author: String
    let authorLink: String?
    let nfts: [NftDTO]

    func toDomain() -> NftCollection {
        NftCollection(
            id: id,
            title: name,
            cover: URL(string: cover),
            description: description,
            author: author,
            authorSite: authorLink.flatMap(URL.init(string:)),
            items: nfts.map { $0.toDomain() }
        )
    }
}

struct NftDTO: Decodable {
    let id: String
    let name: String
    let images: [String]?
    let rating: Double?
    let price: Double?

    func toDomain() -> NftShort {
        NftShort(
            id: id,
            title: name,
            image: images?.first.flatMap(URL.init(string:)),
            rating: rating ?? 0,
            priceEth: price ?? 0
        )
    }
}

struct CollectionRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(RequestConstants.baseURL)/api/v1/collections/\(id)") }
    var httpMethod: HttpMethod { .get }
    var dto: Dto? { nil }
}
