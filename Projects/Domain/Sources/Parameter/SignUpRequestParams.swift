import Foundation

public struct SignUpRequestParams: Encodable {
    public let name: String
    public let profileImage: Data
    public let majors: [String]
    public let rank: Int
    public let introduction: String
    public let shortIntroduction: String
    public let contact: String
    public let links: [String]
    public let stacks: [String]

    public init(
        name: String,
        profileImage: Data,
        majors: [String],
        rank: Int,
        introduction: String,
        shortIntroduction: String,
        contact: String,
        links: [String],
        stacks: [String]
    ) {
        self.name = name
        self.profileImage = profileImage
        self.majors = majors
        self.rank = rank
        self.introduction = introduction
        self.shortIntroduction = shortIntroduction
        self.contact = contact
        self.links = links
        self.stacks = stacks
    }

    enum CodingKeys: String, CodingKey {
        case name
        case profileImage
        case majors
        case rank
        case introduction
        case shortIntroduction
        case contact
        case links
        case stacks
    }
}
