import Foundation

struct Info: Codable {
    let month: String
    let num: Int
    let year: String
    let news: String
    let safeTitle: String
    let transcript: String
    let alternativeText: String
    let image: String
    let title: String
    let day: String

    enum CodingKeys: String, CodingKey {
        case month
        case num
        case year
        case news
        case safeTitle = "safe_title"
        case transcript
        case alternativeText = "alt"
        case image = "img"
        case title
        case day
    }
}
