
import Foundation

struct XCCovFile: Codable {
    var coveredLines: Int
    var lineCoverage: Double
    var path: String
    var functions: [XCCovFunction]
    var name: String
    var executableLines: Int

    enum CodingKeys: String, CodingKey {
        case coveredLines = "coveredLines"
        case lineCoverage = "lineCoverage"
        case path = "path"
        case functions = "functions"
        case name = "name"
        case executableLines = "executableLines"
    }
}
