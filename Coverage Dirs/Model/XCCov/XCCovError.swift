
import Foundation

struct XCCovError: Codable {
    var code: Int
    var localizedDescription: String
    var domain: String

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case localizedDescription = "localizedDescription"
        case domain = "domain"
    }
}
