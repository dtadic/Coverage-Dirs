import Foundation

struct XCCovTarget: Codable {
    var coveredLines: Int
    var lineCoverage: Double
    var files: [XCCovFile]
    var name: String
    var executableLines: Int
    var buildProductPath: String

    enum CodingKeys: String, CodingKey {
        case coveredLines
        case lineCoverage
        case files
        case name
        case executableLines
        case buildProductPath
    }
}
