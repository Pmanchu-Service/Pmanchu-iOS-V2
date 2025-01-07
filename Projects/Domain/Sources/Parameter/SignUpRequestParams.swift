import Foundation

public struct SignUpRequestParams: Encodable {
    public let name: String
    public let majors: [String]
    public let years: Int
    public let introduction: String
    public let shortIntroduction: String
    public let contact: String
    public let links: [String]
    public let stacks: [String]

    public init(
        name: String,
        majors: [String],
        years: Int,
        introduction: String,
        shortIntroduction: String,
        contact: String,
        links: [String],
        stacks: [String]
    ) {
        self.name = name
        self.majors = majors
        self.years = years
        self.introduction = introduction
        self.shortIntroduction = shortIntroduction
        self.contact = contact
        self.links = links
        self.stacks = stacks
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case majors
        case years
        case introduction
        case shortIntroduction = "shortIntroduction"
        case contact
        case links
        case stacks
    }
}
