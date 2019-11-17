
import Foundation

struct XCCovTarget: Codable {
    var coveredLines: Int
    var lineCoverage: Double
    var files: [XCCovFile]
    var name: String
    var executableLines: Int
    var buildProductPath: String

    enum CodingKeys: String, CodingKey {
        case coveredLines = "coveredLines"
        case lineCoverage = "lineCoverage"
        case files = "files"
        case name = "name"
        case executableLines = "executableLines"
        case buildProductPath = "buildProductPath"
    }
}
