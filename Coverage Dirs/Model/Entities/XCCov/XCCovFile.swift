import Foundation

struct XCCovFile: Codable {
    var coveredLines: Int
    var lineCoverage: Double
    var path: String
    var functions: [XCCovFunction]
    var name: String
    var executableLines: Int

    enum CodingKeys: String, CodingKey {
        case coveredLines
        case lineCoverage
        case path
        case functions
        case name
        case executableLines
    }
}
