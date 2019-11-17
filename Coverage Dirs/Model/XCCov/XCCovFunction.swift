
import Foundation

struct XCCovFunction: Codable {
    var coveredLines: Int
    var lineCoverage: Double
    var lineNumber: Int
    var executionCount: Int
    var name: String
    var executableLines: Int

    enum CodingKeys: String, CodingKey {
        case coveredLines = "coveredLines"
        case lineCoverage = "lineCoverage"
        case lineNumber = "lineNumber"
        case executionCount = "executionCount"
        case name = "name"
        case executableLines = "executableLines"
    }
}
