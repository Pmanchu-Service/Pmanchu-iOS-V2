import Foundation

public struct SignUpRequestParams: Encodable {
    public let name: String
    public let rank: String
    public let introduction: String
    public let techStack: [String]
    public let major: String
 
    public init(
        name: String,
        rank: String,
        introduction: String,
        techStack: [String],
        major: String
    ) {
        self.name = name
        self.rank = rank
        self.introduction = introduction
        self.techStack = techStack
        self.major = major
    }

    enum CodingKeys: String, CodingKey {
        case name
        case rank
        case introduction
        case techStack = "tech_stack"
        case major
    }
}
