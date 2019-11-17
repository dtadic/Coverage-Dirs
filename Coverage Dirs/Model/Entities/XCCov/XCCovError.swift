import Foundation

struct XCCovError: Codable {
    var code: Int
    var localizedDescription: String
    var domain: String

    enum CodingKeys: String, CodingKey {
        case code
        case localizedDescription
        case domain
    }
}
