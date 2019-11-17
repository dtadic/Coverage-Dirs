import Foundation

struct XCCovFunction: Codable {
    var coveredLines: Int
    var lineCoverage: Double
    var lineNumber: Int
    var executionCount: Int
    var name: String
    var executableLines: Int

    enum CodingKeys: String, CodingKey {
        case coveredLines
        case lineCoverage
        case lineNumber
        case executionCount
        case name
        case executableLines
    }
}
