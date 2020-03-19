import Foundation

// MARK: - List
struct Info: Codable {
    let month: String
    let num: Int
    let link, year, news, safeTitle: String
    let transcript, alt: String
    let img: String
    let title, day: String

    enum CodingKeys: String, CodingKey {
        case month, num, link, year, news
        case safeTitle
        case transcript, alt, img, title, day
    }
}

