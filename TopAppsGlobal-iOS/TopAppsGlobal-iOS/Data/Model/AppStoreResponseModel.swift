//
//  AppStoreResponseModel.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

// MARK: - AppStoreResponseDTO
struct AppStoreResponseDTO: Decodable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Decodable {
    let author: Author
    let entry: [Entry]
}

// MARK: - Author
struct Author: Decodable {
    let name: LabelWrapper
    let uri: LabelWrapper
}

// MARK: - Entry (각 앱 항목)
struct Entry: Decodable {
    let imName: LabelWrapper
    let imImage: [Image]
    let summary: LabelWrapper?
    let imPrice: PriceWrapper?
    let imContentType: AttributesWrapper?
    let rights: LabelWrapper?
    let title: LabelWrapper
    let link: LinkContainer
    let id: IdWrapper
    let imArtist: LabelWrapper?
    let category: Category
    let imReleaseDate: ReleaseDate

    enum CodingKeys: String, CodingKey {
        case imName = "im:name"
        case imImage = "im:image"
        case summary
        case imPrice = "im:price"
        case imContentType = "im:contentType"
        case rights
        case title
        case link
        case id
        case imArtist = "im:artist"
        case category
        case imReleaseDate = "im:releaseDate"
    }
}

// MARK: - 공통 래퍼 (Only label 만 있는 경우)
struct LabelWrapper: Decodable {
    let label: String
}

// MARK: - 이미지
struct Image: Decodable {
    let label: String
    let attributes: ImageAttributes
}

struct ImageAttributes: Decodable {
    let height: String
}

// MARK: - 가격 정보
struct PriceWrapper: Decodable {
    let label: String
    let attributes: PriceAttributes
}

struct PriceAttributes: Decodable {
    let amount: String
    let currency: String
}

// MARK: - im:contentType (attributes만 있는 경우)
struct AttributesWrapper: Decodable {
    let attributes: Attributes
}

struct Attributes: Decodable {
    let term: String
    let label: String
}

// MARK: - Link 처리 (단일 객체 또는 배열)
struct LinkContainer: Decodable {
    let links: [AppLink]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        // Link가 단일 객체로 올 수 있음
        if let singleLink = try? container.decode(AppLink.self) {
            self.links = [singleLink]
        } else {
            self.links = try container.decode([AppLink].self)
        }
    }
}

struct AppLink: Decodable {
    let attributes: LinkAttributes
    let imDuration: DurationWrapper?

    enum CodingKeys: String, CodingKey {
        case attributes
        case imDuration = "im:duration"
    }
}

struct LinkAttributes: Decodable {
    let rel: String
    let type: String
    let href: String
}

struct DurationWrapper: Decodable {
    let label: String
}

// MARK: - ID
struct IdWrapper: Decodable {
    let label: String
    let attributes: IdAttributes
}

struct IdAttributes: Decodable {
    let imId: String
    let imBundleId: String

    enum CodingKeys: String, CodingKey {
        case imId = "im:id"
        case imBundleId = "im:bundleId"
    }
}

// MARK: - Category
struct Category: Decodable {
    let attributes: CategoryAttributes
}

struct CategoryAttributes: Decodable {
    let imId: String
    let term: String
    let scheme: String
    let label: String

    enum CodingKeys: String, CodingKey {
        case imId = "im:id"
        case term, scheme, label
    }
}

// MARK: - Release Date
struct ReleaseDate: Decodable {
    let label: String
    let attributes: ReleaseDateAttributes
}

struct ReleaseDateAttributes: Decodable {
    let label: String
}

// AppStoreResponseDTO.swift의 toDomain() 메서드 수정
extension AppStoreResponseDTO {
    func toDomain() -> [AppEntity] {
        return feed.entry.map { entry in
            let price = entry.imPrice?.label ?? "무료"
            let amount = Int(entry.imPrice?.attributes.amount ?? "0") ?? 0
            
            let priceLabel = amount == 0 ? "" : price
            
            return AppEntity(
                id: entry.id.attributes.imId,
                name: entry.imName.label,
                developer: entry.imArtist?.label ?? "Unknown Developer",
                category: entry.category.attributes.label,
                imageUrl: entry.imImage[2].label,
                summary: entry.summary?.label ?? "설명 없음",
                releaseDate: entry.imReleaseDate.attributes.label,
                appStoreUrl: entry.link.links[0].attributes.href,
                price: priceLabel
            )
        }
    }
}
