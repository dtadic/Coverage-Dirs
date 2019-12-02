import Foundation

struct XCCovOutput: Codable {
    var coveredLines: Int
    var lineCoverage: Double
    var errors: [XCCovError]?
    var targets: [XCCovTarget]
    var executableLines: Int

    enum CodingKeys: String, CodingKey {
        case coveredLines
        case lineCoverage
        case errors
        case targets
        case executableLines
    }
}
